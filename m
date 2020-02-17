Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E225160804
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 03:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgBQCSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 21:18:54 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47465 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbgBQCSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 21:18:22 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 934CA6D42;
        Sun, 16 Feb 2020 21:18:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 16 Feb 2020 21:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=Hc4JR0Vl78E8a
        ni0afny2xMSor6ZCyoJcVsg+yk/Wis=; b=QeRTUMZ07ZEApmelrmz7vpOmTRFLA
        tI3932e8vmi7MJE7crDUdVfHHub6kT7f5fOBTL4oKGJGCaQX2XaNMA6lrmGRQwSl
        1fzXFFY9fVKZMgzTwOerZuWiECT0lGE8sS03MynXwQS01I45/6NHddpBQlHpPhRe
        9IbXhS+h54oYAdw3XtxgwLenXo0Az3njGiNuJG4/juZyf7MCxNRGMIybIicTjY66
        3OgKKr9HhQ6JX5L5JXfpCEMKNExMczwEtQ3t60uFo46dOI3lRZ8BcRuIozlD5zhv
        AJlDoe3cy7pbjOJ1pEoLi31sxEduSq+8FS9UyliRvGOuuKMwovwlczAcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Hc4JR0Vl78E8ani0afny2xMSor6ZCyoJcVsg+yk/Wis=; b=ZDFixzOL
        kPq4zqwnsiwyDrOzaVrvVo3u/qcvUbBkD7qNQHybrWxtIy9SC69p1a1Vy+5ToT06
        URMvxRDyOm+U4AbHrpTKu+MnlMm+YQ1cIykQ1mDRH6IOosAd8SD6mPj3du5MOwWp
        fLllac5cAKrxbv0E64M7IXOrt/xp4JyDU2vxTI5g7DqV+9ZKaQkWBtGYaETiloso
        HYNxoy1lzCZl+mdH0lYDrjsnkiFlD4ejMmTjEEavJVZvlDrSJ1qVNRMAFwIF39WH
        v1NXapdkjlTb5dLx3RGsIWTifu+RqofW8antvKfQxlQO2/zNenkhDY0rBBXP9Fzh
        GxkLN3azMql1/w==
X-ME-Sender: <xms:6vdJXjj0kCro0mL0AtACyL-ATto5XXVrE48MmDMtGfXPSu5C3Zse9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6vdJXhX9k6xXa7mD_nwzVpRdwNIhdBJucoEdanYDj9OZsFfdLQ4a9g>
    <xmx:6vdJXnuk7pAHBMS_3ZcFu9CoFfWe5ChOkzFHvGpSjBd3nscpRC_ZUA>
    <xmx:6vdJXi8yghNBOP7c5NbOsFwQlmHnaYHzOdvaIB1LJBrz5Ze6RDoASQ>
    <xmx:6_dJXj7eRppNl7P-yBTmko10P0b0Wa_CUB0r3WOsB3DibVXNvAHHOg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id A5D3C3060FDD;
        Sun, 16 Feb 2020 21:18:17 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 7/8] ASoC: sun50i-codec-analog: Enable DAPM for line out switch
Date:   Sun, 16 Feb 2020 20:18:12 -0600
Message-Id: <20200217021813.53266-8-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217021813.53266-1-samuel@sholland.org>
References: <20200217021813.53266-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By including the line out mute switch in the DAPM graph, the
Mixer/DAC inputs can be powered off when the line output is muted.

The line outputs have an unusual routing scheme. The left side mute
switch is between the source selection and the amplifier, as usual.
The right side source selection comes *after* its amplifier (and
after the left side amplifier), and its mute switch controls
whichever source is currently selected. This matches the diagram in
the SoC manual.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index df39f6ffe25a..84bb76cad74f 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -228,11 +228,6 @@ static const struct snd_kcontrol_new sun50i_a64_codec_controls[] = {
 		       SUN50I_ADDA_LINEOUT_CTRL1_VOL, 0x1f, 0,
 		       sun50i_codec_lineout_vol_scale),
 
-	SOC_DOUBLE("Line Out Playback Switch",
-		   SUN50I_ADDA_LINEOUT_CTRL0,
-		   SUN50I_ADDA_LINEOUT_CTRL0_LEN,
-		   SUN50I_ADDA_LINEOUT_CTRL0_REN, 1, 0),
-
 	SOC_SINGLE_TLV("Earpiece Playback Volume",
 		       SUN50I_ADDA_EARPIECE_CTRL1,
 		       SUN50I_ADDA_EARPIECE_CTRL1_ESP_VOL, 0x1f, 0,
@@ -280,6 +275,12 @@ static const struct snd_kcontrol_new sun50i_codec_lineout_src[] = {
 		      sun50i_codec_lineout_src_enum),
 };
 
+static const struct snd_kcontrol_new sun50i_codec_lineout_switch =
+	SOC_DAPM_DOUBLE("Line Out Playback Switch",
+			SUN50I_ADDA_LINEOUT_CTRL0,
+			SUN50I_ADDA_LINEOUT_CTRL0_LEN,
+			SUN50I_ADDA_LINEOUT_CTRL0_REN, 1, 0);
+
 static const char * const sun50i_codec_earpiece_src_enum_text[] = {
 	"DACR", "DACL", "Right Mixer", "Left Mixer",
 };
@@ -332,6 +333,10 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_lineout_src),
 	SND_SOC_DAPM_MUX("Right Line Out Source",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_lineout_src),
+	SND_SOC_DAPM_SWITCH("Left Line Out Switch",
+			    SND_SOC_NOPM, 0, 0, &sun50i_codec_lineout_switch),
+	SND_SOC_DAPM_SWITCH("Right Line Out Switch",
+			    SND_SOC_NOPM, 0, 0, &sun50i_codec_lineout_switch),
 	SND_SOC_DAPM_OUTPUT("LINEOUT"),
 
 	SND_SOC_DAPM_MUX("Earpiece Source Playback Route",
@@ -444,10 +449,12 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Left Line Out Source", "Stereo", "Left Mixer" },
 	{ "Left Line Out Source", "Mono Differential", "Left Mixer" },
 	{ "Left Line Out Source", "Mono Differential", "Right Mixer" },
-	{ "LINEOUT", NULL, "Left Line Out Source" },
+	{ "Left Line Out Switch", "Line Out Playback Switch", "Left Line Out Source" },
+	{ "LINEOUT", NULL, "Left Line Out Switch" },
 
-	{ "Right Line Out Source", "Stereo", "Right Mixer" },
-	{ "Right Line Out Source", "Mono Differential", "Left Line Out Source" },
+	{ "Right Line Out Switch", "Line Out Playback Switch", "Right Mixer" },
+	{ "Right Line Out Source", "Stereo", "Right Line Out Switch" },
+	{ "Right Line Out Source", "Mono Differential", "Left Line Out Switch" },
 	{ "LINEOUT", NULL, "Right Line Out Source" },
 
 	/* Earpiece Routes */
-- 
2.24.1

