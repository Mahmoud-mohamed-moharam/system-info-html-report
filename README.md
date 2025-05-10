
# System Information HTML Report

A Bash script that generates a detailed system information report in HTML format. It collects essential system metrics including uptime, disk usage, and home directory utilization, and formats them into a simple, readable HTML file.

## Features

- 📊 System uptime reporting
- 💾 Disk space usage for mounted partitions
- 🏠 Home directory space usage (supports both root and standard users)
- 🧩 Interactive and command-line modes
- 📂 HTML output with timestamp and hostname

## Script Name

`system_report.sh`

## Usage

### Basic Usage
```bash
bash system_report.sh
```

### Save Output to a File
```bash
bash system_report.sh -f report.html
```

### Interactive Mode
```bash
bash system_report.sh -i
```

### Help Option
```bash
bash system_report.sh -h
```

## Output

The script produces an HTML report with sections:
- **System Uptime**
- **Disk Space Utilization**
- **Home Space Utilization** (either for all users or the current user depending on privileges)

## Requirements

- Bash shell environment
- Standard Linux utilities: `df`, `du`, `uptime`, `date`

## Project Structure

```
.
├── system_report.sh      # Main Bash script
└── README.md             # Project documentation
```

## Author

**Mahmoud Mohamed Moharam**  
📧 mahmoud.m.moharam@gmail.com

