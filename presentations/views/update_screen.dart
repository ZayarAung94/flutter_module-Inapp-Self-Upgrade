import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taximeter/core/constant/app_colors.dart';
import 'package:taximeter/core/constant/app_versions.dart';
import 'package:taximeter/features/auth/presentation/components/brand_card.dart';
import 'package:taximeter/modules/inapp_self_upgrade/presentations/controller/update_screen_controller.dart';
import 'package:taximeter/ui/widgets/widget_helper.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateScreenController());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, obj) {},
      child: Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return WidgetHelper.loading();
            }
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() {
                            if (controller.currentVersion.value == null) {
                              return BrandCard(
                                message: "Current version is up to date!",
                              );
                            }
                            return BrandCard(
                              message:
                                  "${controller.version} (${controller.buildNumber})"
                                  " is available!",
                            );
                          }),
                          SizedBox(height: 10),
                          Text(
                            "Current version :  ${AppVersions.version} (${AppVersions.buildNumber})",
                            style: TextStyle(
                              color: Get.theme.colorScheme.onSurface,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 50),

                          Obx(() {
                            return Text(
                              controller.releaseNotes,
                              style: TextStyle(
                                color: Get.theme.colorScheme.onSurface,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            );
                          }),
                        ],
                      ),
                    ),
                    Obx(() {
                      if (controller.finlePath.value != null) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.success,
                              foregroundColor: Colors.black,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Center(
                                child: Text(
                                  "Install Update",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              controller.versionFacade.installApk.call(
                                controller.finlePath.value!,
                              );
                            },
                          ),
                        );
                      }

                      if (controller.isDownloading.value) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: LinearProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.info),
                                  backgroundColor: AppColors.info.withAlpha(100),
                                  value: controller.downloadProgress.value,
                                  minHeight: 50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              Text(
                                "${(controller.downloadProgress.value * 100).toStringAsFixed(1)} %",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if (controller.currentVersion.value == null) {
                        return SizedBox(width: double.infinity);
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.info,
                              foregroundColor: Colors.black,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: Center(
                                child: Text(
                                  "Download Update",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              controller.startDownload();
                            },
                          ),
                        );
                      }
                    }),

                    SizedBox(height: 20),
                  ],
                ),
                Obx(() {
                  if (controller.currentVersion.value?.forceUpdate ?? false) {
                    return SizedBox.shrink();
                  }
                  return Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Icon(Icons.clear),
                      ),
                      style: IconButton.styleFrom(
                        foregroundColor: Get.theme.colorScheme.onSurface,
                        backgroundColor: Get.theme.colorScheme.surfaceContainer,
                      ),
                      onPressed: () {
                        Get.back(result: true);
                      },
                    ),
                  );
                }),
              ],
            );
          }),
        ),
      ),
    );
  }
}
