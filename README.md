# Password Validation System in x86 Assembly

## System Design Specification

### 1. Program Overview
It runs in **real mode** and uses **DOS interrupts** for input and output operations.  

---

### 2. User Interface
- **Welcome Message:** Greets the user and introduces the program.  
- **Main Menu:** Provides two options:  
  1. Attempt Password Validation  
  2. Exit Program  

---

### 3. Password Handling
- **Predefined Password:** `password`  
- **Password Length:** Fixed at **8 characters**  

---

### 4. Input and Validation
- Users are prompted to enter an **8-character password**.  
- Input is handled securely:  
  - Characters are **not echoed** to the screen  
  - **Backspace** is supported for corrections  
  - **Non-printable characters** are rejected  
- Validation compares input **character-by-character** with the predefined password.  
- After each incorrect attempt, the program displays the **number of correct characters**.  
- Users have **up to 3 attempts** to enter the correct password.  

---

### 5. Feedback and Error Handling
- **Success Message:** Displayed when the password is correct.  
- **Failure Message:** Displayed for incorrect passwords.  
- **Lockout Message:** Displayed after 3 failed attempts.  
- **Invalid Input Handling:** Gracefully handles non-printable characters and invalid menu selections.  

---
