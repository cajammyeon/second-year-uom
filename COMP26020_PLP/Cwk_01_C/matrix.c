#include "matrix.h"

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <string.h>

// helper method
void print_matrix(matrix_t *m) {
    for (int i = 0; i < m->rows; ++i) {
        for (int j = 0; j < m->columns; ++j) {
            printf("%d ", m->content[i][j]);
        }
        printf("\n");
    }
}

/*
* Allocate proper memory for the matrix, with dynamic allocation
*
* @param *m      - pointer towards the location of matrix
* @param rows    - number of rows to be allocated
* @param columns - number of columns to be allocated
* @return        - error code during allocation, 0 for success and -1 for failure
*
*/
int matrix_allocate(matrix_t *m, int rows, int columns) {
    m->rows = rows;
    m->columns = columns;

    // allocate for row pointer
    m->content = (int **)malloc(rows * sizeof(int *));
    // check for failure
    if (m->content == NULL) {return -1;}

    // allocate column for each row
    for (int i = 0; i < rows; ++i) {
        m->content[i] = (int *)malloc(columns * sizeof(int));
        // again check for failure
        if (m->content[i] == NULL) {return -1;}
    }

    return 0;
}

/*
* Free the memory allocated for the matrix, backwards from allocation
*
* @param *m - pointer towards the location of matrix
*
*/
void matrix_free(matrix_t *m) {
    // free each column first
    for (int i = (m->rows)-1; i >= 0; --i) {
        free(m->content[i]);
    }

    // free row pointer
    free(m->content);
}

/*
* Initialises previously allocated matrix with random integers, between min and max
* 
* @param *m - pointer towards the location of matrix
* @param val_min - minimum value to be allocated in the matrix
* @param val_max - maximum value to be allocated in the matrix
* @return        - error code during generation of random integer, 0 in range, -1 out of range
*
*/
int matrix_init_rand(matrix_t *m, int val_min, int val_max) {

    // seeding the random number generator
    srand(time(NULL));

    int random_number = (rand() % (val_max - val_min + 1)) + val_min;
    if ((random_number > val_max) || (random_number < val_min)) {return -1;}

    // set values if correct
    matrix_init_n(m, random_number);

    return 0;
}

/*
* Initialises a previously allocated matrix by setting each element to n
*
* @param *m - pointer towards the location of matrix 
* @param n  - value to be allocated
*
*/
void matrix_init_n(matrix_t *m, int n) {
    for (int i = 0; i < m->rows; ++i) {
        for (int j = 0; j < m->columns; ++j) {
            m->content[i][j] = n;
        }
    }
}

/*
* Initialises a previously allocated matrix by setting each element to 0, calling to matrix_init_n
*
* @param *m - pointer towards the location of matrix 
*
*/
void matrix_init_zeros(matrix_t *m) {
    matrix_init_n(m, 0);
}

/*
* Initialise the matrix's elements to create an identity matrix
*
* @param *m - pointer towards the location of matrix
* @return   - error code during initialisation, 0 for success, -1 if the matrix is not a square matrix, marking failure
*
*/
int matrix_init_identity(matrix_t *m){

    if (m->rows != m->columns) {return -1;}
    else {
        for (int i = 0; i < m->rows; ++i) {
            for (int j = 0; j < m->columns; ++j) {
                if (i == j) {m->content[i][j] = 1;}
                else {m->content[i][j] = 0;}
            }
        }   
    }

    return 0;
}

/*
* Check if 2 matrices are the same, by comparing values in each rows and columns
*
* @param *m - pointer towards the location of matrix
* @return   - 1 if two matrices are equal, 0 if they are different
*
*/
int matrix_equal(matrix_t *m1, matrix_t *m2) {
    
    // equality as having the same size
    if (m1->rows != m2->rows) {return 0;}
    if (m1->columns != m2->columns) {return 0;}

    // equality as having the same elements
    for (int i = 0; i < m1->rows; ++i) {
        for (int j = 0; j < m1->columns; ++j) {
             if (m1->content[i][j] != m2->content[i][j]) {return 0;}
        }
    }

    return 1;
}

