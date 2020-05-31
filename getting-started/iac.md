# The Concept of Infrastructure as a Code (IaC)

Infrastructure as a Code (IaC), as the name suggests, is a way of managing your entire infrastructure in the form of code. It helps us to solve several problems such as:

1. **Reproducible Environments:** By using code to generate infrastructure, the same environment can be created over and over. Over time an environment can drift away from its desired state and difficult to diagnose issues can creep into your release pipeline. With IaC no environment gets special treatment and fresh new environments are easily created and destroyed.

2. **Idempotence & Convergence:** In IaC, only the actions needed to bring the environment to the desired state are executed. If the environment is already in the desired state, no actions are taken.

3. **Easing Collaboration:** Having the code in a version control system like Git allows teams to collaborate on infrastructure. Team members can get specific versions of the code and create their own environments for testing or other scenarios.

4. **Self-service Infrastructure:** A pain point that often existed for developers before moving to cloud infrastructure was the delays required to have operations teams create the infrastructure they needed to build new features and tools. With the elasticity of the cloud allowing resources to be created on-demand, developers can provision the infrastructure they need when they need it. IaC further improves the situation by allowing developers to use infrastructure modules to create identical environments at any point in the application development lifecycle. The infrastructure modules could be created by operations and shared with developers freeing developers from having to learn another skill.

All combined these benefits make IaC a staple in DevOps practices.

***

[< Previous](the-problem.md) | [Next >](terraform.md)