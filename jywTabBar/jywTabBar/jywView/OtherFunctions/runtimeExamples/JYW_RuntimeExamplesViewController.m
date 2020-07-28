//
//  JYW_RuntimeExamplesViewController.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/15.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_RuntimeExamplesViewController.h"
#import "JYW_RuntimeExamplesModel.h"
#import <objc/runtime.h>
#import <objc/message.h>
static NSString *CellTableIndentifier = @"CellTableIdentifier";
@interface JYW_RuntimeExamplesViewController ()<JYW_RuntimeExamplesModel_delegate>
{
    NSArray *tableGroup;
    NSArray *tableDSArray;
    NSArray *subtitleArray;
}
@end

@implementation JYW_RuntimeExamplesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableGroup=@[
        @"Working with Classes",
        @"Adding Classes(添加类)",
        @"Instantiating Classes(实例化类)",
        @"Working with Instances(使用实例)",
        @"Obtaining Class Definitions(获取类定义)",
        @"Working with Instance Variables(使用实例变量)",
        @"Associative References(关联参考)",
        @"Sending Messages(消息发送)",
        @"Working with Methods(使用方法)",
        @"Working with Libraries(使用类库)",
        @"Working with Selectors(使用选择器)",
        @"Working with Protocols(使用协议)",
        @"Working with Properties(使用属性)",
        @"Using Objective-C Language Features(使用Objective-C语言功能)"
    ];
    tableDSArray=@[
    @[@"class_getName",
      @"class_getSuperclass",
      @"class_isMetaClass",
      @"class_getInstanceSize",
      @"class_getInstanceVariable",
      @"class_getClassVariable",
      @"class_addIvar",
      @"class_copyIvarList",
      @"class_getIvarLayout",
      @"class_getWeakIvarLayout",
      @"class_setWeakIvarLayout",
      @"class_setIvarLayout",
      @"class_getProperty",
      @"class_copyPropertyList",
      @"class_addMethod",
      @"class_getInstanceMethod",
      @"class_getClassMethod",
      @"class_copyMethodList",
      @"class_replaceMethod",
      @"class_getMethodImplementation",
      @"class_getMethodImplementation_stret",
      @"class_respondsToSelector",
      @"class_addProtocol",
      @"class_addProperty",
      @"class_replaceProperty",
      @"class_conformsToProtocol",
      @"class_copyProtocolList",
      @"class_getVersion",
      @"class_setVersion",
    ],
    @[@"objc_allocateClassPair"],
    @[@"class_createInstance",
      @"objc_constructInstance",],
    @[@"自动引用计数下不可用"],
    @[@"objc_getClassList",
      @"objc_copyClassList",
      @"objc_lookUpClass",
      @"objc_getClass",
      @"objc_getRequiredClass",
      @"objc_getMetaClass"],
    @[@"ivar_getName",
      @"ivar_getTypeEncoding",
      @"ivar_getOffset"],
    @[@"objc_setAssociatedObject"],
    @[@"objc_msgSend",
      @"objc_msgSend_fpret"],
    @[@"method_invoke",
      @"method_getName",
      @"method_getImplementation",
      @"method_getTypeEncoding",
      @"method_copyReturnType",
      @"method_copyArgumentType",
      @"method_getReturnType",
      @"method_getNumberOfArguments",
      @"method_getArgumentType",
      @"method_getDescription",
      @"method_setImplementation",
      @"method_exchangeImplementations"],
    @[@"objc_copyImageNames",
      @"class_getImageName",
      @"objc_copyClassNamesForImage"],
    @[@"sel_getName",
      @"sel_registerName",
      @"sel_getUid",
      @"sel_isEqual"],
    @[@"objc_getProtocol",
      @"objc_copyProtocolList",
      @"objc_allocateProtocol",
      @"protocol_addMethodDescription"],
    @[@"property_getName",
      @"property_getAttributes",
      @"property_copyAttributeValue",
      @"property_copyAttributeList"],
    @[@"",
      @"imp_implementationWithBlock",
      @"imp_getBlock",
    ],
    ];
    subtitleArray=@[
    @[@"获取类名",
      @"获取父类",
      @"返回一个布尔值，该值指示类对象是否为元类",
      @"获取实例的大小",
      @"返回给定类的指定实例变量的Ivar",
      @"返回给定类的指定类变量的Ivar",
      @"将新的实例变量添加到类",
      @"描述由类声明的实例变量",
      @"返回给定类的Ivar布局的描述",
      @"返回给定类的弱Ivar布局的描述",
      @"设置给定类的弱Ivar的布局",
      @"设置给定类的Ivar布局。",
      @"返回具有给定类的给定名称的属性。",
      @"返回描述类声明的属性",
      @"向具有给定名称和实现的类中添加新方法。",
      @"返回给定类的指定实例方法。",
      @"返回一个指向描述给定类的给定类方法的数据结构的指针。",
      @"描述由类实现的实例方法。",
      @"替换给定类的方法的实现。",
      @"返回将特定消息发送到类的实例时将调用的函数指针。",
      @"返回将特定消息发送到类的实例时将调用的函数指针。",
      @"返回一个布尔值，该值指示类的实例是否响应特定的选择器。",
      @"给类添加协议",
      @"给类添加属性",
      @"替换类的属性。",
      @"返回一个布尔值，该值指示类是否符合给定的协议。",
      @"描述类采用的协议。",
      @"获取类的版本号",
      @"设置类的版本号"
    ],
    @[@"创建一个新的类和元类,并注册、销毁。"],
    @[@"创建一个类的实例，在默认的malloc内存区域中为该类分配内存。",
      @"在指定位置创建类的实例。"],
    @[@"自动引用计数下不可用"],
    @[@"获取注册的类定义列表。",
      @"创建并返回指向所有已注册类定义的指针的列表。",
      @"返回指定类的类定义。",
      @"返回指定类的类定义。",
      @"返回指定类的类定义。",
      @"返回指定类的元类定义。"],
    @[@"返回实例变量的名称。",
      @"返回实例变量的类型字符串。",
      @"返回实例变量的偏移量。"],
    @[@"使用给定的键和关联策略为给定的对象设置关联的值。"],
    @[@"将带有简单返回值的消息发送到类的实例。",
      @"将带有浮点返回值的消息发送到类的实例。"],
    @[@"调用指定方法的实现。",
      @"返回方法的名称。",
      @"返回方法的实现。",
      @"返回描述方法参数和返回类型的字符串。",
      @"返回描述方法返回类型的字符串。",
      @"返回描述方法的单个参数类型的字符串。",
      @"通过引用返回描述方法返回类型的字符串。",
      @"返回方法接受的参数数量。",
      @"通过引用返回描述方法的单个参数类型的字符串。",
      @"返回指定方法的方法描述结构。",
      @"设置方法的实现。",
      @"交换两种方法的实现。"],
    @[@"返回所有已加载的Objective-C框架和动态库的名称。",
      @"返回类所属的动态库的名称。",
      @"返回指定库或框架中所有类的名称。"],
    @[@"返回给定选择器指定的方法的名称。",
      @"在Objective-C运行时系统中注册方法，将方法名称映射到选择器，然后返回选择器值。",
      @"在Objective-C运行时系统中注册方法名称。",
      @"返回一个布尔值，该值指示两个选择器是否相等。"],
    @[@"返回指定的协议。",
      @"返回运行时已知的所有协议的数组。",
      @"创建一个新的协议实例。",
      @"协议注册前，给协议添加方法描述"],
    @[@"返回属性名称",
      @"返回属性的属性字符串。",
      @"返回给定属性名称的属性属性的值。",
      @"返回给定属性的属性属性数组。"],
    @[@"",
      @"创建一个指向在调用方法时调用指定块的函数的指针。",
      @"返回与使用imp_implementationWithBlock创建的IMP关联的块。",
    ],
    ];
}
#pragma mark -Working with Classes
//class_getName，获取类名
-(void)class_getName{
    //获取父类
    Class superClass=class_getSuperclass([self class]);
    //获取父类的名称
    const char *superClassName=class_getName(superClass);
    messageTextView.text=[NSString stringWithFormat:@"class_getName(获取类名):%s",superClassName];
}
//class_getSuperclass，获取父类
-(void)class_getSuperClass{
    //获取父类
    Class superClass=class_getSuperclass([self class]);
    //获取父类的名称
    const char *superClassName=class_getName(superClass);
    messageTextView.text=[NSString stringWithFormat:@"class_getSuperclass(获取父类):%s",superClassName];
}
//class_isMetaClass(返回一个布尔值，该值指示类对象是否为元类。)
-(void)class_isMetaClass{
    //获取父类
    Class superClass=class_getSuperclass([self class]);
    BOOL superIsMeta=class_isMetaClass(superClass);
    BOOL selfIsMeta=class_isMetaClass([self class]);
    messageTextView.text=[NSString stringWithFormat:@"返回一个布尔值，该值指示类对象是否为元类。superClass:%d,selfClass:%d",superIsMeta,selfIsMeta];
}
//class_getInstanceSize(获取实例的大小)
-(void)class_getInstanceSize{
    size_t st=class_getInstanceSize([self class]);
    messageTextView.text=[NSString stringWithFormat:@"获取实例的大小：%zu",st];
}
//class_getInstanceVariable(返回给定类的指定实例变量的Ivar。)
-(void)class_getInstanceVariable{
    Ivar ivar=class_getInstanceVariable([self class], "messageTextView");
    const char *name=ivar_getName(ivar);
    const char *type=ivar_getTypeEncoding(ivar);
    messageTextView.text=[NSString stringWithFormat:@"返回给定类的指定实例变量的Ivar，成员变量名：%s,成员变量类型：%s",name,type];
}
//class_getClassVariable(返回给定类的指定类变量的Ivar)
-(void)class_getClassVariable{
    Ivar ivar=class_getClassVariable([JYW_RuntimeExamplesModel class], "_value1");
    const char *name=ivar_getName(ivar);
    const char *type=ivar_getTypeEncoding(ivar);
    messageTextView.text=[NSString stringWithFormat:@"返回给定类的指定类变量的Ivar，成员变量名：%s,成员变量类型：%s",name,type];
}
//class_addIvar(将新的实例变量添加到类)
//转载：http://www.360doc.com/content/18/0719/18/9200790_771725635.shtml
-(void)class_addIvar{
    BOOL isSuccess=class_addIvar([self class], [@"value1" UTF8String], sizeof(id), log2(sizeof(id)), "@");
    Ivar ivar=class_getInstanceVariable([self class], "value1");
    const char *name=ivar_getName(ivar);
    const char *type=ivar_getTypeEncoding(ivar);
    messageTextView.text=[NSString stringWithFormat:@"将新的实例变量添加到类，新增成员变量名：%s,新增成员变量类型：%s",name,type];
}
//class_copyIvarList(描述由类声明的实例变量。)
-(void)class_copyIvarList{
    unsigned int ivarCount = 0;
    Ivar *ivarList=class_copyIvarList([self class], &ivarCount);
    NSString *str=@"";
    for(unsigned int i=0;i<ivarCount;i++){
        str=[NSString stringWithFormat:@"%@;描述由类声明的实例变量，新增成员变量名：%s",str,ivar_getName(*(ivarList+i))];
    }
    messageTextView.text=str;
}
//class_getIvarLayout(返回给定类的Ivar布局的描述。)
//转载：https://www.jianshu.com/p/61b5ae4c4351
-(void)class_getIvarLayout{
    const uint8_t *layout=class_getIvarLayout([self class]);
    messageTextView.text=[NSString stringWithFormat:@"返回给定类的Ivar布局的描述:%s",layout];
}
//class_getWeakIvarLayout(返回给定类的弱Ivar布局的描述)
-(void)class_getWeakIvarLayout{
    const uint8_t *layout=class_getWeakIvarLayout([self class]);
    messageTextView.text=[NSString stringWithFormat:@"返回给定类的弱Ivar布局的描述:%s",layout];
}
//class_setWeakIvarLayout(设置给定类的弱Ivar的布局。)
//转载：https://www.cnblogs.com/uncle4/p/5547285.html
-(void)class_setWeakIvarLayout{
    
}
//class_setIvarLayout(设置给定类的Ivar布局。)
-(void)class_setIvarLayout{
    
}
//class_getProperty(返回给定类的给定名称的属性。)
-(void)class_getProperty{
    objc_property_t p=class_getProperty([self class], "jyw_acceptEventInterval");
    messageTextView.text=[NSString stringWithFormat:@"返回给定类的给定名称的属性，属性名：%s，属性：%s",property_getName(p),property_getAttributes(p)];
}
//class_copyPropertyList(描述类声明的属性。)
-(void)class_copyPropertyList{
    unsigned int outCount=0;
    objc_property_t *p=class_copyPropertyList([self class], &outCount);
    NSString *outputStr=@"";
    for(unsigned int i=0;i<outCount;i++){
        
        //outputStr=[NSString stringWithFormat:@"%@;返回描述类声明的属性：%s",outputStr,property_getName(*(p+1))];
        objc_property_t pt=p[i];
        outputStr=[NSString stringWithFormat:@"%@;返回描述类声明的属性：%s",outputStr,property_getName(pt)];
    }
    messageTextView.text=outputStr;
}
//class_addMethod(向具有给定名称和实现的类中添加新方法。)
//转载：https://www.jianshu.com/p/0041254cf72c
//转载：https://blog.csdn.net/qq_34900204/article/details/75105026
-(void)class_addMethod{
    JYW_RuntimeExamplesModel *rem=[[JYW_RuntimeExamplesModel alloc] init];
    class_addMethod([rem class], @selector(alertMessage:), class_getMethodImplementation([self class],@selector(alertMessage:)), "V@:*");
    //Method exchangeM = class_getInstanceMethod([self class], @selector(alertMessage:));
    //class_addMethod([self class], @selector(alertMessage:), class_getMethodImplementation([self class], @selector(alertMessage:)),method_getTypeEncoding(exchangeM));
    
    [rem performSelector:@selector(alertMessage:) withObject:@"向具有给定名称和实现的类中添加新方法"];
}
//class_getInstanceMethod(返回给定类的指定实例方法。返回类的对象方法，-(void))
-(void)class_getInstanceMethod{
    JYW_RuntimeExamplesModel *rem=[[JYW_RuntimeExamplesModel alloc] init];
    
    Method m=class_getInstanceMethod([rem class], @selector(alertMessage:));
    const char *codeChar=method_getTypeEncoding(m);
    messageTextView.text=[NSString stringWithFormat:@"返回给定类的指定实例方法:%s",codeChar];
}
//class_getClassMethod(返回一个指向描述给定类的给定类方法的数据结构的指针,返回类的类对象+(void))
//转载:https://blog.csdn.net/baidu_25743639/article/details/51793764
-(void)class_getClassMethod{
    //JYW_RuntimeExamplesModel *rem=[[JYW_RuntimeExamplesModel alloc] init];
    Method m=class_getClassMethod([JYW_RuntimeExamplesModel class], @selector(alertMessage:));
    const char *codeChar=method_getTypeEncoding(m);
    messageTextView.text=[NSString stringWithFormat:@"返回一个指向描述给定类的给定类方法的数据结构的指针:%s",codeChar];
}
//class_copyMethodList(描述由类实现的实例方法。)
//转载：https://www.jianshu.com/p/b30c2580d977
-(void)class_copyMethodList{
    unsigned int outCount=0;
    Method *methodList=class_copyMethodList([JYW_RuntimeExamplesModel class], &outCount);
    NSString *messageStr=@"";
    for(unsigned int i=0;i<outCount;i++){
        messageStr=[NSString stringWithFormat:@"%@;描述由类实现的实例方法:%s",messageStr,sel_getName(method_getName(methodList[i]))];
    }
    messageTextView.text=messageStr;
}
//class_replaceMethod(替换给定类的方法的实现。)
//转载：https://www.jianshu.com/p/799eda6750d7
//转载：https://www.jianshu.com/p/ab966e8a82e2
-(void)class_replaceMethod{
    //class_addMethod([self class], @selector(jh_alertMessage:), class_getMethodImplementation([self class],@selector(jh_alertMessage:)), "V@:*");
    Method m=class_getInstanceMethod([self class], @selector(jh_alertMessage:));
    class_replaceMethod([self class], @selector(alertMessage:), method_getImplementation(m), method_getTypeEncoding(m));
    [self alertMessage:@"替换给定类的方法的实现"];
}
//class_getMethodImplementation(返回将特定消息发送到类的实例时将调用的函数指针。)
-(void)class_getMethodImplementation{
    IMP imp=class_getMethodImplementation([JYW_RuntimeExamplesModel class], @selector(alertMessage:));
}
//class_getMethodImplementation_stret(返回将特定消息发送到类的实例时将调用的函数指针。)
-(void)class_getMethodImplementation_stret{
    IMP imp=class_getMethodImplementation_stret([JYW_RuntimeExamplesModel class], @selector(alertMessage:));
}
//class_respondsToSelector(返回一个布尔值，该值指示类的实例是否响应特定的选择器。)
-(void)class_respondsToSelector{
    JYW_RuntimeExamplesModel *rem=[[JYW_RuntimeExamplesModel alloc] init];
    BOOL isOrNo1=class_respondsToSelector([rem class], @selector(alertMessage1:));
    BOOL isOrNo2=class_respondsToSelector([JYW_RuntimeExamplesModel class], @selector(alertMessage:));
    messageTextView.text=[NSString stringWithFormat:@"返回一个布尔值，该值指示类的实例是否响应特定的选择器。类的实例：%d,类对象：%d",isOrNo1,isOrNo2];
}
//class_addProtocol(给类添加协议)
-(void)class_addProtocol{
    //BOOL isOrNo=class_addProtocol([self class], nil);
}
//class_addProperty(给类添加属性)
//Type Encodeings:https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
//转载：https://www.jianshu.com/p/819fed534eff
//转载：https://blog.csdn.net/meegomeego/article/details/18356169
-(void)class_addProperty{
    objc_property_attribute_t aType={"T","@\"NSString\""};
    objc_property_attribute_t aOwnerShip={"&",""};
    objc_property_attribute_t aBackingivar={"V", "_addProperty_Name"};
    objc_property_attribute_t attrs[]={aType,aOwnerShip,aBackingivar};
    class_addProperty([self class], "addProperty_Name", attrs, 3);
    objc_property_t pt=class_getProperty([self class], "addProperty_Name");
    objc_property_t pt1=class_getProperty([self class], "value1");
    messageTextView.text=[NSString stringWithFormat:@"给类添加属性，动态添加的：%s,原有的：%s",property_getAttributes(pt),property_getAttributes(pt1)];
}
//class_replaceProperty(替换类的属性的属性。)
-(void)class_replaceProperty{
    NSString *messageStr=@"";
    objc_property_t p1=class_getProperty([self class], "value1");
    messageStr=[NSString stringWithFormat:@"替换类的属性,替换前属性：%s",property_getAttributes(p1)];
    objc_property_attribute_t aType={"T","@\"NSString\""};
    objc_property_attribute_t aOwnerShip={"C",""};
    objc_property_attribute_t aBackingivar={"V", "_addProperty_Name"};
    objc_property_attribute_t attrs[]={aType,aOwnerShip,aBackingivar};
    //class_addProperty([self class], "addProperty_Name", attrs, 3);
    
    unsigned int attributeCount=3;
    class_replaceProperty([self class], "value1", attrs, attributeCount);
    //objc_property_t pv=class_getProperty([self class], "value1");
    messageStr=[NSString stringWithFormat:@"%@,替换后属性：%s",messageStr,property_getAttributes(p1)];
    messageTextView.text=messageStr;
}
//class_conformsToProtocol(返回一个布尔值，该值指示类是否符合给定的协议。)
-(void)class_conformsToProtocol{
    BOOL isOrYes=class_conformsToProtocol([self class], @protocol(JYW_RuntimeExamplesModel_delegate));
    messageTextView.text=[NSString stringWithFormat:@"返回一个布尔值，该值指示类是否符合给定的协议,判断是否实现JYW_RuntimeExamplesModel_delegate：%d",isOrYes];
}
//class_copyProtocolList(描述类采用的协议。)
-(void)class_copyProtocolList{
    unsigned int outCount=0;
    __unsafe_unretained Protocol ** p=class_copyProtocolList([self class], &outCount);
    NSString *protocalStr=@"描述类采用的协议,";
    for(unsigned int i=0;i<outCount;i++)
    {
        Protocol *protocal = p[i];
        protocalStr=[NSString stringWithFormat:@"%@%s,",protocalStr,protocol_getName(protocal)];
        //        const char *pName = protocol_getName(protocal);
        //        NSLog(@"protocol[%d] ---- %@", i, [NSString stringWithUTF8String:pName]);
    }
    messageTextView.text=protocalStr;
}
//class_getVersion(获取类的版本号)
-(void)class_getVersion{
    int v=class_getVersion([self class]);
    messageTextView.text=[NSString stringWithFormat:@"获取类的版本号:%d",v];
}
//class_setVersion(设置类的版本号)
-(void)class_setVersion{
    class_setVersion([self class], 1);
    int v=class_getVersion([self class]);
    messageTextView.text=[NSString stringWithFormat:@"设置类的版本号:%d",v];
}
//objc_getFutureClass()
-(void)objc_getFutureClass{
    
}
-(void)alertMessage:(NSString *)message{
    NSLog(@"1:%@",message);
}
-(void)jh_alertMessage:(NSString *)message{
    NSLog(@"2:%@",message);
}

