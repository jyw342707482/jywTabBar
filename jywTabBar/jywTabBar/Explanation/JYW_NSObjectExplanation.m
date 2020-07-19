//
//  JYW_NSObjectExplanation.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/14.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_NSObjectExplanation.h"

@implementation JYW_NSObjectExplanation
#pragma mark -Initializing a Class(初始化类)
+(void)initialize{
    //Initializes the class before it receives its first message.
    //初始化类，当收到第一个消息前。
}
+(void)load{
    //Invoked whenever a class or category is added to the Objective-C runtime; implement this method to perform class-specific behavior upon loading.
    //类在被初始装载时调用
}
#pragma mark -Creating,Copying,and Deallocating Objects(创建、复制和取消分配对象)

+ (instancetype)alloc{
    //Returns a new instance of the receiving class.
    //返回接收类的新实例
    return [super alloc];
}
- (instancetype)init{
    //Implemented by subclasses to initialize a new object (the receiver) immediately after memory for it has been allocated.
    //为新对象（接收器）分配内存后立即对其进行初始化。
    return [super init];
}
- (void)dealloc{
    //Deallocates the memory occupied by the receiver.
    //释放内存资源
}
+ (instancetype)new{
    //Allocates a new instance of the receiving class, sends it an init message, and returns the initialized object.
    //分配接收类的新实例，向其发送初始化消息，然后返回已初始化的对象。
    return [super new];
}
#pragma mark -Identifying Classes(识别类)
+ (Class)class{
    //Returns the Class object.
    //返回类对象
    return [super class];
    /*
     配合  isKindOfClass:
     使用，返回一个布尔值，该值指示接收方是给定类的实例还是从该类继承的任何类的实例。
     如果接收方是aClass的实例或从aClass继承的任何类的实例，则为YES，否则为NO。
     转载：https://www.jianshu.com/p/47f53e9e3a64
     */
}
+(Class)superclass{
    //Returns the class object for the receiver’s superclass.
    //返回接收者超类的类对象。
    return [super superclass];
}
//转载：https://www.jianshu.com/p/47f53e9e3a64
+(BOOL)isSubclassOfClass:(Class)aClass{
    //Returns a Boolean value that indicates whether the receiving class is a subclass of, or identical to, a given class.
    //返回一个布尔值，该值指示接收类是给定类的子类还是与给定类相同的子类。
    
    return [super isSubclassOfClass:aClass];
}
#pragma mark -Testing Class Functionality(测试类功能)
+ (BOOL)instancesRespondToSelector:(SEL)aSelector{
    //Returns a Boolean value that indicates whether instances of the receiver are capable of responding to a given selector.
    //返回一个布尔值，该值指示接收器的实例是否能够响应给定的选择器。
    return [super instancesRespondToSelector:aSelector];
}
#pragma mark -Testing Protocol Conformance(测试协议一致性)
+ (BOOL)conformsToProtocol:(Protocol *)protocol{
    //Returns a Boolean value that indicates whether the receiver conforms to a given protocol.
    //返回一个布尔值，该值指示接收方是否符合给定的协议。
    return [super conformsToProtocol:protocol];
}
#pragma mark -Obtaining Information About Methods(获取有关方法的信息)
/*
 * @param aSelector ：一个选择器，用于标识要为其返回实现地址的方法。 选择器必须为有效且非NULL。 如有疑问，请在将选择器传递给methodForSelector：之前，使用responsToSelector：方法进行检查。
 * @return 接收者实现aSelector的地址。
 * 如果接收方是一个实例，则Selector应该引用一个实例方法； 如果接收者是一个类，则应引用一个类方法。
 转载：https://www.jianshu.com/p/65cf7755d30e
 */
