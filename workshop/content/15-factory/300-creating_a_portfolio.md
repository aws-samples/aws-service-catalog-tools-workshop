+++
title = "Creating a portfolio"
weight = 300
+++

```yaml
Schema: factory-2019-04-01
Portfolios:
  - DisplayName: central-it-team-portfolio
    Description: A place for self service products ready for your account
    ProviderName: central-it-team
    Associations:
      - arn:aws:iam::${AWS::AccountId}:role/Admin
    Tags:
    - Key: provider
      Value: central-it-team
```