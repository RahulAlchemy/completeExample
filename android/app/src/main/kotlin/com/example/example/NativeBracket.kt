package com.example.example

import io.flutter.embedding.android.FlutterActivity

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import com.ventura.bracketslib.BracketsView
import com.ventura.bracketslib.model.ColomnData
import com.ventura.bracketslib.model.CompetitorData
import com.ventura.bracketslib.model.MatchData
import io.flutter.plugin.platform.PlatformView
import java.util.*

internal class NativeBracketView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val bracketsView: BracketsView

    override fun getView(): View {
        return bracketsView
    }

    override fun dispose() {}

    init {
        bracketsView= BracketsView(context,null)
        val brazilSemiFinal = CompetitorData("Brazil", "3")
        val englandSemiFinal = CompetitorData("England", "1")
        val argentinaSemiFinal = CompetitorData("Argentina", "3")
        val russiaSemiFinal = CompetitorData("Russia", "2")
        val brazilFinal = CompetitorData("Brazil", "4")
        val argentinaFinal = CompetitorData("Argentina", "2")

        val match1SemiFinal = MatchData(brazilSemiFinal, englandSemiFinal)
        val match2SemiFinal = MatchData(argentinaSemiFinal, russiaSemiFinal)
        val match3Final = MatchData(brazilFinal, argentinaFinal)

        val semiFinalColomn = ColomnData(Arrays.asList(match1SemiFinal, match2SemiFinal))
        val finalColomn = ColomnData(Arrays.asList(match3Final))

        bracketsView.setBracketsData(Arrays.asList(semiFinalColomn, finalColomn))
    }
}
