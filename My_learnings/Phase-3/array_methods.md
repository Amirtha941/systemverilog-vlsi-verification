
# 🚀 Part 2: Complete List of Array Methods (Dynamic, Associative, Queue)

SystemVerilog arrays come with **powerful built-in methods**, accessed with a dot (`.`).  
We’ll go through each category, with **syntax, example, and output explanation.**

----------

## 🧮 1. `.size()`

Returns the number of elements in **dynamic or queue** arrays.

```
int arr[] = '{10, 20, 30};
$display("Size = %0d", arr.size());
``` 

**Output:**

`Size = 3` 

💡 Works for: Dynamic & Queue arrays

----------

## 🧹 2. `.delete()`

Deletes all elements of **dynamic or associative arrays**.

```
int arr[] = '{10, 20, 30};
arr.delete();
$display("Size = %0d", arr.size());
``` 

**Output:**

`Size = 0` 

💡 For associative arrays, you can delete a single key:

`int assoc[string];
assoc["A"] = 10;
assoc["B"] = 20;
assoc.delete("A"); // deletes key "A"` 

----------

## 🔍 3. `.exists(index)`

Checks if a **key exists** in an associative array.

```
int assoc[string];
assoc["apple"] = 10;
if (assoc.exists("apple"))
  $display("Apple exists!");
 ``` 

**Output:**

`Apple exists!` 

----------

## 🔢 4. `.first(var)` and `.last(var)`

Gets the **first** or **last** key in an associative array.

```
int assoc[int];
assoc[10] = 100;
assoc[20] = 200;
int key;
assoc.first(key);
$display("First key = %0d", key);
assoc.last(key);
$display("Last key = %0d", key);
``` 

**Output:**

```
First  key  =  10  
Last  key  =  20
``` 

----------

## ⏭️ 5. `.next(var)` and `.prev(var)`

Move to next or previous key in associative arrays.

```
int assoc[int];
assoc[10] = 100;
assoc[20] = 200;
assoc[30] = 300;

int k;
assoc.first(k); // k = 10
assoc.next(k);  // move to next key (20)
$display("Next key = %0d", k);
``` 

**Output:**

`Next  key = 20` 

----------

## 🔁 6. `.sort()` (Dynamic/Queue Arrays)

Sorts the array in **ascending order**.

```
int arr[] = '{4, 2, 9, 1};
arr.sort();
$display("Sorted = %p", arr);
``` 

**Output:**

`Sorted = '{1,2,4,9}` 

💡 You can also use a **custom comparator** for descending order:

`arr.rsort(); // reverse sort` 

----------

## 🔄 7. `.reverse()`

Reverses the array order.

```
int arr[] = '{1, 2, 3, 4};
arr.reverse();
$display("Reversed = %p", arr);
``` 

**Output:**

`Reversed = '{4,3,2,1}` 

----------

## 🎲 8. `.shuffle()`

Randomly rearranges elements (useful in random testing).

```
int arr[] = '{1, 2, 3, 4};
arr.shuffle();
$display("Shuffled = %p", arr);
``` 

**Output Example:**

`Shuffled = '{3,1,4,2}` 

----------

## 🎯 9. `.sum()` / `.product()` / `.min()` / `.max()` _(SystemVerilog 2012+)_

Perform arithmetic reduction on dynamic or queue arrays.

```
int arr[] = '{1, 2, 3, 4};
$display("Sum = %0d", arr.sum());
$display("Product = %0d", arr.product());
$display("Min = %0d", arr.min());
$display("Max = %0d", arr.max());
``` 

**Output:**

`Sum = 10  Product = 24  Min = 1  Max = 4` 

----------

## 🧠 10. `.unique()` _(returns array with unique elements)_

```
int arr[] = '{1, 2, 2, 3, 3, 3, 4};
arr = arr.unique();
$display("Unique = %p", arr);
``` 

**Output:**

`Unique = '{1,2,3,4}` 

----------

## 🪄 11. `.find()` / `.find_index()` / `.find_first()` / `.find_last()`

Used to **filter or search** array elements based on a condition.

