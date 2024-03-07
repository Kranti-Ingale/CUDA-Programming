#include <stdio.h>
#include <cuda.h>

__global__ void Transpose(unsigned *matrix,unsigned *result ,unsigned size){
    
    unsigned id =blockDim.x*blockIdx.x+threadIdx.x;
    unsigned i=id/size;
    unsigned j=id%size;
    for(unsigned k=0;k<size;k++){
    result[i*size+j]=matrix[j*size+i];
 }
} // end Transpose

void initmatrix(unsigned *matrix,unsigned size){
        for(unsigned i=0;i<size;i++){
            for(unsigned j=0;j<size;j++){
                                        matrix[i*size+j]=(i*size+j);
                                        }
                                    }
}// end of initmatrix

void reset(unsigned *matrix,unsigned size){
     for(unsigned i=0;i<size;i++){
        for(unsigned j=0;j<size;j++){
                                    matrix[i*size+j]=0;
                                    }
                                }
}// end of reset

void printMatrix(unsigned *matrix,unsigned size){
    for(unsigned i=0;i<size;i++){
        for(unsigned j=0;j<size;j++){
                                    printf("%8d",matrix[i*size+j]);
                                    }
        printf("\n");
    }
}

#define N 64
#define BLCOKSIZE N
int main(){
 // host var
 unsigned *hmatrix,*hres;

 //device var
  unsigned *matrix,*res;

//allocate memory --host
hmatrix=(unsigned*)malloc(N*N*sizeof(unsigned));
hres=(unsigned*)malloc(N*N*sizeof(unsigned));

//allocate memory --device
cudaMalloc(&matrix,N*N*sizeof(unsigned));
cudaMalloc(&res,N*N*sizeof(unsigned));

//init 
initmatrix(hmatrix,N);
reset(hres,N);

//printing input matrix
printf("\nHost input\n");
printMatrix(hmatrix,N);


//cudamemcpy trasnfer host--> device
cudaMemcpy(matrix,hmatrix,N*N*sizeof(unsigned),cudaMemcpyHostToDevice);
cudaMemcpy(res,hres,N*N*sizeof(unsigned),cudaMemcpyHostToDevice);

Transpose<<<N,N>>>(matrix,res,N);
cudaDeviceSynchronize();

//cudamem trasnfer device -->host
cudaMemcpy(hres,res,N*N*sizeof(unsigned),cudaMemcpyDeviceToHost);

printf("\nDevice output\n");
printMatrix(hres,N);

return 0;
}
