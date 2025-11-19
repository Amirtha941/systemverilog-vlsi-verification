
# 🔥 ASSOCIATIVE ARRAYS — Full Deep Explanation

Associative array syntax:

`datatype array_name[index_type];` 

Examples:

```
int mem[int];            // key = int
int marks[string];       // key = string
bit [7:0] pixels[bit[15:0]];  // key = 16-bit logic value
``` 

Associative arrays can have **any type of key**:

-   int
    
-   string
    
-   bit vector
    
-   enum
    
-   even classes
    

----------

# 🚀 ASSOCIATIVE ARRAY METHODS — With Examples + Output

## **1. exists()**

Check if a given key exists.

```
nt mem[int];
mem[10] = 100;

if (mem.exists(10))
  $display("Key 10 found");
  ``` 

**Output:**

`Key  10 found` 

----------

## **2. delete() — full delete**

Delete entire associative array:

`mem.delete();` 

----------

## **3. delete(key) — specific delete**

`mem.delete(10); // removes key 10 only` 

----------

## **4. first()**

Gets the **smallest key**.

```
int mem[int];
mem[50] = 1;
mem[10] = 2;
mem[30] = 3;

int k;
mem.first(k);

$display("First key = %0d", k);
``` 

**Output:**

`First  key  =  10` 

----------

## **5. last()**

Gets the **largest key**.

```
mem.last(k);
$display("Last key = %0d", k);
``` 

**Output:**

`Last  key  =  50` 

----------

## **6. next()**

Moves to next key in sorted key-space.

```
mem.first(k);    // k = 10
mem.next(k);     // next key is 30
$display("Next key = %0d", k);
``` 

**Output:**

`Next  key = 30` 

----------

## **7. prev()**

Moves to previous key.

```
k = 30;
mem.prev(k); // previous key is 10
``` 

**Output:**

`Previous  key  =  10` 

----------

# 🧠 ASSOCIATIVE ARRAY KEY ITERATION

This is used daily in UVM scoreboards.

### **Iterating all keys (in sorted order):**

```
int k;
if (mem.first(k)) begin
  do begin
    $display("key=%0d value=%0d", k, mem[k]);
  end while (mem.next(k));
end
``` 

**Output:**

```
key=10 value=2  key=30 value=3  key=50 value=1
``` 

----------

# 💡 ASSOCIATIVE ARRAY WITH STRING KEYS

```
int marks[string];
marks["Tesla"] = 90;
marks["Nvidia"] = 99;
marks["Google"] = 95;

foreach (marks[name])
  $display("%s → %0d", name, marks[name]);
  ``` 

**Output:**

`Google → 95 Nvidia → 99 Tesla → 90` 

(SystemVerilog sorts keys alphabetically for strings.)

----------

# 🚀 ADVANCED: ASSOCIATIVE ARRAYS WITH CLASS KEYS (Verification)

```
class Packet;
  rand bit [31:0] addr;
endclass

Packet p;
int score[Packet];  // associative array with class object key
``` 

Used for:

-   storing packet → ID mapping
    
-   scoreboard transactions
    

----------

# 🧠 ASSOCIATIVE ARRAY SIZE ALTERNATIVE

Associative arrays **don’t have `.size()`**.  
But you can count them manually:

```
int count = 0;
foreach (mem[k])
  count++;

$display("Total elements = %0d", count);
```


# ⭐ 1. What makes associative arrays unique?

Associative arrays allow **sparse storage**, meaning:

-   You do NOT need to store continuous memory
    
-   You only store key → value pairs
    
-   Memory grows automatically as keys are added
    
-   No concept of array bounds (`size` does not exist)
    

This is why they are perfect for **scoreboards, reference models, CAMs, register files, out-of-order storage**.

----------

# ⭐ 2. Supported key types

Associative arrays support:

