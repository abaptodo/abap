# My ABAP Code Collection
In order to use the source code, simply copy and paste into your ABAP Development Workbench.<br>
<br>1. Create the program in ABAP Development Workbench under any package.
<br>2. Copy and paste the source code.
<br>3. F8 to run the source code.
# Enhancement
In order to run and test enhancement, you need to find the corresponding program that includes the user exit used by the sourcecode. 
After that, simply copy and paste the enhancement sourcecode below the enhancement point in the corresponding user exit form.
# Smartforms
In order to run and test smartforms program, you need to create a smartforms (t-code SMARTFORMS) for the corresponding program. After that,
you need to revised the sourcecode by calling the function module to the smartforms you've just created.
<br><br>
For example:<br>
<code>CALL FUNCTION '/1BCDWB/SF00000247'</code><br><br>
Will be replaced by<br>
<code>CALL FUNCTION 'Your own smartforms'</code>
