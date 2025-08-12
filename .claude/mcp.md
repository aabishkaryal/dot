# MCP Servers Reference

This document lists all MCP servers extracted from agent files, categorized into global and project-scoped servers based on their configuration requirements and usage patterns.

## Global MCP Servers

These servers make sense to be enabled globally as they don't need project-specific configuration and will be used in the majority of projects.

### Core Development Tools
- **Read** - File reading operations
- **Write** - File writing operations  
- **Grep** - Pattern searching in files
- **Glob** - File pattern matching

### Version Control & CI/CD
- **git** - Git version control operations
- **github-cli** - GitHub command-line interface
- **gitlab** - GitLab integration
- **gitflow** - Git workflow management
- **pre-commit** - Git pre-commit hooks
- **github-actions** - GitHub workflow automation
- **gitlab-ci** - GitLab CI integration
- **jenkins** - CI/CD orchestration

### Build Tools & Package Managers
- **webpack** - Module bundler and build tool
- **vite** - Fast build tool with HMR
- **rollup** - ES module bundler
- **esbuild** - Fast JavaScript bundler
- **turbo** - High-performance build system
- **nx** - Smart build framework
- **bazel** - Build and test tool
- **rush** - Scalable monorepo manager
- **lerna** - Monorepo workflow tool

### Package Managers
- **npm** - Node.js package management
- **yarn** - Fast JavaScript packages
- **pip** - Python package installer
- **cargo** - Rust package manager
- **maven** - Java dependency management
- **gradle** - Build automation and dependencies
- **bundler** - Ruby dependency management
- **composer** - PHP dependency manager
- **poetry** - Python dependency resolution

### Programming Language Tools
- **node** - Node.js runtime
- **python** - Python interpreter
- **go** - Go programming language tools
- **rust** - Rust programming language
- **tsc** - TypeScript compiler
- **tsx** - TypeScript execute for Node.js
- **gofmt** - Go code formatter
- **golint** - Go linter
- **golangci-lint** - Go linters runner
- **delve** - Go debugger

### C/C++ Development
- **g++** - GNU C++ compiler
- **clang++** - Clang C++ compiler
- **cmake** - Build system generator
- **make** - Build automation tool
- **gdb** - GNU debugger
- **valgrind** - Memory error detector
- **clang-tidy** - C++ linter and static analyzer

### Code Quality & Linting
- **eslint** - JavaScript/TypeScript linting
- **prettier** - Code formatting
- **black** - Python code formatter
- **mypy** - Python type checker
- **ruff** - Fast Python linter
- **bandit** - Python security scanner
- **ast-grep** - AST-based code transformation
- **semgreg** - Semantic code search
- **jscodeshift** - JavaScript code transformation
- **sonarqube** - Code quality platform

### Testing Frameworks
- **jest** - JavaScript testing framework
- **pytest** - Python testing framework
- **cypress** - Modern web testing
- **playwright** - Cross-browser automation
- **selenium** - Web browser automation
- **k6** - Performance testing
- **jmeter** - Load testing tool
- **gatling** - High-performance load testing
- **locust** - Distributed load testing
- **appium** - Mobile automation

### Documentation Tools
- **markdown** - Markdown processing
- **asciidoc** - AsciiDoc documentation
- **sphinx** - Python documentation generator
- **mkdocs** - Project documentation with Markdown
- **docusaurus** - React-based documentation site
- **swagger** - API documentation tools
- **openapi** - OpenAPI 3.x tooling
- **swagger-ui** - Interactive API documentation
- **redoc** - OpenAPI documentation generator
- **slate** - Beautiful static documentation

### Infrastructure & Cloud (Generic)
- **docker** - Container platform
- **terraform** - Infrastructure as Code
- **terragrunt** - Terraform wrapper for DRY code
- **tflint** - Terraform linter
- **terraform-docs** - Documentation generator
- **checkov** - Infrastructure security scanner
- **infracost** - Infrastructure cost estimation
- **ansible** - Configuration management