#pragma mark -Add Classes(添加类)
//objc_allocateClassPair(创建一个新的类和元类,并注册、销毁。)
-(void)objc_allocateClassPair{
    Class superClass=[NSObject class];
    Class newClass=objc_allocateClassPair(superClass, "newClass", 0);
    IMP imp=class_getMethodImplementation([self class], @selector(alertMessage:));
    class_addMethod(newClass, @selector(alertMessage:), imp, "V@:*");
    //注册类和元类
    objc_registerClassPair(newClass);
    id newId=[[newClass alloc] init];
    [newId performSelector:@selector(alertMessage:) withObject:@"创建一个新的类和元类"];
    //销毁动态添加的类和元类
    objc_disposeClassPair(newClass);
}

#pragma mark -Instantiating Classes(注册类)
//class_createInstance(创建一个类的实例，在默认的malloc内存区域中为该类分配内存。)
-(void)class_createInstance{
    id cI=class_createInstance([JYW_RuntimeExamplesModel class], 0);
    [cI alertMessage1:@"注册类,调用alertMessage"];
    //自动引用计数下，销毁不可用
    //objc_destructInstance(cI);
}
//objc_constructInstance(在指定位置创建类的实例。)
-(void)objc_constructInstance{
    //自动引用计数下不可用
    //id cI=objc_constructInstance([JYW_RuntimeExamplesModel class],0);
    messageTextView.text=@"创建类：objc_constructInstance在自动引用计数下不可用，可以使用class_createInstance";
}