/*
* Calculate the sum of 2 matrices
*
* @param *m1     - first matrix
* @param *m2     - second matrix
* @param *result - matrix storing the result of the summation
* @return        - 0 on success, -1 on failure, given that they have different size or allocation failed
*
*/
int matrix_sum(matrix_t *m1, matrix_t *m2, matrix_t *result) {
    
    // size checking 
    if (m1->rows != m2->rows) {return -1;}
    if (m1->columns != m2->columns) {return -1;}

    // initialise result
    int result_allocate = matrix_allocate(result, m1->rows, m1->columns);
    if (result_allocate == -1) {return -1;}

    // if allocate successful, calculate result
    matrix_init_zeros(result);

    for (int i = 0; i < result->rows; ++i) {
        for (int j = 0; j < result->columns; ++j) {
            result->content[i][j] = m1->content[i][j] + m2->content[i][j];
        }
    }

    return 0;
}

/*
* Calculate the scalar product of the matrix
*
* @param *m      - pointer towards the location of matrix
* @param scalar  - the integer value of the scalar that want to be multiplied
* @param *result - matrix storing the result of the scalar multiplication
* @return        - 0 on success, -1 on failure, given that the allocation failed
*
*/
int matrix_scalar_product(matrix_t *m, int scalar, matrix_t *result) {
    
    // initialise result
    int result_allocate = matrix_allocate(result, m->rows, m->columns);
    if (result_allocate == -1) {return -1;}

    // if allocate successful, calculate result
    matrix_init_zeros(result);

    for (int i = 0; i < result->rows; ++i) {
        for (int j = 0; j < result->columns; ++j) {
            result->content[i][j] = m->content[i][j] * scalar;
        }
    }
    
    return 0;
}

/*
* Transpose the elements in matrix, switching rows -> columns and columns -> rows
*
* @param *m      - pointer towards the location of matrix
* @param *result - pointer towards the result of transposition
* @return        - 0 on success, -1 on failure, given that the allocation failed
*
*/
int matrix_transposition(matrix_t *m, matrix_t *result) {
    
    // initialise result
    int result_allocate = matrix_allocate(result, m->columns, m->rows);
    if (result_allocate == -1) {return -1;}

    // if allocate successful, calculate result
    matrix_init_zeros(result);

    for (int i = 0; i < result->rows; ++i) {
        for (int j = 0; j < result->columns; ++j) {
            result->content[i][j] = m->content[j][i];
        }
    }

    return 0;
}

/*
* Helper method in calculating the required sum for matrix product
* 
* @param *m1           - first matrix
* @param *m2           - second matrix
* @param row_number    - row number of the result matrix that is being calculated
* @param column_number - column number of the result matrix that is being calculated
* @return              - row-column summation for given row number and column number
*
*/
int row_column_summation(matrix_t *m1, matrix_t *m2, int row_number, int column_number) {

    int sum = 0;

    for (int i = 0; i < m1->columns; ++i) {
        sum = sum + (m1->content[row_number][i] * m2->content[i][column_number]);
    }

    return sum;
}

/*
* Calculate matrix product of given matrices
* 
* @param *m1    - first matrix
* @param *m2    - second matrix
* @param result - pointer towards result of the matrix product
* @return       - 0 on success, -1 on failure
* 
* Failures
*   number of columns of m1 != number of rows of m2
*   allocation of result
* 
*/
int matrix_product(matrix_t *m1, matrix_t *m2, matrix_t *result) {

    // size checking
    if (m1->columns != m2->rows) {return -1;}
    
    // initialise result
    int result_allocate = matrix_allocate(result, m1->rows, m2->columns);
    if (result_allocate == -1) {return -1;}

    // if allocate successful, calculate result
    matrix_init_zeros(result);

    for (int i = 0; i < result->rows; ++i) {
        for (int j = 0; j < result->columns; ++j) {
            result->content[i][j] = row_column_summation(m1, m2, i, j);
        }
    }

    return 0;
}

