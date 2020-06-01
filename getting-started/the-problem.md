# The problem of provisioning everything manually

Whenever we have the need to setup any infrastructure we always tend to go towards the manual approach by clicking and going through the steps in the UI provided by the major public cloud provider (AWS, Azure, GCP), cloud provider (Linode, DigitalOcean etc.), DNS provider (CloudFlare, Route53, DNSimple etc.) and many such services.

One way to approach this problem is to use scripts. But with that comes another set of challenges such as:

- They're idiosyncratic - if I wrote a script, the other person might not be able to understand the steps being performed.
- They're not idempotent - if I ran the script multiple times, it might not provide me the same result.
- Compatibility issues - if I developed the script on a Linux machine, the other person who is using Windows might not be able to use the script and vice versa.
- The scripts are only for one task. If you want to deploy something else, you need to develop them again.

So, how to automate the setup process without having to deal with the hassles of developing a script? That's where the concept of Infrastructure as a Code (IaC) comes in.

***

[Next >](iac.md)