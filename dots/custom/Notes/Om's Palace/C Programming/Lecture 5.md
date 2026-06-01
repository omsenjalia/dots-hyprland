

## tags: [c-programming, lecture] lecture: 5 topic: Identifiers, Format Specifiers, Constants, and Variable Memory Model prerequisites: Variables and Data Types

# Lecture 5 — Identifiers, Format Specifiers, Constants, and Variable Memory Model

## Agenda

1. Understanding identifiers with program
2. Understanding basic format specifiers with program
3. Understanding constants with program
4. Understanding the back-side process of declaring, initialising, and accessing data elements of any defined data type

---

## Understanding Identifiers

An [[#^identifier|identifier]] is any name a programmer assigns to a program element — a variable, a function, an array, or a user-defined type. Whenever the compiler encounters an identifier, it uses that name to locate the memory address or code block associated with it. Without identifiers, there would be no way to refer to stored values by a meaningful label.

### Rules for Constructing Valid Identifiers

C enforces a strict and unambiguous set of rules for what constitutes a legal identifier:

- The very first character must be a letter (A–Z or a–z) or an underscore (`_`). A digit or any special character in the leading position makes the identifier illegal.
- After the first character, any combination of letters, digits, and underscores is permitted.
- C [[#^keyword|keywords]] — reserved words such as `int`, `float`, `if`, `return`, or `const` — have predefined meanings and cannot be repurposed as identifiers.
- Identifiers are strictly **case-sensitive**: `score`, `Score`, and `SCORE` are three entirely different names as far as the compiler is concerned.
- Names should be concise but descriptive. `studentAge` communicates intent far better than either the opaque `sa` or the unwieldy `theAgeOfTheCurrentStudent`.

> [!info] Why Case Sensitivity Matters C treats the case of every letter as part of the identifier's identity. This means `Temperature` and `temperature` can coexist as two completely separate variables in the same function. Accidentally mixing cases is one of the most common beginner bugs — the compiler will not flag it as an error, it will silently treat them as different names.

```mermaid
graph TD
    A["Does the first character<br/>start with a letter or underscore?"] --> |Yes| B["Does the rest use only<br/>letters, digits, or underscores?"]
    A --> |No| INV["INVALID identifier"]
    B --> |Yes| C["Is it a C keyword<br/>like int, float, or return?"]
    B --> |No| INV
    C --> |No| VAL["VALID identifier"]
    C --> |Yes| INV
```

### Examples of Valid and Invalid Identifiers

> [!warning] Live Demo — Check Video This section was a live demonstration and was not captured in the slides. Refer back to the lecture video for the walkthrough.

The table below covers the most commonly tested cases:

|Identifier|Valid?|Reason|
|---|---|---|
|`studentAge`|✅ Valid|Starts with a letter; contains only letters|
|`_count`|✅ Valid|Leading underscore is permitted|
|`total1`|✅ Valid|Letter first, then digit — allowed|
|`2count`|❌ Invalid|Cannot start with a digit|
|`total-marks`|❌ Invalid|Hyphen is a special character, not permitted|
|`int`|❌ Invalid|Reserved C keyword|
|`my score`|❌ Invalid|Spaces are not allowed inside identifiers|
|`MARKS` vs `marks`|Both valid, distinct|Case-sensitivity makes these two different identifiers|

> [!tip] Naming Convention Prefer **camelCase** (`studentAge`) or **snake_case** (`student_age`) for multi-word identifiers. Whichever convention you choose, apply it consistently — mixed conventions within a single codebase make code noticeably harder to read.

### Program Demonstrating Identifiers

```c
#include <stdio.h>          // gives access to printf and scanf

int main() {
    int   studentAge = 20;  // 'studentAge' is the identifier for an integer variable
    float cgpa       = 8.5; // 'cgpa' is the identifier for a float variable
    char  grade      = 'A'; // 'grade' is the identifier for a char variable

    printf("Age  : %d\n", studentAge);  // %d prints integer values
    printf("CGPA : %f\n", cgpa);        // %f prints float values
    printf("Grade: %c\n", grade);       // %c prints character values

    return 0;               // signal successful completion to the OS
}
```

|Line|Code|Explanation|
|---|---|---|
|1|`#include <stdio.h>`|Includes the standard I/O library so [[Lecture 1#^printf|
|4|`int studentAge = 20;`|Declares an integer variable; `studentAge` is its identifier|
|5|`float cgpa = 8.5;`|Declares a float variable; `cgpa` is its identifier|
|6|`char grade = 'A';`|Declares a character variable; `grade` is its identifier|
|8–10|`printf(...)` calls|Each identifier is used to retrieve and print the value it names|
|12|`return 0;`|Returns 0 to the operating system, signalling successful exit|

---

## Understanding Basic Format Specifiers

A [[#^format-specifier|format specifier]] is a special placeholder token embedded inside a format string that tells [[Lecture 1#^printf|printf]] (or [[Lecture 1#^scanf|scanf]]) what data type is being passed and how to represent it as text. Without a matching specifier, neither function has any way to know whether the bytes it receives should be interpreted as a whole number, a decimal, a letter, or a word.

> [!success] The Four Core Format Specifiers These four cover the overwhelming majority of everyday C programming needs:

|Specifier|Data Type|What It Represents|
|---|---|---|
|[[#^percent-d|`%d`]]|`int`|
|[[#^percent-f|`%f`]]|`float`|
|[[#^percent-c|`%c`]]|`char`|
|[[#^percent-s|`%s`]]|char array|

> [!info] How a Format Specifier Works When `printf` encounters `%d` in its format string, it reaches into the argument list, picks the next value, interprets those bytes as a signed integer, and converts the result into a printable sequence of digit characters. The specifier acts as a contract — it tells `printf` exactly how to decode the binary data it receives.

### Program Demonstrating Format Specifiers

```c
#include <stdio.h>             // needed for printf

int main() {
    int   age     = 21;        // integer — will be printed with %d
    float height  = 5.9;       // float — will be printed with %f
    char  initial = 'K';       // character — will be printed with %c
    char  name[]  = "Kavan";   // string (char array) — will be printed with %s

    printf("Age    : %d\n", age);      // %d matches int type
    printf("Height : %f\n", height);   // %f matches float type
    printf("Initial: %c\n", initial);  // %c matches char type
    printf("Name   : %s\n", name);     // %s matches char array

    return 0;
}
```

|Line|Code|Explanation|
|---|---|---|
|1|`#include <stdio.h>`|Makes `printf` available|
|4|`int age = 21;`|Integer variable — must use `%d` when printing|
|5|`float height = 5.9;`|Float variable — must use `%f` when printing|
|6|`char initial = 'K';`|Single character — must use `%c` when printing|
|7|`char name[] = "Kavan";`|String stored in a char array — must use `%s` when printing|
|9–12|`printf(...)` calls|Each specifier matches its corresponding variable's declared type|
|14|`return 0;`|Signals successful exit to the operating system|

> [!bug] Mismatched Format Specifier Printing a `float` with `%d`, or an `int` with `%f`, produces **undefined behaviour** — the output is garbage, or the program may crash entirely. The compiler may warn about the mismatch, but it will still compile and produce an incorrect result. Always match the specifier precisely to the variable's declared type.

---

## Understanding Constants

A [[#^constant|constant]] is a named value that is fixed at compile time and cannot be modified at any point during program execution. As soon as the compiler sees an assignment to a constant, it raises an error and refuses to produce a binary — the immutability is enforced before the program ever runs.

### When to Use Constants

Use a constant whenever a value must stay the same throughout the life of the program — the mathematical value of π, a maximum array size, a tax rate, or the number of days in a week. Giving a raw number a name achieves two things at once: the code becomes self-documenting (anyone reading `DAYS_IN_WEEK` immediately understands what `7` means in context), and any future change to the value only needs to be made in exactly one place.

### Declaring Constants with `const`

The [[#^const-keyword|`const`]] keyword is placed directly before the type in a variable declaration:

```c
const float PI = 3.14159;    // PI is locked in — no assignment can ever change it
```

> [!danger] Must Initialise at Declaration A `const` variable must receive its value at the exact point of declaration. Because the compiler permanently forbids any later assignment, a `const` declared without an initial value is stuck uninitialised forever — it can never hold a meaningful value and is completely useless. Always initialise a constant on the same line you declare it.

```c
const int DAYS = 7;     // Correct — declared and initialised together
const int SIZE;         // Wrong — declared without a value; can never be set later
```

> [!warning] Live Demo — Check Video This section was a live demonstration and was not captured in the slides. Refer back to the lecture video for the walkthrough.

### Program Demonstrating Constants

```c
#include <stdio.h>                    // for printf

int main() {
    const float PI    = 3.14159;     // constant — value is permanently fixed
    const int   SIDES = 3;           // constant — a triangle always has 3 sides
    float       radius = 7.0;        // regular variable — can change at any time
    float       area;                // will hold the computed circle area

    area = PI * radius * radius;     // reading a constant is always legal

    printf("Area of circle : %f\n", area);    // print the computed result
    printf("Sides of shape : %d\n", SIDES);   // print the integer constant

    // PI = 3.0;  // Uncommenting this causes a COMPILE-TIME ERROR

    return 0;
}
```

|Line|Code|Explanation|
|---|---|---|
|1|`#include <stdio.h>`|Includes the standard I/O library|
|4|`const float PI = 3.14159;`|Immutable float constant — declared and initialised together|
|5|`const int SIDES = 3;`|Immutable integer constant|
|6|`float radius = 7.0;`|Regular mutable float variable|
|7|`float area;`|Declared here; will be assigned in the next statement|
|9|`area = PI * radius * radius;`|Reading a constant in an expression is perfectly legal|
|11–12|`printf(...)` calls|Display the computed area and the constant `SIDES`|
|14|`// PI = 3.0;`|If uncommented, the compiler rejects the program with an error|
|16|`return 0;`|Signals success to the OS|

> [!tip] Naming Constants By convention, constant identifiers are written in ALL_CAPS with underscores between words — `MAX_SIZE`, `SPEED_OF_LIGHT`, `DAYS_IN_WEEK`. This visual distinction immediately signals to any reader that the value is immutable and should not be treated like a regular variable.

---

## Understanding the Back-Side Process of Variable Declaration, Initialisation, and Access

> [!warning] Live Demo — Check Video This section was a live demonstration and was not captured in the slides. Refer back to the lecture video for the walkthrough.

Writing `int x = 5;` in a C program looks like a single action, but it actually sets three distinct mechanisms in motion: [[#^declaration|declaration]], [[#^initialisation|initialisation]], and eventually [[#^access|access]]. Understanding what each stage means at the memory level is what separates a programmer who can write code from one who truly understands what the machine is doing.

### Stage 1 — Declaration

Declaration is the compiler step where memory is reserved. The compiler sees the data type, determines how many bytes that type requires, allocates a region of that size in memory, and permanently binds the identifier (the variable name) to the starting address of that region. At this point, the bytes in the allocated region contain whatever random data was left there from a previous use — commonly called a **garbage value**.

```mermaid
graph TD
    A["int x;"] --> B["Compiler sees type 'int'<br/>4 bytes are reserved in memory"]
    B --> C["A memory address is assigned<br/>e.g. address 0x1004"]
    C --> D["Identifier 'x' is permanently<br/>mapped to address 0x1004"]
    D --> E["Contents of those 4 bytes:<br/>unknown garbage value"]
```

### Stage 2 — Initialisation

Initialisation is the act of writing a meaningful value into the already-allocated memory. This can happen on the same line as declaration (`int x = 5;`) or in a separate assignment statement (`x = 5;`). Either way, the compiler converts the value to the appropriate binary representation for the declared type and writes those bytes into the reserved memory block.

```mermaid
graph TD
    A["x = 5"] --> B["Value 5 encoded in binary<br/>e.g. 00000000 00000000 00000000 00000101"]
    B --> C["Binary pattern written<br/>to address 0x1004"]
    C --> D["Memory at 0x1004<br/>now holds a valid, meaningful value"]
```

### Stage 3 — Access

Access is what happens when the program reads the variable — for example, when `printf` is given `x` as an argument. The compiler resolves the identifier to its associated memory address, fetches the bytes stored there, interprets them according to the variable's declared type, and passes the resulting value to whatever operation requested it.

```mermaid
graph TD
    A["printf uses 'x'"] --> B["Compiler resolves 'x'<br/>to address 0x1004"]
    B --> C["4 bytes fetched<br/>from address 0x1004"]
    C --> D["Bytes interpreted<br/>as a signed integer"]
    D --> E["Value 5 is passed<br/>to printf for display"]
```

### Program Demonstrating All Three Stages

```c
#include <stdio.h>              // for printf

int main() {
    // ---- DECLARATION ----
    int   marks;                // compiler reserves 4 bytes; content is unknown garbage
    float temperature;          // compiler reserves 4 bytes; content is unknown garbage

    // ---- INITIALISATION ----
    marks       = 95;           // integer 95 written into marks' reserved memory
    temperature = 36.6;         // 36.6 encoded as IEEE 754 float and stored

    // ---- ACCESS ----
    printf("Marks      : %d\n", marks);        // 4 bytes at marks' address read as int
    printf("Temperature: %f\n", temperature);  // 4 bytes at temperature's address read as float

    return 0;                   // signal success to the OS
}
```

|Line|Code|Explanation|
|---|---|---|
|5|`int marks;`|**Declaration** — 4 bytes reserved; identifier `marks` bound to their address|
|6|`float temperature;`|**Declaration** — 4 bytes reserved; identifier `temperature` bound to their address|
|9|`marks = 95;`|**Initialisation** — the integer value 95 is written into `marks`' reserved bytes|
|10|`temperature = 36.6;`|**Initialisation** — 36.6 stored in IEEE 754 format in `temperature`'s bytes|
|13|`printf("Marks ...", marks);`|**Access** — bytes at `marks`' address read and displayed as `%d`|
|14|`printf("Temperature ...", temperature);`|**Access** — bytes at `temperature`'s address read and displayed as `%f`|
|16|`return 0;`|Returns 0 to the OS|

> [!question] What Happens If You Read Before Initialising? Reading a declared-but-uninitialised variable is [[#^undefined-behaviour|undefined behaviour]] in C. The program might print a garbage number, silently produce incorrect results, or crash. The C standard imposes no rules on what happens — meaning the behaviour can differ between compilers, machines, and even between separate runs of the same program on the same machine.

---

## Key Terms

|Term|Definition|
|---|---|
|identifier|A programmer-defined name for any program element — a variable, function, or type — used by the compiler to locate that element's associated memory or code|
|keyword|A reserved word in C with a fixed predefined meaning that cannot be repurposed as an identifier (e.g. `int`, `return`, `if`, `const`)|
|format specifier|A placeholder token such as `%d` or `%f` used inside a `printf` or `scanf` format string to specify the type and text representation of a value|
|`%d`|Format specifier for printing or reading a signed decimal integer (`int`)|
|`%f`|Format specifier for printing or reading a floating-point number (`float`)|
|`%c`|Format specifier for printing or reading a single character (`char`)|
|`%s`|Format specifier for printing or reading a null-terminated string (char array)|
|constant|A named value declared with `const` that is fixed at compile time and cannot be reassigned at any point during execution|
|`const`|A C keyword placed before a type declaration to make the variable permanently immutable after its initial value is set|
|declaration|The compiler step that reserves memory of the correct size for a variable and binds the identifier name to that memory address|
|initialisation|The act of writing a meaningful value into a variable's reserved memory for the first time, via either an initialiser at declaration or a subsequent assignment|
|access|The operation of reading the bytes stored at a variable's memory address and interpreting them according to the variable's declared type|
|undefined behaviour|Any program behaviour not defined by the C standard; common causes include reading uninitialised variables and mismatched format specifiers; consequences range from garbage output to crashes|

> [!example]- Try It Yourself **Exercise 1 — Identifier Audit** Write a short program that declares one `int`, one `float`, and one `char`, using identifiers of your own choosing. Before running it, deliberately name one variable starting with a digit (e.g. `1score`), try to compile, and read the error message carefully. Fix it to a valid identifier, recompile, and observe the difference.
> 
> **Exercise 2 — Format Specifier Mismatch** Declare a `float` variable and intentionally print it using `%d` instead of `%f`. Compile and run — record the garbage output. Then switch to `%f` and observe the correct result. This exercise makes the consequences of a mismatched specifier viscerally memorable.
> 
> **Exercise 3 — Constant Enforcement** Declare a `const int` for the number of hours in a day (24). Use it to calculate and print the number of hours in a week and in a 30-day month. Then attempt to reassign the constant and observe the exact compiler error. Finally, try declaring a second constant without a value and observe what the compiler reports.

---

**Lecture 5 Recap**

- An identifier is a programmer-defined name; it must begin with a letter or underscore, may only contain letters, digits, and underscores thereafter, must not collide with a C keyword, and is case-sensitive — `value` and `Value` are two different identifiers.
- The four essential format specifiers are `%d` for integers, `%f` for floats, `%c` for characters, and `%s` for strings; using the wrong specifier for a type results in undefined behaviour.
- The `const` keyword makes a variable permanently immutable; it must always be given its value at the point of declaration — there is no way to assign a value to it later.
- Every variable in C passes through three conceptual stages: **declaration** (memory reserved and identifier bound), **initialisation** (a value written into that memory), and **access** (the stored bytes read and interpreted).
- Reading a variable that has been declared but never initialised is undefined behaviour — the result is unpredictable and can differ across compilers, machines, and program runs.