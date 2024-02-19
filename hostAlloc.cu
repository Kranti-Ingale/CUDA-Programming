#include <stdio.h>
#include <cuda.h>

__global__ void Mykernel(int * count) {
printf("\n counter from device = %d", ++*count);
}

int main() {
int *count = 0;

// use pinned memory
cudaHostAlloc(&count,sizeof(int),0);

//launch kernel
Mykernel<<<1,1>>>(count);
cudaDeviceSynchronize();

//host can access count variable
printf("\ncounter from Host = %d", ++*count);
return 0;
}












































































