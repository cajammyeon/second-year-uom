// Giles Reger, 2019

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

#include "global.h"
#include "pq.h"

// Some helper functions for checking the results of calls in tests
void check_result(int testno, char* expected, char* found){
 if(found == NULL){
   fprintf(stderr,"Test %d Failed when %s expected and NULL found\n",testno,expected);
   exit(-1);
 }
 if(strcmp(expected,found) != 0){
   fprintf(stderr,"Test %d Failed when %s expected and %s found\n",testno,expected,found);
   exit(-1);
 }
}
void assert(int testno, bool value, char* reason){
  if(!value){
   fprintf(stderr,"Test %d Failed as %s\n",testno,reason); 
   exit(-1);
  }
}

// Check that hello and goodbye are popped in the right order
void run_test0(){
  printf("TEST 0\n");
  PriorityQueue queue = initialize_pq(10);
  printf("Initialised...\n");
  insert(queue,"hello",1);
  printf("Inserted hello with priority 1...\n");
  insert(queue,"goodbye",2);
  printf("Inserted goodbye with priority 2...\n");
  check_result(0,"hello",pop_min(queue));
  printf("Popped hello...\n");
  check_result(0,"goodbye",pop_min(queue));
  printf("Popped goodbye...\n");
  assert(0,is_empty(queue)," queue is meant to be empty");
  printf("Queue now empty\n");
  tidy(queue);
}

void run_test1() {
    printf("TEST 1\n");
    PriorityQueue queue = initialize_pq(10);
    printf("Initialised...\n");
    insert(queue, "hello",2);
    printf("Inserted hello with priority 2...\n");
    insert(queue,"goodbye",1);
    printf("Inserted goodbye with priority 1...\n");
    check_result(0,"goodbye",pop_min(queue));
    printf("Popped goodbye...\n");
    check_result(0,"hello",pop_min(queue));
    printf("Popped hello...\n");
    assert(1,is_empty(queue)," queue is meant to be empty");
    printf("Queue now empty\n");
    tidy(queue);
}

void run_test2() {
    printf("TEST 2 - is expansion working?\n");
    PriorityQueue queue = initialize_pq(5);
    insert(queue, "first", 1);
    insert(queue, "second", 2);
    insert(queue, "fourth", 4);
    insert(queue, "third", 3);
    insert(queue, "hundred", 100);
    insert(queue, "fifty", 50);
    insert(queue, "ten", 10);
    check_result(2, "first", pop_min(queue));
    printf("Popped first...\n");
    check_result(2, "second", pop_min(queue));
    printf("Popped second...\n");
    check_result(2, "third", pop_min(queue));
    printf("Popped third...\n");
    check_result(2, "fourth", pop_min(queue));
    printf("Popped fourth...\n");
    check_result(2, "ten", pop_min(queue));
    printf("Popped ten...\n");
    check_result(2, "fifty", pop_min(queue));
    printf("Popped fifty...\n");
    check_result(2, "hundred", pop_min(queue));
    printf("Popped hundred...\n");
  }


char* prog_name = 0;
int main (int argc, char *argv[]) 
{
 prog_name=argv[0];
 if(argc != 2){
   fprintf(stderr,"Supply test number\n");
   return -1;
 }
 char* tmp;
 int test_number = strtol(argv[1],&tmp,0);
 if(*tmp != '\0'){
   fprintf(stderr,"Supply test number as an integer\n");
   return -1;
 }
 switch(test_number){
   case 0: run_test0(); break;
   case 1: run_test1(); break;
     case 2: run_test2(); break;

   default:
     fprintf(stderr,"Test number %d not recognised\n",test_number);
 }
 return 0;
}
