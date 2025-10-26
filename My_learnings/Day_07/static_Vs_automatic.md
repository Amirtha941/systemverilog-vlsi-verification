## ✅ **1. Are `static` and `automatic` keywords in SystemVerilog?**

Yes, **`static`** and **`automatic`** are **keywords** used to control the **lifetime and storage** of variables and functions.

-   **static** → Variable/function retains its value **between function calls**.
    
-   **automatic** → Variable/function is created **fresh for every function call** (no retention).
    

----------

## ✅ **2. What is the difference between `static` and `automatic`?**

|    Feature    |                          static                         |                              automatic                             |
|:-------------:|:-------------------------------------------------------:|:------------------------------------------------------------------:|
| Lifetime      | Exists for the entire simulation. Keeps previous value. | Exists only during the function call. Gets destroyed after return. |
| Default in SV | automatic for functions by default                      | Explicit when needed                                               |
| Reentrancy    | Not reentrant (multiple calls share same storage)       | Reentrant (each call has its own copy)                             |
| Usage         | For counters, persistent data                           | For recursion, temporary data                                      |


### ✅ **Example: static variable in a function**

```
function int count_calls();
    static int count = 0; // Keeps value across calls
    count++;
    return count;
endfunction

initial begin
    $display(count_calls()); // 1
    $display(count_calls()); // 2
    $display(count_calls()); // 3
end
``` 

✔ Output: `1, 2, 3` because `count` persists.

----------

### ✅ **Example: automatic variable in a function**

```
function automatic int count_calls_auto();
    int count = 0; // Created fresh every call
    count++;
    return count;
endfunction

initial begin
    $display(count_calls_auto()); // 1
    $display(count_calls_auto()); // 1
    $display(count_calls_auto()); // 1
end
``` 

✔ Output: `1, 1, 1` because `count` is recreated every time.

----------

----------

## ✅ **3. What is “local” vs “global” in this context?**

-   **Local** → Exists only inside the function during the call (automatic variable).
    
-   **Global/Persistent** → Exists across all calls (static variable).
    

----------

----------

## ✅ **4. What happens when we mix them?**

### **Case 1: Static variable inside an automatic function**

```
function automatic int mixed_case();
    static int persistent = 0; // Keeps value across calls
    persistent++;
    return persistent;
endfunction
``` 

✔ Even though the function is **automatic**, this variable behaves like **static** → retains value.

----------

### **Case 2: Automatic variable inside a static function**

```
function static int mixed_case2();
    automatic int temp; // Exists only for that call
    temp = $urandom_range(1,100);
    return temp;
endfunction
``` 

✔ Even though the function is **static**, this variable behaves like **automatic** → temporary per call.