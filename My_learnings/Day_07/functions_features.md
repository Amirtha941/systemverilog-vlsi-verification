
These are **advanced features of SystemVerilog functions** that make them much more powerful compared to Verilog.
----------

### ✅ **1. Automatic variable in static function**

-   Normally, **static function** means variables inside it keep their value between calls (like global).
    
-   But you can **declare some variables as automatic inside static functions** to make them local to that call.
    

#### Example:

```
function static int example_static();
    automatic int temp; // automatic inside static function
    temp = $urandom_range(1,100);
    return temp;
endfunction
``` 

✔ Here, `temp` will **not retain its value across calls** even though the function is static.

----------

### ✅ **2. Static variable in automatic function**

-   Opposite case: **automatic function** means all variables are local by default.
    
-   But you can make **specific variables static**, so they retain values across calls.
    

#### Example:

```
function automatic int example_auto();
    static int counter = 0; // retains value across calls
    counter++;
    return counter;
endfunction
``` 

✔ Every time you call this function, `counter` keeps increasing.

----------

### ✅ **3. More capabilities for declaring function ports**

SystemVerilog allows:

-   `input`, `output`, `inout` (Verilog allowed only `input`)
    
-   Pass by **value**, **reference**, **name**, or **position**
    

----------

### ✅ **4. Multiple statements without `begin…end`**

-   If you have **multiple statements**, Verilog needed `begin...end`.
    
-   SystemVerilog lets you skip `begin...end` **if each statement is separated by `;` on the same line**.
    

#### Example:

```
function int add_and_double(input int a, b);
    add_and_double = a + b; $display("Adding %0d and %0d", a, b);
endfunction
``` 

✔ Both statements in one line without `begin...end`.

----------

### ✅ **5. Returning early from a function**

-   You can **return before the end** like in C.
    

#### Example:

```
function int check_value(input int x);
    if (x < 0) return -1;
    return x * 2;
endfunction
``` 

----------

### ✅ **6. Passing values by reference, value, names, and position**

-   **By value** (default): The function gets a **copy**.
    
-   **By reference (`ref`)**: The function changes the original variable.
    

#### Example:

```
function void modify(ref int y);
    y = y + 10;
endfunction

initial begin
    int num = 5;
    modify(num);
    $display("num = %0d", num); // Output: 15
end
``` 

-   **By name or position**:
   
```
int res;
res = add(b:20, a:10); // Pass by name
res = add(10, 20);     // Pass by position
``` 

----------

### ✅ **7. Default argument values**

-   If not passed, SystemVerilog uses default.
    

#### Example:

```
function int add(input int a = 5, input int b = 10);
    return a + b;
endfunction

initial $display("%0d", add()); // Output: 15
```` 

----------

### ✅ **8. Default argument type is `logic`**

If you don’t specify type → it becomes `logic`.

#### Example:

`function int demo(x); // x is logic by default
    return x * 2;
endfunction` 

----------

### ✅ **9. Function output and inout ports**

-   Functions can now **return value AND have output/inout arguments** (unlike Verilog).
    

#### Example:

```
function int calc(input int a, input int b, output int sum);
    sum = a + b;
    return a * b;
endfunction

initial begin
    int s, product;
    product = calc(3, 4, s);
    $display("Sum=%0d Product=%0d", s, product); // Sum=7 Product=12
end
``` 

----------

### ✅ **10. Default direction is input**

If you don’t specify, argument is **input** by default.

----------

🔥 These make SystemVerilog functions **powerful and similar to C/C++ functions**.