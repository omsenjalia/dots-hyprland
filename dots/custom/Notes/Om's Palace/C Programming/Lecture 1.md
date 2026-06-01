
---
## tags: [c-programming, lecture] lecture: 1 topic: Introduction to C — Language Basics, History, and Setup prerequisites: None

## Agenda

1. What is a language?
2. Introduction and history of C
3. Who uses C?
4. Exploring, installing and testing software needed to run C programs
5. Writing a sample program

---

## What is a Language?

A **language** is built on two things: a need to communicate, and a set of rules that defines how that communication must happen. Together, need and rules form the foundation of any language — natural or programming.

> [!info] Language = Need + Rules Every language exists because there is something that needs to be expressed, and a syntax that defines how to express it correctly. Break the syntax → the message doesn't get through.

```mermaid
graph TD
  A["Need to Communicate"] --> C["Language"]
  B["Rules / Syntax"] --> C
  C --> D["Understand the rules<br/>written by developers"]
  D --> E["Write a program<br/>that follows those rules"]
  E --> F{"Bug free?"}
  F -- No --> E
  F -- Yes --> G["Run the program"]
```

---

## Introduction & History of C

[[C — Lecture 1]] was developed by [[Dennis Ritchie — Lecture 1]] in 1972 at [[Bell Laboratories — Lecture 1]], USA. It was built primarily to develop the [[UNIX — Lecture 1]] operating system, and was designed to solve the limitations of the languages that preceded it — [[BCPL — Lecture 1]] (Basic Combined Programming Language) and [[B language — Lecture 1]], which was itself derived from BCPL.

> [!quote] Why C was created BCPL and B lacked the power and expressiveness needed to build a full operating system. C was Dennis Ritchie's direct answer to those limitations — purpose-built for systems programming.

```mermaid
graph TD
  BCPL["BCPL<br/>Basic Combined Programming Language"] --> B["B<br/>Derived from BCPL"]
  B --> C["C — 1972<br/>Dennis Ritchie, Bell Labs"]
  C --> UNIX["UNIX OS<br/>Primary use case"]
  C --> ANSI["ANSI C<br/>Standardized by American<br/>National Standards Institute"]
```

After Ritchie's original release, the [[ANSI — Lecture 1]] (American National Standards Institute) team worked on the language and published the standardized **[[ANSI C — Lecture 1]]** version, which became the universal reference for all C compilers.

> [!success] Why C is still relevant today C is used for building operating systems, application packages, and customized software. Its longevity comes from a combination of raw performance and close-to-hardware control that higher-level languages simply cannot match.

---

## Who Uses C?

C is actively used across a range of professional roles:

- Software developers
- Senior programmers
- QA folks
- Programming architects
- Chip software programmers

> [!question] Why do chip programmers rely on C? Embedded systems and firmware require direct control over memory and CPU instructions with minimal overhead — exactly what C provides that languages like Python or Java cannot.

---

## Exploring, Installing & Testing Software to Run C Programs

> [!warning] Live Demo — Check Video This section was a live demonstration and was not captured in the slides. Refer back to the lecture video for the installation walkthrough.

To write and run C programs you need two things: a **[[text editor — Lecture 1]]** or **[[IDE — Lecture 1]]** to write code, and a **[[compiler — Lecture 1]]** to translate that code into machine-executable instructions. The most common compiler used for learning C is [[GCC — Lecture 1]] (GNU Compiler Collection).

```mermaid
graph TD
  A["Write Code<br/>Text Editor / IDE"] --> B["GCC Compiler<br/>Translates C to machine code"]
  B --> C{"Errors?"}
  C -- Yes --> A
  C -- No --> D["Executable File<br/>.exe on Windows<br/>a.out on Linux"]
  D --> E["Run Program<br/>See Output in Terminal"]
```

> [!tip] Recommended Setup for Beginners Install **GCC** and use **VS Code** with the C/C++ extension. On Windows, install GCC via MinGW. On Linux/macOS it is already available via the terminal.

---

## Writing a Sample C Program

> [!warning] Live Demo — Check Video This section was a live demonstration and was not captured in the slides. Refer back to the lecture video for the live coding walkthrough.

Here is the standard first program written in C:

```c
#include <stdio.h>      // gives us access to printf and scanf

int main() {            // entry point — program always starts here
    printf("Hello, World!\n"); // print to console; \n moves to next line
    return 0;           // tell the OS the program finished successfully
}
```

|Line|Code|Explanation|
|---|---|---|
|1|`#include <stdio.h>`|Includes the standard input/output library, giving access to `printf` and `scanf`|
|3|`int main()`|Entry point of every C program. Execution always begins here. `int` means it returns an integer|
|4|`printf("Hello, World!\n");`|Prints text to the console. `\n` moves the cursor to the next line|
|5|`return 0;`|Returns 0 to the OS, signaling the program finished successfully|

```mermaid
graph TD
  A["main()<br/>Program entry point"] --> B["printf()<br/>Print Hello World to console"]
  B --> C["return 0<br/>Signal success to OS"]
  C --> D["Program exits"]
```

> [!bug] Missing Semicolons Every statement in C ends with a semicolon `;`. Forgetting it is the most common beginner mistake and will stop the program from compiling entirely.

> [!example] What the output looks like When you run this program in your terminal, you will see exactly:
> 
> ```
> Hello, World!
> ```

---

## Key Terms

|Term|Definition|
|---|---|
|[[C — Lecture 1]]|A general-purpose, compiled programming language developed in 1972 by Dennis Ritchie|
|[[Dennis Ritchie — Lecture 1]]|Creator of the C language, worked at Bell Laboratories, USA|
|[[Bell Laboratories — Lecture 1]]|US research facility where C and UNIX were developed|
|[[UNIX — Lecture 1]]|Operating system that C was originally built to develop|
|[[BCPL — Lecture 1]]|Basic Combined Programming Language — earliest ancestor of C|
|[[B language — Lecture 1]]|Predecessor to C, derived from BCPL|
|[[ANSI — Lecture 1]]|American National Standards Institute — standardized the C language|
|[[ANSI C — Lecture 1]]|The standardized, cross-platform version of C released after Ritchie's original|
|[[compiler — Lecture 1]]|A program that translates C source code into machine-executable instructions|
|[[GCC — Lecture 1]]|GNU Compiler Collection — the most widely used C compiler for learning and development|
|[[IDE — Lecture 1]]|Integrated Development Environment — a text editor with built-in tools for writing and running code|

---

## Try It Yourself

**Exercise 1 — Change the Message** Modify the Hello World program to print your own name instead of "Hello, World!". Compile and run it.

**Exercise 2 — Multiple Lines** Write a program that prints three separate lines of text using three `printf` statements. Observe how `\n` controls the line breaks.

**Exercise 3 — C History in Code** Write a program that prints the C language lineage as output, like this:

```
BCPL --> B --> C (1972) --> ANSI C
```

---

**Lecture 1 Recap**

- A language = need + rules. Use it by learning the rules, writing conforming code, and running a bug-free program.
- C was created in 1972 by Dennis Ritchie at Bell Labs, evolving from BCPL → B → C to build UNIX.
- ANSI standardized C as the cross-platform baseline.
- C is used by developers, architects, QA engineers, and chip programmers.
- To run C you need GCC (compiler) + a text editor. See the lecture video for the full setup demo.
- Every C program starts at `main()`, every statement ends with `;`, and inline comments use `//`.