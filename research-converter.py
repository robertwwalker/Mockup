import os
import yaml
import re

# --- CONFIGURATION ---
INPUT_ROOT = './research/publication' 
OUTPUT_ROOT = './quarto_publications'

# Map Hugo publication_types to Quarto CSL types
# Hugo: 1=Conf, 2=Journal, 3=Preprint, 4=Report, 5=Book, 6=Book Section
TYPE_MAP = {
    "1": "paper-conference",
    "2": "article-journal",
    "3": "manuscript",
    "4": "report",
    "5": "book",
    "6": "chapter"
}

def clean_text(text):
    """Removes markdown italics and excessive whitespace."""
    if not text: return ""
    return text.replace('*', '').strip()

def process_publication(file_path, folder_name):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            raw = f.read()

        # Split YAML from Body
        match = re.search(r'^---[\r\n]+(.*?)[ \t]*[\r\n]+---(.*)', raw, re.DOTALL)
        if not match: return
        
        hugo = yaml.safe_load(match.group(1))
        body = match.group(2).strip()

        # 1. Extract and Move Abstract
        abstract = hugo.get('abstract', '')
        if abstract:
            body = f"## Abstract\n\n{abstract}\n\n{body}"

        # 2. Build the Quarto Citation Block (Crucial for the 'Cite' button)
        pub_type_code = str(hugo.get('publication_types', ['2'])[0])
        citation_meta = {
            'type': TYPE_MAP.get(pub_type_code, 'article'),
            'container-title': clean_text(hugo.get('publication', '')),
            'publisher': hugo.get('publisher', 'Unpublished'),
            'pdf-url': hugo.get('url_pdf') if hugo.get('url_pdf') != '#' else None
        }

        # 3. Build Main Page Metadata
        quarto_meta = {
            'title': str(hugo.get('title', 'Untitled')),
            'date': str(hugo.get('date', '')),
            'author': hugo.get('authors', []),
            'categories': hugo.get('projects', []),
            'citation': citation_meta, # Nested citation object
        }

        # 4. Action Buttons (Links at the top)
        links = []
        url_map = {'url_pdf': 'PDF', 'url_code': 'Code', 'url_slides': 'Slides'}
        for key, label in url_map.items():
            val = hugo.get(key)
            if val and val not in ['#', '""', '']:
                links.append({'text': label, 'icon': 'file-pdf' if 'pdf' in key else 'github', 'href': val})
        
        if links:
            quarto_meta['links'] = links

        # --- WRITE TO DISK ---
        dest_dir = os.path.join(OUTPUT_ROOT, folder_name)
        os.makedirs(dest_dir, exist_ok=True)
        
        # default_flow_style=False ensures lists look clean and colons are quoted
        yaml_out = yaml.dump(quarto_meta, sort_keys=False, allow_unicode=True, default_flow_style=False)
        
        with open(os.path.join(dest_dir, 'index.qmd'), 'w', encoding='utf-8') as f_out:
            f_out.write(f"---\n{yaml_out}---\n\n{body}")
            
        print(f"Success: {folder_name}")

    except Exception as e:
        print(f"Error in {folder_name}: {e}")

# Run globally
if __name__ == "__main__":
    os.makedirs(OUTPUT_ROOT, exist_ok=True)
    for root, dirs, files in os.walk(INPUT_ROOT):
        if 'index.md' in files:
            process_publication(os.path.join(root, 'index.md'), os.path.basename(root))
