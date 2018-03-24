#########################################################################
# Author:  Kevin RAHETILAHY                                             #
# Version: ???                                                          #
# Name: Capture Tool                                                    #
#########################################################################

# =======================================================================
# Template Form and Node
#
# SUMMARY: This document helps you to re-use directly some common node in
# the XAML form without specifing it everytime. 
# Make sure that names are different for each node of the same type 
# you use to avoid conflict di=uring the Form generation 
# =======================================================================


# ======================== Grid ======================================= 
Function Create-Grid{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $GridName,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $GridMargin)
 
    $Grid = New-Object System.Windows.Controls.Grid
    $Grid.Name        = $GridName 
    $Grid.Margin      = $GridMargin
    
    return $Grid
}

# =================== StackPanel ======================================== 
Function Create-StackPanel{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $StackPanelName,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $StackPanelMarign,
        [Parameter(Position=2,Mandatory=$true)]
        [string] $StackPanelOrientation,
        [Parameter(Position=3)]
        [string] $StackPanelAlignment)

 
    $StackPanel = New-Object System.Windows.Controls.StackPanel
    $StackPanel.Name        = $StackPanelName 
    $StackPanel.Orientation = $StackPanelOrientation
    $StackPanel.Margin      = $StackPanelMarign
    $StackPanel.VerticalAlignment   = "Stretch"
    if($StackPanelMarign -eq "") {$StackPanel.HorizontalAlignment = "Center"}
    else{$StackPanel.HorizontalAlignment = $StackPanelAlignment} 
    
    
 
    return $StackPanel
}

# =================== RadioButton ======================================
Function Create-RadioButton{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $RadioButtonName,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $RadioButtonMargin,
        [Parameter(Position=2,Mandatory=$true)]
        [string] $RadioGroupName)
 
    $RadioButton = New-Object System.Windows.Controls.RadioButton
    $RadioButton.Name        = $RadioButtonName 
    $RadioButton.Margin      = $RadioButtonMargin
    $RadioButton.GroupName   = $RadioGroupName
    $RadioButton.FontSize="16"
    
    return $RadioButton
}

# ======================== Label =======================================
Function Create-Label{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $LabelName,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $LabelMargin)
 
    $Label = New-Object System.Windows.Controls.Label
    $Label.Name        = $LabelName 
    $Label.Margin      = $LabelMargin
    $Label.FontSize="16"
    
    return $Label
}

# ======================== Image =======================================
Function Create-Image{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $ImageName,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $ImageSize,
        [Parameter(Position=2)]
        [string] $ImageMargin)
 
    $Image = New-Object System.Windows.Controls.Image
    $Image.Name        = $RadioButtonName
    if($ImageMargin -ne "") {$Image.Margin  = $ImageMargin }
    $Image.Width =$ImageSize.Split(",")[0]
    $Image.Height=$ImageSize.Split(",")[1]
    $Image.HorizontalAlignment="Left"
    $Image.VerticalAlignment="Top" 
    
    return $Image
}

# ======================== Border =======================================
Function Create-Border{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $BorderName,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $BorderColor)
 
    $Border = New-Object System.Windows.Controls.Border
    $Border.Name            = $BorderName 
    $Border.BorderBrush     = $BorderColor
    $Border.BorderThickness = 2
    return $Border
}

# ======================== Button =======================================
Function Create-Button{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $ButtonName,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $ButtonMargin,
        [Parameter(Position=2,Mandatory=$true)]
        [string] $ButtonContent,
        [Parameter(Position=3,Mandatory=$true)]
        [string] $ButtonTextColor)
 
    $Button = New-Object System.Windows.Controls.Button
    $Button.Name        = $ButtonName 
    $Button.Content     = $ButtonContent
    $Button.Margin      = $ButtonMargin
    $Button.Foreground  = $ButtonTextColor

    return $Button
}

# ======================== Progressbar =======================================
Function Create-Progressbar{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $ProgressbarName,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $ProgressbarMargin,
        [Parameter(Position=2,Mandatory=$true)]
        [string] $ProgressbarHeight)
 
    $Progressbar = New-Object System.Windows.Controls.Progressbar
    $Progressbar.Name       = $ProgressbarName 
    $Progressbar.Margin     = $ProgressbarMargin
    $Progressbar.Height     = $ProgressbarHeight

    return $Progressbar
}


