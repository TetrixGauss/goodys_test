// wrapper.cpp
//#include <windows.h>
#include <dlfcn.h>
#include <stdio.h>

typedef void (*DeserializeAnonymousTypeFunc)();

//HINSTANCE hinstLib;
void* hinstLib;
DeserializeAnonymousTypeFunc DeserializeAnonymousType;

//extern "C" __declspec(dllexport) void Initialize() {
extern "C"  void Initialize() {
//    hinstLib = LoadLibrary(TEXT("/Users/panospavlatos/Desktop/ATCOM Projects/goodys_test/lib/Newtonsoft.Json.dll"));
    hinstLib = dlopen("/Users/panospavlatos/Desktop/ATCOM Projects/goodys_test/assets/dll/Newtonsoft.Json.dll", RTLD_NOW);
    if (hinstLib != NULL)
    {
//        DeserializeAnonymousType = (DeserializeAnonymousTypeFunc) GetProcAddress(hinstLib, "DeserializeAnonymousType");
        DeserializeAnonymousType = (DeserializeAnonymousTypeFunc) dlsym(hinstLib, "DeserializeAnonymousType");
        if (NULL != DeserializeAnonymousType)
        {
            return;
        }
        dlclose(hinstLib);
//        FreeLibrary(hinstLib);
    }
}

//extern "C" __declspec(dllexport) void CallDeserializeAnonymousType() {
extern "C" void CallDeserializeAnonymousType() {
    DeserializeAnonymousType();
}