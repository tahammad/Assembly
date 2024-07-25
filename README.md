Test cases for each part  
Part A:

1. Test Case 1: Error Testing
Input 1: 0
Input 2: -1
Output: Please ensure that your size is greater than 0.

Triangle(0) or Square(1) or Pyramid (2)?0
Required size? -1
Please ensure that your size is greater than 0.

2. Test Case 2: Error Testing
Input 1: 4
Output: Please enter 0, 1, or 2.

Triangle(0) or Square(1) or Pyramid (2)?4
Please enter 0, 1, or 2.

3. Test Case 3: Error Testing
Input 1: 2
Input 2: 0
Output: Please ensure that your size is greater than 0.

Triangle(0) or Square(1) or Pyramid (2)?2
Required size? 0
Please ensure that your size is greater than 0.

4. Test Case 4: Error Testing
Input 1: -1
Output: Please enter 0, 1, or 2.

Triangle(0) or Square(1) or Pyramid (2)?-1
Please enter 0, 1, or 2.

5. Test Case 5: Error Testing
Input 1: 3
Output: Please enter 0, 1, or 2.

Triangle(0) or Square(1) or Pyramid (2)?3
Please enter 0, 1, or 2.

6. Test Case 6: Normal Testing
Input 1: 0
Input 2: 8
Output:
*
**
***
****
*****
******
*******
********

7. Test Case 7: Normal Testing
Input 1: 1
Input 2: 6
Output:
******
******
******
******
******
******

8. Test Case 8: Normal Testing
Input 1: 2
Input 2: 9
Output:
        * 
       * * 
      * * * 
     * * * * 
    * * * * * 
   * * * * * * 
  * * * * * * * 
 * * * * * * * * 
* * * * * * * * * 

9. Test Case 9: Normal Testing
Input 1: 1
Input 2: 1
Output:
*

10. Test Case 10: Normal Testing
Input 1: 2
Input 2: 1
Output:
*

Part B:

1. Test Case 1:
num: 5
Input:
A[1]=1
B[1]=2
A[2]=3
B[2]=4
A[3]=5
B[3]=6
A[4]=7
B[4]=8
A[5]=9
B[5]=10
Output:
2 1|4 3|6 5|8 7|10 9|

2. Test Case 2:
num: 5
Input:
A[1]=9
B[1]=543
A[2]=653
B[2]=53
A[3]=33
B[3]=46
A[4]=7
B[4]=1
A[5]=3
B[5]=7
Output:
543 9|53 653|46 33|1 7|7 3|

3. Test Case 3: 
num: 10 
Input:
A[1]=0
B[1]=9
A[2]=8
B[2]=7
A[3]=6
B[3]=5
A[4]=4
B[4]=3
A[5]=2
B[5]=1
A[6]=-1
B[6]=-2
A[7]=-3
B[7]=-4
A[8]=-5
B[8]=-6
A[9]=-7
B[9]=-8
A[10]=-9
B[10]=-10
Output: 
9 0|7 8|5 6|3 4|1 2|-2 -1|-4 -3|-6 -5|-8 -7|-10 -9|

4. Test Case 4: 
num: 10
Input: 
A[1]=1
B[1]=2
A[2]=3
B[2]=4
A[3]=5
B[3]=6
A[4]=7
B[4]=8
A[5]=9
B[5]=10
A[6]=11
B[6]=12
A[7]=13
B[7]=14
A[8]=15
B[8]=16
A[9]=17
B[9]=18
A[10]=19
B[10]=20
Output:
2 1|4 3|6 5|8 7|10 9|12 11|14 13|16 15|18 17|20 19|

5. Test Case 5:
num: 1
Input:
A[1]=999
B[1]=666
Output:
666 999|

6. Test Case 6:
num: 4
Input:
A[1]=1
B[1]=7
A[2]=38
B[2]=76
A[3]=66
B[3]=99
A[4]=3
B[4]=4
Output:
7 1|76 38|99 66|4 3|

7. Test Case 7:
num: 10
Input:
A[1]=20
B[1]=19
A[2]=18
B[2]=17
A[3]=16
B[3]=15
A[4]=14
B[4]=13
A[5]=12
B[5]=11
A[6]=10
B[6]=9
A[7]=8
B[7]=7
A[8]=6
B[8]=5
A[9]=4
B[9]=3
A[10]=2
B[10]=1
Output:
19 20|17 18|15 16|13 14|11 12|9 10|7 8|5 6|3 4|1 2|

8. Test Case 8
num: 7
Input:
A[1]=4
B[1]=7
A[2]=22
B[2]=66
A[3]=99
B[3]=538
A[4]=72
B[4]=11
A[5]=24
B[5]=219695814
A[6]=4
B[6]=5
A[7]=73
B[7]=66
Output:
7 4|66 22|538 99|11 72|219695814 24|5 4|66 73|

9. Test Case 9
num: 2
Input:
A[1]=2
B[1]=4
A[2]=1
B[2]=3
Output:
4 2|3 1|

10. Test Case 10
num: 2
Input:
A[1]=1
B[1]=1
A[2]=4
B[2]=3
Output:
1 2|3 4|

Part C:

1.Test Case 1: Normal
Size:
    col_m: .word 5         
    row_m: .word 2          
    col_v: .word 1          
    row_v: .word 5  
