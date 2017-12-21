set PATH=F:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\\bin;F:\Program Files (x86)\Microsoft Visual Studio 14.0\\Common7\IDE;C:\Program Files (x86)\Windows Kits\8.1\\bin;F:\D\dmd2\windows\bin;%PATH%

echo ..\dgui\core\controls\abstractbutton.d >Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\controls\containercontrol.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\controls\control.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\controls\ownerdrawcontrol.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\controls\reflectedcontrol.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\controls\scrollablecontrol.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\controls\subclassedcontrol.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\controls\textcontrol.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\dialogs\commondialog.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\dialogs\dialogresult.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\events\controlcodeeventargs.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\events\event.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\events\eventargs.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\events\keyeventargs.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\events\mouseeventargs.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\events\painteventargs.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\events\scrolleventargs.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\interfaces\idisposable.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\interfaces\ilayoutcontrol.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\menu\abstractmenu.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\charset.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\collection.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\exception.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\geometry.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\handle.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\message.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\tag.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\utils.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\winapi.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\wincomp.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\core\windowclass.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\layout\gridpanel.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\layout\layoutcontrol.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\layout\panel.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\layout\splitpanel.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\all.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\application.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\button.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\canvas.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\colordialog.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\combobox.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\contextmenu.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\filebrowserdialog.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\folderbrowserdialog.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\fontdialog.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\form.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\imagelist.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\label.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\listbox.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\listview.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\menubar.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\messagebox.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\picturebox.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\progressbar.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\registry.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\resources.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\richtextbox.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\scrollbar.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\statusbar.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\tabcontrol.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\textbox.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\timer.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\toolbar.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\tooltip.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\trackbar.d >>Win32\Debug\Dgui.build.rsp
echo ..\dgui\treeview.d >>Win32\Debug\Dgui.build.rsp

"C:\Program Files (x86)\VisualD\pipedmd.exe" dmd -g -debug -lib -X -Xf"Win32\Debug\Dgui.json" -deps="Win32\Debug\Dgui.dep" -of"Win32\Debug\Dgui.lib" -map "Win32\Debug\Dgui.map" -L/NOMAP @Win32\Debug\Dgui.build.rsp
if errorlevel 1 goto reportError
if not exist "Win32\Debug\Dgui.lib" (echo "Win32\Debug\Dgui.lib" not created! && goto reportError)

goto noError

:reportError
echo Building Win32\Debug\Dgui.lib failed!

:noError
