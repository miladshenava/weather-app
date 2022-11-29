class currentCityDataModel{
  String _City;
  var _lon;
  var _lat;
  String _main;
  String _description;
  var _temp;
  var _tempmin;
  var _tempmax;
  var _pressure;
  var _humidity;
  var _windspeed;
  var _datatime;
  String _cuntry;
  var _sunrise;
  var _sunset;

  currentCityDataModel(
      this._City,
      this._lon,
      this._lat,
      this._main,
      this._description,
      this._temp,
      this._tempmin,
      this._tempmax,
      this._pressure,
      this._humidity,
      this._windspeed,
      this._datatime,
      this._cuntry,
      this._sunrise,
      this._sunset
      );

  get sunset => _sunset;

  get sunrise => _sunrise;

  String get cuntry => _cuntry;

  get datatime => _datatime;

  get windspeed => _windspeed;

  get humidity => _humidity;

  get pressure => _pressure;

  get tempmax => _tempmax;

  get tempmin => _tempmin;

  get temp => _temp;

  String get description => _description;

  String get main => _main;

  get lat => _lat;

  get lon => _lon;

  String get City => _City;
}