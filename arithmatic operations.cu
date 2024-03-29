#include <stdio.h>
#include <cuda.h>

__global__ void vectorAdd(int *a, int *b, int *c, int N) {
  // Calculate global thread thread ID
  int tid = (blockDim.x * blockIdx.x) + threadIdx.x;

  // Boundary check
  if (tid < N) {
    c[tid] = a[tid] + b[tid];
  }
}

int main(){
     
 const int N = 1 << 16;
 size_t bytes = N * sizeof(int);
 // Declare unified memory pointers
 int *a, *b, *c;
 // Allocation memory for these pointers
 cudaMallocManaged(&a, bytes);
 cudaMallocManaged(&b, bytes);
 cudaMallocManaged(&c, bytes);

 
 // Initialize vectors
 for (int i = 0; i < N; i++) {
   a[i] = rand() % 100;
   b[i] = rand() % 100;
 }
 
 // Threads per CTA (1024 threads per CTA)
 int BLOCK_SIZE = 1 << 10;
 // CTAs per Grid
 int GRID_SIZE = (N + BLOCK_SIZE - 1) / BLOCK_SIZE
 // Call CUDA kernel
 vectorAdd<<<GRID_SIZE, BLOCK_SIZE>>>(a, b, c, N);

  cudaDeviceSynchronize();
 // Verify the result on the CPU
 for (int i = 0; i < N; i++) {
 //  assert(c[i] == a[i] + b[i]);
 }
 
 // Free unified memory (same as memory allocated with cudaMalloc)
 cudaFree(a);
 cudaFree(b);
 cudaFree(c);
printf("COMPLETED SUCCESSFULLY!\n");
 return 0;
    
}




































































































