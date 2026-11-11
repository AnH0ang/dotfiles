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

## Repository Groups and Architecture

The platform is organized into distinct repository groups that separate application development, shared platform services, and declarative deployment lifecycles.

### What the Repositories Do

- **Sand (`sand/`)**:
  The primary business application repository. Contains the full Sand application: the Django REST Framework backend, the Angular single-page frontend, Dagster data pipelines for batch processing financial assets, and end-to-end tests. Sand relies on PostgreSQL for transactional data and Cloud Storage for asset dumps.

- **Sand GitOps (`sand-odv-gitops/`)**:
  The GitOps delivery repository for Sand. Manages declarative deployment configurations across all stages (`dev`, `test`, `int`, `prod`) using Argo CD and Kargo. It provisions the frontend and backend workloads, manages cloud infrastructure claims (Cloud SQL, GCS buckets) via Crossplane, sets up external secrets, and configures ingress routing. It also configures the Sand frontend to route all backend API communication securely through the Pricing Gateway.

- **Pricing Platform & Gateway (`pbp/`)**:
  The core pricing and market data platform shared across pricing applications:
  - **Pricing Gateway**: The central security gateway and reverse proxy (Spring Cloud Gateway). It is the single entry point for frontend API traffic, responsible for validating Microsoft Entra ID (Azure AD) tokens, preventing header spoofing by injecting verified user/role claims, and enforcing role-based routing before requests reach downstream services.
  - **Market Data Services**: Ingests live financial data (e.g. from Bloomberg), distributes real-time market data snapshots, and provides APIs/SDKs consumed by pricing engines and analytical workloads.
  - **RFQ Gateway & Pricer Templates**: Handles quote negotiation workflows and provides reusable templates for implementing new pricing services.

- **PBP GitOps (`releng-customers/pbp/pbp-gitops`)**:
  The GitOps repository for the Pricing Platform and shared infrastructure. Deploys core PBP applications (the Pricing Gateway, market data services, data importers, and GraphQL APIs) and manages shared cluster infrastructure in the `pbp-infra` namespace, including the central RabbitMQ messaging cluster and Istio service mesh waypoints.

- **Pricers & Tenant Services (`ir-pricer/`, `releng-customers/*`)**:
  Domain-specific pricing suites, such as Interest Rate Pricer (`ir-pricer`) and LAVA Pricer. These comprise financial calculation engines, dedicated frontend apps, and tenant GitOps repos that manage their deployment into dedicated namespaces.

- **Platform Engineering Foundations (`releng-shared/`)**:
  Provides common foundation components used by all teams: the standardized RelEng Helm chart (Common Chart), Crossplane infrastructure composition packages, Kargo promotion workflows, and shared GitLab CI pipeline components (Docker, Helm, Python, security scanning).

---

### High-Level Interconnection

```
[ Web Browsers / SPAs ]
(Sand Frontend, Pricer UIs)
           │
           │ 1. HTTPS + Entra ID JWT
           ▼
┌────────────────────────────────────────────────────────┐
│                    Pricing Gateway                     │
│  - Validates Entra ID JWT tokens                       │
│  - Strips untrusted headers & injects verified claims  │
│  - Enforces role-based route access                    │
└──────┬──────────────────┬──────────────────┬───────────┘
       │                  │                  │
       │ 2. Proxied API   │ 2. Proxied API   │ 2. Proxied API
       ▼                  ▼                  ▼
┌──────────────┐   ┌──────────────┐   ┌──────────────┐
│ Sand Backend │   │ Market Data  │   │ Rate Pricers │
│ & Pipelines  │   │  (PBP Core)  │   │ (IR / LAVA)  │
└──────┬───────┘   └──────┬───────┘   └──────┬───────┘
       │                  │                  │
       │                  │ 3. Market Events │
       │                  └────────┐         │
       │                           ▼         ▼
       │                    ┌──────────────────────┐
       └───────────────────►│ RabbitMQ (pbp-infra) │
         Background /       │ Shared Event & Quote │
         Data Ingestion     │      Messaging       │
                            └──────────────────────┘
```

1. **Central Ingress & Authentication**:
   Frontend applications (such as the Sand Angular UI and pricer sales apps) authenticate users against Microsoft Entra ID. Instead of communicating directly with their backends, external API requests route through the **Pricing Gateway**. The gateway validates identity, strips forged headers, injects trusted user and role headers, and forwards requests to the appropriate backend service (`sand-odv-backend`, market data, or pricer microservices) across namespace boundaries.

2. **Market Data & Event Bus**:
   Market data ingestion components feed real-time pricing and reference data into the central **RabbitMQ** messaging cluster hosted in `pbp-infra`. Downstream calculation engines (such as IR Pricer) and Sand analytical pipelines subscribe to these queues or call market data gateway APIs to drive calculations and bond valuations.

3. **Declarative GitOps Delivery**:
   Application repositories (`sand`, `pbp`, `ir-pricer`) only contain source code and CI pipelines that build container images. The GitOps repositories (`sand-odv-gitops`, `pbp-gitops`) own the declarative environment definitions. **Kargo** monitors image registries and promotes changes across stages (`dev` -> `test` -> `int` -> `prod`), while **Argo CD** continuously reconciles Kubernetes cluster state against the GitOps definitions.

## Kubernetes

kubectl is configure to connect to `dcgvdshared01`, the cluster on which the development version of the sand app runs. There a are other apps on the cluster in different namespaces but the allows namespaces are `sand-*` which contains sand infra

## Google Cloud

All cloud infrastrucure is hosted on google cloud. For develoment the kubernetes cluster is in project `d-2006243-relengcust-ops-0000`. All sand infrastrture (storage, postgres etc) is in `d-2006243-relengcust-ops-0440`. If the cli is not authenticated ask the use to log in.
