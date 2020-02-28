# container_runtime_benchmark

This benchmark was created as part of my Bachelor thesis. It allows to install systems with Docker, Kata Containers, gvisor and Nabla Containers and compare them in different benchmarks.

## Benchmark (ansible)

The entire setup was done with Ansible and the various benchmarks were performed by the Ansible controller. Docker was installed with an external [Playbook](https://github.com/nickjj/ansible-docker).

The following benchmarks are performed:

### Web Server Performance (apachebench)

Measurement with ApacheBench

### Ram consumption (apachebench)

Measurement of the used RAM during the measurement with ApacheBench

### Network bandwidth (bench_iperf)

Measurement with iPerf:

- TCP: Up and Download
- UDP: Download

### CPU performance (bench_linpack)

Measurement with Linpack

### Start and removal duration of a container (bench_time)

For this purpose, various containers are started and removed. The times are measured with Time.

## Vagrant

All measurements can also be performed in Vagrant for testing and debugging purposes.

## Evaluation(evaluation_scripts)

During the measurements, the results are written to individual files in different order structures. The scripts in the Order scripts parse these files and create CSV files.