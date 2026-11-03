# AGENTS.md

## Scope

These instructions apply when working on this machine. Follow any additional
repository-specific instructions in the repository you are working in.

## Preferred tools

Use the following tools:

| Task | Tool |
| --- | --- |
| Search file contents | `rg` |
| Find files and directories by name | `fd` |
| List directory contents | `eza` |
| Display a directory tree | `eza --tree` |
| Read files in the terminal | `bat` |
| Query or transform YAML and JSON | `yq` |
| Interact with GitLab | `glab` |

Use `rg` for content searches and `fd` for filename or directory searches.
Prefer these tools over `find`, `ls`, `tree`, `jq`, and `cat` for the
corresponding tasks.

## Git and GitLab workflow

After completing a feature **in a linked Git worktree**:

1. Run the relevant tests, linters, and other available checks.
2. Create a commit with a clear, descriptive message.
3. Push the feature branch.
4. Create a GitLab merge request using `glab`.
   - If an MR already exists for the branch, update it instead of creating
     a duplicate.
   - Summarize the changes and validation performed.
6. Report the commit and MR, including any checks that could not be run.

**The automatic commit-and-MR requirement applies only to linked Git
worktrees.** In a primary checkout, do not automatically commit, push, or
create an MR unless explicitly instructed.

## Primary repositories

The main workspace is:

    /home/user/Git/sand-odv/

The two primary repositories are:

| Path relative to the workspace | Purpose |
| --- | --- |
| `sand/` | Source code for the Sand monorepo / monolith |
| `sand-odv-gitops/` | Sand GitOps repository, including Helm charts |

## Supporting repositories

Consult these directories when relevant to the task:

| Path relative to the workspace | Purpose |
| --- | --- |
| `releng-shared/pipeline-components/` | Internal CI/CD pipeline components and templates |
| `releng-shared/helm/` | Shared internal Helm charts |
| `releng-shared/crossplane/` | Crossplane charts |
| `releng-shared/kargo/` | Shared Kargo promotion tasks |
| `releng-shared/project-templates/` | Project templates following internal best practices |
| `github.com/` | Local copies of upstream repositories, including Dagster and HackSoftware examples |
| `releng-customers/` | GitOps repositories for other projects on the platform |

You may read these repositories for examples, conventions, and implementation
details. Keep modifications within the scope of the task; do not change
supporting repositories merely because they are available.

## Repository inventory

The following inventory is a reference, not a guarantee of the current
directory layout. Verify paths before using them.

All paths below are relative to `/home/user/Git/sand-odv/`.
Entries marked `[git]` are Git repositories.

    .
    ├── github.com
    │   ├── HackSoftware
    │   │   ├── Django-Styleguide [git]
    │   │   └── Django-Styleguide-Example [git]
    │   └── dagster-io
    │       └── dagster [git]
    ├── releng-customers
    │   ├── ir-pricer
    │   │   └── ir-pricer-gitops [git]
    │   ├── lava-pricer
    │   │   └── lava-pricer-gitops [git]
    │   └── pbp
    │       └── pbp-gitops [git]
    ├── releng-shared
    │   ├── crossplane
    │   │   ├── crossplane-claim-charts [git]
    │   │   └── crossplane-umbrella-chart [git]
    │   ├── helm
    │   │   └── common-chart [git]
    │   ├── kargo
    │   │   └── kargo-promotion-tasks [git]
    │   ├── pipeline-components
    │   │   ├── conjur [git]
    │   │   ├── docker [git]
    │   │   ├── helm [git]
    │   │   ├── helpers [git]
    │   │   ├── kargo [git]
    │   │   ├── maven [git]
    │   │   ├── npm [git]
    │   │   ├── python [git]
    │   │   ├── scanning [git]
    │   │   ├── super-components
    │   │   │   ├── docker-pipeline [git]
    │   │   │   └── helm-pipeline [git]
    │   │   └── xray [git]
    │   └── project-templates
    │       ├── angular-template [git]
    │       ├── bundle-repo-template [git]
    │       ├── gitops-repo-template [git]
    │       ├── spring-boot-template [git]
    │       └── uv-python-template [git]
    ├── sand [git]
    └── sand-odv-gitops [git]
