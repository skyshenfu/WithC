#include "jni.h"
#include <string>
extern "C"{
#include <libavutil/avutil.h>
}
extern "C" JNIEXPORT jstring JNICALL
Java_com_example_withc_MainActivity_stringFromJNI(
        JNIEnv* env,
        jobject /* this */) {
    return env->NewStringUTF(av_version_info());
}