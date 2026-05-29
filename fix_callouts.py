import os
import glob

def fix_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        
    new_lines = []
    changed = False
    for i, line in enumerate(lines):
        new_lines.append(line)
        # If this line is a callout start (like "> [!tip] Title\n")
        if line.startswith("> [!"):
            # Check if the next line is NOT "> \n" or ">\n"
            if i + 1 < len(lines):
                next_line = lines[i+1].strip()
                if next_line != ">":
                    new_lines.append(">\n")
                    changed = True

    if changed:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)

for md_file in glob.glob("Topics/**/*.md", recursive=True):
    fix_file(md_file)
    
print("Callouts fixed.")
