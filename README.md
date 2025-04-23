# Flask ToDo App - DevOps Pipeline Project

## Project Structure

```
flask-todo-app/
├── app.py                  # Main Flask application
├── templates/              
│   └── index.html          # HTML template for the app
├── test_app.py             # Unit tests for the application
├── requirements.txt        # Python dependencies
├── .github/
│   └── workflows/          # Will contain GitHub Actions workflow files
├── infrastructure/         # Will contain Ansible or Terraform files
└── README.md               # Project documentation
```

## Setup Instructions

1. Create a virtual environment:
   ```
   python -m venv venv
   ```

2. Activate the virtual environment:
   - Windows: `venv\Scripts\activate`
   - macOS/Linux: `source venv/bin/activate`

3. Install dependencies:
   ```
   pip install -r requirements.txt
   ```

4. Run the application:
   ```
   python app.py
   ```

5. Run tests:
   ```
   python -m pytest test_app.py
   ```

The application will be available at http://localhost:5000