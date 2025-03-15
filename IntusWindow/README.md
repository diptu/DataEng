**Prerequisites:**

* **Python and pip Installed:** You must have Python and pip

**Steps:**

1.   **Create a Virtual Environment (Recommended):**

    * Navigate to your dbt project directory in your terminal.Use the `cd` command to navigate to the root directory of your dbt project.
         `cd /IntusWindow`
    * Create a virtual environment using `venv` (or `virtualenv` if you prefer):

        ```bash
        python3 -m venv venv
        ```

Activate the virtual environment:

        * **macOS/Linux:**

            ```bash
            source venv/bin/activate
            ```

        * **Windows:**

            ```bash
            venv\Scripts\activate
            ```

2.  **Install Requirements (Recommended):**

    * If you have a `requirements.txt` file in your dbt project directory, install the required packages:

        ```bash
        pip install -r requirements.txt
        ```

3.  **Navigate to Your dbt task Directory:**
  - `cd /task`
4.  **Generate dbt Documentation:**

    * In your terminal, run the following command:

    ```bash
    dbt docs generate
    ```

5.  **Serve dbt Documentation:**

    * After the documentation generation is complete, run the following command:

    ```bash
    dbt docs serve
    ```

    * This command will start a local web server that hosts your generated dbt documentation.
    * dbt will provide a URL in the terminal, typically `http://localhost:8080/`.

6.  **View dbt Documentation:**

    * Open your web browser.
    * Enter the URL provided by the `dbt docs serve` command (e.g., `http://localhost:8080/`) into the address bar.
    * Your dbt documentation website will be displayed in your browser.
    * You can now browse your models, sources, macros, tests, and documentation.

7.  **Stop the dbt Documentation Server (Optional):**

    * To stop the local web server, press `Ctrl + C` in your terminal.