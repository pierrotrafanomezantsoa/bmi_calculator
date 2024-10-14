import 'package:flutter/material.dart';

class FourthCard extends StatelessWidget {
  final double bim;
  final String featureName;
  final String featureDetails;

  const FourthCard({Key? key, required this.bim, required this.featureName, required this.featureDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );

    var size = MediaQuery.of(context).size;
    double width = size.width;
   
    final style1 = theme.textTheme.displayMedium!.copyWith(
      color: Colors.green,
      fontSize: 15,
      fontWeight: FontWeight.bold,  
    );

    final style2 = theme.textTheme.displayMedium!.copyWith(
      color: Colors.white,
      fontSize: 11,  
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 1, 32),
      appBar: AppBar(
        title: const Text('BMI Calculator', ),  
         titleTextStyle: const TextStyle( 
          color: Colors.white,  
          fontSize: 24,  
          fontWeight: FontWeight.bold, 
        ),
        centerTitle: true,  
        backgroundColor: const Color.fromARGB(255, 8, 1, 32),
        iconTheme: const IconThemeData( 
          color: Colors.white,  
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('YOUR RESULT', style: style,),
            Container(
              width: width * 0.70,
              height: 250,
              padding: const EdgeInsets.all(30),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 18, 27, 34),     
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color.fromARGB(255, 23, 25, 26),
                  width: 2,
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(featureName, style: style1),
                    const SizedBox(height: 40),
                    Text(bim.toStringAsFixed(2), style: style),
                    const SizedBox(height: 50),
                    Text(featureDetails, style: style2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
