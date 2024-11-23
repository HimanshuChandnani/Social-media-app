# Social Media App

A Flask-based social media application developed as an assignment for the completion of my Python course. This app incorporates core web development concepts, including Flask for backend, MySQL for database management, and HTML/CSS/JavaScript for frontend design.

---

## Features

### User Authentication

-   **Signup**: New users can create an account.
-   **Login**: Registered users can log in securely.
-   **Logout**: Users can log out of their account.

### Posts

-   **Home Page**: Displays all posts created by users.
-   **Post Management**:
    -   **Like and Comment**: Interact with posts by liking and commenting.
    -   **Edit and Delete**: Users can modify or delete their own posts.
-   **Post Comment Page**: Clicking on the comment button opens a dedicated page showing:
    -   The post details.
    -   Comments for that specific post.

### Profiles

-   **User Profiles**:
    -   Visit any user's profile to see their posts.
    -   Clicking on a post from a profile leads to its dedicated comment page.

### Messaging

-   **Global Chat**: A shared messaging page for all users.
-   **Direct Messages**:
    -   Add users to chat privately.
    -   Message existing connections.

---

## Technology Stack

-   **Backend**: Flask
-   **Database**: MySQL
-   **Frontend**: HTML, CSS, JavaScript

---

## Setup and Installation

### Prerequisites

-   Python 3.x
-   MySQL
-   A virtual environment setup (recommended)

### Steps

1. Clone the repository:
    ```
    git clone https://github.com/yourusername/social-media-app.git
    cd social-media-app
    ```
2. Create a virtual environment and activate it:

    ```
    python -m venv venv
    venv/Scripts/activate
    ```

3. Install the required packages:
    ```
    pip install -r requirements.txt
    ```
4. Set up the database:

-   Locate the social.sql file in the db/ folder.
-   Import the file into your MySQL database using phpMyAdmin or the MySQL command line:
    ```
    SOURCE path_to_social.sql;
    ```

5. Start the server:
    ```
    py app.py
    ```
6. Access the application in your browser:
    ```arduino
    http://127.0.0.1:12345/
    ```

## Project Structure

    social-media-app/
    ├── db/                 # Database dump folder (contains social.sql)
    ├── flask_session/       # Flask session files
    ├── static/              # CSS, JavaScript, and image files
    ├── templates/           # HTML templates
    ├── app.py               # Main Flask application
    ├── routes.py            # Application routes
    ├── requirements.txt     # Python dependencies
    └── README.md            # Project documentation

## Screenshots
