Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB2D6FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 08:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfJOG7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 02:59:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41986 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfJOG7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 02:59:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so11832241pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 23:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s8ax0pNsjS34NQgcw7z1oLLF7sOclh4TjvoGbZiiLB8=;
        b=LqiY4+eTQkVeBC1lMPF7YYxbluIbw9VUU8JZtS9m6oR7ctp0sCqy0oj4hTdQIc/l15
         4DKDY8XL6sekA8doxm7hTPg4AYK71o2L3A+NMbrt5Pj3intEUQQqTlIub45xUtEBQHHY
         uD4GaZUTARVLXiFJ2UuOxQ+Qalc/tgumAzfr1ixW/QDNGrfDlhnouuNdzqQQA78tRker
         NJhTGUVomZcZO0b1u18SHLHzElT0gFfFT5bFTusN5tdKNIcWQzVZ+SPUAJYdPIe4kOwX
         TK42n/0c8B70Kd735fQhYiGw/4K/tVRxsZFiYCozdTENJ+8gZ76uk2nf4TNCdtBx/UY7
         2uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s8ax0pNsjS34NQgcw7z1oLLF7sOclh4TjvoGbZiiLB8=;
        b=dMkoH5sy25Kc3s4Wn+6ojKETPHT9z5Tbvr+prNbh9TQvHqBmRegyoqBpn/efUJRvb6
         gGRLl3Ac/cd8Ko48dgoSzPSjmSW15cKz59Q0cu1Zi4BvvtqhjqMmfo1NutR8DOunm7/2
         hKSEy0s1eql7zQaKG4p6dUnRywbneLWzFg3sN0RQn+bKdbjbs9gw8qkhbE00WoUb3wdU
         o1fl6QV8CBHdiWQR3HbnioQl9qTTXVlQ9VokwghjwZbF1WEwS813+K6IGlsJZcigiOwR
         cFt2uedmk+bytRJ0QR/qmej6cW0BomV7v0gCo6pPVTBkJMxBFILsnj7F8jHEEjykj1wE
         ApPQ==
X-Gm-Message-State: APjAAAVap6kmrddw8a3oUb+bEQ2LNDqoWsAwADRYGeCtVFSGwOYMQZOH
        3Ac39uMkPIxj+scKi+iAO+3A8Q==
X-Google-Smtp-Source: APXvYqyVrARJeunnXPSfERMIsMVbKXz1zoefqYCxcoqCdlJ+Flg5NAbVu6m+pTIqUmhkYPT5g+KCtw==
X-Received: by 2002:a62:6411:: with SMTP id y17mr37212371pfb.24.1571122780487;
        Mon, 14 Oct 2019 23:59:40 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i16sm17952646pfa.184.2019.10.14.23.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 23:59:39 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 2/4] ASoC: pcm3168a: The codec does not support S32_LE
Date:   Tue, 15 Oct 2019 00:59:35 -0600
Message-Id: <20191015065937.23169-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191015065937.23169-1-mathieu.poirier@linaro.org>
References: <20191015065937.23169-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

commit 7b2db65b59c30d58c129d3c8b2101feca686155a upstream

24 bits is supported in all modes and 16 bit only when the codec is slave
and the DAI is set to RIGHT_J.

Remove the unsupported sample format.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20190919071652.31724-1-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 sound/soc/codecs/pcm3168a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index e3de1ff3b6c2..439e40245bb0 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -24,8 +24,7 @@
 
 #define PCM3168A_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
 			 SNDRV_PCM_FMTBIT_S24_3LE | \
-			 SNDRV_PCM_FMTBIT_S24_LE | \
-			 SNDRV_PCM_FMTBIT_S32_LE)
+			 SNDRV_PCM_FMTBIT_S24_LE)
 
 #define PCM3168A_FMT_I2S		0x0
 #define PCM3168A_FMT_LEFT_J		0x1
-- 
2.17.1

