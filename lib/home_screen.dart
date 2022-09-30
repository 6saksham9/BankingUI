import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var overview;
  List performance = [];
  bool isLoading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future getData() async {
    setState(() {
      isLoading=true;
    });
    var res1 = await http.get(Uri.parse(
        'https://api.stockedge.com/Api/SecurityDashboardApi/GetCompanyEquityInfoForSecurity/5051?lang=en'));
    overview = jsonDecode(res1.body);
    var res2 = await http.get(Uri.parse(
        "https://api.stockedge.com/Api/SecurityDashboardApi/GetTechnicalPerformanceBenchmarkForSecurity/5051?lang=en"));
    performance = jsonDecode(res2.body);
    print(overview);
    isLoading=false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:isLoading?Center(child: CircularProgressIndicator(),): Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              SizedBox(height: 10),
              Text(
                "Overview",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sector',
                      style: TextStyle(fontSize: 17, color: Colors.black)),
                  Text(overview['Sector'].toString(),
                      style: TextStyle(fontSize: 17, color: Colors.black))
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Industry',
                      style: TextStyle(fontSize: 17,)),
                  Text(overview['Industry'].toString(),
                      style: TextStyle(fontSize: 17,))
                ],
              ),
               SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Market Cap',
                      style: TextStyle(fontSize: 17,)),
                  Text(overview['MCAP'].toStringAsFixed(2) + " Cr.",
                      style: TextStyle(fontSize: 17,))
                ],
              ),
               SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Enterprise Value (EV)',
                      style: TextStyle(fontSize: 17, )),
                  Text(overview['EV'] ?? '-',
                      style: TextStyle(fontSize: 17, ))
                ],
              ),
               SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Book Value / Share',
                      style: TextStyle(fontSize: 17,)),
                  Text(overview['BookNavPerShare'].toStringAsFixed(2),
                      style: TextStyle(fontSize: 17,))
                ],
              ),
               SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price-Earning Ratio (PE)',
                      style: TextStyle(fontSize: 17, )),
                  Text(overview['TTMPE'].toStringAsFixed(2),
                      style: TextStyle(fontSize: 17, ))
                ],
              ),
               SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('PEG Ratio',
                      style: TextStyle(fontSize: 17, )),
                  Text(overview['PEGRatio'].toStringAsFixed(2),
                      style: TextStyle(fontSize: 17, ))
                ],
              ),
               SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Dividend Yield',
                      style: TextStyle(fontSize: 17,)),
                  Text(overview['Yield'].toStringAsFixed(2),
                      style: TextStyle(fontSize: 17, ))
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Performance",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 1,
              ),
              ListView.builder(
              
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            performance[index]['Label'],
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: LinearProgressIndicator(
                            minHeight: 20,
                            color: Colors.green,
                            backgroundColor: Colors.grey[300],
                            value: (performance[index]["ChangePercent"])/351,
                          ),
                        ),
                        SizedBox(width: 30,),
                        Expanded(
                          
                          child: Text(performance[index]["ChangePercent"]
                                  .toStringAsFixed(1)
                                  .toString() +
                              " %",style: TextStyle(fontSize: 17),),
                        )
                      ],
                    ),
                  );
                },
                itemCount: performance.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
