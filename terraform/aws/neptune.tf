resource "aws_neptune_cluster" "default" {
  cluster_identifier                  = var.neptune-dbname
  engine                              = "neptune"
  backup_retention_period             = 5
  preferred_backup_window             = "07:00-09:00"
  skip_final_snapshot                 = true
  iam_database_authentication_enabled = false
  apply_immediately                   = true
  storage_encrypted                   = false
  tags = {
    git_commit           = "aa8fd16fd94cccf6af206e2f0922b5558f8ac514"
    git_file             = "terraform/aws/neptune.tf"
    git_last_modified_at = "2020-08-21 19:14:35"
    git_last_modified_by = "matt@bridgecrew.io"
    git_modifiers        = "matt"
    git_org              = "metahertz"
    git_repo             = "terragoat"
    yor_trace            = "c9a31419-6214-4686-872a-cee099c4bd36"
  }
}

resource "aws_neptune_cluster_instance" "default" {
  count              = 1
  cluster_identifier = aws_neptune_cluster.default.id
  engine             = "neptune"
  instance_class     = "db.t3.medium" # Smallest instance type listed for neptune https://aws.amazon.com/neptune/pricing/
  apply_immediately  = true
  #publicly_accessible                = true # No longer supported, API returns create error. See https://docs.aws.amazon.com/neptune/latest/userguide/api-instances.html#CreateDBInstance
  tags = {
    git_commit           = "5e3a493d8eac0b48db3fb570b6fb573aacf9a600"
    git_file             = "terraform/aws/neptune.tf"
    git_last_modified_at = "2021-06-02 15:23:26"
    git_last_modified_by = "41898282+github-actions[bot]@users.noreply.github.com"
    git_modifiers        = "41898282+github-actions[bot]/matt"
    git_org              = "metahertz"
    git_repo             = "terragoat"
    yor_trace            = "1c62b605-5926-4b39-b342-9bb7b59a8a99"
  }
}

resource "aws_neptune_cluster_snapshot" "default" {
  db_cluster_identifier          = aws_neptune_cluster.default.id
  db_cluster_snapshot_identifier = "resourcetestsnapshot1"
}