#pragma mark -Working with Instances(使用实例)
//自动引用计数下不可用

#pragma mark -Obtaining Class Definitions(获取类定义)
//objc_getClassList(获取注册的类定义列表。)
//转载：https://www.jianshu.com/p/bf6c81fc2434
-(void)objc_getClassList{
    int numClasses = 0, newNumClasses = objc_getClassList(NULL, 0); // 1
    Class *classes = NULL; // 2
    while (numClasses < newNumClasses) { // 3
        numClasses = newNumClasses; // 4
        classes = (Class *)realloc(classes, sizeof(Class) * numClasses); // 5
        newNumClasses = objc_getClassList(classes, numClasses); // 6
        
        for (int i = 0; i < numClasses; i++) { // 7
            const char *className = class_getName(classes[i]); // 8
            NSLog(@"%s", className); // 9
        } // 10
        
    } // 11
    free(classes); // 12
    /*
     第1行代码中的 objc_getClassList 函数是为了获取到当前注册的所有类的总个数 newNumClasses
     第5行代码是根据 newNumClasses 调整数组 classes 的空间
     第6行代码是向已分配好内存空间的数组 classes 中存放元素
     第7-10行代码是用 class_getName 函数获取每个类的名称
     */
}
//objc_copyClassList(创建并返回指向所有已注册类定义的指针的列表。)
-(void)objc_copyClassList{
    unsigned int outCount;
    Class *classes = objc_copyClassList(&outCount);
    for (int i = 0; i < outCount; i++) {
        NSLog(@"%s", class_getName(classes[i]));
    }
    free(classes);
}
//objc_lookUpClass(返回指定类的类定义。)
-(void)objc_lookUpClass{
    Class c=objc_lookUpClass("New_JYW_RuntimeExamplesModel");
    if(c==nil)
    {
        Class superClass=[NSObject class];
        Class newClass=objc_allocateClassPair(superClass, "New_JYW_RuntimeExamplesModel", 0);
        IMP imp=class_getMethodImplementation([self class], @selector(alertMessage:));
        class_addMethod(newClass, @selector(alertMessage:), imp, "V@:*");
        //注册类和元类
        objc_registerClassPair(newClass);
        id newId=[[newClass alloc] init];
        [newId performSelector:@selector(alertMessage:) withObject:@"返回指定类的类定义,如果没找到创建新类，"];
        //销毁动态添加的类和元类
        //objc_disposeClassPair(newClass);
    }
    else
    {
        id newId=[[c alloc] init];
        [newId performSelector:@selector(alertMessage:) withObject:@"返回指定类的类定义,找到后，调用添加的方法。"];
    }
}
//objc_getClass(返回指定类的类定义。)
-(void)objc_getClass{
    id c=objc_getClass("New_JYW_RuntimeExamplesModel");
    if(c==nil){
        Class superClass=[NSObject class];
        Class newClass=objc_allocateClassPair(superClass, "New_JYW_RuntimeExamplesModel", 0);
        IMP imp=class_getMethodImplementation([self class], @selector(alertMessage:));
        class_addMethod(newClass, @selector(alertMessage:), imp, "V@:*");
        //注册类和元类
        objc_registerClassPair(newClass);
        id newId=[[newClass alloc] init];
        [newId performSelector:@selector(alertMessage:) withObject:@"返回指定类的类定义,如果没找到创建新类，"];
    }
    else{
        id newId=[[c alloc] init];
        [newId performSelector:@selector(alertMessage:) withObject:@"返回指定类的类定义,找到后，调用添加的方法。"];
    }
}
//objc_getRequiredClass(返回指定类的类定义。)
//此函数与objc_getClass相同，但是如果找不到该类，则将终止该进程
-(void)objc_getRequiredClass{
    Class c=objc_getClass("New_JYW_RuntimeExamplesModel");
    if(c==nil){
        Class superClass=[NSObject class];
        Class newClass=objc_allocateClassPair(superClass, "New_JYW_RuntimeExamplesModel", 0);
        IMP imp=class_getMethodImplementation([self class], @selector(alertMessage:));
        class_addMethod(newClass, @selector(alertMessage:), imp, "V@:*");
        //注册类和元类
        objc_registerClassPair(newClass);
        id newId=[[newClass alloc] init];
        [newId performSelector:@selector(alertMessage:) withObject:@"返回指定类的类定义,如果没找到创建新类，"];
    }
    else{
        id newId=[[c alloc] init];
        [newId performSelector:@selector(alertMessage:) withObject:@"返回指定类的类定义,找到后，调用添加的方法。"];
    }
}
//objc_getMetaClass(返回指定类的元类定义。)
//命名类的元类的Class对象，如果未在Objective-C运行时中注册该类，则为nil。
-(void)objc_getMetaClass{
    id c=objc_getMetaClass("JYW_RuntimeExamplesModel");
    NSLog(@"%p",c);
    if(c==nil){
           Class superClass=[NSObject class];
           Class newClass=objc_allocateClassPair(superClass, "New_JYW_RuntimeExamplesModel", 0);
           IMP imp=class_getMethodImplementation([self class], @selector(alertMessage:));
           class_addMethod(newClass, @selector(alertMessage:), imp, "V@:*");
           //注册类和元类
           objc_registerClassPair(newClass);
           id newId=[[newClass alloc] init];
           [newId performSelector:@selector(alertMessage:) withObject:@"返回指定类的类定义,如果没找到创建新类，"];
       }
       else{
           //id newId=[[c alloc] init];
           //[c alertMessage1:@"返回指定类的类定义,找到后，调用添加的方法。"];
           //[c performSelector:@selector(alertMessage:) withObject:@"返回指定类的类定义,找到后，调用添加的方法。"];
       }
}

