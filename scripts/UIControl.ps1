#########################################################################
# Author:  Kevin RAHETILAHY                                             #
#########################################################################

# =======================================================================
# Template Form and Node
#
# SUMMARY: This document helps you to re-use directly some common node in
# the XAML form without specifing it everytime. 
# Make sure that names are different for each node of the same type 
# you use to avoid conflict during the Control generation.
# =======================================================================


# ======================== Grid ======================================= 
Function New-Grid{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $Name,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $Margin)
 
    $Grid = New-Object System.Windows.Controls.Grid
    $Grid.Name        = $Name 
    $Grid.Margin      = $Margin
    
    return $Grid
}

# =================== StackPanel ======================================== 
Function New-StackPanel{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0)]
        [string] $Name,
        [Parameter(Position=1)]
        [string] $Margin,
        [Parameter(Position=2)]
        [string] $Orientation,
        [Parameter(Position=3)]
        [string] $HorizontalAlignment,
        [Parameter(Position=4)]
        [string] $Background
        )

 
    $StackPanel = New-Object System.Windows.Controls.StackPanel
    if($Name){$StackPanel.Name        = $Name} 
    $StackPanel.Orientation = $Orientation
    $StackPanel.Margin      = $Margin
    $StackPanel.VerticalAlignment   = "Stretch"
    if($Background){$StackPanel.Background   = $Background}
    if($HorizontalAlignment){$StackPanel.HorizontalAlignment = $HorizontalAlignment} 
    
    
 
    return $StackPanel
}

# =================== RadioButton ======================================
Function New-RadioButton{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $Name,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $Margin,
        [Parameter(Position=2,Mandatory=$true)]
        [string] $GroupName)
 
    $RadioButton = New-Object System.Windows.Controls.RadioButton
    $RadioButton.Name        = $Name 
    $RadioButton.Margin      = $Margin
    $RadioButton.GroupName   = $GroupName
    
    return $RadioButton
}

# ======================== Label =======================================
Function New-Label{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $Name,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $Margin,
        [Parameter(Position=2)]
        [string] $FontSize
        )
 
    $Label = New-Object System.Windows.Controls.Label
    $Label.Name        = $Name 
    $Label.Margin      = $Margin
    if ($FontSize){$Label.FontSize=$FontSize}
    
    return $Label
}

# ======================== TextBlock =======================================
Function New-TextBlock{ 
    [CmdletBinding()]
       param(
           [Parameter(Position=0)]
           [string] $Margin,
           [Parameter(Position=1)]
           [string] $FontSize,
           [Parameter(Position=2)]
           [string] $Foreground
           )
    
       $Label = New-Object System.Windows.Controls.TextBlock
       $Label.Margin  = $Margin
       if($Foreground){$Label.Foreground = $Foreground} 
       if ($FontSize){$Label.FontSize=$FontSize}
       
       return $Label
   }

# ======================== Image =======================================
Function New-Image{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $Name,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $Size,
        [Parameter(Position=2)]
        [string] $Margin)
 
    $Image = New-Object System.Windows.Controls.Image
    $Image.Name        = $Name
    if($Margin -ne "") {$Image.Margin  = $Margin }
    $Image.Width =$Size.Split(",")[0]
    $Image.Height=$Size.Split(",")[1]
    $Image.HorizontalAlignment="Left"
    $Image.VerticalAlignment="Top" 
    
    return $Image
}

# ======================== Border =======================================
Function New-Border{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $Color)
 
    $Border = New-Object System.Windows.Controls.Border
    $Border.BorderBrush     = $Color
    $Border.BorderThickness = 2
    return $Border
}

# ======================== Button =======================================
Function New-Button{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $Name,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $Margin,
        [Parameter(Position=2,Mandatory=$true)]
        [string] $Content,
        [Parameter(Position=3,Mandatory=$true)]
        [string] $Foreground)
 
    $Button = New-Object System.Windows.Controls.Button
    $Button.Name        = $Name 
    $Button.Content     = $Content
    $Button.Margin      = $Margin
    $Button.Foreground  = $Foreground

    return $Button
}

# ======================== Progressbar =======================================
Function New-Progressbar{ 
 [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=$true)]
        [string] $Name,
        [Parameter(Position=1,Mandatory=$true)]
        [string] $Margin,
        [Parameter(Position=2,Mandatory=$true)]
        [string] $Height)
 
    $Progressbar = New-Object System.Windows.Controls.Progressbar
    $Progressbar.Name       = $Name 
    $Progressbar.Margin     = $Margin
    $Progressbar.Height     = $Height

    return $Progressbar
}

# ======================== Rectangle =======================================
Function New-Rectangle{ 
    [CmdletBinding()]
       param(
           [Parameter(Position=0)]
           [string] $Margin,
           [Parameter(Position=1,Mandatory=$true)]
           [string] $Size,
           [Parameter(Position=2)]
           [System.Windows.Media.VisualBrush] $VisualBrush
        )
           

        $Rectangle = New-Object System.Windows.Shapes.Rectangle
		$Rectangle.Margin = $Margin
		$Rectangle.Width  = $Size.Split(",")[0]
        $Rectangle.Height = $Size.Split(",")[1]
        if($VisualBrush){$Rectangle.Fill = $VisualBrush}
       

       return $Rectangle
   }
   

