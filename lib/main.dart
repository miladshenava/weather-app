import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:weather_app/models/currentCityDataModel.dart';
import 'package:intl/intl.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: myApp(),
  ));
}

class myApp extends StatefulWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  TextEditingController textEditingController = TextEditingController();
var CityName = 'tehran';
late Future<currentCityDataModel> CurrentWeatherFuture;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    CurrentWeatherFuture = sendRequestCurrentWeather(CityName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[600],
          title: Center(
              child: Text(
            'Weather APP',
            style: GoogleFonts.ubuntu(
                color: Colors.black54,
                fontSize: 25,
                fontWeight: FontWeight.w600),
          )),
        ),
        body: FutureBuilder<currentCityDataModel>(
          future:  CurrentWeatherFuture,
          builder: (context,snapshot){
            if(snapshot.hasData){
              currentCityDataModel? cityDataModel = snapshot.data;
              final formatter = DateFormat.jm();
              var sunrise = formatter.format(
                DateTime.fromMillisecondsSinceEpoch(cityDataModel!.sunset * 1000,
                    isUtc: true),
              );
              var sunset = formatter.format(
                DateTime.fromMillisecondsSinceEpoch(cityDataModel.sunset * 1000,
                    isUtc: true),
              );
              return Container(
                color: Colors.cyan[800],
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_rounded,
                                size: 50,
                                color: Colors.black54,
                              ),
                              const SizedBox(
                                width: 1,
                              ),
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    hintText: 'City Name',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                  ),

                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      CurrentWeatherFuture = sendRequestCurrentWeather(textEditingController.text);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.search_sharp,
                                    size: 35,

                                  ))
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(cityDataModel.City.toString(),style: GoogleFonts.ubuntu(fontSize: 45,color: Colors.black45),),
                          const SizedBox(height: 5,),

                          Container(
                            height: 100,
                            width: 100,
                            child: setIconForMain(cityDataModel)
                          ),
                          const SizedBox(height: 10,),
                          Text(cityDataModel.description.toString(),style: GoogleFonts.ubuntu(fontSize: 21,color: Colors.black45),),
                          const SizedBox(height: 5,),
                          Text(
                            cityDataModel.temp.round().toString() + '\u00B0',
                            style: GoogleFonts.ubuntu(fontSize: 80),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'max',
                                    style: GoogleFonts.ubuntu(fontSize: 20,color: Colors.black45),
                                  ),
                                  Text(
                                    cityDataModel.tempmax.round().toString()+ '\u00B0',
                                    style: GoogleFonts.ubuntu(fontSize: 20),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  width: 1,
                                  height: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                      'min',
                                      style: GoogleFonts.ubuntu(fontSize: 20,color: Colors.black45)
                                  ),
                                  Text(
                                    cityDataModel.tempmin.round().toString() + '\u00B0',
                                    style: GoogleFonts.ubuntu(fontSize: 20),
                                  )
                                ],
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              height: 0.8,
                              color: Colors.black45,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 2,),
                              Container(
                                height: 100,
                                width: 80,
                                child: Column(
                                  children: [
                                    Text('WindSpeed',style: GoogleFonts.ubuntu(fontSize: 15,color: Colors.black45),),
                                    const SizedBox(height: 5,),
                                    Container(width: 30,height: 30,child: const Image(image: AssetImage('lib/images/wind.png'))),
                                    const SizedBox(height: 5,),
                                    Text(cityDataModel.windspeed.round().toString(),style: GoogleFonts.ubuntu(fontSize: 19),)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  width: 0.8,
                                  height: 45,
                                  color: Colors.black45,
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 70,
                                child: Column(
                                  children: [
                                    Text('Humidity',style: GoogleFonts.ubuntu(fontSize: 15,color: Colors.black45),),
                                    const SizedBox(height: 5,),
                                    Container(width: 30,height: 30,child: const Image(image: AssetImage('lib/images/humidity.png'))),
                                    const SizedBox(height: 5,),
                                    Text(cityDataModel.humidity.round().toString(),style: GoogleFonts.ubuntu(fontSize: 19),)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  width: 0.8,
                                  height: 45,
                                  color: Colors.black45,
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 70,
                                child: Column(
                                  children: [
                                    Text('Sunrise',style: GoogleFonts.ubuntu(fontSize: 15,color: Colors.black45),),
                                    const SizedBox(height: 5,),
                                    Container(width: 30,height: 30,child: const Image(image: AssetImage('lib/images/sunrise.png'))),
                                    const SizedBox(height: 5,),
                                    Text(sunrise,style: GoogleFonts.ubuntu(fontSize: 19),)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  width: 0.8,
                                  height: 45,
                                  color: Colors.black45,
                                ),
                              ),
                              Container(

                                height: 100,
                                width: 70,
                                child: Column(
                                  children: [
                                    Text('Sunset',style: GoogleFonts.ubuntu(fontSize: 15,color: Colors.black45),),
                                    const SizedBox(height: 5,),
                                    Container(width: 30,height: 30,child: const Image(image: AssetImage('lib/images/sunSet.png'))),
                                    const SizedBox(height: 5,),
                                    Text(sunset,style: GoogleFonts.ubuntu(fontSize: 19),)
                                  ],
                                ),
                              ),

                            ],
                          )


                        ],
                      )
                    ],
                  ),
                ),
              );
            }else{return Center(child: Container( child: const Text('loading...'),),);}
          },

        )
    );
  }
  Image setIconForMain(model) {
    String description = model.description;
    if (description == 'clear sky') {
      return const Image(
        image: AssetImage('lib/images/suny.png'),
      );
    } else if (description == 'few clouds') {
      return const Image(
        image: AssetImage('lib/images/sun-clud.png'),
      );
    } else if (description.contains('rain')) {
      return const Image(image: AssetImage('lib/images/rain.png'));
    }else if (description.contains('thuntherstorm')) {
      return const Image(image: AssetImage('lib/images/cloud-rain.png'));
    }else if (description.contains('drizzle')) {
      return const Image(image: AssetImage('lib/images/cloud-rain.png'));
    }else if (description.contains('snow')) {
      return const Image(image: AssetImage('lib/images/snow.png'));
    }else if (description.contains('clouds')) {
      return const Image(image: AssetImage('lib/images/cloud.png'));
    }else{return const Image(image: AssetImage('lib/images/haze.png'));}
  }
  Future<currentCityDataModel> sendRequestCurrentWeather(String cityName) async{
    var apiKey = 'bfd6c9b65a5ba4ec3e260b6dccec5dea';
    var respons = await Dio().get('https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {'q': cityName, 'appId': apiKey, 'units': 'metric'});
    var dataModel = currentCityDataModel(
      respons.data['name'],
      respons.data['coord']['lon'],
      respons.data['coord']['lat'],
      respons.data['weather'][0]['main'],
      respons.data['weather'][0]['description'],
      respons.data['main']['temp'],
      respons.data['main']['temp_min'],
      respons.data['main']['temp_max'],
      respons.data['main']['pressure'],
      respons.data['main']['humidity'],
      respons.data['wind']['speed'],
      respons.data['dt'],
      respons.data['sys']['country'],
      respons.data['sys']['sunrise'],
      respons.data['sys']['sunset'],

    );
    print(respons.statusCode);
    print(respons.data);

    return dataModel;


  }
}