- (IMP)methodForSelector:(SEL)aSelector{
    //Locates and returns the address of the receiver’s implementation of a method so it can be called as a function.
    //找到并返回接收者实现方法的地址，因此可以将其称为函数。
    return [super methodForSelector:aSelector];
}
/*
 * @param aSelector ：一个选择器，用于标识要为其返回实现地址的方法。 选择器必须为有效且非NULL。 如有疑问，请在将选择器传递给methodForSelector：之前，使用responsToSelector：方法进行检查。
 * @return 接收者实现aSelector的地址。
 *如果接收者的实例无法响应aSelector消息，则会生成错误。

 使用此方法仅要求类对象实现实例方法。 要向类询问类方法的实现，请改为将methodForSelector：实例方法发送给该类。
 转载：https://www.jishudog.com/812/html
 */
+ (IMP)instanceMethodForSelector:(SEL)aSelector{
    //Locates and returns the address of the implementation of the instance method identified by a given selector.
    //查找并返回由给定选择器标识的实例方法的实现的地址。
    return [super instanceMethodForSelector:aSelector];
}
/*
 *@param aSelector:一个选择器，用于标识要为其返回实现地址的方法。
 *@reutrn 一个NSMethodSignature对象，其中包含由aSelector标识的实例方法的描述，如果找不到该方法，则为nil。
 */
+ (NSMethodSignature *)instanceMethodSignatureForSelector:(SEL)aSelector{
    //Returns an NSMethodSignature object that contains a description of the instance method identified by a given selector.
    //返回一个NSMethodSignature对象，该对象包含由给定选择器标识的实例方法的描述。
    return [super instanceMethodSignatureForSelector:aSelector];
}
/*
 *@param aSelector:一个选择器，用于标识要为其返回实现地址的方法。 当接收者是一个实例时，aSelector应该标识一个实例方法。 当接收者是一个类时，它应该标识一个类方法。

 *@return:NSMethodSignature对象，其中包含由aSelector标识的方法的描述；如果找不到该方法，则为nil。
 此方法用于协议的实现。 在必须创建NSInvocation对象的情况下（例如，在消息转发期间），也使用此方法。 如果您的对象维护一个委托或能够处理它不直接实现的消息，则应重写此方法以返回适当的方法签名。
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    //Returns an NSMethodSignature object that contains a description of the method identified by a given selector.
    //返回一个NSMethodSignature对象，该对象包含由给定选择器标识的方法的描述。
    return [super methodSignatureForSelector:aSelector];
}
#pragma mark -Describing Objects(描述对象)
+ (NSString *)description{
    //Returns a string that represents the contents of the receiving class.
    //返回一个表示接收类内容的字符串。
    //转载：https://www.jianshu.com/p/f4722479758d
    return [super description];
}
#pragma mark -Supporting Discardable Content(支持废弃内容)
//autoContentAccessingProxy,接收对象的代理
#pragma mark -Sending Messages(传送消息)
/*
 *@param aSelector:用于标识要调用的方法。该方法应该没有明显的返回值，并且应该采用id类型的单个参数，或者不带参数。
 *@param anArgument:调用时传递给方法的参数。如果该方法不带参数，则传递nil。
 *@param delay:消息发送的最短时间。将延迟指定为0并不一定会使选择器立即执行。选择器仍在线程的运行循环中排队，并尽快执行。
 转载：https://blog.csdn.net/xumingwei12345/article/details/17913171
 */
- (void)performSelector:(SEL)aSelector withObject:(id)anArgument afterDelay:(NSTimeInterval)delay{
    //Invokes a method of the receiver on the current thread using the default mode after a delay.
    //延迟后，使用默认模式在当前线程上调用接收器的方法。
}
/*
 *@param aSelector:用于标识要调用的方法。该方法应该没有明显的返回值，并且应该采用id类型的单个参数，或者不带参数。
 *@param anArgument:调用时传递给方法的参数。如果该方法不带参数，则传递nil。
 *@param delay:消息发送的最短时间。将延迟指定为0并不一定会使选择器立即执行。选择器仍在线程的运行循环中排队，并尽快执行。
 *@param modes:字符串数组，标识与执行选择器的计时器关联的模式。 该数组必须包含至少一个字符串。 如果为该参数指定nil或空数组，则此方法将返回而不执行指定的选择器。 有关运行循环模式的信息，请参见《线程编程指南》中的“运行循环”。
 */
