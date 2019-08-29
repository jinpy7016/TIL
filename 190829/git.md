# Git

> Git�� �л���������ý���(DVCS)�̴�.
>
> �ҽ��ڵ��� �̷��� �����Ѵ�.

* ���� ����
  * [Git scm](https://git-scm.com/book/ko/v2)
  * [Git �Թ�](https://backlog.com/git-tutorial/kr/)

## 1. git ����

git Ŀ���� �ϱ� ���ؼ��� �ʱ⿡ �ۼ���(author) ������ �ݵ�� �Ͽ��� �Ѵ�.

```bash
$ git config --global user.name {������̸�}
$ git config --global user.email {������̸���}
```

���� global�� ������ ȯ�漳���� Ȯ���ϱ� ���ؼ��� �Ʒ��� ��ɾ �ۼ��Ѵ�.

```bash
$ git config --global --list
user.email=edutak.ssafy@gmail.com
user.name=edutak
```



## 2. git Ȱ�� ����

1. ���� git ����� ����

   ```bash
   $ git init
   Initialized empty Git repository in C:/Users/student/Desktop/algorithms/.git/
   (master) $
   ```

   * �ش� ���丮�� `.git/` ������ ���� �ȴ�.
   * �׻� `git init` �ϱ� ������ �ش� ������ �̹� ���� ���������(`(master)` ����) Ȯ�� �Ͽ��� �Ѵ�.

2. add

   ```bash
   $ git add .
   $ git add README.md a.txt
   $ git add folder/
   $ git status
   On branch master
   Your branch is ahead of 'origin/master' by 1 commit.
     (use "git push" to publish your local commits)
   
   Untracked files:
     (use "git add <file>..." to include in what will be committed)
   
           Git.md
   
   nothing added to commit but untracked files present (use "git add" to track)
   
   ```

   * `add` ��ɾ ���ؼ� `Working directory`���� `INDEX(staging area)`�� Ư�� ���ϵ��� �̵���Ų��.
   * Ŀ���� �� ��Ͽ� �״� ���̴�.

3. commit

   ```bash
   $ git commit -m 'Ŀ�Ը޽���'
   $ git commit
   [master a1a04a7] README ���� �ۼ�
    1 file changed, 1 insertion(+)
   $ git log
   ```

4. Ŀ�� �����丮 Ȯ���ϱ�(`log`)

   ```bash
   $ git log
   $ git log -2
   $ git log --oneline
   ```

5. ���� git ���� �˾ƺ���(`status`) **�߿�! ���� �Է��ؼ� Ȯ������!**

   ```bash
   $ git status
   ```

## 3. ���������(remote) Ȱ���ϱ�

### 1. ����

1. remote ����� ���

   ```bash
   $ git remote add origin {github URL}
   ```

   * ���� ����Ҹ� `origin` �̶�� �̸����� `URL` �� ����Ѵ�.

2. remote ����� Ȯ��

   ```bash
   $ git remote -v
   ```

3. remote ����� ����

   ```bash
   $ git remote rm {����� �̸�}
   ```

### 2. Push - Pull

1. ���� ����ҷ� ������ (`push`)

    ```bash
    $ git push origin master
    ```

2. ���� ����ҷκ��� ��������(`pull`)

   ```bash
   $ git pull origin master
   ```

### 3. Push-Pull �ó�����

Local A, Local B, Github���� Ȱ���� �ϴ� ��� ��������� �̷°� �޶����� �浹�� �߻��� �� �ִ�. ����, �׻� �۾��� �����ϱ����� `pull` �� �ް�, �۾��� �Ϸ��� ���Ŀ� `push`�� �����ϸ� �浹 ������ �߻����� �ʴ´�!

1. auto-merge

   * ������ ������ �������� ���� ��� �ڵ����� merge commit�� �߻� �Ѵ�.

   ```
   1. Local A���� �۾� �� Push
   2. Local B���� �۾� �� pull�� ���� ����.
   3. Local B���� �ٸ� ���� �۾� �� commit -> push
   4. ���� �߻�(~~git pull~~)
   5. Local B���� git pull
   6. �ڵ����� vim commit �� �� �ֵ��� ��.
   7. �����ϸ�, merge commit �߻�
   8. Local B���� git push!
   ```

2. merge conflict

   * �ٸ� �̷�(Ŀ��)���� ������ ������ �����Ǵ� ��� merge conflict �߻�.
   * ���� �浹 ������ �ذ� �ؾ� �Ѵ�!

   ```
   1. Local A���� �۾� �� Push
   2. Local B���� �۾� �� pull�� ���� ����.
   3. Local B���� ���� ���� �۾� �� commit -> push
   4. ���� �߻�(~~git pull~~)
   5. Local B���� git pull
   6. �浹 �߻�(merge conflict)
   7. ���� ���� ���� �� add, commit
   8. Local B���� git push
   ```

   * `git status` ��ɾ ���� ��� ���Ͽ��� �浹�� �߻��Ͽ����� Ȯ�� ����!

   * ���� ���� ����

     ```
     <<<<<<< HEAD
     Local B�۾�
     =======
     ���� ����ҿ� ��ϵ� �۾�
     >>>>>>> fajskh213ht12h4fahjkfhsdk
     ```


## 4. �ǵ�����

1. `Staging area` ���� unstage

   ```bash
   $ git status
   On branch master
   Your branch is ahead of 'origin/master' by 1 commit.
     (use "git push" to publish your local commits)
   
   Changes to be committed:
     (use "git reset HEAD <file>..." to unstage)
   
           deleted:    b.txt
   $ git reset HEAD b.txt
   ```

2. commit �޽��� �����ϱ�

   ```bash
   $ git commit --amend
   ```

   * Ŀ�� �޽����� �����ϰ� �Ǹ� �ؽð��� ����Ǿ� �̷��� ��ȭ�ϰ� �ȴ�.

   * ���� ���� ����ҿ� push�� �̷��̶�� ���� �����ϸ� �ȵȴ�!

   * Ŀ���� �ϴ� �������� ������ ���߷ȴٸ�, ���� ��ɾ ���ؼ� ������ ���� �ִ�!

     ```bash
     $ git add omit_file.txt
     $ git commit --amend
     ```

3. `working directory` ������� ������

   ```bash
   $ git checkout -- ���ϸ�
   ```

   * ��������� ��� ���� �ǰ�, �ش� ������ ���� Ŀ�� ���·� ��ȭ�Ѵ�!