#pragma mark -Working with Instance Variables(使用实例变量)
//ivar_getName(返回实例变量的名称。)
-(void)ivar_getName{
    unsigned int outCount=0;
    //描述由类声明的实例变量
    Ivar *ivarList=class_copyIvarList([self class], &outCount);
    NSString *messageStr=@"返回实例变量的名称。";
    for(unsigned int i=0;i<outCount;i++)
    {
        Ivar ivar=ivarList[i];
        messageStr=[messageStr stringByAppendingFormat:@"实例变量名：%s;",ivar_getName(ivar)];
    }
    messageTextView.text=messageStr;
}
//ivar_getTypeEncoding(返回实例变量的类型字符串。)
-(void)ivar_getTypeEncoding{
    unsigned int outCount=0;
    Ivar *ivarList=class_copyIvarList([self class], &outCount);
    NSString *messageStr=@"返回实例变量的类型字符串。";
    for(unsigned int i=0;i<outCount;i++){
        Ivar ivar=ivarList[i];
        messageStr=[messageStr stringByAppendingFormat:@"类型字符串%s;",ivar_getTypeEncoding(ivar)];
    }
    messageTextView.text=messageStr;
}
//ivar_getOffset(返回实例变量的偏移量。)
-(void)ivar_getOffset{
    unsigned int outCount=0;
    Ivar *ivarList=class_copyIvarList([self class], &outCount);
    NSString *messageStr=@"返回实例变量的偏移量。";
    for(unsigned int i=0;i<outCount;i++){
        Ivar ivar=ivarList[i];
        messageStr=[messageStr stringByAppendingFormat:@"偏移量%td;",ivar_getOffset(ivar)];
    }
    messageTextView.text=messageStr;
}

