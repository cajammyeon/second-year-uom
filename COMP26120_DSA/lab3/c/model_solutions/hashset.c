#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#define _BSD_SOURCE 
#include <string.h>
#include <math.h>

#include "global.h"
#include "hashset.h"

// Can be redefined if Value_Type changes
int compare(Value_Type a, Value_Type b){
  return strcmp(a,b);
}

// Helper functions for finding prime numbers 
bool isPrime (int n)
{
  for (int i = 2; i*i <= n; i++)
    if (n % i == 0)
      return false;
  return true;
}

int nextPrime(int n)
{
  for (; !isPrime(n); n++);
  return n;
}
// h = x0*a^(k-1) + x1*a^(k-2) + ... + x(k-2)*a + x(k-1)
// h = |ak + b| mod N
int hashFunc(Value_Type k, int N)
{
  int temp = 1; int a = 41;
  int len = strlen(k);
  long long h = 0;
  //printf("%s, len: %d, k[%d]: %lld\n", k, len, len - 1, h);
  for (int i = len - 1; i >= 0; i--){
    h += k[i] * temp;
    //printf("h += k[%d](%d) * %d, h = %lld\n", i, k[i], a, h);
    temp *= a;
  }

  //printf("%lld\n", h);
  h = labs(h) % N;
  return h;
}

int hashFunc2(Value_Type k, int N)
{
    int len = strlen(k);
    long long h = 0;
    for (int i = len -1; i >=0; i--) {
        h += k[i];
    }
    h = labs(h) % N;
    return h;
}

bool isLinearProbing(int mode){
  return mode == HASH_1_COLLISION_1 || mode == HASH_2_COLLISION_1;
}
bool isQuadraticProbing(int mode){
  return mode == HASH_1_COLLISION_2 || mode == HASH_2_COLLISION_2;
}
bool isDoubleHashing(int mode){
 return mode == HASH_1_COLLISION_3 || mode == HASH_2_COLLISION_3;
}



struct hashset* initialize_set (int size)  
{
  struct hashset* set = (struct hashset*) malloc(sizeof(struct hashset));
  check(set);
  set->cells = (cell *)malloc(size * sizeof(cell));
  check(set->cells);
  set->size = size;
  set->num_entries = 0;
  set->collision = 0;

  for(int i = 0; i < size; i++){
    set->cells[i].state = empty;
  }
  return set;

}

void tidy(struct hashset* set)
{
    for(int i=0;i<set->size;i++){
      if(set->cells[i].state == in_use){
          free(set->cells[i].element);
      }
    }
    free(set->cells);
    free(set);
}

int size(struct hashset* set){ return set->num_entries; }

// insertion

void insertCell(Value_Type k, struct hashset* set, int pos)
{
 set->cells[pos].element = strdup(k);
 set->cells[pos].state = in_use;
 set->num_entries ++;
  return;
}

struct hashset* rehash(struct hashset* set)
{
  int N =set->size;
  int newSize = nextPrime(2*N);
  struct hashset* new_set = initialize_set(newSize);
  //  printf("test");
  if (verbose > 2)
    { // call with option -vvv to get this
        printf("Rehashing\n");
        printf("Current Set:\n");
        print_set (set);
   }
  for(int i = 0; i < N; i++){
    if(set->cells[i].state == in_use)
        insert(set->cells[i].element, new_set);
  }
  tidy(set);
  if (verbose > 2)
    { // call with option -vvv to get this
        printf("New Set\n");
        print_set (new_set);
    }

  return new_set;
}

struct hashset* insert (Value_Type value, struct hashset* set)
{
  if(find(value, set)) return set; // detect duplicate

  int N = set->size;
  if(set->num_entries >= N/2) // check full table
    set = rehash(set);

  N = set->size;
  int pos = hashFunc(value, N);

  // insert into empty cell
  //  printf("i %s\n",value);
  if(set->cells[pos].state != in_use)
  {
      insertCell(value, set, pos);
  }
  else{
     if(isLinearProbing(mode)) // linear probing: A[(i+j)mod N]
      {
          for(int j = 1; j < N; j++){
              int look = (pos + j) % N;
              set->collision ++;
              if(set->cells[look].state != in_use){
                  insertCell(value, set, look);
                  break;
              }
          }
      }
      else if(isQuadraticProbing(mode)) // quadratic probing: A[(i+j^2)mod N]
      {
          for(int j = 1; j < N; j++){
              int look = (pos + j*j) % N;
              set->collision ++;
              if(set->cells[look].state != in_use){
                  insertCell(value, set, look);
                  break;
              }
          }
      }
      else if(isDoubleHashing(mode)) // double hash: A[(i+j*h'(k))mod N]
      {
          int temp = hashFunc2(value, N);
          
          for(int j = 1; j < N; j++){
              int look = (pos + j*temp) % N;
              set->collision ++;
              if(set->cells[look].state != in_use){
                  printf("Inserting %s at %d", value, look);
                  insertCell(value, set, look);
                  break;
              }
          }
      }
  }
  return set;
}

bool find (Value_Type value, struct hashset* set)
{
  int N =set->size;
  int pos = hashFunc(value, N);

  if(set->cells[pos].state == in_use
        && (strcmp(set->cells[pos].element, value) == 0))
      return true;

  else if(isLinearProbing(mode)) // linear probing
  {
	for(int j = 1; j < N; j++){
	  int look = (pos + j) % N;
	  if(set->cells[look].state == empty)
	    return false;
	  if(set->cells[look].state == in_use
	     && (strcmp(set->cells[look].element, value) == 0)){
	    return true;
	  }
	}
  }
  else if(isQuadraticProbing(mode)) // quadratic probing
  {
	for(int j = 1; j < N; j++){
	  int look = (pos + j*j) % N;
	  if(set->cells[look].state == empty)
	    return false;
	  if(set->cells[look].state == in_use &&
	     (strcmp(set->cells[look].element, value) == 0)){
	    return true;
	  }
	}
  }
  else if(isDoubleHashing(mode)) // double hash
  {
	int temp = hashFunc2(value, N);

	for(int j = 1; j < N; j++){
	  int look = (pos + j*temp) % N;
	  if(set->cells[look].state == empty)
	    return false;
	  if(set->cells[look].state == in_use &&
	     (strcmp(set->cells[look].element, value) == 0)){
	    return true;
	  }
	}
  }
  return false;
}

void print_set (struct hashset* set)
{
  int i = 0;
  for(; i < set->size; i++){
    if(set->cells[i].state == in_use)
        printf("Cell %5d: %s\n", i, set->cells[i].element);
    if(set->cells[i].state == empty)
        printf("Cell %5d: empty\n", i);
  }
}

void print_stats (struct hashset* set)
{
  printf("Collision times: %d\n", set->collision);
  printf("Entry number: %d\n", set->num_entries);
  printf("Average collisions per access: %lf\n", (double)set->collision / (double)set->num_entries);
}

