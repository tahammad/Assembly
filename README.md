[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/K8OywbE8)
# CSE220_HW7

MIPS Programming  


SBU ID#  114863193


Name:  Tanjim Ahammad


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










 