#pragma mark -Associative References(关联参考)
//转载：https://www.cnblogs.com/someonelikeyou/p/7162613.html
//objc_setAssociatedObject(使用给定的键和关联策略为给定的对象设置关联的值。)
//8888155
static char glValue;
-(void)objc_setAssociatedObject{
    
    objc_setAssociatedObject(messageTextView, &glValue, @"关联数据", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self gl_alertMessage];
}
-(void)gl_alertMessage{
    NSString *glStr=objc_getAssociatedObject(messageTextView, &glValue);
    messageTextView.text=[NSString stringWithFormat:@"使用给定的键和关联策略为给定的对象设置关联的值。关联的值是：%@",glStr];
    objc_removeAssociatedObjects(self.value1);
}

#pragma mark -sending Messages(消息发送)
//objc_msgSend(将带有简单返回值的消息发送到类的实例。)
//转载：https://www.jianshu.com/p/e5aef096f967
//转载：https://www.jianshu.com/p/53edb8572df4
-(void)objc_msgSendE{
    /*
     此书写方式，需要设置build setting,Enable strict checking of objc_msgSend calls=NO,默认值是YES
     */
    SEL sel=@selector(alertMessage:);
    objc_msgSend(self,sel,@"消息发送");
    objc_msgSend([JYW_RuntimeExamplesModel new], sel_registerName("alertMessage1:"),@"消息发送JYW");
    //发送无参数无返回值消息
    ((void (*)(id,SEL))objc_msgSend)(self, @selector(alertMessageSend));
    //发送有参数无返回值消息
    int mStr=1;
    ((void (*)(id,SEL,int))objc_msgSend)(self, @selector(alertMessageSend1:),mStr);
    //发送无参数有返回值消息
    NSString *str=objc_msgSend(self, @selector(alertMessageSend2));
    //发送有参数有返回值得消息
    NSString *str1=objc_msgSend(self, @selector(alertMessageSend3:),@"参数1");
}
-(void)alertMessageSend{
    NSLog(@"发送消息，发送无参数无返回值消息。");
}
-(void)alertMessageSend1:(int)message{
    NSLog(@"发送消息，发送有参数无返回值消息。");
}
-(NSString *)alertMessageSend2{
    NSLog(@"发送消息，发送无参数有返回值消息。");
    return @"OK";
}
-(NSString *)alertMessageSend3:(NSString *)str{
    NSLog(@"发送消息，发送无参数有返回值消息。%@",str);
    return @"OK";
}
//objc_msgSend_fpret(将带有浮点返回值的消息发送到类的实例。)
-(void)objc_msgSend_fpret{
    float returnValue=objc_msgSend_fpret(self, @selector(alertMessageSend4));
    messageTextView.text=[NSString stringWithFormat:@"将带有浮点返回值的消息发送到类的实例,返回值：%f",returnValue];
}
-(float)alertMessageSend4{
    NSLog(@"发送消息，将带有浮点返回值的消息发送到类的实例。");
    return 13.1f;
}

