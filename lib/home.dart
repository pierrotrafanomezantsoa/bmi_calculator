
import 'package:bmi_calculator/result.dart';
import 'package:flutter/material.dart';


class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _age = 15;
  int _weight = 35;
  double _height = 170;
  
  double _bim = 0.0;
  String _featureName = 'Normal'; 
  String _featureDetail = 'Completely Normal, Good Job!';

  void _updateBim(double newBim) {
    setState(() {
      _bim = newBim;
    });
  }

  void _updateFeatureName(String featureName) {
    setState(() {
      _featureName = featureName;
    });
  }

  void _updateFeatureDetail(String featureDetail) {
    setState(() {
      _featureDetail = featureDetail;
    });
  }

  void _updateWeight(int weight) {
    setState(() {
      _weight = weight;
    });
  }

  void _updateAge(int age) {
    setState(() {
      _age = age;
    });
  }

  void _updateHeight(double height) {
    setState(() {
      _height = height;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 1, 32),
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text('BMI CALCULATOR', style: style),
                  ),
                  SizedBox(height: 10),
                  firstCard(),
                  SizedBox(height: 20),
                  secondCard(onUpdateHeight: _updateHeight),
                  SizedBox(height: 20),
                  thirdCard(
                      onUpdateWeight: _updateWeight, onUpdateAge: _updateAge),
                  SizedBox(height: 20),

                  /*fourthCard(
                    bim: _bim,
                    featureName: _featureName,
                    featureDetails: _featureDetail,
                  ),*/

                  SizedBox(height: 20),
                  fifthCard(
                    age: _age,
                    weight: _weight,
                    height: _height,
                    onBimCalculated: _updateBim,
                    onBimAppreciation: _updateFeatureName,
                    onBimAppreciationDetail: _updateFeatureDetail,
                  ),
                ],
              ),
            ),
          ),
          // Positioned return arrow at the top-left corner
          Positioned(
            top: 20,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); 
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class fifthCard extends StatefulWidget {
  const fifthCard({Key? key, required this.age, required this.weight,required this.height, required this.onBimCalculated, required this.onBimAppreciation, required this.onBimAppreciationDetail})
      : super(key: key);

  final int age;
  final int weight;
  final double height;
  final ValueChanged<double> onBimCalculated; 
  final ValueChanged<String> onBimAppreciation; 
  final ValueChanged<String> onBimAppreciationDetail; 
  @override
  State<fifthCard> createState() => _fifthCardState();
}

class _fifthCardState extends State<fifthCard> {
  
  double _bim = 0.0;
  String featureName='';
  String featureDetails = '';

  List<String> appreciationKeys = [
    "Normal",
    "Sous-poids",
    "Surpoids",
    "Obésité",
    "Hors Norme"
  ];

  List<String> appreciationMessages = [
    "Vous avez un poids normal.",
    "Vous avez un sous poids. Attention.",
    "Vous avez un sur poids. Attention.",
    "Vous êtes obèse. Hein.",
    "Heeee HORS NORMES."
  ];


