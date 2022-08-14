import ecs = require('aws-cdk-lib/aws-ecs');
import ecsPatterns = require('aws-cdk-lib/aws-ecs-patterns');
import ec2 = require('aws-cdk-lib/aws-ec2');
import cdk = require('aws-cdk-lib');

export class AwscdkStack extends cdk.Stack {
  constructor(scope: cdk.App, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // Create a cluster
    const vpc = new ec2.Vpc(this, 'Vpc', { maxAzs: 2 });
    const cluster = new ecs.Cluster(this, 'fargate-service-autoscaling', { vpc });

    // Create Fargate Service
    const service = new ecsPatterns.QueueProcessingFargateService(this, 'service', {
      vpc,
      memoryLimitMiB: 512,
      image: ecs.ContainerImage.fromRegistry('test'),
      maxReceiveCount: 42,
      retentionPeriod: cdk.Duration.days(7),
      visibilityTimeout: cdk.Duration.minutes(5),
    })

    // new cdk.CfnOutput(this, 'LoadBalancerDNS', { value: fargateService.loadBalancer.loadBalancerDnsName });
  }
}