#pragma mark -
//method_invoke(调用指定方法的实现)
//使用此函数调用方法的实现比调用method_getImplementation和method_getName更快。
//转载：https://www.yunyingxbs.com/article/detail/id/229.html
-(void)method_invoke{
    Method method=class_getInstanceMethod([self class], @selector(alertMessageInvoke:));
    NSString *returnStr=method_invoke(self, method,@"调用指定方法的实现");
}
-(NSString *)alertMessageInvoke:(NSString *)message{
    messageTextView.text=message;
    return @"OK";
}
//method_getName(返回方法的名称。)
-(void)method_getName{
    Method m=class_getInstanceMethod([self class], @selector(alertMessageInvoke:));
    SEL sel=method_getName(m);
    const char *mName=sel_getName(sel);
    messageTextView.text=[NSString stringWithFormat:@"返回方法的名称。%s",mName];
}
//method_getImplementation(返回方法的实现。)
-(void)method_getImplementation{
    Method m=class_getInstanceMethod([self class], @selector(alertMessageInvoke:));
    IMP imp=method_getImplementation(m);
    messageTextView.text=@"返回方法的实现。";
}
//method_getTypeEncoding(返回描述方法参数和返回类型的字符串。)
-(void)method_getTypeEncoding{
    Method m=class_getInstanceMethod([self class], @selector(alertMessageInvoke:));
    const char *te=method_getTypeEncoding(m);
    messageTextView.text=[NSString stringWithFormat:@"返回描述方法参数和返回类型的字符串。%s",te];
}
//method_copyReturnType(返回描述方法返回类型的字符串。)
-(void)method_copyReturnType{
    Method m=class_getInstanceMethod([self class], @selector(alertMessageInvoke:));
    char *te=method_copyReturnType(m);
    messageTextView.text=[NSString stringWithFormat:@"返回描述方法返回类型的字符串。%s",te];
}
//method_copyArgumentType(返回描述方法的单个参数类型的字符串。)
-(void)method_copyArgumentType{
    Method m=class_getInstanceMethod([self class], @selector(alertMessageInvoke:));
    char *te=method_copyArgumentType(m, 0);
    messageTextView.text=[NSString stringWithFormat:@"返回描述方法的单个参数类型的字符串。%s",te];
}
//method_getReturnType(通过引用返回描述方法返回类型的字符串。)
-(void)method_getReturnType{
    Method m=class_getInstanceMethod([self class], @selector(alertMessageInvoke:));
    char te[512]={};
    method_getReturnType(m, te, 512);
    messageTextView.text=[NSString stringWithFormat:@"通过引用返回描述方法返回类型的字符串。%s",te];
}
//method_getNumberOfArguments(返回方法接受的参数数量。)
-(void)method_getNumberOfArguments{
    Method m=class_getInstanceMethod([self class], @selector(alertMessageInvoke:));
    const int n=method_getNumberOfArguments(m);
    messageTextView.text=[NSString stringWithFormat:@"返回方法接受的参数数量。%d",n];
}
//method_getArgumentType(通过引用返回描述方法的单个参数类型的字符串。)
-(void)method_getArgumentType{
    Method m=class_getInstanceMethod([self class], @selector(alertMessageInvoke:));
    char dst[512]={};
    method_getArgumentType(m, 0, dst, 512);
    messageTextView.text=[NSString stringWithFormat:@"通过引用返回描述方法的单个参数类型的字符串。%s",dst];
}
//method_getDescription(返回指定方法的方法描述结构。)
-(void)method_getDescription{
    Method m=class_getInstanceMethod([self class], @selector(alertMessageInvoke:));
    struct objc_method_description *omd=method_getDescription(m);
    
    messageTextView.text=[NSString stringWithFormat:@"返回指定方法的方法描述结构。name:%s,types:%s",sel_getName(omd[0].name),omd[0].types];
}
//method_setImplementation(设置方法的实现。)
-(void)method_setImplementation{
    //[self alertMessageInvoke:@"设置方法的实现"];
    Method oldMethod = class_getInstanceMethod(NSClassFromString(@"JYW_RuntimeExamplesViewController"), @selector(alertMessageInvoke:));
    
    IMP old_imp = method_getImplementation(oldMethod);
    
    Method newMethod = class_getInstanceMethod(NSClassFromString(@"JYW_RuntimeExamplesViewController"), @selector(alertMessageSend3:));
    IMP new_imp=method_getImplementation(newMethod);
    
    method_setImplementation(oldMethod,new_imp);
    [self alertMessageInvoke:@"设置方法的实现"];
}
//method_exchangeImplementations(交换两种方法的实现。)
-(void)method_exchangeImplementations{
    Method oldMethod = class_getInstanceMethod([self class], @selector(alertMessageInvoke:));
    Method newMethod = class_getInstanceMethod([self class], @selector(alertMessageSend3:));
    method_exchangeImplementations(oldMethod, newMethod);
    [self alertMessageInvoke:@"设置方法的实现"];
}

#pragma mark -Working with Libraries
//objc_copyImageNames(返回所有已加载的Objective-C框架和动态库的名称。)
-(void)objc_copyImageNames{
    unsigned int outCount=0;
    const char * _Nonnull * nameArray=objc_copyImageNames(&outCount);
    NSString *messageStr=@"返回所有已加载的Objective-C框架和动态库的名称。";
    for(unsigned int i=0;i<outCount;i++)
    {
        const char *name=nameArray[i];
        messageStr=[messageStr stringByAppendingFormat:@"动态库：%s;",name];
    }
    messageTextView.text=messageStr;
}
//class_getImageName(返回类所属的动态库的名称。)
-(void)class_getImageName{
    const char * name=class_getImageName([self class]);
    messageTextView.text=[NSString stringWithFormat:@"返回类所属的动态库的名称。%s",name];
}
//objc_copyClassNamesForImage(返回指定库或框架中所有类的名称。)
-(void)objc_copyClassNamesForImage{
    unsigned int outCount=0;
    const char **nameArray=objc_copyClassNamesForImage(class_getImageName([self class]), &outCount);
    NSString *messageStr=@"返回指定库或框架中所有类的名称。";
    for(unsigned int i=0;i<outCount;i++){
        const char *name=nameArray[i];
        messageStr=[messageStr stringByAppendingFormat:@"类名称：%s;",name];
    }
    messageTextView.text=messageStr;
}

#pragma mark -Working with Selectors
//sel_getName(返回给定选择器指定的方法的名称。)
-(void)sel_getName{
    SEL sel=@selector(alertMessage:);
    const char *selName=sel_getName(sel);
    messageTextView.text=[NSString stringWithFormat:@"返回给定选择器指定的方法的名称。%s",selName];
}
//sel_registerName(在Objective-C运行时系统中注册方法，将方法名称映射到选择器，然后返回选择器值。)
-(void)sel_registerName{
    SEL sel=sel_registerName("alertMessage:");
    [self performSelector:sel withObject:@"在Objective-C运行时系统中注册方法，将方法名称映射到选择器，然后返回选择器值。"];
}
//sel_getUid(在Objective-C运行时系统中注册方法名称。)
-(void)sel_getUid{
    SEL sel=sel_getUid("alertMessage:");
    [self performSelector:sel withObject:@"在Objective-C运行时系统中注册方法，将方法名称映射到选择器，然后返回选择器值。"];
}
//sel_isEqual(返回一个布尔值，该值指示两个选择器是否相等。)
-(void)sel_isEqual{
    BOOL isEque=sel_isEqual(@selector(alertMessage:), @selector(alertMessage:));
    messageTextView.text=[NSString stringWithFormat:@"返回一个布尔值，该值指示两个选择器是否相等。是否相同：%d",isEque];
}

