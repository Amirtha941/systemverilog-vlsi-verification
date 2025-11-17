
## ⚙️** Passing values in functions (by value, by reference, by name, by position)**

SystemVerilog supports different **argument passing methods**:

----------

### **(a) By Value** (Default)

-   A **copy** of the variable is passed.
    
-   Changes inside the function **do not affect original**.
    

Example:

```
function void by_value(int a);
    a = a + 10;
endfunction

initial begin
    int x = 5;
    by_value(x);
    $display("x = %0d", x); // Output: 5 (NOT changed)
end
``` 

----------

### **(b) By Reference (`ref`)**

-   The function uses the **same memory** as the caller variable.
    
-   Changes affect the original variable.
    

Example:

```
function void by_reference(ref int a);
    a = a + 10;
endfunction

initial begin
    int x = 5;
    by_reference(x);
    $display("x = %0d", x); // Output: 15 (Changed!)
end
``` 

----------

### **(c) Pass by Name**

-   You can call function with **named arguments**.
    

Example:

```
function int add(input int a, input int b);
    return a + b;
endfunction

initial begin
    $display("%0d", add(b:20, a:10)); // Pass by name → 30
end
``` 

----------

### **(d) Pass by Position**

-   Just use the order of arguments.
    

Example:

`$display("%0d", add(10, 20)); // Pass by position → 30` 

----------

----------

## ✅ **6. Function ports in SystemVerilog**

Unlike Verilog (which allowed only `input`), **SystemVerilog allows `input`, `output`, and `inout` in functions**.

### Example:

```
function int calc(input int a, input int b, output int sum, inout int ref_val);
    sum = a + b;
    ref_val = ref_val + 1;
    return a * b;
endfunction

initial begin
    int s, product, r = 100;
    product = calc(3, 4, s, r);
    $display("Sum=%0d Product=%0d Ref=%0d", s, product, r);
end
``` 

✔ Output: `Sum=7 Product=12 Ref=101`