In **SystemVerilog**, a **function** is a block of code that performs a specific task and returns a single value. Functions are used to avoid writing the same logic again and again.

----------

### ✅ **Key Points about Functions**

1.  **Functions return a value** (unlike tasks, which may not).
    
2.  **Functions execute in zero simulation time** (they cannot have delays like `#10`).
    
3.  **Functions cannot call tasks** (but they can call other functions).
    
4.  **Used for combinational logic**, mathematical calculations, or returning results.
    

----------

### ✅ **Basic Syntax**

```
function [return_type] function_name (input arguments);
    // function body
    return value;
endfunction
``` 

-   `return_type` → data type of the returned value (e.g., `int`, `logic`, `bit [3:0]`).
    
-   `function_name` → name of the function.
    
-   `input arguments` → values passed to the function.
    

----------

### ✅ **Simple Example**

```
module func_example;
    function int add(input int a, input int b);
        add = a + b;  // or return a + b;
    endfunction

    initial begin
        int result;
        result = add(10, 20);
        $display("Sum = %0d", result);
    end
endmodule
``` 

✔ Output: `Sum = 30`

----------

### ✅ **Rules of Functions**

-   Must **return a single value**.
    
-   **No timing control** inside (`#`, `@`, `wait` not allowed).
    
-   Can have **input arguments only** (not output/inout).
    
-   Can be **automatic** (reentrant) for recursion.
    

----------

### ✅ **Function Types**

-   **Regular Function** – simple calculation like above.
    
-   **Automatic Function** – each call has its own storage (used for recursion).
    
-   **Built-in Functions** – SystemVerilog provides many like `$clog2()`, `$bits()`, etc.
    

----------

### ✅ **Example with `automatic`**

```
function automatic int factorial(input int n);
    if (n <= 1)
        return 1;
    else
        return n * factorial(n-1);
endfunction
``` 

✔ This works because `automatic` allows recursion.