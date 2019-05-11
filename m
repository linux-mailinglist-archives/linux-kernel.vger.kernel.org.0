Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F061A834
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2019 17:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfEKPML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 11:12:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39227 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfEKPMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 11:12:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id w8so8311150wrl.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=C9xJNH3rQETX8Uvs3BiVRbTmI3eQORXEanCcAES6EWo=;
        b=edW68aqiIHYXtk5/iyC/IjpLFuHH5sNyT/MWGYlKWphrNuWw6CC4sAOLKhR+YYuFjY
         wAdYHFoArU5lVWImIRBdWDF0fhK8aEMDjL4/3KVfbNk3dEDIwVa4PXdlhtkLCQSfNFSu
         Alc4+s7PmH0P3dmVS1JlC1J59yekcgeWRdNw/NXDpyhkj/hD5dcuy8/CNEKNtNfP8MMD
         VeBFVLvzem3RIthSx+dOCgrGxTTxwMxh4e+C2aEl/urK1grtbM3umIY5Jx9l39bBo3oI
         BJelrPxkXR1wZWnYk6f1emsArtADKTW3V8WJSHtSrobvE1pMl/TIAYUxOyHzSeq6oRTz
         Bzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=C9xJNH3rQETX8Uvs3BiVRbTmI3eQORXEanCcAES6EWo=;
        b=bXu2HukxLzZ3262ZrvgV+sCI6oOiEi3fJ0OLpJhhHqwW9+HuTjSAu9Rc43pwXQ7854
         14AnmaoXDfcrvD9q9U3MJafiVAZc7jPVOYtT/N0KcryXMUNFUufvzbpaAxqwMT77C9SL
         FMdxeDT0KgeLBO5Mr7jV/Yk4lUMvyBNxl6hYE4yHZaGoWkru+/s/QWgShzeKOWJ8fDE1
         6Ry7jV6y3vg5ASw5mvthgtoAqOFzDpflpeu0X4Zui1+pArXWugnDaA9QJGcMcMXKMie3
         OXfNQk+MoJ+or0FYE9UUNTDp8quZBxi7Dtnon/C613+zD938My0URzpF+ef/+rrotRPE
         VFzg==
X-Gm-Message-State: APjAAAUnx8IOpnt7vG6FyYJIADo8GZ9/KcOpwqU424XgNaGXGIH6OPs3
        HaopxjCfNQqqlpoNDbiVHss=
X-Google-Smtp-Source: APXvYqyWfcN3Yu3qXJX1XKz4kwKny7FzO4sA95+9hvM0ipCvNtla9/0vQyTesyjVdmZHRW/aV4yrqA==
X-Received: by 2002:a5d:6b46:: with SMTP id x6mr11143117wrw.313.1557587529021;
        Sat, 11 May 2019 08:12:09 -0700 (PDT)
Received: from localhost.localdomain (p5DCFEB77.dip0.t-ipconnect.de. [93.207.235.119])
        by smtp.gmail.com with ESMTPSA id c9sm5650992wrv.62.2019.05.11.08.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 08:12:07 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] ASoC: tlv320aic3x: Add support for high power analog output
Date:   Sat, 11 May 2019 17:11:49 +0200
Message-Id: <20190511151149.28823-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to output level control for the analog high power output
drivers HPOUT and HPCOM.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---

Notes:
    Notes:
        Changes in V4:
        -Added separate mono playback volume control
        -grouped volume controls with corresponding switch
    
        Changes in V3:
        -Fixed compilation error
    
        Changes in V2:
        - Removed power control as it is handled by DAPM
        - Added level control for left channel

 sound/soc/codecs/tlv320aic3x.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 516d17cb2182..599e4ed3850b 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -324,6 +324,9 @@ static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 50, 0);
  */
 static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);
 
+/* Output volumes. From 0 to 9 dB in 1 dB steps */
+static const DECLARE_TLV_DB_SCALE(out_tlv, 0, 100, 0);
+
 static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Output */
 	SOC_DOUBLE_R_TLV("PCM Playback Volume",
@@ -386,11 +389,17 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 			 DACL1_2_HPLCOM_VOL, DACR1_2_HPRCOM_VOL,
 			 0, 118, 1, output_stage_tlv),
 
-	/* Output pin mute controls */
+	/* Output pin controls */
+	SOC_DOUBLE_R_TLV("Line Playback Volume", LLOPM_CTRL, RLOPM_CTRL, 4,
+			 9, 0, out_tlv),
 	SOC_DOUBLE_R("Line Playback Switch", LLOPM_CTRL, RLOPM_CTRL, 3,
 		     0x01, 0),
+	SOC_DOUBLE_R_TLV("HP Playback Volume", HPLOUT_CTRL, HPROUT_CTRL, 4,
+			 9, 0, out_tlv),
 	SOC_DOUBLE_R("HP Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
 		     0x01, 0),
+	SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTRL,
+			 4, 9, 0, out_tlv),
 	SOC_DOUBLE_R("HPCOM Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
 		     0x01, 0),
 
@@ -472,6 +481,9 @@ static const struct snd_kcontrol_new aic3x_mono_controls[] = {
 			 0, 118, 1, output_stage_tlv),
 
 	SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
+	SOC_SINGLE_TLV("Mono Playback Volume", MONOLOPM_CTRL, 4, 9, 0,
+			out_tlv),
+
 };
 
 /*
-- 
2.17.1

