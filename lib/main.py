from flask import Flask, render_template, request, redirect, url_for, jsonify
import pandas as pd
import numpy as np
import random
import os
from tensorflow import lite
from sklearn.preprocessing import MinMaxScaler

app = Flask(__name__)
app_root = os.path.dirname(os.path.abspath(__file__))

dataset_1 = pd.read_csv(os.path.join(app_root,'Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv'))
dataset_2 = pd.read_csv(os.path.join(app_root,'Friday-WorkingHours-Afternoon-PortScan.pcap_ISCX.csv'))
datasets = pd.concat([dataset_1, dataset_2], axis=0)
numeric_columns = datasets.select_dtypes(include=[np.number])
numeric_columns = numeric_columns.drop_duplicates()
numeric_columns = numeric_columns.dropna()
numeric_columns = numeric_columns[~np.isinf(numeric_columns).any(axis=1)]
scaler = MinMaxScaler()
scaler.fit_transform(numeric_columns)

interpreter = lite.Interpreter(model_path=os.path.join(app_root,'cnn_model.tflite'))
interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

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
    new_row = numeric_columns.iloc[random.randint(0, len(numeric_columns)-1)]
    new_row = new_row.values.reshape(1, -1)
    new_rowScaled = scaler.transform(new_row)
    new_rowScaled = new_rowScaled.reshape((1, 2, 39, 1))
    input_data = new_rowScaled.astype(np.float32)
    interpreter.set_tensor(input_details[0]['index'], input_data)
    interpreter.invoke()
    output_data = interpreter.get_tensor(output_details[0]['index'])
    predicted_class = np.argmax(output_data)
    return jsonify({'class': int(predicted_class)})


if __name__ == '__main__':
    app.run(debug=True)