/*
* Write a matrix into a (preferably) text file with given format
*
* @param *m           - pointer towards the location of matrix
* @param *output_file - string, giving the file name to be written to
* @return             - 0 on success, -1 on failure
*
* Failures :
*   allocation of string intermediate
*   file opening
*   file writing
*   file closing
*
*/
int matrix_dump_file(matrix_t *m, const char *output_file) {
    
    // write the matrix to a buffer
    // allocate with redundancy
    char *post_matrix = malloc(sizeof(char) * m->rows * m->columns * 4);
    if (post_matrix == NULL) {return -1;}
    post_matrix[0] = '\0';

    for (int i = 0; i < m->rows; ++i) {
        for (int j = 0; j < m->columns; ++j) {
            char elements[2];                           // just temporary allocation
            sprintf(elements, "%d", m->content[i][j]);  // change to string
            strcat(post_matrix, elements);              // add that certain element to the string
            if (j != (m->columns - 1)) {
                strcat(post_matrix, " ");                   // space in between items
            }
        }
        strcat(post_matrix, "\n");
    }

    FILE *f1;
    // open the file
    f1 = fopen(output_file, "w");
    if (f1 == NULL) {return -1;}

    // write the matrix
    if (fwrite(post_matrix, sizeof(char), strlen(post_matrix), f1) < strlen(post_matrix)) {
        if (fclose(f1) != 0) {
            free(post_matrix);
            return -1;
        }
        free(post_matrix);
        return -1;
    }

    // close the file to avoid leak
    if (fclose(f1) != 0) {
        free(post_matrix);
        return -1;
    }
    
    // free memory
    free(post_matrix);

    return 0;
}

/*
* Helper method to calculate file size before reading, to avoid overallocation
* 
* @param *input_file - string, giving the location to be read from
* @return            - size of the file
*
*/
int file_size(const char *input_file) {
    FILE *f;
    f = fopen(input_file, "r");
    fseek(f, 0, SEEK_END);
    int len = ftell(f);
    fclose(f);

    return len;
}

/*
* Read a particular text file, and initialise a matrix from that text file
*
* @param *m          - pointer towards the location of matrix
* @param *input_file - string, giving the location to be read from
* @return            - 0 on success, -1 on failure
*
* Failures 
*   allocation of read buffer
*   file opening
*   file reading
*   file closing
*   matrix allocation
*
*/
int matrix_allocate_and_init_file(matrix_t *m, const char *input_file) {

    int rows_file = 0;
    int columns_file = 0;
    int filesize = file_size(input_file);

    // open the file
    FILE *f2;
    f2 = fopen(input_file, "r");
    if (f2 == NULL) {return -1;}

    // read the file
    char *string_read = malloc(filesize);
    if(fread(string_read, sizeof(char), filesize, f2) < filesize) {
        if (fclose(f2) != 0) {
            free(string_read);
            return -1;
        }
        free(string_read);
        return -1;
    }

    if (fclose(f2) != 0) {
        free(string_read);
        return -1;
    }

    for (int i = 0; i < strlen(string_read); ++i) {
        char compare = string_read[i];
        if (compare == '\n') {
            ++rows_file;
        }
    }

    // count number of columns
    for (int i = 0; i < strlen(string_read) - 1; ++i) {
        char compare = string_read[i];
        if (compare == ' ') {
            ++columns_file;
        } else if (compare == '\n') {
            ++columns_file;
            break;
        }
    }

    // allocate matrix
    int allocate_code = matrix_allocate(m, rows_file, columns_file);
    if (allocate_code == -1) {return -1;}

    // initialise a zero matrix for convenience
    matrix_init_zeros(m);

    // fixing the matrix index
    int row_ref = 0;
    int col_ref = 0;

    // initialises the value from text file
    const char *delim = " \n";
    char *item_read = strtok(string_read, delim);

    while (item_read != NULL) {
        int elements = atoi(item_read);
        m->content[row_ref][col_ref] = elements;

        ++col_ref;

        if (col_ref == m->columns) {
            col_ref = 0;
            ++row_ref;

            if (row_ref == m->rows) {
                break;
            }
        }

        item_read = strtok(NULL, delim);
    } 

    // free memory
    free(string_read);

    return 0;
}
