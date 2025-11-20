System Design Specification

Program Overview:
The program is a simple password validation system written in x86 assembly language.
It runs in real mode and uses DOS interrupts for input and output operations.

User Interface:
Welcome Message: A message welcoming the user to the password validation system.
Menu: Options for the user to attempt password validation or exit the program.

Password Handling:
Predefined Password: The password to be validated against is hardcoded as 'password'.
Password Length: The password length is fixed at 8 characters.
Input and Validation:
User is prompted to enter an 8-character password.
Input characters are read without echoing them to the screen.
The user can use the backspace key to correct their input.
Non-printable characters are rejected.
 
Validation Logic:
The entered password is compared character-by-character with the predefined password
After each failed attempt, the program displays the number of correct characters.
The user is allowed up to 3 attempts to enter the correct password.

Feedback and Error Handling:
Success Message: Displayed if the password is correct.
Failure Message: Displayed if the password is incorrect.
Lockout Message: Displayed if the user fails to enter the correct password within 3 attempts.
Invalid Input Handling: Non-printable characters and invalid menu selections are handled gracefully.

Program Flow:
Main Menu: Displays options and reads user choice.
Password Prompt: Prompts the user to enter the password.
Input Reading: Handles character input, including backspace.
Password Checking: Compares entered password with the predefined one.
Feedback: Provides feedback on the number of correct characters and overall result.
Attempts Management: Tracks the number of attempts and locks out the user after 3 failed attempts.
