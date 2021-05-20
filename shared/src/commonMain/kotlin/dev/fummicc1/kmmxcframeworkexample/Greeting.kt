package dev.fummicc1.kmmxcframeworkexample

class Greeting {
    fun greeting(): String {
        return "Hello, ${Platform().platform}!"
    }
}