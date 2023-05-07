# CM Node Module - Find/Remove

Managing Node.js projects often involves the installation of numerous packages and their dependencies. Over time, these `node_modules` folders can accumulate and consume a significant amount of disk space. If you have multiple projects or are working on a system with limited storage, it becomes essential to keep track of and clean up these directories.

CM Node Module - Find/Remove is a simple and efficient Bash script designed to help you find and list or remove `node_modules` directories. It also displays a summary of the total size of the directories or the space reclaimed after removal, allowing you to keep your workspace clean and organized.

## Instructions

1. Save the script to a file, e.g., `process_node_modules.sh`.
2. Make the script executable:

   ```bash
   chmod +x process_node_modules.sh
   ```

3. Run the script with the desired options:

   ```bash
   ./process_node_modules.sh -f
   ./process_node_modules.sh -r
   ```

## Usage

```
Usage:
  ./process_node_modules.sh -f [-d /path/to/directory]          Find and list 'node_modules' directories and their sizes
  ./process_node_modules.sh -r [-d /path/to/directory]          Remove 'node_modules' directories and show a summary of deleted space
```

### Example

Find and list `node_modules` directories in the `/path/to/project` directory:

```bash
$ ./process_node_modules.sh -f -d /path/to/project
```

Sample output:

```text
1.2M - /path/to/project/project1/node_modules
500K - /path/to/project/project2/node_modules
Total size: 1.7MB
```

Remove `node_modules` directories in the `/path/to/project` directory and display a summary of the deleted space:

```bash
$ ./process_node_modules.sh -r -d /path/to/project
```

Sample output:

```text
Deleted 1.7MB from 2 directories
```
