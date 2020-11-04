#  objc结构

## isa_t
```
union isa_t {
    Class cls;
    uintptr_t bits;     //(isa.bits & ISA_MASK)
    
    #define ISA_MASK        0x0000000ffffffff8ULL
    #define ISA_MAGIC_MASK  0x000003f000000001ULL
    #define ISA_MAGIC_VALUE 0x000001a000000001ULL
    #define ISA_BITFIELD                                                      \
        uintptr_t nonpointer        : 1;                                       \    //标识是否开启isa优化.如果是一个指针值该位为0,则表示当前结构的值只是一个指针没有保存其他信息;如果为1,则表示当前结构不是指针,而是一个包含了其他信息的位域结构
        uintptr_t has_assoc         : 1;                                       \    //当前对象是否使用objc_setAssociatedObject动态绑定了额外的属性
        uintptr_t has_cxx_dtor      : 1;                                       \    //是否含有C++或者OC的析构函数,不包含析构函数时对象释放速度会更快;
        uintptr_t shiftcls          : 33; /*MACH_VM_MAX_ADDRESS 0x1000000000*/ \    //真正的isa指针地址，所以最后三位肯定是0
        uintptr_t magic             : 6;                                       \        //用于判断对象是否已经完成了初始化
        uintptr_t weakly_referenced : 1;                                       \        //是否是弱引用对象
        uintptr_t deallocating      : 1;                                       \        //对象是否正在执行析构函数
        uintptr_t has_sidetable_rc  : 1;                                       \        //判断是否需要用sidetable去处理引用计数
        uintptr_t extra_rc          : 19            //存储该对象的引用计数值减一后的结果. 当对象的引用计数使用extra_rc足以存储时has_sidetable_rc=0；当对象的引用计数使用extra_rc不能存储时has_sidetable_rc=1.可见对象的引用计数主要存储在两个地方：如果isa中extra_rc足以存储则存储在isa的位域中；如果isa位域不足以存储，就会使用sidetable去存储
    #define RC_ONE   (1ULL<<45)
    #define RC_HALF  (1ULL<<18)
};

## objc_object
struct objc_object {

    isa_t isa;
}

## objc_class
struct objc_class : objc_object {

    Class superclass; // 指向父类的地址
    cache_t cache;   // 方法缓存列表
    //结构体，内部存储着主要的数据，通过&不同的掩码值获取不同的信息地址
    class_data_bits_t bits;  //union结构，所有数据公用一块内存
    // 获取存放在bits中的可读可写的数据信息
    class_rw_t *data() { 
        return bits.data();
    }
    class_rw_t* data() const {
        return (class_rw_t *)(bits & FAST_DATA_MASK);
    }
   ......
}

## cache_t
struct cache_t {

    explicit_atomic<struct bucket_t *> _buckets;    //哈希表，直接通过@selector计算出对应数组里的index，然后直接取出。不需要遍历
    explicit_atomic<mask_t> _mask;//总共能存放的_buckets数-1（比如一共能存10个，这里的_mask为9）
    uint16_t _occupied;//实际存放_buckets数量
}
```
## 方法缓存查找
- 先看缓存中是否已经存在了该方法，如果已经存在，直接return掉，不用再缓存
- 如果当前cache还没被初始化，则分配一个大小为4的数组，并设置_mask为3。
- 如果存入缓存后的大小小于当前大小的3/4，则当前缓存大小还可以使用，无需扩容
- 否则缓存太满，需要扩容，扩容为原来大小的2倍。放弃旧的缓存，新扩容的缓存为空。并保存当前调用的方法，保存后有一个数据，以前存的方法全部丢弃。
- 将_key与_mask相与，因为_mask是数组大小-1，所以得到的结果刚好小于数组的大小。
- 如果得到的位置已经被占用，则往后寻找，直到找到空的位置，把缓存设置到这个位置（如果到了最后一个都不为空会跳到第一个查找，直到回到最开始的位置，如果没有空会执行第4步）。

## bucket_t
typedef unsigned long     uintptr_t;
typedef uintptr_t     cache_key_t;
```
struct bucket_t {

    cache_key_t _key;
    MethodCacheIMP _imp;
}
```
## class_rw_t
```
struct class_rw_t {
    uint32_t flags;
    uint32_t version;
  
    const class_ro_t *ro;  // 只读的,Class的初始信息
    method_array_t methods; // 方法列表
    property_array_t properties; // 属性列表
    protocol_array_t protocols; // 协议列表

    Class firstSubclass;
    Class nextSiblingClass;
    char *demangledName;
}

## class_ro_t
struct class_ro_t {

    uint32_t flags;
    uint32_t instanceStart;
    uint32_t instanceSize;// 大小

    const uint8_t * ivarLayout;
    
    const char * name;     // 类名
    method_list_t * baseMethodList; // 初始方法列表
    protocol_list_t * baseProtocols; // 初始协议列表
    const ivar_list_t * ivars; // 初始成员变量列表

    const uint8_t * weakIvarLayout;
    property_list_t *baseProperties; // 初始属性列表
    ......
}
```
## method_array_t
class method_array_t : 
// method_array_t里面存放的是method_list_t, 二维数组
//method_list_t 里面存放的是method_t ，一维数组
```
    public list_array_tt<method_t, method_list_t> 
{

    typedef list_array_tt<method_t, method_list_t> Super;
 public:
 
    method_list_t **beginCategoryMethodLists() {
        return beginLists();
    }
    
    method_list_t **endCategoryMethodLists(Class cls);

    method_array_t duplicate() {
        return Super::duplicate<method_array_t>();
    }
};

## method_t
struct method_t {

    SEL name; // 方法选择器，也就是方法的名字
    const char *types; // 方法的返回类型和参数
    MethodListIMP imp; // 方法的存放地址
};
```