- (void)performSelector:(SEL)aSelector withObject:(id)anArgument afterDelay:(NSTimeInterval)delay inModes:(NSArray<NSRunLoopMode> *)modes{
    //Invokes a method of the receiver on the current thread using the specified modes after a delay.
    //延迟后，使用默认模式在当前线程上调用接收器的方法。
}
/*
 *@param aSelector:用于标识要调用的方法。 该方法应该没有明显的返回值，并且应该采用id类型的单个参数，或者不带参数。
 *@param arg:调用时传递给方法的参数。 如果该方法不带参数，则传递nil。
 *@param wait:一个布尔值，指定当前线程是否在主线程上的接收器上执行指定的选择器之后才阻塞。 指定是阻止该线程； 否则，请指定NO以使此方法立即返回。
 如果当前线程也是主线程，并且您为此参数指定YES，则消息将立即传递并处理。
 
 */
- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait{
    //Invokes a method of the receiver on the main thread using the default mode.
    //使用默认模式在主线程上调用接收器的方法。
}
/*
*@param aSelector:用于标识要调用的方法。 该方法应该没有明显的返回值，并且应该采用id类型的单个参数，或者不带参数。
*@param arg:调用时传递给方法的参数。 如果该方法不带参数，则传递nil。
*@param wait:一个布尔值，指定当前线程是否在主线程上的接收器上执行指定的选择器之后才阻塞。 指定是阻止该线程； 否则，请指定NO以使此方法立即返回。
如果当前线程也是主线程，并且您为此参数指定YES，则消息将立即传递并处理。
 *@param array:字符串数组，标识允许执行指定选择器的模式。 该数组必须包含至少一个字符串。 如果为该参数指定nil或空数组，则此方法将返回而不执行指定的选择器。 有关运行循环模式的信息，请参见《线程编程指南》中的“运行循环”。
*/

- (void)performSelectorOnMainThread:(SEL)aSelector withObject:(id)arg waitUntilDone:(BOOL)wait modes:(NSArray<NSString *> *)array{
    //Invokes a method of the receiver on the main thread using the default mode.
    //使用默认模式在主线程上调用接收器的方法。
}
/*
 *@param aSelector:用于标识要调用的方法。该方法应该没有明显的返回值，并且应该采用id类型的单个参数，或者不带参数。
 *@param thr:在其上执行aSelector的线程。
 *@param arg:调用时传递给方法的参数。如果该方法不带参数，则传递nil。

 *@param wait:一个布尔值，指定当前线程是否在指定线程的接收器上执行指定选择器之后才阻塞。指定是阻止该线程；否则，请指定NO以使此方法立即返回。
 */