#pragma mark -Working with Protocol(使用协议)
//objc_getProtocol(返回指定的协议。)
-(void)objc_getProtocol{
    Protocol *p= objc_getProtocol("JYW_RuntimeExamplesModel_delegate");
    const char *pName=protocol_getName(p);
    messageTextView.text=[NSString stringWithFormat:@"返回指定的协议。协议名：%s",pName];
}
//objc_copyProtocolList(返回运行时已知的所有协议的数组。)
//__unsafe_unretained说明，转载：https://www.jianshu.com/p/bd6aa1e62717
-(void)objc_copyProtocolList{
    unsigned int outCount=0;
    __unsafe_unretained Protocol * _Nonnull * pArray= objc_copyProtocolList(&outCount);
    NSString *messageStr=@"返回运行时已知的所有协议的数组.";
    for(unsigned int i=0;i<outCount;i++){
        Protocol *p=pArray[i];
        messageStr=[messageStr stringByAppendingFormat:@"协议名称：%s；",protocol_getName(p)];
    }
    messageTextView.text=messageStr;
    free(pArray);
}
//objc_allocateProtocol(创建一个新的协议实例)
//必须先使用objc_registerProtocol函数注册返回的协议实例，然后才能使用它。
-(void)objc_allocateProtocol{
    Protocol *p=objc_allocateProtocol("New_JYW_RuntimeExamplesModel_delegate");
    
    //objc_registerProtocol(p);
}
//protocol_addMethodDescription(协议注册前，添加给协议添加方法)
-(void)protocol_addMethodDescription{
    
}

#pragma mark -Working with Property(使用属性)
//property_getName(返回属性名称)
-(void)property_getName{
    //获取类的属性
    unsigned int outCount=0;
    objc_property_t *propertyArray=class_copyPropertyList([self class], &outCount);
    NSString *messageStr=@"返回属性名称。";
    for(unsigned int i=0;i<outCount;i++){
        objc_property_t property=propertyArray[i];
        messageStr=[messageStr stringByAppendingFormat:@"属性名称：%s;",property_getName(property)];
    }
    messageTextView.text=messageStr;
}
//property_getAttributes(返回属性的属性字符串。)
-(void)property_getAttributes{
    //获取类的属性
    unsigned int outCount=0;
    objc_property_t *propertyArray=class_copyPropertyList([self class], &outCount);
    NSString *messageStr=@"返回属性的属性字符串。";
    for(unsigned int i=0;i<outCount;i++){
        objc_property_t property=propertyArray[i];
        messageStr=[messageStr stringByAppendingFormat:@"字符串名称：%s,属性字符串：%s;",property_getName(property),property_getAttributes(property)];
    }
    messageTextView.text=messageStr;
}
//property_copyAttributeValue(返回给定属性名称的属性属性的值。)
-(void)property_copyAttributeValue{
    //获取类的属性
    unsigned int outCount=0;
    objc_property_t *propertyArray=class_copyPropertyList([self class], &outCount);
    NSString *messageStr=@"返回给定属性名称的属性属性的值。";
    for(unsigned int i=0;i<outCount;i++){
        objc_property_t property=propertyArray[i];
        //获取属性类型
        const char *attributeValueT=property_copyAttributeValue(property,"T");
        //获取属性名
        const char *attributeValueV=property_copyAttributeValue(property,"V");
        messageStr=[messageStr stringByAppendingFormat:@"属性名称：%s,属性类型T：%s，属性名V:%s;",property_getName(property),attributeValueT,attributeValueV];
    }
    messageTextView.text=messageStr;
}
//property_copyAttributeList(返回给定属性的属性属性数组。)
-(void)property_copyAttributeList{
    //获取类的属性
    unsigned int outCount=0;
    objc_property_t *propertyArray=class_copyPropertyList([self class], &outCount);
    NSString *messageStr=@"返回给定属性的属性属性数组。";
    for(unsigned int i=0;i<outCount;i++){
        objc_property_t property=propertyArray[i];
        unsigned int outCount1=0;
        objc_property_attribute_t *attributeArray1= property_copyAttributeList(property, &outCount1);
        for(unsigned int j=0;j<outCount1;j++){
            objc_property_attribute_t attribute=attributeArray1[j];
            messageStr=[messageStr stringByAppendingFormat:@"属性名称：%s,属性名name：%s，属性值value:%s;",property_getName(property),attribute.name,attribute.value];
        }
        
    }
    messageTextView.text=messageStr;
}

