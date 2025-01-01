# Hosting a Simple Webpage on AWS with Terraform

## **Project Overview**
This project demonstrates how to deploy a highly available and globally accessible webpage using Amazon Web Services (AWS). It uses **Amazon S3** to host static content, **Amazon CloudFront** for global content delivery with low latency, and **Terraform** as the Infrastructure as Code (IaC) tool to automate the setup. The project also incorporates key security measures such as Origin Access Identity (OAI) and HTTPS enforcement to ensure secure access.

## **Features**
- Static content hosting with Amazon S3.
- Global content delivery using Amazon CloudFront.
- Automated infrastructure setup using Terraform.
- Secure access to S3 via CloudFront with OAI.
- HTTPS enforced for all communication.
- Scalable architecture designed for high availability.

---

## **Project Structure**
The project files are organized as follows:

```
Project/
├── Terraform_Files/
│   ├── main.tf               # Primary Terraform configuration file.
│   ├── variables.tf          # Variables for flexibility and reusability.
│   ├── outputs.tf            # Outputs for key information.
│   ├── terraform.tfvars      # Values for defined variables (optional).
├── Static_Content/
│   ├── index.html            # Main webpage content.
│   ├── imgs/                 # Folder containing image assets.
├── Architecture_Diagram/     
│   ├── diagram.png           # Diagram illustrating the cloud architecture.
├── README.md                 # Project documentation.
├── Testing_Screenshots/      # Screenshots showing test results.
```

---

## **Getting Started**

### **Prerequisites**
- **Terraform**: Install Terraform by following the [official guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
- **AWS Account**: Ensure you have an AWS account with programmatic access configured.
- **AWS CLI**: Install and configure the AWS CLI. Use `aws configure` to set your credentials.

---

### **Setup Instructions**

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/<your-username>/Hosting-a-Simple-Webpage-on-AWS.git
   cd Hosting-a-Simple-Webpage-on-AWS
   ```

2. **Navigate to Terraform Directory**:
   ```bash
   cd Terraform_Files
   ```

3. **Initialize Terraform**:
   ```bash
   terraform init
   ```

4. **Validate the Configuration** (optional):
   ```bash
   terraform validate
   ```

5. **Plan the Changes** (optional):
   ```bash
   terraform plan
   ```

6. **Apply the Configuration**:
   ```bash
   terraform apply
   ```
   - Type `yes` when prompted to confirm.

7. **Access the Webpage**:
   - After the resources are deployed, Terraform will output the **CloudFront URL**.
   - Visit the CloudFront URL in your browser to access the webpage.

---

## **Testing**
- Verified global accessibility by testing the webpage from different locations.
- Updated content in S3 and observed the cache behavior in CloudFront.
- Ensured secure access by validating HTTPS enforcement and restricted S3 access via OAI.

---

## **Future Scope**
- Integrate a custom domain using Amazon Route 53.
- Add enhanced monitoring with AWS CloudWatch.
- Implement dynamic features using AWS Lambda and API Gateway.

---

## **References**
- [AWS S3 Documentation](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
- [AWS CloudFront Documentation](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)
- [Terraform Documentation](https://developer.hashicorp.com/terraform/intro)

---

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/Mo-Zeini/Hosting-a-Simple-Webpage-on-AWS/blob/main/LICENSE.txt) file for details.


## Author

- [Mohamed Elzeini](https://github.com/Mo-Zeini)


## Acknowledgements

- This app was developed as part of a project assigned by IU International University of Applied Sciences for the Bachelor of Applied Artificial Intelligence program.
