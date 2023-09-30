from flask import Flask, render_template, request, redirect, url_for, jsonify

app = Flask(__name__)


@app.route('/')
def index():
    return 'Hello, World!'


@app.route('/login', methods=['POST'])
def login():
    data = request.form
    username = data.get('username')
    password = data.get('password')
    if username == 'admin' and password == 'admin':
        return jsonify({'message': 'Login successful'}), 200
    else:
        return jsonify({'message': 'Login failed'}), 401


@app.route('/get_request', methods=['GET'])
def get_request():
    data = {"message": "Hello from Flask!"}
    return jsonify(data)


@app.route('/submit', methods=['POST'])
def submit():
    if request.method == 'POST':
        data = request.form['data']
        return redirect(url_for('index'))


if __name__ == '__main__':
    app.run(debug=True)