#pragma mark -Using Objective-C Language Features(使用Objective-C语言功能)
//imp_implementationWithBlock(创建一个指向在调用方法时调用指定块的函数的指针。)
-(void)imp_implementationWithBlock{
    IMP myIMP = imp_implementationWithBlock(^(id _self, NSString *string) {
        self->messageTextView.text=[NSString stringWithFormat:@"创建一个指向在调用方法时调用指定块的函数的指针。参数：%@",string];
    });
    class_addMethod([self class], @selector(sayHello:), myIMP, "v@:@");
    [self performSelector:@selector(sayHello:) withObject:@"sayHello"];
}
//imp_getBlock(返回与使用imp_implementationWithBlock创建的IMP关联的块。)
-(void)imp_getBlock{
    IMP myIMP = imp_implementationWithBlock(^(id _self, NSString *string) {
        self->messageTextView.text=[NSString stringWithFormat:@"创建一个指向在调用方法时调用指定块的函数的指针。参数：%@",string];
    });
    id impId=imp_getBlock(myIMP);
}
#pragma mark -tableViewDelegate

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableGroup.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(16, 0, tableView.frame.size.width-32, 40)];
    titleLabel.text=tableGroup[section];
    titleLabel.textAlignment=NSTextAlignmentRight;
    titleLabel.font=[UIFont systemFontOfSize:14.0f];
    titleLabel.numberOfLines=0;
    [headerView addSubview:titleLabel];
    return headerView;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    footerView.backgroundColor=[UIColor blueColor];
    return footerView;
}
-(float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableDSArray[section] count];
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //单元格ID
    //重用单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIndentifier];
    //初始化单元格
    if(cell == nil)
    {
        /*
         UITableViewCellStyle:
         UITableViewCellStyleDefault
         具有文本标签（黑色和左对齐）和可选图像视图的单元格的简单样式。
         UITableViewCellStyleValue1
         单元格的样式，在单元格的左侧带有标签，带有左对齐和黑色文本； 右侧是带有较小蓝色文本并且右对齐的标签。 设置应用程序使用此样式的单元格。
         UITableViewCellStyleValue2
         单元格的样式，该单元格的左侧具有标签，标签的文本右对齐且为蓝色； 单元格右侧的另一个标签是较小的文本，该文本左对齐并且为黑色。 “电话/联系人”应用程序使用此样式的单元格。
         UITableViewCellStyleSubtitle
         单元格的样式，该单元格的顶部带有左对齐标签，而其下方则是带有较小灰色文本的左对齐标签。
         */
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIndentifier];
        //自带有两种基础的tableView样式，UITableViewCellStyleValue1、2. 后面的文章会讲解自定义样式
        /*
         accessoryType:
         UITableViewCellAccessoryNone、
         UITableViewCellAccessoryDisclosureIndicator、
         UITableViewCellAccessoryDetailDisclosureButton、
         UITableViewCellAccessoryCheckmark、
         UITableViewCellAccessoryDetailButton、
         */
        //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //UIImage *img = [UIImage imageNamed:@"group"];
    //cell.imageView.image = img;
    //添加图片
    cell.textLabel.text = [[tableDSArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [[subtitleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    //添加右侧注释
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    [self class_getName];
                    break;
                case 1:
                    [self class_getSuperClass];
                    break;
                case 2:
                    [self class_isMetaClass];
                    break;
                case 3:
                    [self class_getInstanceSize];
                    break;
                case 4:
                    [self class_getInstanceVariable];
                    break;
                case 5:
                    [self class_getClassVariable];
                    break;
                case 6:
                    [self class_addIvar];
                    break;
                case 7:
                    [self class_copyIvarList];
                    break;
                case 8:
                    [self class_getIvarLayout];
                    break;
                case 9:
                    [self class_getWeakIvarLayout];
                    break;
                case 10:
                    [self class_setWeakIvarLayout];
                    break;
                case 11:
                    [self class_setIvarLayout];
                    break;
                case 12:
                    [self class_getProperty];
                    break;
                case 13:
                    [self class_copyPropertyList];
                    break;
                case 14:
                    [self class_addMethod];
                    break;
                case 15:
                    [self class_getInstanceMethod];
                    break;
                case 16:
                    [self class_getClassMethod];
                    break;
                case 17:
                    [self class_copyMethodList];
                    break;
                case 18:
                    [self class_replaceMethod];
                    break;
                case 19:
                    [self class_getMethodImplementation];
                    break;
                case 20:
                    [self class_getMethodImplementation_stret];
                    break;
                case 21:
                    [self class_respondsToSelector];
                    break;
                case 22:
                    [self class_addProtocol];
                    break;
                case 23:
                    [self class_addProperty];
                    break;
                case 24:
                    [self class_replaceProperty];
                    break;
                case 25:
                    [self class_conformsToProtocol];
                    break;
                case 26:
                    [self class_copyProtocolList];
                    break;
                case 27:
                    [self class_getVersion];
                    break;
                case 28:
                    [self class_setVersion];
                    break;
                case 29:
                    [self objc_getFutureClass];
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    [self objc_allocateClassPair];
                    break;
                    
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 0:
                    [self class_createInstance];
                    break;
                case 1:
                    [self objc_constructInstance];
                    break;
                default:
                    break;
            }
            break;
        case 3:
            
            break;
        case 4:
            switch (indexPath.row) {
                case 0:
                    [self objc_getClassList];
                    break;
                case 1:
                    [self objc_copyClassList];
                    break;
                case 2:
                    [self objc_lookUpClass];
                    break;
                case 3:
                    [self objc_getClass];
                    break;
                case 4:
                    [self objc_getRequiredClass];
                    break;
                case 5:
                    [self objc_getMetaClass];
                    break;
                default:
                    break;
            }
            break;
        case 5:
            switch (indexPath.row) {
                case 0:
                    [self ivar_getName];
                    break;
                case 1:
                    [self ivar_getTypeEncoding];
                    break;
                case 2:
                    [self ivar_getOffset];
                    break;
                default:
                    break;
            }
            break;
        case 6:
            switch (indexPath.row) {
                case 0:
                    [self objc_setAssociatedObject];
                    break;
                    
                default:
                    break;
            }
            break;
        case 7:
            switch (indexPath.row) {
                case 0:
                    [self objc_msgSendE];
                    break;
                case 1:
                    [self objc_msgSend_fpret];
                    break;
                default:
                    break;
            }
            break;
        case 8:
            switch (indexPath.row) {
                case 0:
                    [self method_invoke];
                    break;
                case 1:
                    [self method_getName];
                    break;
                case 2:
                    [self method_getImplementation];
                    break;
                case 3:
                    [self method_getTypeEncoding];
                    break;
                case 4:
                    [self method_copyReturnType];
                    break;
                case 5:
                    [self method_copyArgumentType];
                    break;
                case 6:
                    [self method_getReturnType];
                    break;
                case 7:
                    [self method_getNumberOfArguments];
                    break;
                case 8:
                    [self method_getArgumentType];
                    break;
                case 9:
                    [self method_getDescription];
                    break;
                case 10:
                    [self method_setImplementation];
                    break;
                case 11:
                    [self method_exchangeImplementations];
                    break;
                default:
                    break;
            }
            break;
        case 9:
            switch (indexPath.row) {
                case 0:
                    [self objc_copyImageNames];
                    break;
                case 1:
                    [self class_getImageName];
                    break;
                case 2:
                    [self objc_copyClassNamesForImage];
                    break;
                default:
                    break;
            }
            break;
        case 10:
            switch (indexPath.row) {
                case 0:
                    [self sel_getName];
                    break;
                case 1:
                    [self sel_registerName];
                    break;
                case 2:
                    [self sel_getUid];
                    break;
                case 3:
                    [self sel_isEqual];
                    break;
                default:
                    break;
            }
            break;
        case 11:
            switch (indexPath.row) {
                case 0:
                    [self objc_getProtocol];
                    break;
                case 1:
                    [self objc_copyProtocolList];
                    break;
                case 2:
                    [self objc_allocateProtocol];
                    break;
                case 3:
                    [self protocol_addMethodDescription];
                    break;
                default:
                    break;
            }
            break;
        case 12:
            switch (indexPath.row) {
                case 0:
                    [self property_getName];
                    break;
                case 1:
                    [self property_getAttributes];
                    break;
                case 2:
                    [self property_copyAttributeValue];
                    break;
                case 3:
                    [self property_copyAttributeList];
                    break;
                    
                default:
                    break;
            }
            break;
        case 13:
            switch (indexPath.row) {
                case 0:
                    
                    break;
                case 1:
                    [self imp_implementationWithBlock];
                    break;
                case 2:
                    [self imp_getBlock];
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
    
}


@end
