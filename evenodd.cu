#include<stdio.h>
#include<cuda.h>

#define N 32
#define BLOCKSIZE 1024

__global__ void Even() {
    int id=blockDim.x*blockIdx.x+threadIdx.x;
    if(id<N){
                if(id%2 == 0)
                printf("\n%d",id);
            }
} // end of Even

__global__ void Odd() {
    int id=blockDim.x*blockIdx.x+threadIdx.x;
    if(id<N){
                 if(id%2 == 1)
                 printf("\n%d",id);
            }
} //end of odd


int main(){

    printf("\nEven");
    Even<<<(N+BLOCKSIZE-1)/BLOCKSIZE,BLOCKSIZE>>>();
    cudaDeviceSynchronize();

    printf("\nOdd");
    Odd<<<(N+BLOCKSIZE-1)/BLOCKSIZE,BLOCKSIZE>>>();
    cudaDeviceSynchronize();

    return 0;
}