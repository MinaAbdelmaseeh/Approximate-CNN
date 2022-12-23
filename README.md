# Approximate-CNN
In this project an approximate CNN is implemented in using an 8 bit floating point representation:

#FLoating Point Representation : 
Sign          -       Mantissa        -   exponent
1b            -         4b            -     3b

X.XXX * X.XXX = XX.XXXXXX

# Exponent Representation
|Exponent |	Case	       |Exponent     | binary |
| ---     | ---          | ---         |  ---   |
|000	    |	denormalized | 0.XXXX 2^-2 | 	110   |
|001    	|	normalized   | 1.XXXX 2^-2 |	110   |
|010	    |	normalized   | 1.XXXX 2^-1 |	111   |
|011	    |	normalized   | 1.XXXX 2^0  |	000   |
|100	    |	normalized   | 1.XXXX 2^1	 |	001   |
|101      | normalized   | 1.XXXX 2^2	 |	010   |
|110	    |	normalized   | 1.XXXX 2^3	 |	011   |
|111	    |	----         | 1.0000      |  Inf   |
|111	    |	------	     | 1.XXXX      |  NAN   |



# Test Cases : 
#### 00000000 * 00000000 = 0*0 = 0
#### 00001000 * 00001000 = 0.0001*0.0001 = 00.00000001 === 000000000
#### 00000110 * 00000011 = 1.00 2^3 * 1.00 2^0 = 1.00 2^3
#### 00001110 * 00001000 = 1.0001e3 * 0.0001e-2 = 1.0001e1 = 0.1 e-2
