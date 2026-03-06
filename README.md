<div align="center">

# Infra Drills

Real-world AWS, Kubernetes, and GitLab CI/CD break-fix challenges that run entirely on your machine. Zero cloud costs, no signup.

[![Live][badge-site]][url-site]
[![Makefile][badge-make]][url-make]
[![Shell][badge-shell]][url-shell]
[![Claude Code][badge-claude]][url-claude]
[![License][badge-license]](LICENSE)

[badge-site]:    https://img.shields.io/badge/live_site-0063e5?style=for-the-badge&logo=googlechrome&logoColor=white
[badge-make]:    https://img.shields.io/badge/Makefile-427819?style=for-the-badge&logo=gnu&logoColor=white
[badge-shell]:   https://img.shields.io/badge/Shell-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white
[badge-claude]:  https://img.shields.io/badge/Claude_Code-CC785C?style=for-the-badge&logo=anthropic&logoColor=white
[badge-license]: https://img.shields.io/badge/license-MIT-404040?style=for-the-badge

[url-site]:   https://infradrills.neorgon.com/
[url-make]:   #
[url-shell]:  #
[url-claude]: https://claude.ai/code

</div>

---

Near-real-world troubleshooting simulations for AWS and EKS, built as hands-on challenges.

Don't worry about cloud costs; everything you do will be executed locally using tools like LocalStack and Minikube.

Our three goals:

- 1️⃣ Give the chance to learn from others by tackling challenges you haven’t encountered yet.
- 2️⃣ Help you understand what you don't know.
- 3️⃣ Double as interview challenges.

Online course labs rarely throw curveballs your way. We want to make a difference by providing interesting cases that may help you.

More about this at the [Curve Ball Approach](#the-curve-ball-approach) section.

<br>

## Solutions

Except to use Docker!

- [AWS Drills](./aws/README.md): using [LocalStack](https://docs.localstack.cloud/).
    - The folders follow the pattern `SERVICE-NUMBER-SHORT-TITLE`.
    - Solutions are in README format based on the name of the challenges (folders).
- [Kubernetes Drills](./kubernetes/README.md): using Minikube.
    - `k8s-` prefix: Generic Kubernetes (works on any cluster — minikube, kind, etc.)
    - `eks-` prefix: AWS EKS-specific (ALB ingress, IRSA, Secrets Manager CSI, etc.)
- [GitLab CI/CD Drills](./gitlab/README.md): using [gitlab-ci-local](https://github.com/firecow/gitlab-ci-local).
    - Pipelines run locally without a GitLab instance.

<br>

### Templates

- Docker
- Gitlab
- Terraform

## Drills structure

Not to gatekeep, but prioritize real cases based on your own experience. Things that have made you think "Wow, I'm glad I know how to do that!" or "If someone can figure this out, I'm hiring them!

- 🔎 **Problem/Request**: A thing that happened to you or a request from an user.
    - Optional Sections:
        - Context: Information that can help you understand the problem or request.
        - Hint: You may provide some clues to help the player solve the problem.
- 🧪 **Validation**: What does success look like? What command should we run to validate?
- 💉 **Solution**: Links to the solutions README.
    - File: linked like this `[Solution](../solutions/TYPE/SERVICE-NUMBER-TITLE.md)`.
    - Optional Sections:
        - Common Mistakes: assumptions or other things.
        - Additional Resources: links to explain more behind the issue.

<br>

## The curve ball approach

Performing Chaos Engineering in your company each time a new member starts on-call duties or begins the onboarding isn't feasible to test their abilities or wait for something to happen to help them grow.

This approach is a close second.

- 1️⃣ Limited Exposure:
    - Once a project passes the implementation phase, you will get less experience because the scope will consist mainly of providing support or, at best, occasional new features.
    - Unless you actively try to dig and find answers about how and why someone designed the thing you support. You will probably miss most of the nitty-gritty details.

- 2️⃣ Knowledge Gaps:
    - While your company might document past issues, reading static documentation about problem-free systems is hardly engaging or educational. These simulations serve as "live documentation," allowing you to learn by doing.
    - You shouldn't have to wait for something to break to realize that you have knowledge gaps. Stop it, get some help.

- 3️⃣ Interview Challenges:
    - Sometimes, you haven't had the chance to work with a particular technology, but you have the skills to get up to speed—this is for you.

<br>

## Contributing

Found a bug or have a suggestion? Open an issue or submit a pull request.

---

<div align="center">
  <sub>Part of <a href="https://neorgon.com">Neorgon</a></sub>
</div>