```
int arr[] = '{1, 2, 3, 4, 5};

// Find elements > 3
int result[] = arr.find(x) with (x > 3);
$display("Elements > 3: %p", result);

// Find index of element == 3
int idx[] = arr.find_index(x) with (x == 3);
$display("Index of 3: %p", idx);
``` 

**Output:**

`Elements > 3: '{4,5} Index of  3: '{2}` 

🔎 `.find_first()` and `.find_last()`

These are **specialized search methods**:

-   `.find_first()` → returns the **first element** (or index) that matches the condition.
-   `.find_last()` → returns the **last element** (or index) that matches the condition.

**Example 1:** Using `.find_first()`

```
int arr[] = '{1, 2, 3, 4, 5, 3}; 

// Find first element equal to 3 

int first_val[] = arr.find_first(x) with (x == 3); 
$display("First element == 3: %p", first_val);
 
// Find first index where element == 3 

int first_idx[] = arr.find_first_index(x) with (x == 3); 
$display("First index of 3: %p", first_idx);
```

**Output:**

```
First element == 3: '{3} First index of 3: '{2}
```
**Example 2:** Using `.find_last()
```
int arr[] = '{1, 2, 3, 4, 5, 3}; 

// Find last element equal to 3 

int last_val[] = arr.find_last(x) with (x == 3); 
$display("Last element == 3: %p", last_val); 
// Find last index where element == 3 
int last_idx[] = arr.find_last_index(x) with (x == 3); 
$display("Last index of 3: %p", last_idx);
```

**Output:**

Last element == 3: '{3} Last index of 3: '{5}

👉 Notice the difference:

-   `.find_first()` → gives the **earliest match**.
-   `.find_last()` → gives the **latest match**.
----------

## 🧩 12. `.insert(index, value)` and `.delete(index)` (Queues)

For **queues**, we can directly insert or delete at positions.

```
int q[$] = '{10, 20, 30};
q.insert(1, 15); // insert 15 at index 1
$display("After insert: %p", q);
q.delete(2); // delete element at index 2
$display("After delete: %p", q);
```

**Output:**
```
After  insert: '{10,15,20,30}
After delete: '{10,15,30}
```


# **Which array methods belong to which type (VERY IMPORTANT)**

SystemVerilog **does NOT** give all methods to all array types.

Here is the **truth table** you must remember:

|            Method            | Fixed Array | Dynamic Array |           Queue          | Associative Array |
|:----------------------------:|:-----------:|:-------------:|:------------------------:|:-----------------:|
| .size()                      | ❌           | ✅             | ✅                        | ❌*                |
| .delete()                    | ❌           | ✅             | ❌ (except delete(index)) | ✅                 |
| .exists()                    | ❌           | ❌             | ❌                        | ✅                 |
| .first() / .last()           | ❌           | ❌             | ❌                        | ✅                 |
| .next() / .prev()            | ❌           | ❌             | ❌                        | ✅                 |
| .sort() / .rsort()           | ❌           | ✅             | ✅                        | ❌                 |
| .reverse()                   | ❌           | ✅             | ✅                        | ❌                 |
| .shuffle()                   | ❌           | ✅             | ❌                        | ❌                 |
| .find() / .find_index()      | ❌           | ✅             | ❌                        | ❌                 |
| .unique()                    | ❌           | ✅             | ❌                        | ❌                 |
| .sum() / .min() / .max()     | ❌           | ✅             | ❌                        | ❌                 |
| .push_back() / .push_front() | ❌           | ❌             | ✅                        | ❌                 |
| .pop_back() / .pop_front()   | ❌           | ❌             | ✅                        | ❌                 |
| .insert(index)               | ❌           | ❌             | ✅                        | ❌                 |
| .delete(index)               | ❌           | ❌             | ✅                        | ❌                 |


### ⭐ SUPER IMPORTANT:

### **Fixed arrays have NO methods. Zero. Nothing.**

They are simple, static memory blocks.

----------

### 🔥 Why?

Fixed arrays exist at compile-time → no dynamic behavior → no methods.  
Dynamic arrays & queues are runtime structures → need methods.  
Associative arrays use keys → need navigation methods.
