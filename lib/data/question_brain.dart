class Question {
  List<dynamic> flutterQuestion = [
    {
      "question": "What is Flutter?",
      "options": [
        "Flutter is an open-source UI toolkit",
        "Flutter is an open-source backend development framework",
        "Flutter is an open-source programming language for cross-platform applications",
        "Flutters is a DBMS toolkit",
      ]
    },
    {
      "question": "Which programming language is used to build Flutter applications?",
      "options": [
        "Dart",
        "Kotlin",
        "Go",
        "Java",
      ],
    },
    {
      "question": "How many types of widgets are there in Flutter?",
      "options": [
        "2",
        "4",
        "6",
        "8+",
      ],
    },
    {
      "question": "A sequence of asynchronous Flutter events is known as a:",
      "options": [
        "Stream",
        "Flow",
        "Current",
        "Series",
      ],
    },
    {
      "question": "Access to a cloud database through Flutter is available through which service?",
      "options": [
        "Firebase Database",
        "SQLite",
        "NOSQL",
        "MYSQL",
      ],
    },
    {
      "question":
          "What element is used as an identifier for components when programming in Flutter?",
      "options": [
        "Keys",
        "Widgets",
        "Elements",
        "Serial",
      ],
    },
    {
      "question":
          "Which function will return the widgets attached to the screen as a root of the widget tree to be rendered on screen?",
      "options": [
        "runApp()",
        "main()",
        "container()",
        "root()",
      ],
    },
    {
      "question": "What is the key configuration file used when building a Flutter project?",
      "options": [
        "pubspec.yaml",
        "pubspec.xml",
        "config.html",
        "root.xml",
      ],
    },
    {
      "question":
          "Which component allows us to specify the distance between widgets on the screen?",
      "options": [
        "SizedBox",
        "SafeArea",
        "AppBar",
        "Material",
      ],
    },
    {
      "question": "What widget would you use for repeating content in Flutter?",
      "options": [
        "ListView",
        "ExpandedView",
        "Stack",
        "ArrayView",
      ],
    },
  ];
  List<dynamic> cQuestion = [
    {
      "question": """
      What is the output of the following code snippet?
          #include<stdio.h>
          main() 
          { 
             int const a = 5;  
             a++; 
             printf(“%d”,a); 
          } 
     """,
      "options": [
        "Compile Error",
        "Runtime Error",
        "5",
        "6",
      ]
    },
    {
      "question": """
      What is the output of the following code snippet?
          #include<stdio.h>
          main() 
          { 
             int const a = 5; 
             a++; 
             printf(“%d”,a); 
          } 
          """,
      "options": [
        "0",
        "0.5",
        "1",
        "4",
      ]
    },
    {
      "question": """
      What is the output of the following program?

          #include<stdio.h>
          
          main()
          { 
             int a[] = {2,1};
             
             printf("%d", *a); 
          }
      """,
      "options": [
        "2",
        "1",
        "Compiler Error",
        "0",
      ]
    },
    {
      "question": """
      What is the output of the below code snippet.

          #include<stdio.h>
          
          main()
          {
             printf("%d", -11%2);
          }
      """,
      "options": [
        "-1",
        "5.5",
        "1",
        "-5.5",
      ]
    },
    {
      "question": """
      What is the output of the following program?

      #include<stdio.h>
      
      main()
      { 
         char s[] = "Hello\\0Hi";
         
         printf("%d %d", strlen(s), sizeof(s));
      }
      """,
      "options": [
        "5 9",
        "7 20",
        "5 20",
        "8 20",
      ]
    },
    {
      "question": "How to round-off a value “5.77” to 6.0?",
      "options": [
        "ceil(5.77)",
        "round-off(5.77)",
        "round-up(5.77)",
        "floor(5.77)",
      ]
    },
    {
      "question":
          "Which header file can be used to define input/output function prototypes and macro",
      "options": [
        "stdio.h",
        "math.h",
        "dos.h",
        "memory.h",
      ]
    },
    {
      "question": "Which of the following is an exit controlled loop?",
      "options": ["do-while", "For", "While", "None of them"]
    },
    {
      "question": "What is the range of values that can be stored by int datatype in C?",
      "options": [
        "-(2^31) to (2^31) - 1",
        "-256 to 256",
        "-(2^63) to (2^63) - 1",
        "0 to (2^31) - 1",
      ]
    },
    {
      "question": "How are String represented in memory in C",
      "options": [
        "An array of characters",
        "The object of some class",
        "Same as other primitive data type",
        "Linkedlist of character",
      ],
    },
  ];
  List<dynamic> pythonQuestion = [
    {
      "question": "Which type of Programming does Python support?",
      "options": [
        "all of the mentioned",
        "functional programming",
        "structured programming",
        "object-oriented programming",
      ]
    },
    {
      "question": "Is Python case sensitive when dealing with identifiers?",
      "options": [
        "yes",
        "no",
        "machine dependent",
        "none of the mentioned",
      ]
    },
    {
      "question": "Is Python code compiled or interpreted?",
      "options": [
        "both compiled and interpreted",
        "neither compiled nor interpreted",
        "only compiled",
        "only interpreted",
      ]
    },
    {
      "question": "All keywords in Python are in ___",
      "options": [
        "Lowercase",
        "Capitalized",
        "Uppercase",
        "None of them",
      ]
    },
    {
      "question": "What will be the value of the following Python expression?\n4+3%5",
      "options": [
        "7",
        "2",
        "4",
        "1",
      ]
    },
    {
      "question": "Which of the following is used to define a block of code in Python language?",
      "options": [
        "Indentation",
        "Key",
        "Brackets",
        "All of them",
      ]
    },
    {
      "question": "Which keyword is used for function in Python language?",
      "options": ["def", "fun", "Function", "Define"]
    },
    {
      "question":
          "Which of the following character is used to give single-line comments in Python?",
      "options": ["#", "!", "/*", "//"]
    },
    {
      "question":
          "Which of the following functions can help us to find the version of python that we are currently working on?",
      "options": [
        "sys.version",
        "sys.version()",
        "version",
        "version()",
      ]
    },
    {
      "question": "Python supports the creation of anonymous functions at runtime, using a "
          "construct called ___",
      "options": ["lambda", "pi", "anonymous", "none of them"]
    },
  ];
  List<dynamic> dataStructureQuestion = [
    {
      "question": "How can we describe an array in the best possible way?",
      "options": [
        "Container that stores the elements of similar types",
        "The Array shows a hierarchical structure.",
        "Arrays are immutable.",
        "The Array is not a data structure",
      ]
    },
    {
      "question": "Which of the following is the correct way of declaring an array?",
      "options": [
        "int arr[10];",
        "int arr;",
        "arr{20};",
        "array arr[10];",
      ]
    },
    {
      "question": "How can we initialize an array in C language?",
      "options": [
        "int arr[2] = {10, 20}",
        "int arr[2]=(10, 20)",
        "int arr(2) = (10, 20)",
        "int arr(2)={10, 20}",
      ]
    },
    {
      "question": "Which of the following is the advantage of the array data structure?",
      "options": [
        "Easier to access the elements in an array",
        "Elements of mixed data types can be stored",
        "Index of the first element starts from 1",
        "Elements of an array cannot be sorted",
      ]
    },
    {
      "question": "Which of the following highly uses the concept of an array?",
      "options": [
        "Spatial locality",
        "Binary Search tree",
        "Caching",
        "Scheduling of Processes",
      ]
    },
    {
      "question":
          "Which one of the following is the size of int arr[9] assuming that int is of 4 bytes?",
      "options": [
        "36",
        "9",
        "35",
        "None of them",
      ]
    },
    {
      "question":
          "Which one of the following is the process of inserting an element in the stack?",
      "options": [
        "Push",
        "Insert",
        "Add",
        "None of them",
      ]
    },
    {
      "question": "Which data structure is mainly used for implementing the recursive algorithm?",
      "options": [
        "Stack",
        "Queue",
        "Binary tree",
        "Linked list",
      ]
    },
    {
      "question": "Which data structure is required to convert the infix to prefix notation?",
      "options": [
        "Stack",
        "Linked list",
        "Binary tree",
        "Queue",
      ]
    },
    {
      "question": "Which one of the following is not the application of the stack data structure",
      "options": [
        "Asynchronous data transfer",
        "Backtracking",
        "Recursion",
        "String reversal",
      ]
    },
  ];
  List<dynamic> dbmsQuestion = [
    {
      "question": "What is the full form of DBMS?",
      "options": [
        "Database Management System",
        "Data of Binary Management System",
        "Data Backup Management System",
        "Database Management Service",
      ]
    },
    {
      "question": "What is DBMS?",
      "options": [
        "DBMS stores, modifies and retrieves data",
        "DBMS is a programming language",
        "DBMS is a high-level language",
        "DBMS is a collection of queries",
      ]
    },
    {
      "question": "Which of the following is not a type of database?",
      "options": [
        "Decentralized",
        "Hierarchical",
        "Network",
        "Distributed",
      ]
    },
    {
      "question": "Which of the following is not an example of DBMS?",
      "options": [
        "Google",
        "MySQL",
        "IBM DB2",
        "Microsoft Access",
      ]
    },
    {
      "question": "Which of the following is not a feature of DBMS?",
      "options": [
        "Single-user Access only",
        "High Level of Security",
        "Minimum Duplication and Redundancy of Data",
        "Support ACID Property",
      ]
    },
    {
      "question": "The ability to query data, as well as insert, delete, and alter tuples, is "
          "offered by ___",
      "options": [
        "DML (Data Manipulation Language)",
        "DDL (Data Definition Language)",
        "DCL (Data Control Language)",
        "TCL (Transaction Control Language)",
      ]
    },
    {
      "question":
          "___ is a set of one or more attributes taken collectively to uniquely identify a record.",
      "options": [
        "Super key",
        "Primary Key",
        "Foreign key",
        "Candidate key",
      ]
    },
    {
      "question": "Which command is used to remove a relation from an SQL?",
      "options": [
        "Drop table",
        "Delete",
        "Purge",
        "Remove",
      ]
    },
    {
      "question": "Which forms have a relation that contains information about a single entity?",
      "options": [
        "4NF",
        "2NF",
        "3NF",
        "5NF",
      ]
    },
    {
      "question":
          "Which of the following is the best way to represent the attributes in a large db?",
      "options": [
        "Concatenation",
        "Dot representation",
        "Relational-and",
        "All of the mentioned",
      ]
    },
  ];
  List<dynamic> oopQuestion = [
    {
      "question": "Why Java is Partially OOP language?",
      "options": [
        "It allows code to be written outside classes",
        "It supports usual declaration of primitive data types",
        "It does not support pointers",
        "It does not support all types of inheritance",
      ],
    },
    {
      "question": "Which is not a feature of OOP in general definitions?",
      "options": [
        "Duplicate/Redundant data",
        "Modularity",
        "Code reusability",
        "Efficient Code",
      ],
    },
    {
      "question": "Which was the first purely object oriented programming language developed?",
      "options": [
        "SmallTalk",
        "Kotlin",
        "Java",
        "C++",
      ],
    },
    {
      "question": "Which feature of OOP indicates code reusability?",
      "options": [
        "Inheritance",
        "Abstraction",
        "Encapsulation",
        "Polymorphism",
      ],
    },
    {
      "question": "Which header file is required in C++ to use OOP?",
      "options": [
        "OOP can be used without using any header file",
        "stdlib.h",
        "iostream.h",
        "stdio.h",
      ],
    },
    {
      "question": "The feature by which one object can interact with another object is ___",
      "options": [
        "Message Passing",
        "Message reading",
        "Data transfer",
        "Data Binding",
      ],
    },
    {
      "question": "Which among the following, for a pure OOP language, is true?",
      "options": [
        "The language must follow all the rules of OOP",
        "The language should follow at least 1 feature of OOP",
        "The language must follow only 3 features of OOP",
        "The language should follow 3 or more features of OOP",
      ],
    },
    {
      "question": " In multilevel inheritance, which is the most significant feature of OOP used?",
      "options": [
        "Code reusability",
        "Flexibility",
        "Code readability",
        "Code efficiency",
      ],
    },
    {
      "question": "Which of the following is not true about polymorphism?",
      "options": [
        "Increases overhead of function definition always",
        "Helps in redefining the same functionality",
        "It is feature of OOP",
        "Ease in readability of program",
      ],
    },
    {
      "question": "What is an abstraction in object-oriented programming?",
      "options": [
        "Hiding the implementation and showing only the features",
        "Hiding the important data",
        "Hiding the implementation",
        "Showing the important data",
      ],
    },
  ];
  List<dynamic> cnQuestion = [
    {
      "question": "Which of these is a standard interface for serial data transmission?",
      "options": [
        "RS232C",
        "ASCII",
        "2",
        "Centronics",
      ]
    },
    {
      "question": "Which type of topology is best suited for large businesses which must carefully control and coordinate the operation of distributed branch outlets?",
      "options": [
        "Star",
        "Ring",
        "Hierarchical",
        "Local area",
      ]
    },
    {
      "question": "Which of the following transmission directions listed is not a legitimate channel?",
      "options": [
        "Double Duplex",
        "Full Duplex",
        "Half Duplex",
        "Simplex",
      ]
    },
    {
      "question": "Parity bits are used for which of the following purposes?",
      "options": [
        "To detect errors",
        "To transmit faster",
        "Encryption of data",
        "To identify the user",
      ]
    },
    {
      "question": "What kind of transmission medium is most appropriate to carry data in a computer network that is exposed to electrical interferences?",
      "options": [
        "Optical fiber",
        "Coaxial cable",
        "Microwave",
        "Unshielded twisted pair",
      ]
    },
    {
      "question": " A collection of hyperlinked documents on the internet forms the ?",
      "options": [
        "World Wide Web (WWW)",
        "E-mail system",
        "Mailing list",
        "Hypertext markup language",
      ]
    },
    {
      "question": "The location of a resource on the internet is given by its?",
      "options": [
        "URL",
        "Protocol",
        "E-mail address",
        "ICQ",
      ]
    },
    {
      "question": "The term HTTP stands for?",
      "options": [
        "Hypertext transfer protocol",
        "Hypertext transfer program",
        "Hypertext tracing protocol",
        "Hyper terminal tracing program",
      ]
    },
    {
      "question": "A proxy server is used as the computer?",
      "options": [
        "with external access",
        "acting as a backup",
        "performing file handling",
        "accessing user permissions",
      ]
    },
    {
      "question": "Which one of the following would breach the integrity of a system?",
      "options": [
        "Full access rights for all users",
        "Looking the room to prevent theft",
        "Fitting the system with an anti-theft device",
        "rotecting the device against willful or accidental damage",
      ]
    },
  ];
}
