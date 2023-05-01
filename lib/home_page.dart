
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scientific_effect_base/search_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late double screenWidth;
  late double screenHeight;

  var searchPageData = [
    ["功能", "选择一个操作类型和对应要操作的对象,然后点击提交查询按钮。", ["操作类型","操作对象"], {
      "操作类型" : [
        "吸收 (Absorb)",
        "累积 (Accumulate)",
        "弯曲 (Bend)",
        "分解 (Break Down)",
        "改变相 (Change Phase)",
        "清洁 (Clean)",
        "压缩 (Compress)",
        "浓缩 (Concentrate)",
        "凝结 (Condense)",
        "限制 (Constrain)",
        "冷却 (Cool)",
        "沉积 (Deposit)",
        "摧毁 (Destroy)",
        "检测 (Detect)",
        "稀释 (Dilute)",
        "干燥 (Dry)",
        "蒸发 (Evaporate)",
        "膨胀 (Expand)",
        "提取 (Extract)",
        "冷冻 (Freeze)",
        "加热 (Heat)",
        "保持 (Hold)",
        "连接 (Join)",
        "熔化 (Melt)",
        "混合 (Mix)",
        "移动 (Move)",
        "定向 (Orient)",
        "生产 (Produce)",
        "保护 (Protect)",
        "净化 (Purify)",
        "移除 (Remove)",
        "抵抗 (Resist)",
        "旋转 (Rotate)",
        "分离 (Separate)",
        "振动 (Vibrate)"
      ],
      "操作对象": [
        "分散固体 (Divided Solid)",
        "场 (Field)",
        "气体 (Gas)",
        "液体 (Liquid)",
        "固体 (Solid)"
      ]},
    ],
    ["参数", "选择一个操作和对应要改变的参数,然后点击提交查询按钮.", ["操作类型","操作参数"], {
      "操作类型" : [
        "改变 (Change)",
        "减少 (Decrease)",
        "增加 (Increase)",
        "测量 (Measure)",
        "稳定 (Stabilise)"
      ],
      "操作参数": [
        "亮度 (Brightness)",
        "颜色 (Colour)",
        "浓度 (Concentration)",
        "密度 (Density)",
        "阻力 (Drag)",
        "电导率 (Electrical Conductivity)",
        "能量 (Energy)",
        "流体流动 (Fluid Flow)",
        "力量 (Force)",
        "频率 (Frequency)",
        "摩擦 (Friction)",
        "硬度 (Hardness)",
        "热传导 (Heat Conduction)",
        "均匀性 (Homogeneity)",
        "湿度 (Humidity)",
        "长度 (Length)",
        "磁性能 (Magnetic Properties)",
        "方向 (Orientation)",
        "极化 (Polarisation)",
        "孔隙率 (Porosity)",
        "位置 (Position)",
        "功率 (Power)",
        "压力 (Pressure)",
        "纯度 (Purity)",
        "反射率 (Reflectivity)",
        "刚度 (Rigidity)",
        "形状 (Shape)",
        "声音 (Sound)",
        "速度 (Speed)",
        "强度 (Strength)",
        "表面积 (Surface Area)",
        "表面处理 (Surface Finish)",
        "温度 (Temperature)",
        "时间 (Time)",
        "半透明性 (Translucency)",
        "振动 (Vibration)",
        "粘度 (Viscosity)",
        "体积 (Volume)",
        "重量 (Weight)"
      ]},
    ],
    ["转换", "选择一种你要转换的能量类型和你想要转换成为的能量类型,然后点击提交查询按钮。", ["转换前类型","转换后类型"], {
      "转换前类型" : [
        "声学 (Acoustic)",
        "化学 (Chemical)",
        "电学 (Electrical)",
        "电磁 (Electromagnetic)",
        "动能 (Kinetic)",
        "磁学 (Magnetic)",
        "机械 (Mechanical)",
        "光学 (Optical)",
        "热力学 (Thermal)"
      ],
      "转换后类型": [
        "声学 (Acoustic)",
        "化学 (Chemical)",
        "电学 (Electrical)",
        "电磁 (Electromagnetic)",
        "动能 (Kinetic)",
        "磁学 (Magnetic)",
        "机械 (Mechanical)",
        "光学 (Optical)",
        "热力学 (Thermal)"
      ],}
    ],
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "科学原理数据库"
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "选择你要查询的科学效应类型:",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            SizedBox(height: 20,),
            // 选择搜索方式
            Wrap (
              // direction: MediaQuery.of(context).size.width < 500 ? Axis.vertical : Axis.horizontal,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOptions(0, "功能"),
                    Text("例如：移动 液体"),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOptions(1, "参数"),
                    Text("例如：增加 温度"),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOptions(2, "转换"),
                    Text("例如：机械能 转换为 动能"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildOptions(int index, String title) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SearchPage(
            title: searchPageData[index][0] as String,
            prompt: searchPageData[index][1] as String,
            options: searchPageData[index][2] as List<String>,
            choices: searchPageData[index][3] as Map<String, List<String>>,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.width < 600 ? 1 : 4),
        height: MediaQuery.of(context).size.height / 8,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
