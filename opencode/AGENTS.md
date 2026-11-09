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
| `pbp` | Core components of pbp plattform |
| `github.com/` | Local copies of upstream repositories, including Dagster and HackSoftware examples |
| `releng-customers/` | GitOps repositories for other projects on the platform |

You may read these repositories for examples, conventions, and implementation
details. Keep modifications within the scope of the task; do not change
supporting repositories merely because they are available.

## Worktree repositories

Next to the repositories may be `*__worktrees/` repositories which contain different development versions of the repository code (for example `sand/` may have `sand__worktrees/<feature_name>` containing feature code).

## Repository inventory

The following inventory is a reference, not a guarantee of the current
directory layout. Verify paths before using them.

All paths below are relative to `/home/user/Git/sand-odv/`.


```
.
├── github.com
│   ├── dagster-io
│   │   └── dagster
│   └── HackSoftware
│       ├── Django-Styleguide
│       └── Django-Styleguide-Example
├── ir-pricer
│   ├── financial-engineering-tool
│   │   └── ares-ratespricer
│   ├── services
│   │   ├── ir-calculation-service
│   │   ├── issuer-service
│   │   └── ratespricer-service
│   └── ui
│       └── ir-pricer-sales-app
├── pbp
│   ├── ci
│   │   └── pbp-pipeline
│   ├── gateway
│   │   ├── pricing-gateway
│   │   └── pricing-gateway-helm
│   ├── marketdata
│   │   ├── md-bloomberg
│   │   ├── md-commons
│   │   ├── md-config
│   │   ├── md-gateway
│   │   └── md-python-sdk
│   ├── rfq-gateway
│   └── templates
│       ├── demo-pricer
│       └── python-pricer-template
├── releng-customers
│   ├── ir-pricer
│   │   └── ir-pricer-gitops
│   ├── lava-pricer
│   │   └── lava-pricer-gitops
│   └── pbp
│       └── pbp-gitops
├── releng-shared
│   ├── crossplane
│   │   ├── crossplane-claim-charts
│   │   ├── crossplane-configuration-packages
│   │   ├── crossplane-umbrella-chart
│   │   └── iam-webhook-chart
│   ├── helm
│   │   ├── common-chart
│   │   └── releng-messaging-helm
│   ├── kargo
│   │   └── kargo-promotion-tasks
│   ├── kubernetes-bundle
│   │   ├── kubernetes-bundle
│   │   └── kubernetes-bundle-kargo
│   ├── pipeline-components
│   │   ├── conjur
│   │   ├── docker
│   │   ├── helm
│   │   ├── helpers
│   │   ├── kargo
│   │   ├── maven
│   │   ├── npm
│   │   ├── python
│   │   ├── renovate
│   │   ├── scanning
│   │   ├── super-components
│   │   │   ├── deployment-extension
│   │   │   ├── docker-pipeline
│   │   │   └── helm-pipeline
│   │   └── xray
│   └── project-templates
│       ├── angular-template
│       ├── bundle-repo-template
│       ├── gitops-repo-template
│       ├── spring-boot-template
│       └── uv-python-template
├── sand
└── sand-odv-gitops

```

## Kubernets

kubectl is configure to connect to `dcgvdshared01`, the cluster on which the development version of the sand app runs. There a are other apps on the cluster in different namespaces but the allows namespaces are `sand-*` which contains sand infra

## Google Cloud

All cloud infrastrucure is hosted on google cloud. For develoment the kubernetes cluster is in project `d-2006243-relengcust-ops-0000`. All sand infrastrture (storage, postgres etc) is in `d-2006243-relengcust-ops-0440`. If the cli is not authenticated ask the use to log in.
