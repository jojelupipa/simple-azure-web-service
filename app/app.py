from flask import Flask
import pyodbc
import os

app = Flask(__name__)

# Connection string from environment variables
connection_string = os.getenv("CONNECTION_STRING")


@app.route('/')
def index():
    try:
        # Connect to Azure SQL Database
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        cursor.execute("SELECT 'Hello from Azure SQL Database!'")
        message = cursor.fetchone()[0]
        conn.close()
        return message
    except Exception as e:
        return str(e)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
