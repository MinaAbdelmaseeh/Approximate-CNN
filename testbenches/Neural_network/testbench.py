A = 0x7f
B = 0x01
def mult8x8(A,B):
    if(A>>4 > 0x7):
        neg_A = 0x1
        A =  (A^0xff) + 0x01;
    else:
        neg_A = 0x0
    if(B>>4 > 0x7):
        neg_B = 1
        B = (B^0xff) + 0x01;
    else:
        neg_B = 0x0
    res = A*B>>4
    if(res>>4 >0x7):
        if(neg_A^neg_B==0):
            return (0x7f)
        else:
            return (0x80)
    if(neg_A^neg_B==0):
        return (res)
    else:
        return ((res^0xff) + 0x01)
def add8x8(A,B):
    if(A>>4 > 0x7):
        neg_A = 0x1
    else:
        neg_A = 0x0
    if(B>>4 > 0x7):
        neg_B = 0x1
    else:
        neg_B = 0x0
    res = A + B
    if(neg_A==1 and neg_B==1 and ((res ^0xff) + 1)>0x80):
        return (0x80)
    if(neg_A==0 and neg_B==0 and res>0x7f):
        return (0x7f)
    return (res%0x100)
def neural_layer(W,B,inputs):
    res = [0x00]*len(W)
    for i in range(len(W)):
        res[i] = B[i];
        for j in range(len(W[0])):
            res[i] = add8x8(mult8x8(W[i][j],inputs[j]),res[i])
    return res
A = [[0x07,0x07],
     [0x07,0x07],
     [0x07 ,0x07],
     [0x07 ,0x07]]
     
B = [0x07 ,0x07,0x07,0x07]
ip = [0x09, 0x0C]
layer1 = neural_layer(A,B,ip)
A = [[0x07,0x07,0x07,0x07],
     [0x08,0x08,0x08,0x08],
     [0x08 ,0x08,0x08,0x08],
     [0x08 ,0x08,0x08,0x08]]
B = [0x08 ,0x08,0x08,0x08]
layer2 = neural_layer(A,B,layer1)
A = [[0x07,0x07,0x07,0x07],
     [0x08,0x08,0x08,0x08]]
B = [0x08 ,0x08]
layer3= neural_layer(A,B,layer2)
print(layer3)
print(hex(67))