import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media/commons/assets.dart';
import 'package:social_media/data/env/env.dart';
import 'package:social_media/domain/blocs/blocs.dart';
import 'package:social_media/domain/blocs/post/post_bloc.dart';
import 'package:social_media/ui/helpers/helpers.dart';
import 'package:social_media/ui/screens/home/home_page.dart';
import 'package:social_media/ui/themes/color_custom.dart';
import 'package:social_media/ui/widgets/widgets.dart';

class AddPostPage extends StatefulWidget {
  AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  late TextEditingController _descriptionController;
  final _keyForm = GlobalKey<FormState>();
  late List<AssetEntity> _mediaList = [];
  late File fileImage;

  @override
  void initState() {
    _assetImagesDevice();
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  _assetImagesDevice() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      if (albums.isNotEmpty) {
        List<AssetEntity> photos = await albums[0].getAssetListPaged(0, 50);
        setState(() => _mediaList = photos);
      }
    } else {
      PhotoManager.openSetting();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context).state;
    final postBloc = BlocProvider.of<PostBloc>(context);
    final size = MediaQuery.of(context).size;

    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {
        if (state is LoadingPost) {
          modalLoading(context, 'Creating post...');
        } else if (state is FailurePost) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        } else if (state is SuccessPost) {
          Navigator.pop(context);
          modalSuccess(context, 'Post created!',
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context, routeSlide(page: const HomePage()), (_) => false));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Form(
          key: _keyForm,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                _appBarPost(),
                SizedBox(height: 10.h),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  height: 120.h,
                                  width: size.width * .125,
                                  child: CircleAvatar(
                                    radius: 30.r,
                                    backgroundImage: NetworkImage(
                                        Environment.baseUrl +
                                            userBloc.user!.image),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 100.h,
                              width: size.width * .78,
                              color: Colors.white,
                              child: TextFormField(
                                controller: _descriptionController,
                                maxLines: 4,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: 10.w, top: 10.h),
                                    border: InputBorder.none,
                                    hintText: 'Add a comment',
                                    hintStyle:
                                        GoogleFonts.roboto(fontSize: 18.sp)),
                                validator: RequiredValidator(
                                    errorText: 'This field is required'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.only(left: 65.w, right: 10.w),
                          child: BlocBuilder<PostBloc, PostState>(
                              buildWhen: (previous, current) =>
                                  previous != current,
                              builder: (_, state) => (state.imageFileSelected !=
                                      null)
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:
                                          state.imageFileSelected!.length,
                                      itemBuilder: (_, i) => Stack(
                                        children: [
                                          Container(
                                            height: 150.h,
                                            width: size.width * .95,
                                            margin:
                                                EdgeInsets.only(bottom: 10.h),
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: FileImage(state
                                                            .imageFileSelected![
                                                        i]))),
                                          ),
                                          Positioned(
                                            top: 5.h,
                                            right: 5.w,
                                            child: InkWell(
                                              onTap: () => postBloc.add(
                                                  OnClearSelectedImageEvent(i)),
                                              child: const CircleAvatar(
                                                backgroundColor: Colors.black38,
                                                child: Icon(Icons.close_rounded,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : const SizedBox()),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 90.h,
                  width: size.width,
                  // color: Colors.amber,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _mediaList.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () async {
                          fileImage = (await _mediaList[i].file)!;
                          postBloc.add(OnSelectedImageEvent(fileImage));
                        },
                        child: FutureBuilder(
                          future: _mediaList[i].thumbDataWithSize(200, 200),
                          builder:
                              (context, AsyncSnapshot<Uint8List?> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Container(
                                height: 85.h,
                                width: 100.w,
                                margin: EdgeInsets.only(right: 5.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: MemoryImage(snapshot.data!))),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 5.h),
                const Divider(),
                InkWell(
                  onTap: () => modalPrivacyPost(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Row(
                      children: [
                        BlocBuilder<PostBloc, PostState>(builder: (_, state) {
                          if (state.privacyPost == 1) {
                            return const Icon(Icons.public_rounded);
                          }
                          if (state.privacyPost == 2) {
                            return const Icon(Icons.group_outlined);
                          }
                          if (state.privacyPost == 3) {
                            return const Icon(Icons.lock_outline_rounded);
                          }
                          return const SizedBox();
                        }),
                        SizedBox(width: 5.w),
                        BlocBuilder<PostBloc, PostState>(builder: (_, state) {
                          if (state.privacyPost == 1) {
                            return TextCustom(
                                text: 'Anyone can comment', fontSize: 16.sp);
                          }
                          if (state.privacyPost == 2) {
                            return TextCustom(
                                text: 'Only followers', fontSize: 16.sp);
                          }
                          if (state.privacyPost == 3) {
                            return TextCustom(text: 'No one', fontSize: 16.sp);
                          }
                          return const SizedBox();
                        }),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                SizedBox(height: 5.h),
                SizedBox(
                  height: 40.h,
                  width: size.width,
                  child: Row(
                    children: [
                      IconButton(
                          splashRadius: 20.r,
                          onPressed: () async {
                            AppPermission()
                                .permissionAccessGalleryMultiplesImagesNewPost(
                                    await Permission.storage.request(),
                                    context);
                          },
                          icon: SvgPicture.asset(SocialMediaAssets.gallery)),
                      IconButton(
                          splashRadius: 20.r,
                          onPressed: () async {
                            AppPermission()
                                .permissionAccessGalleryOrCameraForNewPost(
                                    await Permission.camera.request(),
                                    context,
                                    ImageSource.camera);
                          },
                          icon: SvgPicture.asset(SocialMediaAssets.camera)),
                      IconButton(
                          splashRadius: 20.r,
                          onPressed: () {},
                          icon: SvgPicture.asset(SocialMediaAssets.gif)),
                      IconButton(
                          splashRadius: 20.r,
                          onPressed: () {},
                          icon: SvgPicture.asset(SocialMediaAssets.location)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _appBarPost() {
    final postBloc = BlocProvider.of<PostBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            splashRadius: 20.r,
            onPressed: () => Navigator.pushAndRemoveUntil(
                context, routeSlide(page: const HomePage()), (_) => false),
            icon: const Icon(Icons.close_rounded)),
        BlocBuilder<PostBloc, PostState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) => TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.only(left: 12.w, right: 12.w),
                  backgroundColor: CustomColors.primary,
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r))),
              onPressed: () {
                if (_keyForm.currentState!.validate()) {
                  if (state.imageFileSelected != null) {
                    postBloc.add(
                        OnAddNewPostEvent(_descriptionController.text.trim()));
                  } else {
                    modalWarning(context, 'There are no selected images!');
                  }
                }
              },
              child: TextCustom(
                text: 'Post',
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: .7,
              )),
        )
      ],
    );
  }
}
