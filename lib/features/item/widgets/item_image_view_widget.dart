import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import '../../parcel/widgets/get_service_video_widget.dart';

class ItemImageViewWidget extends StatefulWidget {
  final Item? item;
  ItemImageViewWidget({super.key, required this.item});

  @override
  State<ItemImageViewWidget> createState() => _ItemImageViewWidgetState();
}

class _ItemImageViewWidgetState extends State<ItemImageViewWidget> {
  final PageController _controller = PageController();
  List<String?> imageList = [];
  Future<bool> checkImage(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
  imageList.add(widget.item!.imageFullUrl!);
  addPhoto();

  if(widget.item!.youtube!=null){

    imageList.insert(widget.item!.youtubeIndex!,widget.item!.youtube);
  }
  if(widget.item!.videoModule!=null){

    imageList.insert(0,widget.item!.videoModule);
  }
  if(widget.item!.videoStore!=null){

    imageList.insert(0,widget.item!.videoStore);
  }
    super.initState();
  }
  Future<void> addPhoto() async {
    if(await checkImage(widget.item!.imagesFullUrl![0])==true)
    imageList.addAll(widget.item!.imagesFullUrl!);
  }
  @override
  Widget build(BuildContext context) {
print(imageList);
    return GetBuilder<ItemController>(builder: (itemController) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        InkWell(
          onTap: () => widget.item!.youtubeIndex!=null&&_controller.page==widget.item!.youtubeIndex?null:Navigator.of(context).pushNamed(
            RouteHelper.getItemImagesRoute(widget.item!),
            arguments: ItemImageViewWidget(item: widget.item),
          ),
          child: Stack(children: [
            SizedBox(
              height: ResponsiveHelper.isDesktop(context)
                  ? 350
                  : MediaQuery.of(context).size.width * 0.7,
              child: PageView.builder(
                controller: _controller,
                itemCount: imageList.length,
                itemBuilder: (context, index) {
                  if((widget.item!.youtubeIndex!=null&&index==widget.item!.youtubeIndex)){
                    return GetServiceVideoWidget(youtubeVideoUrl: widget.item!.youtube!, fileVideoUrl: '',);
                  }else if(imageList[index]?.contains("youtu.be")==true){
                    return GetServiceVideoWidget(youtubeVideoUrl: imageList[index]!, fileVideoUrl: '',);

                  }
               return   ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomImage(
                      image: '${imageList[index]}',
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );

                },
                onPageChanged: (index) {
                  itemController.setImageSliderIndex(index);
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _indicators(context, itemController, imageList),
                ),
              ),
            ),
          ]),
        ),
      ]);
    });
  }
  List<Widget> _indicators(BuildContext context, ItemController itemController,
      List<String?> imageList) {
    List<Widget> indicators = [];
    for (int index = 0; index < imageList.length; index++) {
      indicators.add(TabPageSelectorIndicator(
        backgroundColor: index == itemController.imageSliderIndex
            ? Theme.of(context).primaryColor
            : Colors.white,
        borderColor: Colors.white,
        size: 10,
      ));
    }
    return indicators;
  }
}
class HighlightVideoWidget extends StatefulWidget {
  final String link;
  const HighlightVideoWidget({super.key, required this.link});

  @override
  State<HighlightVideoWidget> createState() => _HighlightVideoWidgetState();
}

class _HighlightVideoWidgetState extends State<HighlightVideoWidget> {

  late VideoPlayerController videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();

    videoPlayerController.addListener(() {
      if(videoPlayerController.value.duration == videoPlayerController.value.position){

      }
    });
  }

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
      widget.link ?? "",
    ));

    await Future.wait([
      videoPlayerController.initialize(),
    ]);

    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      aspectRatio: videoPlayerController.value.aspectRatio * (ResponsiveHelper.isDesktop(context) ? 1 : 1.3),
    );
    _chewieController?.setVolume(0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).disabledColor.withOpacity(0.07), width: 2),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusDefault)),
          child: Stack(
            children: [
              _chewieController != null &&  _chewieController!.videoPlayerController.value.isInitialized ? Stack(
                children: [
                  Container(color: Colors.black, child: Chewie(controller: _chewieController!)),
                ],
              ) : const Center(child: CircularProgressIndicator()),
            ],
          ),
        )
    );
  }
}