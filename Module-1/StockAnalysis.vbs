' ##### EASY PART #####

    Sub Easy()

    'To apply the script to each sheet in this workbook

        Dim ws As Worksheet
        For Each ws In Worksheets
        ws.Activate
        
    ' To find the last row of data within current worksheet
    
        Dim LastRow As Long
        With ActiveSheet
        LastRow = .Cells(.Rows.Count, "A").End(xlUp).Row
        End With
     
     ' To define initial variables
 
        Dim Volume As Double
            Volume = Range("G2").Value
        Dim Ticker As String
        Dim NextRow As Integer
            NextRow = 2
    
     ' To create the titles for the volume summary
  
        Range("I1") = "Ticker"
        Range("J1") = "Total Stock Volume"
    
   
     ' To populate the total volume for each stock
    
        For i = 2 To LastRow
            Ticker = Cells(i, 1).Value
        
            If Ticker = Cells(i + 1, 1).Value Then
                Volume = (Volume + Cells(i + 1, 7).Value)
        
            Else
                Cells(NextRow, 9).Value = Ticker
                Cells(NextRow, 10).Value = Volume
                NextRow = NextRow + 1
                Volume = Cells(i + 1, 7).Value
            
            End If
        Next i
    
    'To jump to the next worksheet to apply this

     Next

    End Sub

' ##### MODERATE PART #####

    Sub Moderate()

    'To apply the script to each sheet in this workbook

        Dim ws As Worksheet
        For Each ws In Worksheets
        ws.Activate
        
    ' To find the last row with date

        Dim LastRow As Long
        With ActiveSheet
        LastRow = .Cells(.Rows.Count, "A").End(xlUp).Row
        End With
    
    ' To define initial variables
    
        Dim Volume As Double
            Volume = Range("G2").Value
        Dim Ticker As String
        Dim NextRow As Integer
            NextRow = 2
        Dim InitPrice As Double
            InitPrice = Range("C2").Value
        Dim EndPrice As Double
        Dim YearlyChange As Double
        Dim PercentageChange As Double
    
   
    ' To create the titles for the summary
     
        Range("I1") = "Ticker"
        Range("J1") = "Yearly Change"
        Range("K1") = "Percent Change"
        Range("L1") = "Total Stock Volume"
    
    
     ' To populate the total volume for each stock
    
        For i = 2 To LastRow
            Ticker = Cells(i, 1).Value
        
            If Ticker = Cells(i + 1, 1).Value Then
                Volume = (Volume + Cells(i + 1, 7).Value)
                IF InitPrice = 0 Then
                    InitPrice = Cells(i + 1, 3).Value
                End If
            Else
                Cells(NextRow, 9).Value = Ticker
                Cells(NextRow, 12).Value = Volume
                Volume = Cells(i + 1, 7).Value
                EndPrice = Cells(i, 6).Value
                YearlyChange = EndPrice - InitPrice
            
    ' To fix the error caused by division by zero, when the initial stock price is zero

                If InitPrice = 0 Then
                InitPrice = 1
                End If
          
    ' To continue looping throuth the stocks

                PercentageChange = YearlyChange / InitPrice
                Cells(NextRow, 10).Value = YearlyChange
                Cells(NextRow, 11).Value = PercentageChange
            
                NextRow = NextRow + 1
                InitPrice = Cells(i + 1, 3).Value
            
            End If
        Next i
    
' To apply color and percentage formatting
    
        For i = 2 To (NextRow - 1)
            For j = 10 To 10
                If Cells(i, j) > 0 Then
                    Cells(i, j).Interior.ColorIndex = 4
                ElseIf Cells(i, j) < 0 Then
                    Cells(i, j).Interior.ColorIndex = 3
                Else: Cells(i, j).Interior.ColorIndex = 2
                    End If
            Next j
        Next i
           
        Range(Cells(2, 11), Cells(NextRow - 1, 11)).Select
        Selection.NumberFormat = "0.00%"


' ##### HARD PART #####

        Range("P1") = "Ticker"
        Range("Q1") = "Value"
        Range("O2") = "Greatest % Increse"
        Range("O3") = "Greatest % Decrease"
        Range("O4") = "Greatest Total Volume"

    ' To find the stock with the maximum annual price change

        Dim Max As Double
        Dim MaxTickerRow As Integer
        Max = -99.999
   
    
        For i = 2 To (NextRow - 1)
            If Cells(i, 11).Value > Max Then
                Max = Cells(i, 11).Value
                MaxTickerRow = i
    
            End If
    
        Next i

        Range("P2").Value = Cells(MaxTickerRow, 9)
        Range("Q2").Value = Max
        Range("Q2").Select
        Selection.NumberFormat = "0.00%"

    ' To find the stock with the manimum annual price change
        Dim Min As Double
        Dim MinTickerRow As Integer
        Min = 99.999
    
        For i = 2 To (NextRow - 1)
            If Cells(i, 11).Value < Min Then
                Min = Cells(i, 11).Value
                MinTickerRow = i
        End If
    Next i

    Range("P3").Value = Cells(MinTickerRow, 9)
    Range("Q3").Value = Min
    Range("Q3").Select
    Selection.NumberFormat = "0.00%"

    ' To find the stock with the largest overall volume
        Dim MaxVolume As Double
        Dim MaxVolumeRow As Integer
        MaxVolume = 1

        For i = 2 To (NextRow - 1)
            If Cells(i, 12).Value > MaxVolume Then
                MaxVolume = Cells(i, 12).Value
                MaxVolumeRow = i
            End If
        Next i

        Range("P4").Value = Cells(MaxVolumeRow, 9)
        Range("Q4").Value = MaxVolume
            
        
    ' To jump to the next worksheet to apply this

    Next

    End Sub

