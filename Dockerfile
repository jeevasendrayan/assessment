# Use the official Python 3.7 image as the base image
FROM python:3.7-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the Python script into the container
COPY app.py .

# Install Flask, which is required by the script
RUN pip install Flask

# Expose port 8080
EXPOSE 8080

# Set the default command to run the app.py script
CMD ["python", "app.py"]
