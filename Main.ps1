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
#              INCLUDE EXTERNAL SCRIPT                       #
##############################################################
$pathPanel= split-path -parent $MyInvocation.MyCommand.Definition
."$pathPanel\scripts\TrainScript.ps1"    
."$pathPanel\scripts\UIControl.ps1"  
                        
##############################################################
#                CONTROL INITIALIZATION                      #
##############################################################

# === Inside main xaml ===
$gridTrain       = $Form.FindName("trainGrid")
$datagridTrain   = $Form.FindName("datagridTrain")
$StationInput    = $Form.FindName("StationInput")
$StationButon    = $Form.FindName("StationButon")

# ===  Window Resources   ==== 
$ApplicationResources = $Form.Resources.MergedDictionaries


##############################################################
#                DATAS EXAMPLE                               #
##############################################################


##############################################################
#                FUNCTIONS                                   #
##############################################################

function Search_train(){
        
        # remove everything inside the stackpanel
        $gridTrain.Children.Clear()

       foreach ($train in $allTrains ){       
       
            if ($train){      
                
                $trainIndex = $allTrains.IndexOf($train)

                # We assign a Name for the stackpanel for a train
                $PanelIndexName  = [String]("StackPparent_"+$trainIndex ) 
                $OneTrainStackPanel = New-StackPanel -Name $PanelIndexName -Margin "0,4,0,4" -Orientation "Horizontal" -HorizontalAlignment "Stretch" -Background "#5B965B"
               
                # ============== The stackPanel containing infos about the train ... ==================
                    $StackPanelInfos  = New-StackPanel  -Margin "20,5,0,2" -Orientation "Vertical" 
                    # Direction and time reamining 
                    $directionTextBlock = New-TextBlock  -Margin "0,0,0,0" -ForeGround "White"   
                    $TimeTextBlock      = New-TextBlock  -Margin "0,0,0,0" -ForeGround "White"
                    $directionTextBlock.Text = "Direction: "+ [String]$train.direction 
                    $TimeTextBlock.Text      = "Time: " + $train.ETAinMin 
                
                    # append textBlocks to the Informations StackPanel
                    $StackPanelInfos.Children.Add($directionTextBlock) | out-Null
                    $StackPanelInfos.Children.Add($TimeTextBlock)      | out-Null
                # =====================================================================================
                
                # ============ The Train Icon XD ======================================================
                    $appbar_Train = $ApplicationResources[0].Item("appbar_train")
                    $VisualBrush = [System.Windows.Media.VisualBrush]::new()
                    $VisualBrush.Visual = $appbar_Train
                    $Rectangle = New-Rectangle  -Margin "20,0,5,0" -Size "28,32" -VisualBrush $VisualBrush
                # =====================================================================================

                # Merge everything to the Train stackPanel
                $OneTrainStackPanel.Height = "50"
                $OneTrainStackPanel.Children.Add($Rectangle) | out-Null
                $OneTrainStackPanel.Children.Add($StackPanelInfos) | out-Null
                
                # append the current train to the main Grid. 
                $gridTrain.Children.Add($OneTrainStackPanel) | out-Null
            }
       }  
   }


##############################################################
#                MANAGE EVENT ON PANEL                       #
##############################################################


$StationButon.add_Click({
    
    $gareInput = $StationInput.Text
    Write-Host $gareInput

    $rawResultTrains = (Get-gare -gare "$gareInput").idgare | Get-TrainDirection | %{ Get-NextTrain -idgare $_.idgare -traindirection $_.direction } 
    # remove empty values
    $script:allTrains = $rawResultTrains |?{$_}
    # Add datas to the datagrid
    $datagridTrain.ItemsSource = $allTrains

    Search_train

})



##############################################################
#                SHOW WINDOW                                 #
##############################################################



$Form.ShowDialog() | Out-Null

