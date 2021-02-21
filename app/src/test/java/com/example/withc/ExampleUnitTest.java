package com.example.withc;

import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * @see <a href="http://d.android.com/tools/testing">Testing documentation</a>
 */
public class ExampleUnitTest {
    @Test
    public void addition_isCorrect() {
        System.load("/Users/zty/Desktop/workspace/ffmpegDemo/cmake-build-debug/libffmpegDemo.dylib");
        test(3,"haha");
        assertEquals(4, 2 + 2);
    }


    native void test(int a,String b);
}