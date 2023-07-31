# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container to /app
WORKDIR /app

# Add the current directory contents into the container at /app
COPY updateBuilder.py .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir requests

# Run the command to start the Python script
CMD ["python", "updateBuilder.py"]
