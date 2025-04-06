from app import app
from flask import jsonify
import time

@app.route('/')
def home():
    return "Hello World from Rajeev"

@app.route('/compute')
def compute():
    # Fibonacci of 10000 (CPU-intensive task)
    def fib(n):
        a, b = 0, 1
        for _ in range(n):
            a, b = b, a + b
        return a

    result = fib(10000)
    return jsonify({"result": str(result)[0:10] + "...", "status": "done"})
