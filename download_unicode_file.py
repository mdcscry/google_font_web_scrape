import requests
import os

# The URL of the file to download
UNICODE_ZJ_SEQUENCES_URL = "https://unicode.org/Public/emoji/latest/emoji-zwj-sequences.txt"

# The desired local filename for the downloaded file
OUTPUT_FILENAME = "emoji-zwj-sequences.txt"

def fetch_and_save_file(url, local_filename):
    """
    Fetches a file from the given URL and saves it to the specified local filename.
    """
    print(f"Attempting to download file from: {url}")
    try:
        # Send a GET request to the URL
        response = requests.get(url, stream=True)
        response.raise_for_status()  # Raise an HTTPError for bad responses (4xx or 5xx)

        # Open the local file in binary write mode
        with open(local_filename, 'wb') as f:
            # Iterate over the response content in chunks to handle large files efficiently
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)
        
        print(f"Successfully downloaded file to: {os.path.abspath(local_filename)}")
        return True

    except requests.exceptions.RequestException as e:
        print(f"Error downloading the file: {e}")
        return False
    except IOError as e:
        print(f"Error writing file to disk '{local_filename}': {e}")
        return False

# --- Execute the script ---
if __name__ == "__main__":
    fetch_and_save_file(UNICODE_ZJ_SEQUENCES_URL, OUTPUT_FILENAME)
