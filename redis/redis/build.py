import subprocess
import re
import os

# GitHub 仓库地址
GITHUB_REPO = "redis/redis"
GIT_URL = f"https://github.com/{GITHUB_REPO}.git"  # 添加 .git 后缀

def get_github_tags(repo_url):
    """使用 git ls-remote --tags 获取远程仓库的所有 tags"""
    try:
        result = subprocess.run(
            ["git", "ls-remote", "--tags", repo_url],
            capture_output=True, text=True, check=True  # 修正拼写错误
        )

        tags = set()
        for line in result.stdout.splitlines():
            match = re.search(r"refs/tags/([\w\.-]+)", line)
            if match:
                tags.add(match.group(1))  # 提取 tag 名称
        return sorted(tags)

    except subprocess.CalledProcessError as e:
        print(f"Error fetching tags from {repo_url}: {e}")
        return []

def fill_py_tag(file_path, tag, output_folder):
    """填充文件的 {py_tag} """
    if not os.path.exists(output_folder):
        os.mkdir(output_folder)

    try:
        with open(file_path, 'r') as file:
            file_content = file.read()

        file_content = file_content.replace("{py_tag}", tag)

        output_file = os.path.join(output_folder, os.path.basename(file_path))
        print(output_file)
        with open(output_file, 'w') as file:
            file.write(file_content)

        print(f"文件已经替换并保存到指定目录")

    except Exception as e:
        print(f"替换时报错，错误内容如下: {e}")

def run_make(tag):
    subdir = os.path.join(os.getcwd(), tag)
    if not os.path.exists(subdir):
        print(f"目录 {tag} 不存在")
        return
    try:
        print(f"进入目录{tag} 准备执行")
        subprocess.run(["chmod", "+x", "ci.sh"], cwd=subdir)
        subprocess.run(["cp", "../Dockerfile.build", "./"], cwd=subdir)
        subprocess.run(["make", "env"], cwd=subdir)
        subprocess.run(["make", "ci"], cwd=subdir)

        print(f"成功执行")

    except subprocess.CalledProcessError as e:
        print(f"出现错误: {e}")

def extract_version(tag):
    # 使用正则表达式提取版本号的主版本号
    match = re.match(r'(\d+)\.(\d+)\.(\d+)(-[a-zA-Z0-9]+)?', tag)
    if match and int(match.group(1)) >= 6:
        return 1 # 返回主版本号
    return 0

def main():
    """主函数，获取并打印仓库 tags"""
    print(f"Fetching tags from: {GIT_URL}")
    
    tags = get_github_tags(GIT_URL)
    if tags:
        print("Tags found:")
        for tag in tags:
            if extract_version(tag):
              if not os.path.exists(f"{tag}"):
                    os.mkdir(f"{tag}")
              fill_py_tag("Makefile", tag, f"{tag}")
              fill_py_tag("ci.sh", tag, f"{tag}")
              run_make(tag)
    else:
        print("No tags found or error fetching tags.")

if __name__ == "__main__":
    main()

