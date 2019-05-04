Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1244313ADF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2019 17:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfEDPRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 May 2019 11:17:12 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45841 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfEDPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 11:17:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id g57so9668436edc.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZXaWE0cUJ2ctMMePGlWZ/g4c5AmBJC2blqgTYPGb2A=;
        b=bdlXZixVf3e5zBoE2EDSG9jmSG32no/0xGgcoH8v8cA2N8VbZHzXmn72Zt6rLNT5Qd
         Izg4Vd/l9jlMnjT+8xbrjXvLA2iCY3H42IkO2KqLd8dvOE9jz1/AB0P69dIxdEHzHpsM
         ipwVGdaIpAXro0eM1YiRFYro4A84TOkOAMenqxlFVe/0DSUearbblWe272VY8nzdZhTf
         Yz5qFYyguCCTESg4QX5WFpG9L5bSOrZhXEbTrL0HZDfwKsRNphUs6bq8hgUfDTSUwQj4
         ZmCzwgnjh8J4IoSG04spb4+NQ9t2UEQH71uiCq8/zF7f/u+r/IuZZSbjHcCsX0QGl188
         eS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZXaWE0cUJ2ctMMePGlWZ/g4c5AmBJC2blqgTYPGb2A=;
        b=kNtWNJVqQdJQ/jR0fQeMkfQp7jBoPYEhI39DE6rjK+u105G5f+T6YSHJSbGhjfv4Jd
         3PHbrkqIfYktQBhtQlmeu1cP40UXSU8xuUxe8Su7pA534U1UVktop8+X7EdJWMfuVcHM
         ZYqhuo2JOp5vvykhvroezS0JBeN8EkM2es/9Fxuz7C3oTkNsux2wVvZMtdxWoKFT5o63
         PW0TUAL5Vdln8h/IShB6IS5fx0ufnYh3GV1C5DdTvKVDNLPrIuaqto+o0OwryGK5Ah+/
         MnTQ0fRGwPrr/8dCfD1g9EcgtUUhhi4R5nD9AzdxMEzkCgRahi6rBEY00rrY4sh2XGNc
         7NeA==
X-Gm-Message-State: APjAAAW5V9NJtptBNAXA2VSgGDTglibqaVOZeG4X0iUVwQzw2UKqgXnD
        qq6cPC4Upcv0P2ADbwSP8T0=
X-Google-Smtp-Source: APXvYqwqL8zRsW7ZKnmvsZt3KOsmnwZ984201fWB106vclGPjyd0LSLiOowgXGCcI+RaUVMePdqDNg==
X-Received: by 2002:a17:906:1ed2:: with SMTP id m18mr11505783ejj.106.1556983026467;
        Sat, 04 May 2019 08:17:06 -0700 (PDT)
Received: from elitebook-localhost (84-106-70-146.cable.dynamic.v4.ziggo.nl. [84.106.70.146])
        by smtp.gmail.com with ESMTPSA id l18sm1445711edc.33.2019.05.04.08.17.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 May 2019 08:17:05 -0700 (PDT)
From:   Nariman <narimantos@gmail.com>
X-Google-Original-From: Nariman <root>
To:     linux-kernel@vger.kernel.org
Cc:     hdegoede@redhat.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org,
        Damian van Soelen <dj.vsoelen@gmail.com>
Subject: [PATCH] ASoC: Intel: cht_bsw_rt5645.c: Remove buffer and snprintf calls
Date:   Sat,  4 May 2019 17:16:50 +0200
Message-Id: <20190504151652.5213-2-user@elitebook-localhost>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190504151652.5213-1-user@elitebook-localhost>
References: <20190504151652.5213-1-user@elitebook-localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damian van Soelen <dj.vsoelen@gmail.com>

The snprintf calls filling cht_rt5645_cpu_dai_name / cht_rt5645_codec_aif_name
always fill them with the same string ("ssp0-port" resp "rt5645-aif2") so
instead of keeping these buffers around and making the cpu_dai_name /
codec_aif_name point to this, simply update the foo_dai_name and foo_aif_name pointers to
directly point to a string constant containing the desired string.

Signed-off-by: Damian van Soelen <dj.vsoelen@gmail.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 26 ++++---------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index cbc2d458483f..b15459e56665 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -506,8 +506,6 @@ static struct cht_acpi_card snd_soc_cards[] = {
 };
 
 static char cht_rt5645_codec_name[SND_ACPI_I2C_ID_LEN];
-static char cht_rt5645_codec_aif_name[12]; /*  = "rt5645-aif[1|2]" */
-static char cht_rt5645_cpu_dai_name[10]; /*  = "ssp[0|2]-port" */
 
 static bool is_valleyview(void)
 {
@@ -641,28 +639,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	log_quirks(&pdev->dev);
 
 	if ((cht_rt5645_quirk & CHT_RT5645_SSP2_AIF2) ||
-		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2)) {
-
-		/* fixup codec aif name */
-		snprintf(cht_rt5645_codec_aif_name,
-			sizeof(cht_rt5645_codec_aif_name),
-			"%s", "rt5645-aif2");
-
-		cht_dailink[dai_index].codec_dai_name =
-			cht_rt5645_codec_aif_name;
-	}
+		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2))
+			cht_dailink[dai_index].codec_dai_name = "rt5645-aif2";
 
 	if ((cht_rt5645_quirk & CHT_RT5645_SSP0_AIF1) ||
-		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2)) {
-
-		/* fixup cpu dai name name */
-		snprintf(cht_rt5645_cpu_dai_name,
-			sizeof(cht_rt5645_cpu_dai_name),
-			"%s", "ssp0-port");
-
-		cht_dailink[dai_index].cpu_dai_name =
-			cht_rt5645_cpu_dai_name;
-	}
+		(cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2))
+			cht_dailink[dai_index].cpu_dai_name = "ssp0-port";
 
 	/* override plaform name, if required */
 	platform_name = mach->mach_params.platform;
-- 
2.20.1

