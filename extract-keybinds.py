import json
import re


lua_file_path = 'lua/keybinds.lua'  
output_json_path = 'keybinds.json'


def parse_lua_keybinding(lines):
    keybind_info = {}

    # Combine the multiple lines into a single line
    combined_line = " ".join(lines).strip()
    
    # Improved regex pattern to capture multiline keybindings
    match = re.search(r'vim\.keymap\.set\(\s*["\'](\w)["\']\s*,\s*["\'](.*?)["\']\s*,\s*["\']?(.*?["\']?)\s*,\s*\{.*?desc\s*=\s*["\'](.*?)["\']\s*\}\s*\)', combined_line, re.DOTALL)
    
    if match:
        keybind_info['modes'] = match.group(1)
        keybind_info['key'] = match.group(2)
        keybind_info['command'] = match.group(3).strip().strip('"\'')
        keybind_info['description'] = match.group(4)
    
    keybind_info['line'] = lines
    keybind_info['method'] = "block"
    return keybind_info if keybind_info else None

def parse_lua_keybinding_line(line):
    keybind_info = {}
    
    parts = line.strip().split('(', 1)[1].rsplit(')', 1)[0]  
    params = parts.split(',', 3)  
    
    
    open_braces_count = parts.count('{')
    close_braces_count = parts.count('}')
    
   
    if open_braces_count == 1 and close_braces_count == 1:
        if len(params) >= 3:
            mode_part = params[0].strip().strip()
            keybind_info['modes'] = mode_part.strip().strip('{').strip('}').strip('"\'').split(',')
            keybind_info['key'] = params[1].strip().strip('"\'')
            keybind_info['command'] = params[2].strip().strip('"\'')
            if len(params) > 3 and 'desc' in params[3]:
                desc_match = re.search(r'desc\s*=\s*["\'](.*?)["\']', params[3])
                if desc_match:
                    keybind_info['description'] = desc_match.group(1)
                    
        keybind_info['method'] = "line"

    elif open_braces_count == 2 and close_braces_count == 2:
        params = parts.split(',')
        if len(params) >= 3:
            mode_part = '%s,%s' % (params[0], params[1])
            modes = [m.strip().strip("{ ").strip(" }").strip('\"') for m in mode_part.split(',')]
            keybind_info['modes'] = modes
            keybind_info['key'] = params[2].strip().strip('"\'')
            keybind_info['command'] = params[3].strip().strip('"\'')
            if len(params) > 4:
                desc_match = re.search(r'desc\s*=\s*["\'](.*?)["\']', params[4])
                keybind_info['description'] = desc_match.group(1) if desc_match else "No description set"

        keybind_info['method'] = "line2"
    keybind_info['description'] = "No description set" if 'description' not in keybind_info else keybind_info['description']
    keybind_info['line'] = line
    return keybind_info if keybind_info else None

def extract_key_binds():
    keybinds_list = []
    current_lines = []
    inside_keymap = False
    open_parens_count = 0

    with open(lua_file_path, 'r', encoding='utf-8') as lua_file:
        lines = lua_file.readlines()
        for line in lines:
            stripped_line = line.strip()
            
            if 'vim.keymap.set' in stripped_line and not inside_keymap:
                inside_keymap = True
                current_lines = [stripped_line]
                open_parens_count = stripped_line.count('(') - stripped_line.count(')')
            elif inside_keymap:
                current_lines.append(stripped_line)
                open_parens_count += stripped_line.count('(') - stripped_line.count(')')
            
            if open_parens_count <= 0 and len(current_lines) > 0:

                if len(current_lines) == 1:
                    keybind = parse_lua_keybinding_line(current_lines[0]) 
                else:
                    keybind = parse_lua_keybinding(current_lines)
                if keybind and keybind not in keybinds_list and keybind['command'] != '<nop>':
                    keybinds_list.append(keybind)
                elif not keybind:
                    print(f"Error parsing keybinding: {current_lines}")

                inside_keymap = False
                current_lines = []

    with open(output_json_path, 'w', encoding='utf-8') as json_file:
        json.dump(keybinds_list, json_file, indent=2)

    print(f"Keybindings have been exported to {output_json_path}")

extract_key_binds()

