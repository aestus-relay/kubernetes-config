FROM postgres:15.2

# Copy the script to the image
COPY pg-backup.sh /pg-backup.sh

# Make sure the script is executable
RUN chmod +x /pg-backup.sh

# Run the script
ENTRYPOINT "/pg-backup.sh"
