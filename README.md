# AWS Glue Job Terraform module

Terraform module which creates Glue Job resources on AWS.

## Usage

```terraform
module "glue_job" {
  source = "vitalibo/glue-job/aws"

  organization                 = var.organization
  environment                  = var.environment
  name                         = "data-cleaning"
  script_location              = "s3://${var.bucket}/${var.environment}/driver.py"
  glue_version                 = "3.0"
  role_arn                     = aws_iam_role.glue_job.arn
  timeout                      = 60
  number_of_workers            = 6
  job_language                 = "python"
  extra_py_files               = ["s3://${var.bucket}/${var.environment}/sources.zip"]
  job_bookmark_option          = "job-bookmark-enable"
  enable_glue_datacatalog      = true
  enable_metrics               = true
  enable_continuous_log_filter = false

  tags = {
    "Maintainer" : "Vitaliy Boyarsky"
  }
}
```

## Argument Reference

The following arguments are supported:

- `organization` - (Optional) Organization abbreviation that will be prefixed to resource names.
- `environment` - (Required) Environment name.
- `name` - (Required) Name that will be used for identify resources.
- `tags` - (Optional) Key-value map of resource tags.
- `script_location` - (Required) Specifies the S3 path to a script that executes a job.
- `python_version` - (Optional) The Python version being used to execute a Python shell job.
- `connections` - (Optional) The list of connections used for this job.
- `description` - (Optional) Description of the job.
- `max_concurrent_runs` - (Optional) The maximum number of concurrent runs allowed for a job.
- `glue_version` - (Optional) The version of glue to use.
- `max_retries` - (Optional) The maximum number of times to retry this job if it fails.
- `notify_delay_after` - (Optional) After a job run starts, the number of minutes to wait before sending a job run delay
  notification.
- `role_arn` - (Optional) The ARN of the IAM role associated with this job.
- `timeout` - (Optional) The job timeout in minutes.
- `worker_type` - (Optional) The type of predefined worker that is allocated when a job runs.
- `number_of_workers` - (Optional) The number of workers of a defined workerType that are allocated when a job runs.
- `security_configuration` - (Optional) The name of the Security Configuration to be associated with the job.
- `create_security_configuration` - (Optional) Create AWS Glue Security Configuration associated with the job.
- `security_configuration_cloudwatch_encryption` - (Optional) A cloudwatch_encryption block as described below, which
  contains encryption configuration for CloudWatch.
- `security_configuration_job_bookmarks_encryption` - (Optional) A job_bookmarks_encryption block as described below,
  which contains encryption configuration for job bookmarks.
- `security_configuration_s3_encryption` - (Optional) A s3_encryption block as described below, which contains
  encryption configuration for S3 data.
- `log_group_retention_in_days` - (Optional) The default number of days log events retained in the glue job log group.
- `job_language` - (Optional) The script programming language.
- `class` - (Optional) The Scala class that serves as the entry point for your Scala script.
- `extra_py_files` - (Optional) The Amazon S3 paths to additional Python modules that AWS Glue adds to the Python path
  before executing your script.
- `extra_jars` - (Optional) The Amazon S3 paths to additional Java .jar files that AWS Glue adds to the Java classpath
  before executing your script.
- `user_jars_first` - (Optional) Prioritizes the customer's extra JAR files in the classpath.
- `use_postgres_driver` - (Optional) Prioritizes the Postgres JDBC driver in the class path to avoid a conflict with the
  Amazon Redshift JDBC driver.
- `extra_files` - (Optional) The Amazon S3 paths to additional files, such as configuration files that AWS Glue copies
  to the working directory of your script before executing it.
- `job_bookmark_option` - (Optional) Controls the behavior of a job bookmark.
- `temp_dir` - (Optional) Specifies an Amazon S3 path to a bucket that can be used as a temporary directory for the job.
- `enable_s3_parquet_optimized_committer` - (Optional) Enables the EMRFS S3-optimized committer for writing Parquet data
  into Amazon S3.
- `enable_rename_algorithm_v2` - (Optional) Sets the EMRFS rename algorithm version to version 2.
- `enable_glue_datacatalog` - (Optional) Enables you to use the AWS Glue Data Catalog as an Apache Spark Hive metastore.
- `enable_metrics` - (Optional) Enables the collection of metrics for job profiling for job run.
- `enable_continuous_cloudwatch_log` - (Optional) Enables real-time continuous logging for AWS Glue jobs.
- `enable_continuous_log_filter` - (Optional) Specifies a standard filter or no filter when you create or edit a job
  enabled for continuous logging.
- `continuous_log_stream_prefix` - (Optional) Specifies a custom CloudWatch log stream prefix for a job enabled for
  continuous logging.
- `continuous_log_conversion_pattern` - (Optional) Specifies a custom conversion log pattern for a job enabled for
  continuous logging.
- `enable_spark_ui` - (Optional) Enable Spark UI to monitor and debug AWS Glue ETL jobs.
- `spark_event_logs_path` - (Optional) Specifies an Amazon S3 path. When using the Spark UI monitoring feature.
- `additional_python_modules` - (Optional) List of Python modules to add a new module or change the version of an
  existing module.

#### `cloudwatch_encryption` Argument Reference

- `cloudwatch_encryption_mode` - (Optional) Encryption mode to use for CloudWatch data.
- `kms_key_arn` - (Optional) Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data.

#### `job_bookmarks_encryption` Argument Reference

- `job_bookmarks_encryption_mode` - (Optional) Encryption mode to use for job bookmarks data.
- `kms_key_arn` - (Optional) Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data.

#### `s3_encryption` Argument Reference

- `s3_encryption_mode` - (Optional) Encryption mode to use for S3 data.
- `kms_key_arn` - (Optional) Amazon Resource Name (ARN) of the KMS key to be used to encrypt the data.

## Attributes Reference

The following attributes are exported:

- `job_id` - Job name.
- `job_arn` - Amazon Resource Name (ARN) of Glue Job.
- `job_role_arn` - Amazon Resource Name (ARN) specifying the role.
- `job_security_configuration_id` - Glue security configuration name.
- `job_log_group_arn` - The Amazon Resource Name (ARN) specifying the log group.
