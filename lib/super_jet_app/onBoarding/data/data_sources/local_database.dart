import '../../../../core/image/image.dart';
import '../models/model.dart';

abstract class BaseLocalDataBase {
   getData();
}
class LocalDataBase implements BaseLocalDataBase{
  @override
  getData() {
    List<OnBoardingModel> list =[
      OnBoardingModel(
          title: 'Book Travel Tickets Online',
          image: AppImage.onBoarding1,
          description: 'You can book your travel ticket from home, from your work, or from anywhere in the world to save your time and ease of booking',
      ),
      OnBoardingModel(
        title: 'Easy Payment',
        image: AppImage.onBoarding2,
        description: 'You can easily pay for the ticket in a convenient way.',
      ),
      OnBoardingModel(
        title: 'Comfort and pleasure in travel',
        image: AppImage.onBoarding4,
        description: "The company's buses are of high quality to suit and comfort our passengers",
      ),
    ];
    return list;
  }
}