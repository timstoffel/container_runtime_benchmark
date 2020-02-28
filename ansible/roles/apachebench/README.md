# apachebench

This role measures the performance of container runtimes against various web servers using the ApacheBench benchmark. The measurements are performed at different scaling levels. 

At the same time the RAM usage of the system is measured with free.

The images have to be created or pulled with the role create_benchmark_images first. The images are then archived and loaded in this role.

With the parameters in the defaults/main.yml the benchmark can be configured in many ways.