Input:  
    Enter all the elements in the matrix: 
    Enter element 1 =1
    Enter element 2 =2
    Enter element 3 =3
    Enter element 4 =4
    Enter element 5 =5
    Enter element 6 =6
    Enter element 7 =7
    Enter element 8 =8
    Enter element 9 =9
    Enter element 10 =10
    Enter all the elements in the vector: 
    Enter element 1 =1
    Enter element 2 =2
    Enter element 3 =3
    Enter element 4 =4
    Enter element 5 =5      
Output:
    55
    130


2.Test Case 2: Normal
Size:
    col_m: .word 5         
    row_m: .word 2          
    col_v: .word 1          
    row_v: .word 5  
Input:  
    Enter all the elements in the matrix: 
    Enter element 1 =10
    Enter element 2 =9
    Enter element 3 =8
    Enter element 4 =7
    Enter element 5 =6
    Enter element 6 =5
    Enter element 7 =4
    Enter element 8 =3
    Enter element 9 =2
    Enter element 10 =1
    Enter all the elements in the vector: 
    Enter element 1 =5
    Enter element 2 =4
    Enter element 3 =3
    Enter element 4 =2
    Enter element 5 =1    
Output:
    130
    55

3.Test Case 3: Normal
Size:
    col_m: .word 3        
    row_m: .word 7          
    col_v: .word 1          
    row_v: .word 3  
Input:  
    Enter all the elements in the matrix: 
    Enter element 1 =4
    Enter element 2 =7
    Enter element 3 =2
    Enter element 4 =34
    Enter element 5 =11
    Enter element 6 =4
    Enter element 7 =7
    Enter element 8 =26
    Enter element 9 =420
    Enter element 10 =69
    Enter element 11 =3
    Enter element 12 =33
    Enter element 13 =6
    Enter element 14 =3
    Enter element 15 =20
    Enter element 16 =5
    Enter element 17 =88
    Enter element 18 =4
    Enter element 19 =3
    Enter element 20 =1
    Enter element 21 =3
    Enter all the elements in the vector: 
    Enter element 1 =5
    Enter element 2 =4
    Enter element 3 =3  
Output:
    54
    226
    1399
    456
    102
    389
    28

4.Test Case 4: Normal
Size:
    col_m: .word 4        
    row_m: .word 4          
    col_v: .word 1          
    row_v: .word 4  
Input:  
    Enter all the elements in the matrix: 
    Enter element 1 =1
    Enter element 2 =2
    Enter element 3 =3
    Enter element 4 =4
    Enter element 5 =5
    Enter element 6 =6
    Enter element 7 =7
    Enter element 8 =8
    Enter element 9 =9
    Enter element 10 =10
    Enter element 11 =11
    Enter element 12 =12
    Enter element 13 =13
    Enter element 14 =14
    Enter element 15 =15
    Enter element 16 =16
    Enter all the elements in the vector: 
    Enter element 1 =2
    Enter element 2 =4
    Enter element 3 =6
    Enter element 4 =8
Output:
    60
    140
    220
    300

5.Test Case 5: Error Testing Inequal Matrix Column and Vector Row
Size:
    col_m: .word 4        
    row_m: .word 4          
    col_v: .word 1          
    row_v: .word 3
Output:
 NOT WORKABLE BECAUSE OF THE DIMENSIONS

6.Test Case 6: Error Testing Matrix Memory Error
Size:
    col_m: .word 10        
    row_m: .word 11          
    col_v: .word 1          
    row_v: .word 10
Output:
 NOT WORKABLE BECAUSE OF THE MEMORY



7. Test Case 7: Error Testing Vector Memory Error
Size:
    col_m: .word 25        
    row_m: .word 4          
    col_v: .word 5          
    row_v: .word 25
Output:
 NOT WORKABLE BECAUSE OF THE MEMORY


8.Test Case 8: Normal
Size:
    col_m: .word 1        
    row_m: .word 1          
    col_v: .word 1          
    row_v: .word 1  
Input:  
    Enter all the elements in the matrix: 
    Enter element 1 =1
    Enter all the elements in the vector: 
    Enter element 1 =2
Output:
    2

9.Test Case 9: Normal
Size:
    col_m: .word 3        
    row_m: .word 4          
    col_v: .word 1          
    row_v: .word 3  
Input:  
    Enter all the elements in the matrix: 
    Enter element 1 =5
    Enter element 2 =8
    Enter element 3 =2
    Enter element 4 =8
    Enter element 5 =11
    Enter element 6 =5
    Enter element 7 =77
    Enter element 8 =21
    Enter element 9 =23
    Enter element 10 =54
    Enter element 11 =3
    Enter element 12 =3
    Enter all the elements in the vector: 
    Enter element 1 =2
    Enter element 2 =5
    Enter element 3 =88
Output:
    226
    511
    2283
    387

10.Test Case 10: Normal
Size:
    col_m: .word 2        
    row_m: .word 2          
    col_v: .word 1          
    row_v: .word 2  
Input:  
    Enter all the elements in the matrix: 
    Enter element 1 =999
    Enter element 2 =14
    Enter element 3 =17
    Enter element 4 =21
    Enter all the elements in the vector: 
    Enter element 1 =66
    Enter element 2 =25
Output:
    66284
    1647

```








 