### Cloud Platforms
- **aws-cli** - AWS service management
- **azure-cli** - Azure resource control
- **gcloud** - Google Cloud operations

### Kubernetes & Container Orchestration
- **kubectl** - Kubernetes CLI
- **helm** - Kubernetes package manager
- **kustomize** - Kubernetes configuration customization
- **kubeadm** - Cluster bootstrapping tool
- **k9s** - Terminal UI for Kubernetes
- **stern** - Multi-pod log tailing
- **kubectx** - Context and namespace switching

### Monitoring & Observability
- **prometheus** - Monitoring system
- **grafana** - Visualization and dashboards
- **newrelic** - Application performance monitoring
- **datadog** - Infrastructure and APM
- **sentry** - Error tracking
- **loggly** - Log management
- **splunk** - Log analysis platform
- **elasticsearch** - Search and analytics engine
- **pagerduty** - Incident management

### Network & System Tools
- **tcpdump** - Network packet analyzer
- **wireshark** - Network protocol analyzer
- **nmap** - Network discovery and security
- **iperf** - Network performance testing
- **netcat** - Network utility for debugging
- **dig** - DNS lookup tool
- **traceroute** - Network path discovery
- **strace** - System call tracer
- **perf** - Linux performance analysis
- **flamegraph** - Performance visualization

### Security Tools
- **nessus** - Vulnerability scanner
- **qualys** - Security platform
- **openvas** - Open source vulnerability scanner
- **prowler** - AWS security auditing
- **scout suite** - Multi-cloud security auditing
- **compliance checker** - Automated compliance validation
- **metasploit** - Penetration testing framework
- **burp** - Web application security testing
- **vault** - Secrets management platform
- **trivy** - Container vulnerability scanner
- **falco** - Runtime security monitoring

### CLI & Terminal Tools
- **commander** - Command-line interface framework
- **yargs** - Argument parsing library
- **inquirer** - Interactive command-line prompts
- **chalk** - Terminal string styling
- **ora** - Terminal spinners
- **blessed** - Terminal UI library

### Analysis & Architecture Tools
- **plantuml** - UML diagram generation
- **structurizr** - Architecture as code
- **archunit** - Architecture testing
- **draw.io** - Architecture diagramming

### Web Research & Analysis
- **WebSearch** - Web search capabilities
- **WebFetch** - Web content retrieval
- **google-trends** - Google Trends data
- **social-listening** - Social media monitoring
- **google-scholar** - Academic search
- **similarweb** - Website analytics
- **semrush** - SEO and marketing analytics
- **crunchbase** - Business information database
- **data-visualization** - Data visualization tools

### Accessibility Testing
- **axe** - Automated accessibility testing
- **wave** - Web accessibility evaluation
- **nvda** - Screen reader testing (Windows)
- **jaws** - Screen reader testing (Windows)
- **voiceover** - Screen reader testing (macOS/iOS)
- **lighthouse** - Performance and accessibility audit
- **pa11y** - Command line accessibility testing

### Chaos Engineering
- **chaostoolkit** - Open source chaos engineering
- **litmus** - Kubernetes chaos engineering
- **gremlin** - Enterprise chaos platform
- **pumba** - Docker chaos testing
- **powerfulseal** - Kubernetes chaos testing
- **chaosblade** - Alibaba chaos toolkit

### Development Environment
- **chrome-devtools** - Browser debugging
- **vscode-debugger** - IDE debugging
- **lldb** - LLVM debugger

## Project-Scoped MCP Servers

These servers are specific to projects and need project-specific configuration to function properly.

