# Use an official, lightweight Python base image
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy and install dependencies first (for faster caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of our application code
COPY . .

# Document that the container exposes port 5000
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
