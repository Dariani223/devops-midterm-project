# app.py
from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

# Simple in-memory database for tasks
tasks = []

@app.route('/')
def index():
    """Main page - displays all tasks"""
    return render_template('index.html', tasks=tasks)

@app.route('/add', methods=['POST'])
def add_task():
    """Add a new task to the list"""
    task = request.form.get('task')
    if task and task.strip():
        tasks.append(task)
    return redirect(url_for('index'))

@app.route('/delete/<int:task_id>', methods=['GET'])
def delete_task(task_id):
    """Delete a task by its index"""
    if 0 <= task_id < len(tasks):
        del tasks[task_id]
    return redirect(url_for('index'))

@app.route('/health')
def health_check():
    """Health check endpoint for monitoring"""
    return {"status": "healthy"}, 200

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)

    """adding a comment to test branching."""
    """some changes for testing"""