### Databases
- **database** - Generic database interface (needs connection config)
- **postgresql** - PostgreSQL database (requires connection string)
- **psql** - PostgreSQL CLI (requires database config)
- **pg_dump** - PostgreSQL backup utility (needs credentials)
- **pgbench** - PostgreSQL benchmarking (requires DB setup)
- **pg_stat_statements** - PostgreSQL query statistics (DB-specific)
- **pgbadger** - PostgreSQL log analyzer (needs log files)
- **mysql** - MySQL database (requires connection config)
- **sqlite3** - SQLite database (project-specific files)
- **sqlplus** - Oracle SQL*Plus (Oracle-specific config)
- **mongosh** - MongoDB shell (requires MongoDB config)
- **redis** - Redis data store (needs Redis instance)
- **redis-cli** - Redis CLI (requires Redis config)
- **redis-pubsub** - Redis pub/sub (Redis instance specific)
- **percona-toolkit** - MySQL performance tools (MySQL-specific)
- **database/postgresql** - Enhanced PostgreSQL features
- **sql** - SQL query execution (database-specific)
- **explain** - Query plan analysis (database-specific)
- **analyze** - Database performance analysis (DB-specific)

### Framework-Specific Tools
- **magic** - Component generation (project structure dependent)
- **context7** - Framework documentation (project context specific)
- **next** - Next.js framework (Next.js projects only)
- **vercel** - Vercel deployment (Vercel account specific)
- **prisma** - Database ORM (project schema specific)
- **tailwind** - CSS framework (project config specific)
- **react-devtools** - React debugging (React projects only)
- **storybook** - Component development (project-specific stories)
- **typescript** - TypeScript config (project tsconfig dependent)

### Message Queues & Communication
- **socket.io** - WebSocket library (project-specific endpoints)
- **ws** - WebSocket library (application-specific)
- **rabbitmq** - Message broker (RabbitMQ instance required)
- **kafka** - Distributed streaming (Kafka cluster required)
- **centrifugo** - Real-time messaging (service-specific config)

### Service Mesh & Orchestration
- **kubernetes** - Container orchestration (cluster-specific)
- **istio** - Service mesh (cluster and app specific)
- **consul** - Service discovery (Consul cluster required)
- **argocd** - GitOps CD (ArgoCD installation required)
- **spinnaker** - Multi-cloud CD (Spinnaker setup required)
- **crossplane** - Cloud-native control plane (cluster-specific)
- **backstage** - Developer portal (organization-specific)
- **flux** - GitOps toolkit (cluster and repo specific)

### API & Integration Tools
- **openapi-generator** - API code generation (project API specs)
- **graphql-codegen** - GraphQL code generation (project schema)
- **postman** - API testing (project-specific collections)
- **insomnia** - REST client (project APIs)
- **spectral** - API linting (project API rules)
- **api-tools** - API development tools (project-specific)

### Testing & Quality Assurance (Project-Specific)
- **jira** - Issue tracking (organization instance)
- **testrail** - Test management (organization setup)
- **browserstack** - Cross-browser testing (account required)

### Analytics & Data Tools
- **pandas** - Python data analysis (project data specific)
- **survey-tools** - Consumer survey platforms (project surveys)
- **analytics** - Market data analysis (project data)
- **statista** - Statistical database (subscription required)
- **specialized-databases** - Domain-specific databases (project domain)

### Machine Learning & AI
- **transformers** - ML model implementation (model-specific)
- **langchain** - LLM application framework (project-specific chains)
- **llamaindex** - RAG implementation (project knowledge base)
- **vllm** - High-performance LLM serving (model-specific)
- **wandb** - ML experiment tracking (project experiments)

## Usage Guidelines

### Global Server Selection
- Install global servers that provide universal utility across projects
- Consider your primary development stack when selecting globals
- Essential globals: git, docker, basic build tools, code quality tools

### Project-Scoped Server Management
- Configure project-scoped servers per project in project-specific settings
- Database servers always require connection configuration
- Framework-specific tools should match your project's technology stack
- Message queues and service mesh tools need corresponding infrastructure

### Configuration Recommendations
- Use environment-specific configurations for project-scoped servers
- Implement secure credential management for database connections
- Document required infrastructure for service-dependent tools
- Consider development vs production configurations for project tools

## Notes
- This categorization is based on typical usage patterns and configuration requirements
- Some tools like `docker` can function globally but may need project-specific configurations for advanced features
- Database tools are universally project-scoped due to connection requirements
- Framework-specific tools inherently depend on project structure and configuration