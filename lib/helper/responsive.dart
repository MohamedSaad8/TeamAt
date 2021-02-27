import 'package:flutter/material.dart';

class Responsive {
  bool isPhone;
  bool isTablet;

  double width;
// Size of Fonts
  double h1 = 20;
  double h2 = 16;
  double t1 = 13;
  double t2 = 10;

  Responsive(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    isPhone = width >= 375.0 && width < 768;
    isTablet = width >= 768.0;
  }

// set width And height
  double setWidth(double size) {
    if (isPhone) {
      //   print('from phone');

      if (width < 480) {
// Portable phones here
        //     print('Portable Mode');

        return size * 2;
      } else {
// landscape phones here
        //   print('LandScape Mode');

        return size * 3;
      }
    } else if (isTablet) {
      print('from tablet');

      if (width < 992) {
// Portable phones here
        print('Portable Mode');
        return size * 3.5;
      } else {
// landscape phones here
        print('LandScape Mode');
        return size * 4.5;
      }
    }
  }

  double setHeight(double size) {
    if (isPhone) {
      //  print('from phone');

      if (width < 480) {
// Portable phones here
        //       print('Portable Mode');

        return size * 2;
      } else {
// landscape phones here
        //    print('LandScape Mode');

        return size * 2.5;
      }
    } else if (isTablet) {
      print('from tablet');

      if (width < 992) {
// Portable Tablet here
        print('Portable Mode');
        return size * 4;
      } else {
// landscape Tablet here
        print('LandScape Mode');
        return size * 5;
      }
    }
  }

// set fontsize
  double setFontSize(String type) {
    switch (type) {
      case 'h1':
        return _getFontSize(h1);
        break;
      case 'h2':
        return _getFontSize(h2);
        break;
      case 't1':
        return _getFontSize(t1);
        break;
      case 't2':
        return _getFontSize(t2);
        break;
      default:
        return 4;
        break;
    }
    return 0;
  }

  double _getFontSize(double size) {
    if (isPhone) {
      //    print('from phone');

      if (width < 480) {
// Portable phones here


        return size * 1.3;
      } else {
// landscape phones here
        return size * 1.5;
      }
    } else if (isTablet) {
      print('from tablet');

      if (width < 992) {
// Portable phones here
        print('Portable Mode');
        return size * 2.5;
      } else {
// landscape phones here
        print('LandScape Mode');
        return size * 3;
      }
    }
  }

// set margin And padding
  double setPadding(double size) {
    if (isPhone) {
      //     print('from phone');

      if (width < 480) {
// Portable phones here
        //     print('Portable Mode');

        return size * 2;
      } else {
// landscape phones here
        //    print('LandScape Mode');

        return size * 3.4;
      }
    } else if (isTablet) {
      print('from tablet');

      if (width < 992) {
// Portable Tablet here
        print('Portable Mode');
        return size * 4;
      } else {
// landscape Tablet here
        print('LandScape Mode');
        return size * 5;
      }
    }
  }

  double setMargin(double size) {
    if (isPhone) {
      //   print('from phone');

      if (width < 480) {
// Portable phones here
//        print('Portable Mode');

        return size * 2;
      } else {
// landscape phones here
        //     print('LandScape Mode');

        return size * 3.4;
      }
    } else if (isTablet) {
      print('from tablet');

      if (width < 992) {
// Portable Tablet here
        print('Portable Mode');
        return size * 4;
      } else {
// landscape Tablet here
        print('LandScape Mode');
        return size * 5;
      }
    }
  }
}