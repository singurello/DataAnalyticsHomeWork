// from data.js
var tableData = data;
my_table = d3.select("#ufo-table tbody")

// YOUR CODE HERE!

createTable=(tableData)=>{
}
tableData.forEach(row => {
  my_table.append('tr').html(`<td>${row.datetime}</td><td>${row.city}</td><td>${row.state}</td><td>${row.country}</td><td>${row.shape}</td><td>${row.durationMinutes}</td><td>${row.comments}</td>`)

});





//my_table.append('tr')

// datetime - make sure to consider it 

// search (3rd lecture - text input)
// filter (3rd lecture )

//
