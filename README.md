# Titan-Order-Sheet
Code and shiny app for Naresh Watch and Digital zone

This was a pet project to help out a friend who owns a shop that sells watches. The code:

- Loads an '.xlsx' file.
- Reads a stock sheet provided by the wholeseller of watches from various brands.
- Extracts the brand, model number, stock available, and price of all the watches.
- Uses the model number and brand of the each watch to populate a dataframe with URLs for 5 images of the watch.
- Saves this dataframe in a Google Drive as a google spreadsheet.
- This spreadsheet is then used by my friend to prepare an order, using the images to decide the quantity of watches he wants to order.
- The shiny app can be found at https://palashisback.shinyapps.io/Order_Sheet/


