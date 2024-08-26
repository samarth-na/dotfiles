#!/usr/bin/env python3

import os
import subprocess
import datetime


def get_files():
    find_command = """
    find ~/projects -type f -mmin -100 -exec ls -lt --time-style=+'%Y-%m-%d %T' {} + |
    sort -rk6,7
    """
    raw_input_allfiles = subprocess.getoutput(find_command).strip()
    if not raw_input_allfiles:
        raise FileNotFoundError("No files found in the specified time range.")
    return raw_input_allfiles


def get_current_time():
    return datetime.datetime.now().strftime("%Y-%m-%d %T")


def get_latest_file():
    raw_input_allfiles = get_files()
    current_time = get_current_time()

    for line in raw_input_allfiles.split("\n"):
        file_time = " ".join(line.split()[5:7])
        if file_time < current_time:
            return line.split()[-1]

    raise FileNotFoundError("No files found before the current time.")


def get_file_info(file_path):
    file_name = os.path.basename(file_path)
    file_extension = file_name.split(".")[-1]
    file_name_without_extension = os.path.splitext(file_name)[0]

    if file_name.strip() == "index":
        raise FileNotFoundError("write something new in the file")

    return file_name, file_extension, file_name_without_extension


def execute_file(file_path, file_extension, file_name_without_extension):
    if file_name_without_extension == "index":
        print("index file found \nplease write something new in the file")
        return

    commands = {
        "py": f"python {file_path}",
        "go": f"go run {file_path}",
        "js": f"bun run {file_path}",
        "ts": f"bun run {file_path}",
        "c": f"g++ {file_path} && ./a.out",
        "cpp": f"g++ {file_path} && ./a.out",
        "c++": f"g++ {file_path} && ./a.out",
        "out": "./a.out",
        "java": f"javac {file_path}",
        "lua": f"lua {file_path}",
        "sh": f"bash {file_path}",
        "rs": f"rustc {file_path} && ./{file_name_without_extension}",
    }

    command = commands.get(
        file_extension,
        f"echo Unsupported file type\necho -e '\n{file_path.split()[-1]}'",
    )
    subprocess.run(command, shell=True)


def main():
    try:
        raw_input = get_latest_file()
        file_name, file_extension, file_name_without_extension = get_file_info(
            raw_input
        )
        execute_file(raw_input, file_extension, file_name_without_extension)

        print(
            f"""
            \n--- ---
            \n{file_name}
            """
        )

    except FileNotFoundError as e:
        print(e)

    except KeyboardInterrupt:
        print("\nExited by user.")
        return


if __name__ == "__main__":
    main()
