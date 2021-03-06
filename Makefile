alenka : bison.o merge.o \
         MurmurHash2_64.o filter.o \
		 strings_filter.o strings_join.o strings_sort_host.o strings_sort_device.o \
		 select.o zone_map.o \
		 atof.o cm.o mgpucontext.o 
	nvcc -O3 -arch=sm_20 -L . -lcudpp -lcudpp_hash mgpucontext.o mgpuutil.o -o alenka bison.o merge.o \
         MurmurHash2_64.o filter.o \
		 strings_filter.o strings_join.o strings_sort_host.o strings_sort_device.o \
		 select.o zone_map.o \
		 atof.o cm.o 
		 

nvcc = nvcc --machine 64 -O3 -arch=sm_20 -c

cm.o : cm.cu cm.h	
	$(nvcc) cm.cu
bison.o : bison.cu cm.h sorts.cu
	$(nvcc) -I moderngpu/include/ bison.cu
merge.o : merge.cu cm.h merge.h
	$(nvcc) merge.cu
MurmurHash2_64.o : MurmurHash2_64.cu cm.h 
	$(nvcc) MurmurHash2_64.cu
filter.o : filter.cu cm.h filter.h
	$(nvcc) filter.cu
strings_filter.o : strings_filter.cu strings.h strings_type.h
	$(nvcc) strings_filter.cu
strings_join.o : strings_join.cu strings.h strings_type.h
	$(nvcc) strings_join.cu
strings_sort_host.o : strings_sort_host.cu strings.h strings_type.h
	$(nvcc) strings_sort_host.cu
strings_sort_device.o : strings_sort_device.cu strings.h strings_type.h
	$(nvcc) strings_sort_device.cu
select.o : select.cu cm.h select.h
	$(nvcc) select.cu
zone_map.o : zone_map.cu cm.h zone_map.h
	$(nvcc) zone_map.cu
atof.o : atof.cu cm.h atof.h
	$(nvcc) atof.cu 
mgpucontext.o : moderngpu-master/src/mgpucontext.cu 	
	$(nvcc) -I moderngpu-master/include/ moderngpu-master/src/mgpucontext.cu moderngpu-master/src/mgpuutil.cpp
	
clean : del bison.o merge.o \
         MurmurHash2_64.o filter.o \
		 strings_filter.o strings_join.o strings_sort_host.o strings_sort_device.o \
		 select.o zone_map.o itoa.o \
		 atof.o cm.o mgpucontext.o 