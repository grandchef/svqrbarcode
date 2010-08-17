***************************************
17/08/2010
Below is the original README.TXT file
The Site Below is no longer running, i could not find any
other place where these to helpfull components can be
downloaded/updated etc
So i have Posted them onto sourceforge as it.

Soon ill post notes not Delphi 7 Installations

Let me know if you You can help with the Components
Christopher Chase.



********************************************************************************************
QuickReport Barcode Components
Version 1.02 (22/12/2002)
Copyright 2000 Stefano Vecchiato


This unit has two Barcode components for QuickReport.

SvQRBarcode     is a QuickReport component which print a barcode
                from the value of the Text property. You can set it
		in the BeforePrint Event.

SvQRDBBarcode   is a QuickReport data-aware component which print
                the barcode from the value of a DataField in a DataSet.

These components uses the freeware TAsBarcode
component by Andreas Schmidt and friends.

http://members.tripod.de/AJSchmidt/index.html



Tested in Delphi 3, 5 and 6;

These components are published as freeware.

Installation notes:

  Close all open projects/files.
  Use "Install Component" on Component menu.  Install into existing
  package, "DCLUSR50.DPK" (or "DCLUSR40.DPK" or into a new package).
  Compile the package.

  In Delphi 5 you must, also, choose Environment Options on Tools menu,
  select Library and add 

  $(DELPHI)\SOURCE\TOOLSAPI

  and the directory where you have installed SvQRBarcode
 
  to the library path string;


======================================================================================


Copyright notice:

These components is unrestricted freeware. They may be distributed, used and/or
modified without restrictions. Please note that although these components have
been tested and been found to work correctly, you use them entirely at your
own risk and I will not be held responsible for any errors or corrupted  files,
damaged databases or any other event that my be happen when you use these components.


Stefano Vecchiato
November 2000


e-mail: vecchstef@interfree.it


get latest version from

http://vecchstef.interfree.it/Delphi.htm

