import requests
from bs4 import BeautifulSoup
import os # Import the os module for path manipulation (optional but good practice)

def get_gif_links_as_js_array(url):
    """
    Scrapes a given URL for GIF links in <img> tags and returns them
    formatted as a JavaScript array string.
    """
    gif_links = []
    
    try:
        # Fetch the HTML content
        print(f"Fetching content from: {url}")
        response = requests.get(url)
        response.raise_for_status()  # Check for HTTP errors (4xx or 5xx)
        html_content = response.text
        print("Content fetched successfully. Parsing HTML...")

        # Parse the HTML with BeautifulSoup
        soup = BeautifulSoup(html_content, 'html.parser')

        # Find all <img> tags
        img_tags = soup.find_all('img')

        # Extract src attributes that end with .gif
        for img in img_tags:
            src = img.get('src')
            if src and src.endswith('.gif'):
                gif_links.append(src)
        
        print(f"Found {len(gif_links)} GIF links.")

        # Format into a JavaScript array string
        if not gif_links:
            return "const gifUrls = [];\n// No GIF links found."

        js_array_elements = []
        for link in gif_links:
            # Each link should be quoted and on a new line, with proper indentation
            js_array_elements.append(f'    "{link}"') 

        js_output = "const gifUrls = [\n"
        js_output += ",\n".join(js_array_elements) # Join with ',\n' for new lines and commas
        js_output += "\n];"

        return js_output

    except requests.exceptions.RequestException as e:
        print(f"Error fetching the URL: {e}")
        return None # Indicate failure
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return None # Indicate failure

# --- Main execution ---
if __name__ == "__main__":
    target_url = "https://googlefonts.github.io/noto-emoji-animation/"
    output_filename = "noto_emoji_gifs.js" # Define the output file name

    js_array_string = get_gif_links_as_js_array(target_url)

    if js_array_string:
        # Print the resulting JavaScript array to console
        print("\n--- Generated JavaScript Array (also saved to file) ---")
        print(js_array_string)

        # Save the output to a .js file
        try:
            with open(output_filename, "w", encoding="utf-8") as f:
                f.write(js_array_string)
            print(f"\n--- Output successfully saved to '{output_filename}' ---")
            # Get the absolute path for convenience
            print(f"File path: {os.path.abspath(output_filename)}")
        except IOError as e:
            print(f"Error writing to file '{output_filename}': {e}")
    else:
        print("\n--- No JavaScript array generated due to previous errors. ---")

