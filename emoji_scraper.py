import requests
import re
import os

# URL for the emoji-zwj-sequences.txt file
UNICODE_ZJ_SEQUENCES_URL = "https://unicode.org/Public/emoji/latest/emoji-zwj-sequences.txt"

# Desired Unicode Emoji versions (as strings for exact match, e.g., "12.1")
TARGET_VERSIONS_STR = [
    '2.0', '4.0', '12.0', '12.1', '13.0', '13.1',
    '15.0', '15.1', '16.0', '17.0'
]

# Dictionary to store emoji sequences, keyed by full version string
emoji_zwj_sequences_by_version = {v: [] for v in TARGET_VERSIONS_STR}

def fetch_and_parse_emoji_data(url):
    """
    Fetches the emoji-zwj-sequences.txt file and parses its contents.
    Stores each valid sequence (displayable Unicode string) into the
    emoji_zwj_sequences_by_version dictionary.
    Returns True on success, False on failure.
    """
    print(f"Fetching data from: {url}")
    try:
        response = requests.get(url)
        response.raise_for_status()  # Raise an HTTPError for bad responses (4xx or 5xx)
    except requests.exceptions.RequestException as e:
        print(f"Error fetching the file: {e}")
        return False

    content = response.text
    print("Parsing emoji sequences...")

    for line_num, line in enumerate(content.splitlines()):
        line = line.strip()

        # Skip comments and empty lines
        if not line or line.startswith('#'):
            continue

        try:
            # Example line format:
            # 1F468 200D 1F469 200D 1F467 ; RGI_Emoji_ZWJ_Sequence # E14.0 woman, man, girl

            # Split by the first semicolon to separate code points from description
            parts = line.split(';', 1)
            if len(parts) < 2:
                continue

            code_points_str, description_str = parts

            # Extract the FULL emoji version from the description (e.g., "12.1", "13.0")
            # Regex to find '# E<version.minor>'
            version_match = re.search(r'# E(\d+\.\d+)', description_str)
            if not version_match:
                continue

            full_emoji_version = version_match.group(1)

            # Only process target versions defined in TARGET_VERSIONS_STR
            if full_emoji_version not in TARGET_VERSIONS_STR:
                continue
            
            # This file should only contain RGI_Emoji_ZWJ_Sequence entries
            if "RGI_Emoji_ZWJ_Sequence" not in description_str:
                continue

            # Split space-separated hex code points
            hex_codes = code_points_str.strip().split(' ')
            
            # Convert each hex string to an integer, then to a Unicode character,
            # and join them to form the displayable emoji string.
            displayable_emoji_string = "".join([chr(int(h, 16)) for h in hex_codes])
            
            emoji_zwj_sequences_by_version[full_emoji_version].append(displayable_emoji_string)

        except ValueError as e:
            print(f"Skipping malformed data in line {line_num+1}: '{line}' - Error: {e}")
        except Exception as e:
            print(f"An unexpected error occurred on line {line_num+1}: '{line}' - Error: {e}")
    
    # Sort the dictionary keys (versions) for a cleaner output
    global_total_sequences = sum(len(seq_list) for seq_list in emoji_zwj_sequences_by_version.values())
    print(f"Parsing complete. Found {global_total_sequences} sequences across versions {TARGET_VERSIONS_STR}.")
    return True

# --- Execute the script ---
if __name__ == "__main__":
    if fetch_and_parse_emoji_data(UNICODE_ZJ_SEQUENCES_URL):
        print("\n--- Generated Emoji ZWJ Sequence Arrays ---")

        # Sort versions numerically for consistent output
        sorted_versions = sorted(TARGET_VERSIONS_STR, key=lambda v: [int(p) for p in v.split('.')])

        for version in sorted_versions:
            sequences = emoji_zwj_sequences_by_version[version]
            # Replace '.' with '_' in variable names because '.' is not valid in Python identifiers
            var_name = f"emoji_zwj_v{version.replace('.', '_')}" 
            print(f"\n# Unicode Emoji Version {version} ({len(sequences)} sequences)")
            # Print the array representation directly
            print(f"{var_name} = {sequences}")
            
            # Helper to show a few items if the list is long
            if len(sequences) > 5:
                print(f"#   (First 5: {sequences[:5]})")

        print("\n--- Done ---")
        print("You can copy the `emoji_zwj_vX_Y = [...]` lines above into your Python code.")
    else:
        print("Failed to fetch or parse emoji data. No arrays generated.")
