import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              BackButton(),
              SizedBox(height: 16),
              ProductImage(),
              SizedBox(height: 16),
              ProductInfo(),
              SizedBox(height: 16),
              SizeRange(),
              SizedBox(height: 16),
              ProductDescription(),
              SizedBox(height: 24),
              ActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget{
  const BackButton({super.key});
  @override
  Widget build(BuildContext context){
    return Row(children: [
      IconButton(onPressed: (){}, icon:Icon(Icons.arrow_back))

    ],);
  }
}

class ProductImage extends StatelessWidget{
  const ProductImage({super.key});
  @override
  Widget build(BuildContext context){
    return ClipRect(
        child:Image.asset('assets/Img/shoe.jpg')
    );
  }
}
class ProductInfo extends StatelessWidget{
  const ProductInfo ({super.key});
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Row(children: [
          Text('Derby Leather',
          style:TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )
          ),
          Spacer(),
          Text("\$120",
            style:TextStyle(
              fontWeight: FontWeight.normal,
              color:Colors.grey[100]
            )
          )
        ],),

        Row(children: [
          Text("men's shoe",
          style:TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey[200],
            fontSize: 13
          )
          ),
          Spacer(),
          Row(
            children: [
              Icon(Icons.start,color: Colors.amber,size:14),
              Text('(4.0)',style:TextStyle(
                fontSize: 13,
                color:Colors.grey
              ))
            ],
          )
        ],),
      ],
    );
  }
}

class SizeRange extends StatelessWidget{
   const SizeRange({super.key});
  @override
   Widget build(BuildContext context){
     final  sizes = ['39', '40', '41', '42', '43', '44'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Text('Size'),
        SizedBox(height:8),
        SizedBox(
          height:60,
          child:GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            // physics: const NeverScrollableScrollPhysics(),
            children:sizes.map((size) {
              return OutlinedButton(
                style:OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.grey[900],

                  shape:RoundedRectangleBorder(
                    borderRadius:BorderRadiusGeometry.circular(2)
                  )
                ),
                onPressed: (){},
                child: Text(size)
              );
            }
            ).toList()
          )
        )
      ]
    );
   }
}
class ProductDescription extends StatelessWidget{
  const ProductDescription({super.key});
  @override
  Widget build(BuildContext context){
    return Text(
       'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system...',
    );
  }
}
class ActionButtons extends StatelessWidget{
  const ActionButtons({super.key});
  @override
  Widget build(BuildContext context){
    return Row(
      children:[
        Expanded(
          child:OutlinedButton(
          onPressed: (){},
           child:const Text('Delete',style:TextStyle(color: Colors.red)))
        ),
        SizedBox(width:8),
        Expanded(
          child:OutlinedButton(
          onPressed: (){},
           child:const Text('Update',style:TextStyle(color:Colors.blue, ))
          )
        ),
      ]
    );
  }
}
