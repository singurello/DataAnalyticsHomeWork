# to initialize dependencies
import os
import csv

# to initialize initial variables and lists
net_total = 0
changes = []
monthly_change = 0
index = 0
rows = []

# define functions
def maxChange(changes):
    idx = 0
    maxChange = 0
    maxChangeIndex = 0
    for change in changes:
        if change > maxChange:
            maxChange = change
            maxChangeIndex = idx
        idx += 1
    return (maxChange, maxChangeIndex)

def minChange(changes):
    idx = 0
    minChange = 0
    minChangeIndex = 0
    for change in changes:
        if change < minChange:
            minChange = change
            minChangeIndex = idx
        idx += 1
    return (minChange, minChangeIndex)


# to open and read the CSV data file
budget = os.path.join("budget_data.csv")
with open(budget, newline="") as csvfile:
    # to skip the header
    csv_header = next(csvfile)
    csvreader = csv.reader(csvfile, delimiter=',')

    previous_row = []

    for row in csvreader:
        net_total = net_total + int(row[1])
        rows.append(row)

        # Check if we aren't on the first row
        if index > 0:
            monthly_change = int(row[1]) - int(previous_row[1])
            changes.append(monthly_change)

        previous_row = row
        index += 1
    
    # to calculate MAX and MIN change for the year
    maxChangeTuple = maxChange(changes)
    maxChange = maxChangeTuple[0]
    maxChangeIndex = maxChangeTuple[1]
    maxChangeRow = rows[maxChangeIndex + 1] 

    minChangeTuple = minChange(changes)
    minChange = minChangeTuple[0]
    minChangeIndex = minChangeTuple[1]
    minChangeRow = rows[minChangeIndex + 1] 
    
    output_list = []
    # the final output:
    output_list.append("Financial Analysis:")
    output_list.append("----------------------------")
    output_list.append("Total Months: " + str(index))
    output_list.append("Total: $" + str(net_total))
    output_list.append("Average Change: $" + str(round((sum(changes))/(index - 1),2)))
    output_list.append("Greatest Increase in Profits: " + str(maxChangeRow[0] + ' $' + str(maxChange)))
    output_list.append("Greatest Decrease in Profits: " + str(minChangeRow[0] + ' $' + str(minChange)))

    for i in output_list:
        print(i)

    output_path = os.path.join("bank_summary.csv")
    with open(output_path, 'w') as csvfile:

    # Initialize csv.writer
        csvwriter = csv.writer(csvfile, delimiter='\n')
        csvwriter.writerows([output_list]) 