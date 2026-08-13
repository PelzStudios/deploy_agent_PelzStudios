# deploy_agent_PelzStudios
Coding Lab : Linux Summative

Attendance Tracker Project Factory

HOW TO RUN

1. Make sure the following files are in the same directory as setup_project.sh:
   - attendance_checker.py
   - assets.csv
   - config.json
   - reports.log

2. Make the script executable:

   chmod +x setup_project.sh

3. Run the script:

   ./setup_project.sh

4. Enter a project/directory name when prompted.

5. The script will create an attendance_tracker_<name> directory containing the required project structure.

6. The script will ask whether you want to update the attendance thresholds. If yes, enter the new Warning and Failure values.


ARCHIVE FEATURE

The script uses a signal trap to handle interruptions caused by Ctrl+C.

To trigger the archive feature:

1. Run the setup script:

   ./setup_project.sh

2. While the script is running, press Ctrl+C.

3. The script will archive the current project as:

   attendance_tracker_<name>_archive.tar.gz

4. The incomplete project directory will then be deleted.

5. The script will exit after the archive has been created.
