from flask import Flask, render_template_string
import os

app = Flask(__name__)

@app.route('/')
def home():
    env = os.getenv('FLASK_ENV', 'development')  # Pull from environment variable or default to 'development'
    html_content = f'''
    <html>
    <head>
        <title>Demo Flask App</title>
    </head>
    <body>
        <center>
            <h3>This is a simple flask app for demonstrating a deployment<br>
               (connected to the <span style="color: red;">{env}</span> environment)</h3>
            <img border="0" src="/static/devops.png" alt="devops" width="1000" height="500" align="middle"/>
        </center>
    </body>
    </html>
    '''
    return render_template_string(html_content, env=env)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
