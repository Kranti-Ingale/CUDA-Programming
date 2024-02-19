#include <stdio.h>
#include <cuda.h>

__global__ void vectorAdd(unsigned *a, unsigned *b, unsigned *c, unsigned N) {
    // Calculate global thread thread ID
    int id = blockDim.x * blockIdx.x + threadIdx.x;

    // Boundary check
    if (id < N) {
        c[id] = a[id] + b[id];
    }
} // end of vectorAdd

void init(unsigned *Arr,unsigned size){
    for(unsigned i=0;i<size;i++){
        Arr[i] = rand() % 100;
    }
} // end of init

void print(unsigned * a,unsigned *b,unsigned *c, unsigned N)
{
    printf("\n\tid\ta[id]\t+\tb[id]\t=\tc[id]");
    printf("\n--------------------------------------------------------------------");
    for (int i = 0; i < N; i++) {
         printf("\n\t%d\t%d\t+\t%d\t=\t%d",i,a[i],b[i],c[i]);
    }
} // end of print

#define N 32
#define BLOCK_SIZE 1024

int main(){
    // Declare unified memory pointers
    unsigned *a, *b, *c;

    // Allocation memory for these pointers
    cudaMallocManaged(&a, N*sizeof(unsigned));
    cudaMallocManaged(&b, N*sizeof(unsigned));
    cudaMallocManaged(&c, N*sizeof(unsigned));

    // Initialize vectors 
    init(a,N);
    init(b,N);
 
    // CTAs per Grid
    int GRID_SIZE = (N + BLOCK_SIZE - 1) / BLOCK_SIZE;
   
    // Call CUDA kernel
    vectorAdd<<<GRID_SIZE, BLOCK_SIZE>>>(a, b, c, N);
    cudaDeviceSynchronize();

    // print the result on the CPU
    print(a,b,c,N);
 
    // Free unified memory (same as memory allocated with cudaMalloc)
    cudaFree(a);
    cudaFree(b);
    cudaFree(c);
    return 0;
   
}




































































































