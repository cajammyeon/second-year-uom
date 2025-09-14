// Giles Reger, 2019

#include <stdbool.h> 

enum HashingModes { HASH_1_COLLISION_1=0,
                    HASH_1_COLLISION_2=1,
                    HASH_1_COLLISION_3=2,
                    HASH_2_COLLISION_1=3,
                    HASH_2_COLLISION_2=4,
                    HASH_2_COLLISION_3=5};

typedef char* Value_Type;
// Should be redefined if changing Value_Type
int compare(Value_Type,Value_Type);


// This is a cell struct assuming Open Addressing
// You will need alternative data-structurs for separate chaining
typedef struct
{ // hash-table entry
  Value_Type element; // only data is the key itself
  enum {empty, in_use} state;
} cell;

typedef struct CC
{
    Value_Type value;
    struct CC *link;
    int collision;
} cell_chain;

struct  hashset
{
  cell *cells;
  int size; // cell cells [table_size];
  int num_entries; // number of cells in_use
  //TODO add anything else that you need
  int collision;
};

struct hashset* initialize_set (int size);     
void tidy (struct hashset*); 

int size(struct hashset*);

struct hashset* insert (Value_Type, struct hashset*);

bool find (Value_Type, struct hashset*);

// Helper functions
void print_set (struct hashset*);
void print_stats (struct hashset*);
