#include<stdio.h>
#include<cuda.h>
#define BLOCKSIZE 1024

__global__ void mykernel(){

__shared__ unsigned s; // one s copy per block
int id = threadIdx.x; // blockDim.x*blockIdx.x+threadIdx.x

if(blockIdx.x==0){
    if(id==0) s=0;
    if(id==2) printf("\n block id= %d s = %d id = %d",blockIdx.x,s,id);
}
else{ //blockidx==1
    if(id==5) s=5;
    if(id==19) printf("\n block id= %d s = %d id = %d",blockIdx.x,s,id);
}

}
int main(){
    mykernel<<<2,BLOCKSIZE>>>(); // 2*1024
    cudaDeviceSynchronize();
    return 0;
}