|       Key Type       |        Example        |
|:--------------------:|:---------------------:|
| integer              | int mem[int];         |
| string               | int marks[string];    |
| bit / logic vectors  | int table[bit[31:0]]; |
| enum                 | class obj[string];    |
| class object handles | int score[Packet];    |



This is **different** from dynamic arrays and queues, which MUST use integer indexes.

----------

# ⭐ 3. Deep Iteration Techniques

There are **five iteration methods**, not just `first()` and `next()`.

### 3.1 Iterate through all keys in sorted order

```
int A[int];
A[20] = 1; A[5] = 2; A[100] = 3;

int k;
if (A.first(k)) begin
  do begin
    $display("Key=%0d Value=%0d", k, A[k]);
  end while (A.next(k));
end
``` 

Output:

`Key=5 Value=2  Key=20 Value=1  Key=100 Value=3` 

----------

### 3.2 Reverse order iteration

```
A.last(k);
do begin
  $display(k,A[k]);
end while(A.prev(k));
``` 

----------

### 3.3 Check for next/prev element existence

```
if (A.next(k))
   $display("Next exists");
   ``` 

----------

# ⭐ 4. Matching Keys (with conditional operations)

Associative arrays allow matching by any key.

Example:

```
int A[string];
A["car"] = 10;
A["cab"] = 20;
A["cat"] = 30;

foreach(A[k])
  if (k.substr(0,1) == "ca")
    $display(k, A[k]);
 ``` 

Output:

`car 10
cab 20 cat 30` 

----------

# ⭐ 5. Auto-expansion and memory behavior

Associative arrays **grow when you assign** a new key:

```
int m[int];
m[100] = 5;   // now size=1
m[999] = 10;  // size=2
``` 

No resizing, no `new[]`, no memory errors.

Dynamic arrays cannot do this.

----------

# ⭐ 6. Scoreboard Pattern (NVIDIA-Level)

This is **VERY important**.

Associative arrays are used to reconcile expected vs actual transactions.

### Example: Transaction scoreboard

```
class Packet;
  int id;
  int data;
endclass

Packet exp[int];   // expected table
Packet got[int];   // actual table
``` 

When DUT produces output:

```
function void write_expected(Packet p);
  exp[p.id] = p;
endfunction

function void write_actual(Packet p);
  got[p.id] = p;

  if (exp.exists(p.id)) begin
     compare(exp[p.id], got[p.id]);
     exp.delete(p.id);
     got.delete(p.id);
  end
endfunction
``` 

This is EXACTLY how scoreboards work in UVM.

----------

# ⭐ 7. Associative Arrays with structs

```
typedef struct {
  int x;
  int y;
} Point;

Point map[int];
map[10] = '{3,5};
map[20] = '{6,8};
``` 

----------

# ⭐ 8. Associative Arrays with classes (VERY powerful)

```
class User;
  string name;
  int age;
endclass

User db[string]; // key = username

User u = new;
u.name = "harsha";
u.age = 23;

db["harsha"] = u;
``` 

Now you can store complex data structures and objects.

----------

# ⭐ 9. Associative array function return types

You can return associative arrays from functions:

```
function automatic int lookup[string](string prefix);
    int result[string];
    foreach(DB[k])
       if (k.find(prefix) == 0)
         result[k] = DB[k];

    return result;
endfunction
``` 

Returning arrays is allowed (SystemVerilog is very flexible).

----------

# ⭐ 10. The wildcard index type: **[*]**

If you don’t know the index type yet:

`int A[*];` 

This means:

> “Index type is determined by the first assignment.”

Example:

`A[5] = 100;       // now A is int A[int];` 

----------

# ⭐ 11. Ordering Rules

Associative array keys in SystemVerilog follow **sorted order**, depending on type:

|  Key Type |         Sorting        |
|:---------:|:----------------------:|
| integer   | ascending order        |
| string    | alphabetical           |
| bit/logic | numeric interpretation |
| class     | pointer address order  |
|           |                        |
