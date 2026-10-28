# GEMINI.md

There are general instructions for agents when working on this machine:

- When you finished implementing a feature, create a commit and then create a MR in gitlab. THIS ONLY APPLIES WHEN YOU ARE IN A WORKTREE FOLDER.

- There is `glab` (gitlab cli) installed on this machine. Use it to work with gitlab.

- Use `rg` (ripgrep) instead of `find` to search for values

- Use `eza` instead of `ls`

- Use `eza --tree` instead of `tree`

- The most important folder on this machine are
    - /home/user/Git/sand-odv/sand: Source of the sand monorepo monlith
    - /home/user/Git/sand-odv/sand-odv-gitops: GitOps repo of sand containing helm charts

- There a some folders on this machine which might interest you:
    - /home/user/Git/sand-odv/releng-shared/pipeline-components: Repositories which contain internal pipeline templates
    - /home/user/Git/sand-odv/releng-shared/pipeline-components: Repositories which contain internal pipeline templates
    - /home/user/Git/sand-odv/releng-shared/helm: Internal shared helm charts
    - /home/user/Git/sand-odv/releng-shared/crossplane: Crossplane charts
    - /home/user/Git/sand-odv/releng-shared/project-templates: Project templates following internal best practices
    - /home/user/Git/sand-odv/github.com: This folder contains a some git repos which might be relevant for your work. (Like dagster, hacksoftware etc.)
    - /home/user/Git/sand-odv/releng-customers/: GitOps repos for other projects on the plattform
