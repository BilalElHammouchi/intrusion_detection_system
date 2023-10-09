# Intrusion Detection System Deployment

This repository contains the deployment phase of our Intrusion Detection System project. The system leverages Convolutional Neural Networks (CNN) following the CRISP (Cross-Industry Standard Process for Data Mining) methodology to detect network intrusions. Additionally, we have developed a Flutter-based mobile application for real-time monitoring and reporting.

## Table of Contents

- [Introduction](#introduction)
- [Deployment Steps](#deployment-steps)
- [Usage](#usage)

## Introduction

Our Intrusion Detection System is designed to enhance network security by identifying and classifying network traffic as benign or malicious (DDoS and Portscan attacks). The deployment phase involves setting up the system components, including the Flask-based backend server for model deployment and the Flutter mobile application for monitoring and reporting.


## Deployment Steps

To deploy the Intrusion Detection System, follow these steps:

1. **Clone the Repository:** Clone this repository to your local machine using the following command:

   ```bash
   git clone https://github.com/yourusername/intrusion-detection-system-deployment.git
   ```
2. **Set Up Flask Backend:** The backend file is inside the lib directory alongside the flutter source code
   
3. **Deploy TensorFlow Lite Model:** Ensure that you have the pre-trained TensorFlow Lite model for intrusion detection ready and placed in the appropriate directory.

4. **Set Up Flutter Mobile Application:**

Install Flutter and the necessary dependencies. Follow the Flutter installation guide here: https://flutter.dev/docs/get-started/install

Run the Flutter application on an emulator or a physical device:

```bash
flutter run
```
The Flutter application should launch, allowing you to log in and monitor the system.

## Usage
Administrator Login: Use the provided username and password (default: 'admin') to log in to the Flutter mobile application.
![1](https://github.com/GoldenDovah/intrusion_detection_system/assets/19519174/38091c8c-1019-466d-9118-63c72a2005ef)

Dashboard: The home page displays total requests, a breakdown of request types, and real-time reporting of system activity.
![2](https://github.com/GoldenDovah/intrusion_detection_system/assets/19519174/8f2b2cc8-d7a1-4e5b-9cee-88d557ca9264)

Requests Page: Access the history of requests, including timestamps, to track system performance over time.
![3](https://github.com/GoldenDovah/intrusion_detection_system/assets/19519174/24d85ec5-e85d-4903-bbb7-ccb7dcc4f90b)
