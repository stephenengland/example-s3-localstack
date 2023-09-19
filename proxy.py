import boto3
from flask import Flask, Response, request

app = Flask(__name__)

ACCESS_KEY = "fake"
SECRET_ACCESS_KEY = "fake"
BUCKET_NAME = "versionedexample"
ENDPOINT_URL = "http://localstack:4566"


@app.route('/<path:path>')
def proxy(path):
    version_id = request.args.get('version')
    session = boto3.session.Session()
    s3_client = session.client(
        service_name='s3',
        aws_access_key_id=ACCESS_KEY,
        aws_secret_access_key=SECRET_ACCESS_KEY,
        endpoint_url=ENDPOINT_URL
    )
    if version_id:
        s3_file = s3_client.get_object(
            Bucket=BUCKET_NAME,
            Key=path,
            VersionId=version_id)
    else:
        s3_file = s3_client.get_object(
            Bucket=BUCKET_NAME,
            Key=path)

    def stream_file_contents(file):
        for chunk in iter(lambda: file['Body'].read(1024), b''):
            yield chunk

    return Response(stream_file_contents(s3_file), headers={
        'Content-Type': s3_file['ContentType']
    })


if __name__ == "__main__":
    app.run(debug=True)
