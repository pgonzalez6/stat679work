import re 
import time
import re
import datetime
import sys
import os.path


with open(sys.argv[2]) as energy:  #### Open the energy data
    linelist = energy.readlines()
    Energy_date= []    ## create Date list
    Energy_value= []   ## create energy values list
    for row in linelist:   ## selecting parts of the rows to build new variables (Date and Energy)
        a = re.search('^(\d+)',row)
        if a:
            date= re.sub(r'\,(\d+)',"",row)
            date= re.sub(r'\s(\d+):(\d+):(\d+)\s-(\d+)(\d+)',"",date)   
            date= re.sub(r'(\d+):(\d+):(\d+)',"",date) 
            value= re.sub(r'(\d+)-(\d+)-(\d+)\s(\d+):(\d+):(\d+)\s-(\d+)\,',"",row) 
            Energy_date.append(date.rstrip())
            Energy_value.append(value.rstrip())
        else:
            continue
new_energy_date = []
for time in Energy_date:
    new_energy_date1 = datetime.datetime.strptime(time, '%Y-%m-%d').strftime('%m/%d/%y') #change dates in energy.csv to match those in watertemperature.csv
    new_energy_date.append(new_energy_date1)
    
for i in range(len(new_energy_date)-1): #verify energy is sorted
            if new_energy_date[i] > new_energy_date[i+1]: #if its not sorted, sort it!
                new_energy_date.sort(key=lambda x: time.mktime(time.strptime(x,'%m/%d/%y')))
else:
    with open(sys.argv[1]) as wtemp: #open watertemperature.csv, or the second argument after this code, which is the first argument
            Temperature = wtemp.readlines()
            List = []
            Temp_date = []
            merge_list= []
            n_energy = 1
            EnergyDay = new_energy_date[n_energy-1]
            for row in Temperature:
                a = re.search(r'^(\d+)',row)
                if a:
                    List.append(row.rstrip())
                else:
                    continue
            for item in List: #does the format for the data files match? Check!
                water_pattern = re.compile('^(\d+)\,(\d+)\/(\d+)\/(\d+)\s(\d+):(\d+):(\d+)\s(\w+)\,(\d+).(\d+)')
                if water_pattern.match(item):
                        continue
                else:
                    print('water temperature file: format error!')
                    break
            for row in List:
                date = re.sub(r'^(\d+)\,','',row)
                date = re.sub(r'\,(\d+).(\d+)','',date)
                date = re.sub(r'\s(\d+):(\d+):(\d+)\s(\w+)',"",date)
                date = date.rstrip() 
                Temp_date.append(date) 
                
            for x in range(len(Temp_date)-1): #make sure the dates don't overlap
                    if x == 0:
                        if Temp_date[0] == Temp_date[1]:
                            continue
                        else:
                            print('Error:non-overlapping dates')
                            break
                    else:
                        if Temp_date[x] == Temp_date[x-1] or Temp_date[x] == Temp_date[x+1]:
                            continue
                        else:
                            print('Error: non-overlapping dates')
                            break      
            for i in range(len(List)-1):
                while n_energy <= len(Energy_value):
                    rowA = List[i]
                    rowB = List[i+1] 
                    day1 = re.sub(r'^(\d+)\,','',rowB)
                    day1 = re.sub(r'\,(\d+).(\d+)','',day1)
                    day2 = re.sub(r'\s(\d+):(\d+):(\d+)\s(\w+)',"",day1)
                    day2 = day2.rstrip() 
                    while day2 >= EnergyDay:
                        if day2 == EnergyDay:
                            merge_line = rowA + "," 
                            merge_list.append(merge_line)
                            break
                        else:
                            energy = Energy_value[n_energy]
                            energy_1000 = float(energy)/1000 
                            merge_line = rowA +","+ str(energy_1000)
                            merge_list.append(merge_line)
                            n_energy += 1 
                            EnergyDay = new_energy_date[n_energy - 1] 
                            break
                    break
            merge_list.append(List[len(List) - 1]+',')
            header_list = ['Row','Date & Time','Temperature','Energy(Wh/1000)']
                
            print(','.join(header_list)+'\n')
                
              
            if len(sys.argv) == 3:
                file_out = sys.stdout
                file_out.write(','.join(header_list)+'\n')
                for j in merge_list: 
                    file_out.write(j)
                    file_out.write('\n')
            else:
                file_out = sys.argv[3]  
                if os.path.isfile(file_out) == True:
                    choice = input('The filename exists, do you want to append on it or overwrite it? (append(a)/overwrite(o))')#choose 'a' if we want to append it, choose 'o' if we want to overwrite it.
                    # if the file alreay exists in the current directory, we need to confirm if the user still want to use this filename.
                    if choice == 'a':# choose to append the merged data onto the same output file
                        with open(file_out,'a') as output:#'a' means append to the files.
                            for j in range(len(merge_list)):
                                output.write(merge_list[j])
                                output.write('\n')
                    else: #if choose to overwriting it.
                        with open(file_out,'w') as output: #'w' will let us overwrite the file.
                            #for i in range(len(header_list)-2):#write the headers.
                            output.write(','.join(header_list)+'\n')
                            for k in range(len(merge_list)):#write the merged data.
                                output.write(merge_list[k])
                                output.write('\n')

                else: # if the filename is a totally new one, then open and write it directly.                                          
                    with open(file_out,'w') as output:
                        for i in range(len(header_list)):
                            output.write(','.join(header_list)+'\n')
                            output.write('\n')
                        for k in range(len(merge_list)):
                            output.write(merge_list[k])
                            output.write('\n')
    
    print(output)
