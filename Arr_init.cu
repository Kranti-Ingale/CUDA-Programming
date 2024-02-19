#include <stdio.h>
#include <cuda.h>

__global__ void arr(int *a){
    a[threadIdx.x]=0;
}

#define N 32 //  <1024
int main(){
    int a[N],*da; //variable declaration
 
    // allocate device memory
    cudaMalloc(&da,N*sizeof(int));

    //copy data host --> device
    cudaMemcpy(da,a,N*sizeof(int),cudaMemcpyHostToDevice);
  
    //launch kernel
    arr<<<1,N>>>(da);

    //copy data device --> Host
    cudaMemcpy(a,da,N*sizeof(int),cudaMemcpyDeviceToHost);

    //print output
    for(int i=0;i<N;i++){
        printf("\n a[%d] = %d",i,a[i]);
    }
    cudaFree(da);
    return 0;
}