 void _calculateBim() {
    setState(() {
      if (widget.age > 0 && widget.weight > 0) {
        _bim = (widget.age * widget.weight) / (widget.height * widget.height) * 1000;
      } else {
        _bim = 0.0;
      }
    });
    widget.onBimCalculated(_bim);
    print('Calculated BIM: $_bim');  

    if (_bim < 55.5){
        print(appreciationKeys[1]);
        print(appreciationMessages[1]);
        widget.onBimAppreciation(appreciationKeys[1]);
        widget.onBimAppreciationDetail(appreciationMessages[1]);
        featureName = appreciationKeys[1];
        featureDetails = appreciationMessages[1];
    }else if(55.5 <= _bim && _bim < 94.9){
        print(appreciationKeys[0]);
        print(appreciationMessages[0]);
         widget.onBimAppreciation(appreciationKeys[0]);
         widget.onBimAppreciationDetail(appreciationMessages[0]);
         featureName = appreciationKeys[0];
        featureDetails = appreciationMessages[0];
    }else if(95 <= _bim && _bim < 120.5){
        print(appreciationKeys[2]);
        print(appreciationMessages[2]);
         widget.onBimAppreciation(appreciationKeys[2]);
         widget.onBimAppreciationDetail(appreciationMessages[2]);
         featureName = appreciationKeys[2];
         featureDetails = appreciationMessages[2];
    }else if(_bim >= 150 ){
      print(appreciationKeys[3]);
      print(appreciationMessages[3]);
      widget.onBimAppreciation(appreciationKeys[3]);
      widget.onBimAppreciationDetail(appreciationMessages[3]);
      featureName = appreciationKeys[3];
      featureDetails = appreciationMessages[3];
    }
      else{
      print(appreciationKeys[4]);
      print(appreciationMessages[4]);
      widget.onBimAppreciation(appreciationKeys[4]);
      widget.onBimAppreciationDetail(appreciationMessages[4]);
      featureName = appreciationKeys[4];
      featureDetails = appreciationMessages[4];
     }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    
    return  Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        
              onPressed:(){
                print("Calculate Pressed");
                _calculateBim(); 
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  FourthCard(bim: _bim, featureName:   featureName, featureDetails: featureDetails)));
               
              },
      
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 31, 1),     
                foregroundColor:  Colors.white,                  
                side: BorderSide(color: const Color.fromARGB(255, 23, 25, 26)),
                fixedSize: Size(250, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                         
                    
        ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('CALCULATE', style: style,),  
                ],
                
              ),
            ),
    );
  }


}

class thirdCard extends StatefulWidget {
 const thirdCard({Key? key, required this.onUpdateWeight, required this.onUpdateAge}) : super(key: key);

  final Function(int weight) onUpdateWeight;
  final Function(int weight) onUpdateAge;
  
  @override
  State<thirdCard> createState() => _thirdCardState();
}

class _thirdCardState extends State<thirdCard> {
 int _weight =15;
 int _age=35;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: const Color.fromARGB(255, 136, 166, 190),
      fontSize: 15,
      
    );

    final style1 = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 120,
            height: 100,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(10),
            
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 18, 27, 34), 
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color.fromARGB(255, 23, 25, 26),
                width: 2,
              )
            ),

          child: 
            Center(
              child: 
                 Column(
                  
                   children: [
                     Text('WEIGHT', style: style,),
                     if (_weight > 0) 
                      Text(
                      '$_weight',
                       style: style1,
                       ),
                     SizedBox(height: 10),
                     Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 122, 112, 111),
                            shape: BoxShape.circle
                          ),
                          child: TextButton(
                            onPressed: (){
                            print('WEIGHT UPDATED');
                            setState(() {
                                _weight -=1;
                                widget.onUpdateWeight( _weight);
                                print(_weight);
                              });
                            }, 
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero, 
                              minimumSize: Size(25,25),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                            ),
                          )
                         ),
                        SizedBox(width: 10,),
                         Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 122, 112, 111),
                            shape: BoxShape.circle
                          ),
                          child: TextButton(
                            onPressed: (){
                            print('WEIGHT UPDATED');

                            setState(() {
                                _weight +=1;
                                widget.onUpdateWeight( _weight);
                                 print(_weight);
                              });
                            }, 
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero, 
                              minimumSize: Size(25,25),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                            ),
                          )
                         ),
                       ],
                     ),
                   ],
                 ),
                 )
            ),

        SizedBox(width: 10),
         Container(
            width: 120,
            height: 100,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(10),
            
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 18, 27, 34),    
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color.fromARGB(255, 23, 25, 26),
                width: 2,
              )
            ),

          child: 
            Center(
              child: 
                 Column(
                  
                   children: [
                     Text('AGE', style: style,),
                     if (_age> 0) 
                      Text(
                      '$_age',
                       style: style1,
                       ),
                     SizedBox(height: 10),
                     Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 122, 112, 111),
                            shape: BoxShape.circle
                          ),
                          child: TextButton(
                            onPressed: (){
                            print('AGE UPDATED');
                             setState(() {
                                _age-=1;
                                widget.onUpdateAge( _age);
                                print(_age);
                              });
                            }, 
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero, 
                              minimumSize: Size(25,25),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                            ),
                          )
                         ),
                        SizedBox(width: 10,),
                         Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 122, 112, 111),
                            shape: BoxShape.circle
                          ),
                          child: TextButton(
                            onPressed: (){
                            print('AGE UPDATED');
                             setState(() {
                                _age +=1;
                                widget.onUpdateAge( _age);
                                print(_age);
                              });
                            }, 
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero, 
                              minimumSize: Size(25,25),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                            ),
                          )
                         ),
                       ],
                     ),
                   ],
                 ),
                 )
            ),

        
      ],
    );
  }
}

