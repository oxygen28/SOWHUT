List<Map> solarList = [
  {
    "longname":"All Sky Surface Shortwave Downward Irradiance",
    "shortname":"ALLSKY_SFC_SW_DWN",
    "description":'The total solar irradiance incident (direct plus diffuse) on a horizontal plane at the surface of the earth under all sky conditions. An alternative term for the total solar irradiance is the "Global Horizontal Irradiance" or GHI.'
  },
  {
    "longname":"Clear Sky Surface Shortwave Downward Irradiance",
    "shortname":"CLRSKY_SFC_SW_DWN",
    "description":'The total solar irradiance incident (direct plus diffuse) on a horizontal plane at the surface of the earth under clear sky conditions. An alternative term for the total solar irradiance is the "Global Horizontal Irradiance" or GHI.'
  },
  {
    "longname":'All Sky Insolation Clearness Index',
    "shortname":'ALLSKY_KT',
    "description":'A fraction representing clearness of the atmosphere; the all sky insolation that is transmitted through the atmosphere to strike the surface of the earth divided by the average of top of the atmosphere total solar irradiance incident.'
  },
  {
    "longname":'All Sky Normalized Insolation Clearness Index',
    "shortname":'ALLSKY_NKT',
    "description":'The average zenith angle-independent expression of the all sky insolation clearness index.'
  },
  {
    "longname":'All Sky Surface Albedo',
    "shortname":'ALLSKY_SRF_ALB',
    "description":"The all sky rate of reflectivity of the earth's surface; the ratio of the solar energy reflected by the surface of the earth compared to the total solar energy incident reaching the surface of the earth."
  }
];

List<Map> temperatureList = [
  {
    "longname":"Temperature at 2 Meters",
    "shortname":"T2M",
    "description":'The average air (dry bulb) temperature at 2 meters above the surface of the earth.'
  },
  {
    "longname":"Wet Bulb Temperature at 2 Meters",
    "shortname":"T2MWET",
    "description":'The adiabatic saturation temperature which can be measured by a thermometer covered in a water-soaked cloth over which air is passed at 2 meters above the surface of the earth.'
  },
  {
    "longname":'Earth Skin Temperature',
    "shortname":'TS',
    "description":"The average temperature at the earth's surface."
  },
  {
    "longname":'Temperature at 2 Meters Range',
    "shortname":'T2M_RANGE',
    "description":'The minimum and maximum hourly air (dry bulb) temperature range at 2 meters above the surface of the earth in the period of interest.'
  },
];

List<Map> humidityList = [
  {
    "longname":"Specific Humidity at 2 Meters",
    "shortname":"QV2M",
    "description":'The ratio of the mass of water vapor to the total mass of air at 2 meters (kg water/kg total air).'
  },
  {
    "longname":"Relative Humidity at 2 Meters",
    "shortname":"RH2M",
    "description":'The ratio of actual partial pressure of water vapor to the partial pressure at saturation, expressed in percent.'
  }
];

List<Map> windList = [
  {
    "longname":"Wind Speed at 10 Meters",
    "shortname":"WS10M",
    "description":'The average of wind speed at 10 meters above the surface of the earth.'
  },
  {
    "longname":"Wind Speed at 10 Meters Range",
    "shortname":"WS10M_RANGE",
    "description":'The minimum and maximum hourly wind speed range at 10 meters above the surface of the earth.'
  },
  {
    "longname":"Wind Speed at 50 Meters",
    "shortname":"WS50M",
    "description":'The average of wind speed at 50 meters above the surface of the earth.'
  },
  {
    "longname":"Wind Speed at 50 Meters Range",
    "shortname":"WS50M_RANGE",
    "description":'The minimum and maximum hourly wind speed range at 50 meters above the surface of the earth.'
  }
];