import 'package:final_projects/bloc/user_info_bloc/user_info_status_bloc.dart';
import 'package:final_projects/data/data_sources/web_services/api_repository.dart';
import 'package:final_projects/presentation/resources/theme/theme_manager.dart';
import 'package:final_projects/presentation/shared/toast_helper.dart';
import 'package:final_projects/presentation/shared/widget/error_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/auth_bloc/auth_status_bloc.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});




  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoBloc, InfoStates>(
      builder: (context, state) {
        return Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 200,
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Hero(
                  tag: "image",
                  child: AuthBloc.user.photoUrl == null
                      ? const ErrorImage(
                          "https://www.shareicon.net/download/2016/06/27/787159_people_512x512.png",
                          fit: BoxFit.fill)
                      : Base64Image(
                          AuthBloc.user.photoUrl!,
                          height: 200,
                        ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: FilledButton.tonalIcon(
                    style: FilledButton.styleFrom(
                        backgroundColor: ColorManager.darkBlue,
                        fixedSize: const Size(100, 20)),
                    icon: Icon(
                      AuthBloc.user.verified
                          ? Icons.verified
                          : Icons.not_interested,
                      size: 20,
                      color: AuthBloc.user.verified
                          ? Colors.yellow
                          : Colors.redAccent,
                    ),
                    onPressed: () async {
                      try {
                        Map<String, dynamic> data =
                            await ApiCall.instance.getMyProducts();
                        print(data);

                        if(data.isNotEmpty){
                          showSubscriptionDialog(context , data['name_sub'] , data['end_date']);
                          context.read<UserInfoBloc>().add(const ChangeUserEvent(true));
                        }else{
                          context.read<UserInfoBloc>().add(const ChangeUserEvent(false));
                          showToast("لا يوجد اشتراك لك" , type: ToastType.info);
                        }

                      } catch (_, __) {
                        showToast("حدث خطأ اثناء طلب البيانات");
                      }
                    },
                    label: Text(
                      "مشترك",
                      style: TextStyle(
                        fontSize: 16,
                        color: AuthBloc.user.verified
                            ? Colors.yellow
                            : Colors.redAccent,
                      ),
                    )),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Text(
                AuthBloc.user.name,
                // AuthBloc.user.name ?? StringManger.appUser,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w100,
                      height: 1,
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 14,
                    ),
              ),
            )
          ],
        );
      },
    );
  }


  void showSubscriptionDialog(BuildContext context, String subscriptionName, String subscriptionEndDate) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("الاشتراك النشط" , textDirection: TextDirection.rtl,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "لديك اشتراك نشط.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "الخطة: $subscriptionName",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "ينتهي في: $subscriptionEndDate",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("موافق"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
