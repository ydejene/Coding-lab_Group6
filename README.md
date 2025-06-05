# Hospital Data Monitoring & Archival System
**Coding Lab Group 6**

##  Project Overview

The Hospital Data Monitoring & Archival System is an automated log management solution designed to simulate real-world medical device data collection and analysis in healthcare environments. This system demonstrates enterprise-level data management practices used in hospitals and medical facilities worldwide.

##  Project Objectives

This system addresses critical healthcare IT challenges by providing:

- **Real-time Data Collection**: Continuous monitoring of patient health metrics and facility resource usage
- **Intelligent Log Management**: Automated archival system to prevent data overflow and maintain system performance
- **Data Analytics**: Comprehensive reporting on device performance and operational patterns
- **System Administration**: Professional-grade scripts for healthcare IT staff

##  Technical Implementation

### Core Technologies

- **Shell Scripting**: Interactive automation and system administration
- **Python**: Device simulation and data generation
- **Linux Tools**: Data processing with awk, grep, sort, and other utilities
- **File System Management**: Log rotation, archival, and directory organization

### System Architecture

```
Medical Devices → Data Collection → Log Management → Analysis & Reporting
    (Python)      (Continuous)     (Shell Scripts)   (Automated Reports)
```

##  Simulated Medical Environment

The system replicates a hospital's critical monitoring infrastructure:

### Patient Monitoring Systems

- **Heart Rate Monitors**: Dual-device simulation tracking patient cardiac activity (60-100 BPM)
- **Temperature Sensors**: Multi-sensor network monitoring patient body temperatures (36-39°C)
- **Resource Management**: Water usage tracking for facility management (10-50 L/min)

### Data Characteristics

- Realistic medical value ranges based on clinical standards
- Timestamp-based logging for temporal analysis
- Multi-device simulation to represent actual hospital scale
- Continuous 24/7 operation capability

##  Key Features

### 1. Interactive Log Archival (`archive_logs.sh`)

- **User-Friendly Interface**: Menu-driven selection system
- **Intelligent Naming**: Timestamp-based archival with format `device_YYYY-MM-DD_HH:MM:SS.log`
- **System Continuity**: Automatic creation of fresh log files for uninterrupted monitoring
- **Error Handling**: Comprehensive validation and recovery mechanisms

### 2. Advanced Data Analysis (`analyze_logs.sh`)

- **Device Performance Metrics**: Statistical analysis of each monitoring device
- **Temporal Pattern Recognition**: First/last entry tracking for operational insights
- **Automated Reporting**: Professional-grade reports for administrative review
- **Data Validation**: Input sanitization and file integrity checks

### 3. Professional Data Management

- **Scalable Architecture**: Modular design supporting multiple device types
- **Audit Trail**: Complete logging history with archival timestamps
- **Resource Optimization**: Efficient storage management and data rotation
- **Compliance Ready**: Structured logging suitable for healthcare regulations

##  Real-World Applications

This system mirrors data management challenges in:

### Healthcare Industry

- Hospital patient monitoring systems
- Medical device performance tracking
- Regulatory compliance documentation
- Facility resource management

### Enterprise Environments

- Server log management in data centers
- IoT device monitoring in smart buildings
- Financial transaction logging in banking
- Network performance monitoring in telecommunications

##  Skills Demonstrated

### System Administration

- Log file management and rotation strategies
- Directory structure organization and maintenance
- Automated backup and archival procedures
- System monitoring and health checks

### Data Engineering

- Large-scale data processing with Unix/Linux tools
- ETL (Extract, Transform, Load) operations
- Data quality validation and error handling
- Automated reporting and analytics pipelines

### Software Development

- Shell scripting for automation and administration
- Python programming for data simulation
- Error handling and user input validation
- Modular code design and documentation

### DevOps & Automation

- Continuous monitoring system design
- Automated deployment and configuration
- System reliability and fault tolerance
- Performance optimization and resource management

##  Learning Outcomes

By completing this project, developers gain expertise in:

- **Linux System Administration**: Professional-level command-line proficiency
- **Data Pipeline Engineering**: Building automated data processing workflows
- **Healthcare Technology**: Understanding medical device data management
- **Quality Assurance**: Implementing robust error handling and validation
- **Documentation Standards**: Creating professional technical documentation

The project showcases enterprise-grade development practices essential for modern IT infrastructure and demonstrates readiness for professional software development roles in healthcare technology, DevOps, and data engineering.

##  Group Members

- **Belyse Intwaza**
- **Yonas Getachew Dejene**
- **Eloi Mizero**
- **Guido Rene Kayigamba**
- **Ridaa Isaro**
- **Abdul Kudus Zakaria Mukhtaru**



*This project represents a comprehensive approach to healthcare data management, combining technical excellence with practical industry applications.*
