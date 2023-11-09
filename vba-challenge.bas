Attribute VB_Name = "Module1"
Sub VBAChallenge()

Dim ws As Worksheet

For Each ws In Worksheets

    Dim NumRows As Double
   
    ' Get The number of rows in the A column
    NumRows = Range("A2", Range("A2").End(xlDown)).Rows.Count
    
    ' Set the variables to store data in the for loop for the first summary table
    Dim x As Double
    Dim openingValue As Double
    Dim closingValue As Double
    Dim yearlyChange As Double
    Dim stockVolume As Double
    Dim ticker As String
    Dim summary_row As Integer
       
    ' Create the column names for the two summary tables
    summary_row = 2
    ws.Range("I1").Value = "Ticker"
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percent Change"
    ws.Range("L1").Value = "Total Stock Volume"
    ws.Range("O1").Value = "Ticker"
    ws.Range("P1").Value = "Value"
    ws.Range("N2").Value = "Greatest Percent Inrease"
    ws.Range("N3").Value = "Greatest Percent Decrease"
    ws.Range("N4").Value = "Greatest Total Volume"
    
    ' For loop to get opening, closing and stock volume for each ticker
      For x = 2 To NumRows
        If ws.Cells(x, 1).Value <> ws.Cells(x - 1, 1).Value Then
            openingValue = ws.Cells(x, 3).Value
            ticker = ws.Cells(x, 1).Value
        ElseIf ws.Cells(x, 1).Value = ws.Cells(x + 1, 1).Value Then
            stockVolume = stockVolume + ws.Cells(x, 7).Value
        ElseIf ws.Cells(x, 1).Value <> ws.Cells(x + 1, 1).Value Then
            closingValue = ws.Cells(x, 6).Value
            ws.Cells(summary_row, 9).Value = ticker
            ws.Cells(summary_row, 10).Value = closingValue - openingValue
            
            ' Conditional formating for yearly Change
            If ws.Cells(summary_row, 10).Value < 0 Then
                ws.Cells(summary_row, 10).Interior.ColorIndex = 3
            ElseIf ws.Cells(summary_row, 10).Value > 0 Then
                ws.Cells(summary_row, 10).Interior.ColorIndex = 4
            End If
            
            ' Conditional formating for percent change
            If ws.Cells(summary_row, 11).Value < 0 Then
                ws.Cells(summary_row, 11).Interior.ColorIndex = 3
            ElseIf ws.Cells(summary_row, 11).Value > 0 Then
                ws.Cells(summary_row, 11).Interior.ColorIndex = 4
            End If
            
            ws.Cells(summary_row, 11).Value = ((closingValue - openingValue) / openingValue) * 100
            ws.Cells(summary_row, 12).Value = stockVolume
            summary_row = summary_row + 1
            openingValue = 0
            closingValue = 0
            stockVolume = 0
            ticker = ""
        End If
      Next x
     
    ' Get the number of rows in the first summary column
    Dim NumRows2 As Double
    NumRows2 = Range("I2", Range("I2").End(xlDown)).Rows.Count
      
    ' Setting the variables for the max, min, and stockRange values in the second summary table
    Dim Max As Double
    Dim percentRange As Range
    Dim stockRange As Range

    ' Get the range of values for the percent change
    Set percentRange = ws.Range("K:K")
    
    ' Find the max and min values in the percent change column
    Max = Application.WorksheetFunction.Max(percentRange)
    ws.Cells(2, 16).Value = Max
    Min = Application.WorksheetFunction.Min(percentRange)
    ws.Cells(3, 16).Value = Min
    
    ' Get the range of values for the stock volume
    Set stockRange = ws.Range("L:L")
    
    ' Find the max and min values in the percent change column
    greatestStock = Application.WorksheetFunction.Max(stockRange)
    ws.Cells(4, 16).Value = greatestStock
    
    ' For loop to generate the values for the second summary table
    Dim y As Double
    
    For y = 2 To NumRows2
    
        If ws.Cells(y, 11).Value = Max Then
            ws.Cells(2, 15).Value = ws.Cells(y, 9)
        ElseIf ws.Cells(y, 11).Value = Min Then
            ws.Cells(3, 15).Value = ws.Cells(y, 9)
        ElseIf ws.Cells(y, 12).Value = greatestStock Then
            ws.Cells(4, 15).Value = ws.Cells(y, 9)
        End If
    Next y

Next ws
     
End Sub
