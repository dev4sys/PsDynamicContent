

$Script:apikey = 'your api key here'

Function Get-NextTrain
{
[cmdletbinding()]
    param( 
    [Parameter(Mandatory = $true, ValueFromPipeline=$true)]
    $idgare,
    [Parameter(Mandatory = $true, ValueFromPipeline=$true)]
    $traindirection
)

$datenow = ((Get-date -Format s) -replace "-","") -replace ":",""
$params2 = @{uri = "https://api.sncf.com/v1/coverage/sncf/stop_areas/$($idgare)/departures?from_datetime=$($datenow)";
                
                   Method = 'Get'; #(or POST, or whatever)
                   Headers = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($apikey):"));
           } #end headers hash table
   } #end $params hash table
    $string = @"
    Liste des prochains trains pour {0} en provenance de {1} doit arriver a la {2} a {3} et partir a {4}
"@
$var2 = invoke-restmethod @params2
$alltrain = ,@()
foreach($departure in $($var2.departures)){
   if($departure.display_informations.direction -like $($traindirection)){
        $direction = $($departure.display_informations.direction -replace "gare de ","") -replace " 1-2 (Paris)",""
        [datetime]$convertarrival = ConvertTo-SncfDateTime -sncfdate $($departure.stop_date_time.arrival_date_time)
        [datetime]$convertdeparture = ConvertTo-SncfDateTime -sncfdate $($departure.stop_date_time.departure_date_time)
        [timespan]$timefromnow = NEW-TIMESPAN -Start $(Get-date) -End $convertarrival
        $hash = @{            
            Direction = $($direction)                 
            From = $($departure.route.name)             
            GareName = $($departure.stop_point.name)           
            ETAArrival = $($convertarrival)           
            ETADeparture =  $($convertdeparture)
            ETAinMin =  "$($timefromnow.Hours):$($timefromnow.Minutes):$($timefromnow.Seconds)"
        }                           
            $Object = New-Object PSObject -Property $hash   
            $alltrain += $Object
         }
}
return $alltrain 
}

Function Get-TrainDirection 
{
     [cmdletbinding()]
    param( 
    [Parameter(Mandatory = $true, ValueFromPipeline=$true)]
    [string]$idgare
    )
    $datenow = ((Get-date -Format s) -replace "-","") -replace ":",""
    $params2 = @{uri = "https://api.sncf.com/v1/coverage/sncf/stop_areas/$($idgare)/departures?from_datetime=$($datenow)";
                
                       Method = 'Get'; #(or POST, or whatever)
                       Headers = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($apikey):"));
               } #end headers hash table
       } #end $params hash table
    $var2 = invoke-restmethod @params2
    $direction = ,@()
    foreach($departure in $($var2.departures)){
        $hash = @{            
            Direction = $($departure.display_informations.direction.ToString())                
            idgare = $($idgare)             
        }  
        $Object = New-Object PSObject -Property $hash 
        $direction += $Object
    }
    $direction | Select-Object idgare,direction -Unique  -Skip 1  
}

Function Get-Gare{
    param( $gare  )
    $params = @{uri = "https://api.sncf.com/v1/coverage/sncf/places?q=$($gare)";
                    Method = 'Get'; #(or POST, or whatever)
                    Headers = @{Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($apikey):"));
            } #end headers hash table
    } #end $params hash table
    $var = invoke-restmethod @params
    foreach($stoparea in $($var.places |?{ $_.embedded_type -eq "stop_area"})){
        $hash = @{            
                Direction = $($stoparea.Name)                
                idgare = $($stoparea.id)             
            }  
            $Object = New-Object PSObject -Property $hash 
            Write-Output $Object
    }
    
}

function ConvertTo-SncfDateTime
{
    param(
        $sncfdate
    )
    $sncfyear   = $sncfdate.Substring(0,4)
    $sncfmonth  = $sncfdate.Substring(4,2)
    $sncfday    = $sncfdate.Substring(6,2)
    $sncfhour   = $sncfdate.Substring(9,2)
    $sncfminute = $sncfdate.Substring(11,2)
    $sncfsecond = $sncfdate.Substring(13,2)

    $datetime = Get-date -Year $sncfyear -Day $sncfday -Month $sncfmonth -Hour $sncfhour -Second $sncfsecond -Minute $sncfminute
    Write-Output $datetime
}