class secondCard extends StatefulWidget {
  const secondCard({Key? key, required this.onUpdateHeight}) : super(key: key);

  final Function(double height) onUpdateHeight;
 
  @override
  State<secondCard> createState() => _secondCardState();
}

class _secondCardState extends State<secondCard> {
  double _sliderValue = 170.0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double width = size.width;
    
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: const Color.fromARGB(255, 136, 166, 190),
      fontSize: 15,
      
    );

    final style1 = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );
    return Container(
      width: width*0.80,
      height: 120,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
       
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 18, 27, 34),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color.fromARGB(255, 23, 25, 26),
          width: 2,
        )
      ),

    child: SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'HEIGHT',
            style: style),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
              '${_sliderValue.toStringAsFixed(1)}',
              style: style1,
            ),
              Text(
                'cm',
                style: style),
            ],
          ),
          
           Slider.adaptive(
              value: _sliderValue,
              onChanged: (newValue) {
                setState(() {
                  _sliderValue = newValue;
                   widget.onUpdateHeight( _sliderValue);
                   print(_sliderValue);
                });
              },
              min: 50.0,
              max: 250.0,
              thumbColor: const Color.fromARGB(255, 255, 0, 0),
              activeColor: const Color.fromARGB(255, 255, 255, 255),
            ),
          
        ],
      )));
  }
}

class firstCard extends StatefulWidget {
  const firstCard({
    super.key,
  });

  @override
  State<firstCard> createState() => _firstCardState();
}

class _firstCardState extends State<firstCard> {
  var _gender = '';

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
            onPressed: () {
              print("MALE Gender");
              setState(() {
                  _gender = 'male';
                });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 18, 27, 34),   
              foregroundColor: const Color.fromARGB(255, 136, 166, 190),           
              shadowColor: Colors.transparent,         
              side: BorderSide(color: const Color.fromARGB(255, 23, 25, 26)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              fixedSize: const Size(120, 130),
               padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.male,
                  color: Colors.white,  
                  size: 30.0,          
                ),
                Text('MALE'),  
              ],
            ),
          ),

         SizedBox(width: 10),
           ElevatedButton(
            onPressed: () {
              print("FEMALE Gender");
            setState(() {
                  _gender = 'female';
                });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 18, 27, 34),
              foregroundColor: const Color.fromARGB(255, 136, 166, 190),            
              shadowColor: Colors.transparent,         
              side: BorderSide(color: const Color.fromARGB(255, 23, 25, 26)),   
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              fixedSize: Size(120, 130), 
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.female,
                  color: Colors.white,  
                  size: 30.0,          
                ),
                Text('FEMALE'),  
              ],
            ),
          ),

    /*       Text(
              '$_gender',
              style: TextStyle(color: Colors.white), 
            ),*/
      ],
      
    );
  }
}