- (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(id)arg waitUntilDone:(BOOL)wait{
    //Invokes a method of the receiver on the specified thread using the default mode.
    //使用默认模式在指定线程上调用接收器的方法。
}
/*
*@param aSelector:用于标识要调用的方法。该方法应该没有明显的返回值，并且应该采用id类型的单个参数，或者不带参数。
*@param thr:在其上执行aSelector的线程。
*@param arg:调用时传递给方法的参数。如果该方法不带参数，则传递nil。

*@param wait:一个布尔值，指定当前线程是否在指定线程的接收器上执行指定选择器之后才阻塞。指定是阻止该线程；否则，请指定NO以使此方法立即返回。
 *@param array:字符串数组，标识允许执行指定选择器的模式。 该数组必须包含至少一个字符串。 如果为该参数指定nil或空数组，则此方法将返回而不执行指定的选择器。 有关运行循环模式的信息，请参见《线程编程指南》中的“运行循环”。
*/
- (void)performSelector:(SEL)aSelector onThread:(NSThread *)thr withObject:(id)arg waitUntilDone:(BOOL)wait modes:(NSArray<NSString *> *)array{
    //Invokes a method of the receiver on the specified thread using the default mode.
    //使用默认模式在指定线程上调用接收器的方法。
}
/*
 *@param aSelect:一个选择器，用于标识要调用的方法。 该方法应该没有明显的返回值，并且应该采用id类型的单个参数，或者不带参数。

 *@param arg:调用时传递给方法的参数。 如果该方法不带参数，则传递nil。
 
 此方法在应用程序中创建一个新线程，如果尚未将其置于多线程模式，则将其置于多线程模式。 由aSelector表示的方法必须像在程序中创建任何其他新线程一样设置线程环境。 有关如何配置和运行线程的更多信息，请参见《线程编程指南》。
 */
- (void)performSelectorInBackground:(SEL)aSelector withObject:(id)arg{
    //Invokes a method of the receiver on a new background thread.
    //在新的后台线程上调用接收器的方法。
}
+ (void)cancelPreviousPerformRequestsWithTarget:(id)aTarget{
    //Cancels perform requests previously registered with the performSelector:withObject:afterDelay: instance method.
    //取消先前使用performSelector：withObject：afterDelay：实例方法注册的执行请求。
}
+ (void)cancelPreviousPerformRequestsWithTarget:(id)aTarget selector:(SEL)aSelector object:(id)anArgument{
    //Cancels perform requests previously registered with performSelector:withObject:afterDelay:
    //取消先前已在performSelector：withObject：afterDelay：中注册的执行请求。
}
#pragma mark -Forwarding Messages(消息转发)
- (id)forwardingTargetForSelector:(SEL)aSelector{
    //Returns the object to which unrecognized messages should first be directed.
    //返回无法识别的消息应首先定向到的对象。
    return [super forwardingTargetForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    //Overridden by subclasses to forward messages to other objects.
    //被子类重写以将消息转发到其他对象。
}
#pragma mark -Dynamically Resolving Methods(动态解析方法)
/**
 *@param name:要解析的选择器的名称。
 *@return:如果找到该方法并将其添加到接收器，则为“是”，否则为“否”。
 此方法使您可以动态提供给定选择器的实现。 请参阅resolveInstanceMethod：进行进一步的讨论。
 */
+ (BOOL)resolveClassMethod:(SEL)sel{
    //Dynamically provides an implementation for a given selector for a class method.
    //动态的，为选择器提供实现
    return [super resolveClassMethod:sel];
}
/**
 *@param sel:要解析的选择器的名称。
 *@return 如果找到该方法并将其添加到接收器，则为“是”，否则为“否”。
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    //Dynamically provides an implementation for a given selector for an instance method.
    //动态的，为选择器提供实现
    return [super resolveInstanceMethod:sel];
}
#pragma mark -Handling Errors(错误处理)
- (void)doesNotRecognizeSelector:(SEL)aSelector{
    //Handles messages the receiver doesn’t recognize.
    //处理接受者无法识别的消息。
}
#pragma mark -Archiving(封存、归档)
/**
 *@param aDecoder:解码器用于解码接收器。
 *@return 接收者或另一个对象代替已解码并随后接收到此消息的对象。

 您可以使用此方法消除编码器创建的冗余对象。 例如，如果在解码对象后发现同等对象已经存在，则可以返回现有对象。 如果返回替换，则您的替代方法负责释放接收器。
 此方法由NSCoder调用。 NSObject的实现只是返回self。
 */
- (id)awakeAfterUsingCoder:(NSCoder *)coder{
    //Overridden by subclasses to substitute another object in place of the object that was decoded and subsequently received this message.
    //被子类覆盖，以替代另一个对象来代替已解码并随后接收到此消息的对象。
    return [super awakeAfterUsingCoder:coder];
}
/*
 classForArchiver
 在归档过程中代替接收者自己的班级的班级。
 classForCoder
 在编码期间被子类重写以替代其自身之外的其他类。
 classForKeyedArchiver
 子类在密钥归档期间用新类替换实例。
 */
/**
 *@return 字符串对象数组，用于按优先顺序指定用于取消存档的类的名称
 *
 NSKeyedArchiver调用此方法并将结果存储在存档中。 如果取消归档时对象的实际类不存在，则NSKeyedUnarchiver将遍历已存储的类列表，并使用存在的第一个类作为替代类来解码对象。 此方法的默认实现返回一个空数组。

 如果在应用程序中引入了新类以提供向后兼容性，以防在没有该类的系统上读取存档时可以使用此方法。 有时可能存在另一个类，该类几乎可以代替新类工作，并且可以仔细选择（或写出兼容性）新类的存档密钥和存档状态，以便可以像 如有必要，请代课。
 */
+ (NSArray<NSString *> *)classFallbacksForKeyedArchiver{
    //Overridden to return the names of classes that can be used to decode objects if their class is unavailable.
    //重写以返回可用于在对象的类不可用时对对象进行解码的类的名称
    return [super classFallbacksForKeyedArchiver];
}
/**
 *@return 在密钥取消归档过程中替代接收者的类。

 在密钥取消存档期间，接收者的实例将被解码为返回类的成员。 此方法会将解码器的类和实例名称的结果覆盖到类编码表中。
 */
+ (Class)classForKeyedUnarchiver{
    //Overridden by subclasses to substitute a new class during keyed unarchiving.
    //在分发编码中替代接收器的类
    return [super classForKeyedUnarchiver];
}
/**
 *@param aCoder:编码器对接收器进行编码。
 *@return 对象编码而不是接收者编码（如果不同）。

 对象可以将自身编码为存档，但是如果对其进行编码以进行分发，则可以为其自身编码代理。 此方法由NSCoder调用。 NSObject的实现返回self。
 */
- (id)replacementObjectForCoder:(NSCoder *)coder{
    //Overridden by subclasses to substitute another object for itself during encoding.
    //子类重写，以在编码过程中为其自身替换另一个对象。
    return [super replacementObjectForCoder:coder];
}
/**
 *@param archiver :创建存档的键控存档器。
 *@return 对象编码而不是接收者编码（如果不同）。

 仅在尚未在编码器中设置对象的替换映射的情况下，才调用此方法（例如，由于先前对该对象调用了replaceObjectForKeyedArchiver：）。
 */
- (id)replacementObjectForKeyedArchiver:(NSKeyedArchiver *)archiver{
    //Overridden by subclasses to substitute another object for itself during keyed archiving.
    //由子类重写，以在键控归档期间为其自身替换另一个对象。
    return [super replacementObjectForKeyedArchiver:archiver];
}
+ (void)setVersion:(NSInteger)aVersion{
    //Sets the receiver's version number.
    //设置接收者的版本号。
}
+ (NSInteger)version{
    //Returns the version number assigned to the class.
    //返回分配给该类的版本号。
    return [super version];
}
#pragma mark -Working with Class Descriptions(类描述)
/*
attributeKeys
NSString对象数组，其中包含接收者的类的实例所包含的不可变值的名称。
classDescription
包含有关接收者类别的属性和关系的信息的对象。

toManyRelationshipKeys
包含用于接收方的多对关系属性的键的数组。
toOneRelationshipKeys
接收者一对一关系属性的键（如果有）。
 */
- (NSString *)inverseForRelationshipKey:(NSString *)relationshipKey{
    //For a given key that defines the name of the relationship from the receiver’s class to another class, returns the name of the relationship from the other class to the receiver’s class.
    //对于给定的键，该键定义了从接收者的类到另一个类的关系的名称，请返回从另一个类到接收者的类之间的关系的名称。
    return @"";
}
#pragma mark -Scripting(脚本编写)
/*
 classCode//接收者的Apple事件类型代码，存储在对象类的NSScriptClassDescription对象中。
 className//包含类名称的字符串。
 scriptingProperties//接收者可编写脚本的属性的NSString键字典。
 */
/**
 *@param value:一个或多个要复制的对象。该类型必须与由key标识的属性的类型匹配。 （另请参见讨论部分。）
 例如，如果属性是一对多关系，则值将始终是要复制的对象的数组，因此此方法必须返回对象的数组。
 *@param key:标识复制对象或对象之间插入关系的键。
 *@param properties:要在复制的一个或多个对象中设置的属性。从重复命令的“具有属性”参数派生。 （另请参见讨论部分。）
 *@return:复制的一个或多个对象。如果发生错误，则返回nil。

 您可以重写copyScriptingValue方法，以在向应用程序发送重复命令时获得更多控制权。在一个或多个复制对象的预期容器上调用此方法。这些属性是从重复命令的with properties参数派生的。然后使用键值编码将返回的一个或多个对象插入容器。

 当Cocoa调用此方法时，尚未使用NSScriptKeyValueCoding方法coerceValue：forKey：强制值和属性。但是，对于sdef声明的脚本功能，传入对象的类型可靠地匹配相关的sdef声明。

 此方法的默认实现是通过将copyWithZone：发送到value指定的一个或多个对象来复制脚本对象。对于不足的情况，例如在Core Data应用程序中，必须使用[NSManagedObject initWithEntity：insertIntoManagedObjectContext：]初始化新对象，请覆盖此方法。
 */
- (id)copyScriptingValue:(id)value forKey:(NSString *)key withProperties:(NSDictionary<NSString *,id> *)properties{
    //Creates and returns one or more scripting objects to be inserted into the specified relationship by copying the passed-in value and setting the properties in the copied object or objects.
    //通过复制传入的值并在一个或多个复制的对象中设置属性，创建并返回要插入到指定关系中的一个或多个脚本对象。
    return nil;
}
/**
 *@param class:要创建的可编写脚本对象的类。
 *@param key:标识新类对象将插入到其中的关系的键。
 *@param contentsValue:指定要创建的对象的内容。这可能为零。 （另请参见讨论部分。）
 *@param properties:在新对象中设置的属性。 （另请参见讨论部分。）
 *@return:新对象。如果发生错误，则返回nil。

 您可以重写newScriptingObjectOfClass方法，以在向应用程序发送make命令时获得更多控制权。在新对象的预期容器上调用此方法。 contentsValue和properties是从make命令的with内容和properties参数派生的。然后使用键值编码将返回的一个或多个对象插入容器。

 当Cocoa调用此方法时，尚未使用NSScriptKeyValueCoding方法coerceValue：forKey：强制内容值和属性。但是，对于sdef声明的脚本功能，传入对象的类型可靠地匹配相关的sdef声明。

 该方法的默认实现是通过将alloc发送给类，并将init发送给结果对象来创建新的脚本对象。对于不足的情况，例如在Core Data应用程序中，必须使用[NSManagedObject initWithEntity：insertIntoManagedObjectContext：]初始化新对象，请覆盖此方法。
 */
- (id)newScriptingObjectOfClass:(Class)objectClass forValueForKey:(NSString *)key withContentsValue:(id)contentsValue properties:(NSDictionary<NSString *,id> *)properties{
    //Creates and returns an instance of a scriptable class, setting its contents and properties, for insertion into the relationship identified by the key.
    //创建并返回可编写脚本的类的实例，设置其内容和属性，以插入到由键标识的关系中。
    return nil;
}
/**
 *@param objectSpecifier:要评估的对象说明符。
 *@return 接收容器中指定的一个或多个对象。
 根据对象说明符的类型，此方法可能成功返回一个对象，一个对象数组或nil。由于nil是有效的返回值，因此通过在返回之前调用对象说明符的setEvaluationError：方法来指示失败。

 
 您可以重写此方法以自定义对象说明符的评估，而无需脚本容器为自然没有索引的所包含对象组成索引（如果您实现indexsOfObjectsByEvaluatingObjectSpecifier，则可能是这种情况）。

 尽管可以重写此方法，但您不必重写任何NSScriptCommand错误信号发送方法即可记录非常具体的信息。 NSUnknownKeySpecifierError和NSInvalidIndexSpecifierError号是特殊的，如果遇到Cocoa，为了方便脚本编写者，它们可能会继续评估外部说明符。
 */
/*
- (id)scriptingValueForSpecifier:(NSScriptObjectSpecifier *)objectSpecifier{
    //Given an object specifier, returns the specified object or objects in the receiving container.
    //给定对象说明符，则在接收容器中返回指定的一个或多个对象。
    return nil;
}
 */
@end
/*
 
 */
