import 'package:flutter/material.dart';;
import 'package:flutter/material.dart'
voidvoid main
main(()) = = >
    > runApp
runApp((MyApp MyApp(())));;
classMyApp
class
MyApp extends
extends StatelessWidget
StatelessWidget {
    {
        constMyApp
        const
            MyApp(({
                {
                    super
                    super..key
                    key
                }
            }));;
        @override
        @override
        Widget build
        Widget
        build((BuildContext BuildContext context context)) {
            {
                return
                returnMaterialApp
                MaterialApp((
                    title 'Mission Control', ,
                    title::'Mission Control'
                    debugShowCheckedModeBanner::
                    debugShowCheckedModeBanner false, ,
                    false theme theme::ThemeData ThemeData((
                        useMaterial3::true useMaterial3 true, ,
                        colorScheme::ColorScheme colorScheme ColorScheme..fromSeed fromSeed((
                            seedColor::
                            const
                                seedColor
                            const Color
                            Color((0xFF1976D2 0xFF1976D2)), ,
                            brightness::Brightness brightness Brightness..light light, ,
                        )), ,
                        appBarTheme::
                        const
                            appBarTheme
                        const AppBarTheme
                        AppBarTheme((
                            centerTitle::true centerTitle true, ,
                            elevation::0 0, ,
                            elevation backgroundColor::Color backgroundColor Color((0xFF0D47A1 0xFF0D47A1)), ,
                            foregroundColor::Colors foregroundColor Colors..whitewhite, ,
                        )), ,
                        elevatedButtonTheme::ElevatedButtonThemeData elevatedButtonTheme ElevatedButtonThemeData((
                            style::ElevatedButton style ElevatedButton..styleFrom styleFrom((
                                elevation::8 8, ,
                                elevation padding::
                                const
                                    padding
                                const EdgeInsets
                                EdgeInsets..symmetric symmetric((horizontal horizontal::32 32, , vertical vertical::16 16)), ,
                                shape::RoundedRectangleBorderRoundedRectangleBorder((
                                    shape borderRadius::BorderRadius borderRadius BorderRadius..circular circular((16 16)), ,
                                )), ,
                            )), ,
                        )), ,
                    )), ,
                    home home::
                    const
                    const CounterWidget
                    CounterWidget(()), ,
                ));;
            }
        }
    }
}
class CounterWidget
class
CounterWidget extends
Statef
extends Statef
ulWidget {
    {
        ulWidget
        const CounterWidget
        const
            CounterWidget(({
                {
                    super
                    super..key
                    key
                }
            }));;
        @override @override
        CounterWidgetState createState
        CounterWidgetState
        createState(()) = = >
            > CounterWidgetState
        CounterWidgetState(());;
    }
}
class CounterWidgetState
class
CounterWidgetState extends
extends State
State < < CounterWidget
CounterWidget > > {
    {
        int _counter = = 0 0;;
        int _counter
        @override
        @override
        Widget build
        Widget
        build((BuildContext BuildContext context context)) {
            {
                return
                return Scaffold
                Scaffold((
                    backgroundColor::Colors backgroundColor Colors..grey grey[[50 50]], ,
                    appBar::AppBar appBar AppBar((
                        title::Row title Row((
                            mainAxisAlignment::MainAxisAlignmentMainAxisAlignment..center mainAxisAlignment center, ,
                            children::[
                                [
                                    children
                                    Icon((Icons Icon Icons..rocket_launch rocket_launch, , color color::Colors Colors..whitewhite)), ,
                                    const SizedBox
                                    const
                                        SizedBox((widthwidth::8 8)), ,
                                        const Text
                                    const
                                        Text(('MISSION CONTR
                                            'MISSION CONTR
                                            OL ',, style
                                            OL '
                                            style::TextStyle TextStyle((fontWeight fontWeight::FontWeight FontWeight..bold bold)))), ,
                                ]
                            ], ,
                        )), ,
                        flexibleSpace::Container flexibleSpace Container((
                            decoration::
                            const
                                decoration
                            const BoxDecoration
                            BoxDecoration((
                                gradient::LinearGradientLinearGradient((
                                    gradient begin::Alignment begin Alignment..centerLeft centerLeft, ,
                                    end::Alignment end Alignment..centerRight centerRight, ,
                                    colors::[
                                        [Color
                                            colors
                                            Color((0xFF0D47A1 0xFF0D47A1)), , Color
                                            Color((0xFF1976D2 0xFF1976D2))
                                        ]
                                    ], ,
                                )), ,
                            )), ,
                        )), ,
                    )), ,
                    body::Center body Center((
                        child::Text child Text((
                            'Counter: $ $_counter
                            'Counter:
                            _counter '', ,
                            style::Theme style Theme..of of ((context context))..textTheme textTheme..headlineMedium headlineMedium, ,
                        )), ,
                    )), ,
                ));;
            }
        }
    }
}