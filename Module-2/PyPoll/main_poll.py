# to initialize dependencies
import os
import csv

poll_dictionary = {}

# open scv file: 
poll = os.path.join("election_data.csv")
with open(poll, newline="") as csvfile:
    # to skip the header
    csv_header = next(csvfile)
    csvreader = csv.reader(csvfile, delimiter=',')

    for row in csvreader:
      if row[2] not in poll_dictionary.keys():
        poll_dictionary[row[2]] = 1
      else:
        poll_dictionary[row[2]] = poll_dictionary[row[2]] + 1

    total = sum(poll_dictionary.values())
    top_votes = 0

    output_list = []
    output_list.append("Election Results:")
    output_list.append("-----------------")
    output_list.append("Total Votes: " + str(total))
    output_list.append("-----------------")
    for key, value in poll_dictionary.items():
        output_list.append(str(key) + ": " + str(round((int(value)/int(total) * 100),2)) + "% (" + str(value) + ")" )
    output_list.append("-----------------")
    output_list.append("Winner: " + str(max(poll_dictionary.keys(), key=(lambda k: poll_dictionary[k]))))
    output_list.append("-----------------")


    for i in output_list:
        print(i)

    output_path = os.path.join("poll_summary.csv")
    with open(output_path, 'w') as csvfile:
        csvwriter = csv.writer(csvfile, delimiter='\n')
        csvwriter.writerows([output_list])

