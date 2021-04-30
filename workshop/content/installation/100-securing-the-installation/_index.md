+++
title = "Securing the installation"
weight = 100
+++


Service Catalog Puppet introduces two high-privileged IAM roles (*PuppetDeployInSpokeRole* and *PuppetRole*). To ensure that your Service Catalog Puppet installation is secure, it is needed to take additional precautions securing these IAM roles.

The related IAM Roles are deployed in both, hub and spoke accounts and have the following **trust relationships**:

#### PuppetDeployInSpokeRole
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

#### PuppetRole
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::<hub-account-id>:root"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::<spoke-account-id>:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

### Risk

The risk with these IAM role is a potential **privilege escalation** by either directly assuming the *PuppetRole* or by launching a CodeBuild instance and assigning the *PuppetDeployInSpokeRole* to this instance. This would allow any IAM user/role with appropriate permissions to execute commands with the privileges of the Puppet roles.

### Mitigating risk via SCP

The following Service Control Policy denies the `sts:AssumeRole`  and `iam:*` actions on all IAM roles which are created with the path `servicecatalog-puppet`. This path is the default setting. If you defined another path for these IAM roles, you will need to adapt the SCP accordingly.

Apply this SCP to all spoke accounts and the hub account of Service Catalog Puppet <u>after</u> deploying the Puppet resources in these accounts.

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PreventPrivilegeEscalationInServiceCatalogPuppet",
      "Effect": "Deny",
      "Action": [
        "sts:AssumeRole",
        "iam:*"
      ],
      "Resource": [
        "arn:aws:iam::*:role/servicecatalog-puppet/*"
      ],
      "Condition": {
        "ArnNotLike": {
          "aws:PrincipalARN": [
            "arn:aws:iam::*:role/servicecatalog-puppet/*"
          ]
        }
      }
    }
  ]
}
```
