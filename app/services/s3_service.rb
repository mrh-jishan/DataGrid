class S3Service

  def initialize
    @s3_client = Aws::S3::Client.new(
      region: 'us-east-1', # Replace with your desired AWS region
      credentials: Aws::Credentials.new('YOUR_ACCESS_KEY_ID', 'YOUR_SECRET_ACCESS_KEY')
    )
    @s3_resource = Aws::S3::Resource.new(client: @s3_client)
  end

  def list_files(bucket_name)
    bucket = @s3_resource.bucket(bucket_name)

    # Return an array of file keys (names)
    bucket.objects.map(&:key)
  end

end