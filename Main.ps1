#========================================================================
# Author 	: Kevin RAHETILAHY                                          #
#========================================================================

##############################################################
#                      LOAD ASSEMBLY                         #
##############################################################

[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')  				| out-null
[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') 				| out-null
[System.Reflection.Assembly]::LoadWithPartialName('PresentationCore')      				| out-null
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll')       				| out-null
[System.Reflection.Assembly]::LoadFrom('assembly\System.Windows.Interactivity.dll') 	| out-null
[System.Windows.Forms.Application]::EnableVisualStyles()

##############################################################
#                      LOAD FUNCTION                         #
##############################################################
                      
function LoadXml ($Global:filename)
{
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}

# Load MainWindow
$XamlMainWindow=LoadXml(".\Main.xaml")
$Reader=(New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form=[Windows.Markup.XamlReader]::Load($Reader)


##############################################################
#                CONTROL INITIALIZATION                      #
##############################################################

# === Inside main xaml ===
$gridTrain   = $Form.FindName("trainGrid")


# ===  Window Resources   ==== 
# $ApplicationResources = $Form.Resources.MergedDictionaries


##############################################################
#                DATAS EXAMPLE                               #
##############################################################

# observablCollection is easier to handle :)
$script:observableCollection = [System.Collections.ObjectModel.ObservableCollection[Object]]::new()


# Add datas to the datagrid
$gridTrain.ItemsSource = $Script:observableCollection

##############################################################
#                FUNCTIONS                                   #
##############################################################



##############################################################
#                MANAGE EVENT ON PANEL                       #
##############################################################




##############################################################
#                SHOW WINDOW                                 #
##############################################################
$Form.ShowDialog() | Out-Null

