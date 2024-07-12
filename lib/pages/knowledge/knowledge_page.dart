import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/knowledge/detail/knowledge_detail_tab_page.dart';
import 'package:flutter_demo/pages/knowledge/knowledge_vm.dart';
import 'package:flutter_demo/route/route_untils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../repository/datas/knowledge_list_data.dart';

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {

  KnowledgeViewModel viewModel = KnowledgeViewModel();

  @override
  void initState() {
    super.initState();

    viewModel.getKnowledgeList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return viewModel;
    }, child: Scaffold(
        body: SafeArea(
          child: Consumer<KnowledgeViewModel>(builder: (context, vm, child) {
            return ListView.builder(
              itemCount: vm.list?.length ?? 0,
                itemBuilder: (context, index) {
              return _buildListTile(vm.list?[index]);
            });
          }),
        ),
      ),
    );
  }

  Widget _buildListTile(KnowledgeListData? item) {
    return GestureDetector(
      onTap: () {
        //进入明细页面
        RouteUntils.push(context, KnowledgeDetailTabPage(tabList: item?.children,));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(5.r),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?.name ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    viewModel.generalSubtitle(item?.children),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Image.asset("assets/images/img_arrow_right.png", width: 15.w, height: 20.h,),
          ],
        ),
      ),
    );
  }
}
