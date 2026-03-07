# AWS with LocalStack

---

## Setup

- [awscli-local](https://github.com/localstack/awscli-local): will allow you to run AWS commands in the local environment as `awslocal` instead of the `aws`. This has the advantage of not requiring you to do credential setup for the local AWS.
- [Quick Start](https://docs.localstack.cloud/getting-started/quickstart/):
  - MacOS: `brew install localstack/tap/localstack-cli`
- Suggested:
  - [Docker Extension](https://docs.localstack.cloud/user-guide/tools/localstack-docker-extension/): helps the view from the Docker Desktop.

<br>

## Usage

The Web UI will be available in the [Local Stack](https://app.localstack.cloud/sign-in) website. You can create an account by either using your Email or GitHub account.

Provide your Auth Token:

![Alt text](../assets/localstack-tutorial-01.png?raw=true "Token")

Export it:

```bash
export LOCALSTACK_AUTH_TOKEN=ls-ultra-hyper-mega-secret-auth-token-000
```

Start the service:

```bash
docker-compose up
```

When it starts, the dashboard shows available services:

![Alt text](../assets/localstack-tutorial-02.png?raw=true "Services")


<br>

## LocalStack Limitations
A few limitations to keep in mind:

- **UI**:
  - Available through the Docker Extension or the [LocalStack web dashboard](https://app.localstack.cloud/).
    - The Docker Extension shows running services but lacks the full capabilities of the web dashboard.
- **Community Image**:
  - This is the image you'll use unless you have a paid license (starting at $35 USD per user).
  - Not all AWS services are available in the Community tier, but the most common ones are.
- **IAM Restrictions**:
  - In the Community tier, IAM policies are simplified, meaning all resources can access everything. This can affect how you test permissions.
