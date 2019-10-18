Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4096EDBF99
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437720AbfJRIPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 04:15:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35040 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731008AbfJRIPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:15:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so3399820pfw.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uiSq7qeFYNBf+B+hvyqTL3DKogK+/9GgP2nnW/iTdJQ=;
        b=m8ChvJlMrxPv5W8hkfPBg5heCY/fbqHBiTpBTRP3b/WNHPtpzvGVHF5e5f+wCXWtss
         rZ1oxTtWrm/r15UOlkNpO/Yqi/nCcSaE2vTYRRFdUC8JUJ41R/RMgiFAjcLWBCqEbW9q
         qS42/w5YDBEf/LJhPrwB2VBrQ+9h14+tjCMHcLSDVYDQMqSL3UgXqMMyZBs1qlykOUsc
         lfTRNrLm4lw9MuG7v0032yGm+EBoRPQKCtWlZl/hGfg239A/o9eQM3nFqAWK6hikKnEL
         KTnTPx67BNmIYewuXrz8Ersk3DU4QMpbXM+tbPjrxcAJOQ5BmYx9UzQ+ggM0VZHREvj3
         TC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uiSq7qeFYNBf+B+hvyqTL3DKogK+/9GgP2nnW/iTdJQ=;
        b=Wo1Qnzf45rIVzOA9Ln9OAUexkYpU2VOE1x76LWZLnlXo9xehWB50cwCTBG/BDRFqLV
         3j4J0TI01HqEqm+T8dSMtmy7iNTFKiAXtvDrFgpbXSInMf1xTVKRZg/KkNU3hfeeUmBc
         eRtyjqMxwa22KKzCuJi+npUseYz9RDvNSOIoXljz/ba/cna1c/Y4ZHxCFQgyVF2hHQw2
         Q7PcT71HBX6NAJAWJ5JcVxXiWZeKYq86ISjk0iz3hrTGW9OwHT+RMWr5DWdAAdF76180
         jc4SKqxXSfoYp7QlWXbTvqe+16vM0ZGga6JKzNemGih+N7t99EqvGAgn0xoOqa+EO014
         pklw==
X-Gm-Message-State: APjAAAXFKvp78h/bfQXGH1Llc6LAEoypXJqj0bjBI6Kk7IZY+g2hCUuz
        kdiUOV0EUXEmnfNw1jXmW5c=
X-Google-Smtp-Source: APXvYqyaREvbxLHrPizSXgFUs5I1CvDkE+rdYjdtx6uTUnVXZOAzUbbFx63V9/unDy0Pp9RTOGw4Kw==
X-Received: by 2002:aa7:9472:: with SMTP id t18mr5105603pfq.261.1571386519409;
        Fri, 18 Oct 2019 01:15:19 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id z12sm5688656pfj.41.2019.10.18.01.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:15:18 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] ASoC: tlv320aic32x4: add a check for devm_clk_get
Date:   Fri, 18 Oct 2019 16:14:49 +0800
Message-Id: <20191018081448.8486-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aic32x4_set_dai_sysclk misses a check for devm_clk_get and may miss the
failure.
Add a check to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 68165de1c8de..b4e9a6c73f90 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -573,6 +573,9 @@ static int aic32x4_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	struct clk *pll;
 
 	pll = devm_clk_get(component->dev, "pll");
+	if (IS_ERR(pll))
+		return PTR_ERR(pll);
+
 	mclk = clk_get_parent(pll);
 
 	return clk_set_rate(mclk, freq);
-- 
2.20.1

