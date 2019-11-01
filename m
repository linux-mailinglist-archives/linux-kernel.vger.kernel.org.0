Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B64CEC2E8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 13:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbfKAMmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 08:42:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37572 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730750AbfKAMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id v2so10129739lji.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/C1Eg1dR+pzbI0uF0+AzerXAuAR/n78tvkDzoMBSgLI=;
        b=E6p6xxCrNL24MJSKd9WV7hyzQub0rZ74qqVrC33D8S4zffFOXSmiI07OOrVK/EYRr7
         RUa2hKLf0AbNe1U4vqbo424rJ6TtF5dZ7URlni+1mSdKFNbhfuyDZH2bmwUkEc1PN5+y
         KsDZUcdFfYKJBovm1/jt9ezy8dXuKFe/haEvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/C1Eg1dR+pzbI0uF0+AzerXAuAR/n78tvkDzoMBSgLI=;
        b=P0JLtkbw7DxOwAIevvY7ocGLRgnOftLaph/qD8g/Lvl+ma9BcRO35ku0zZ8jhlW40q
         X7XKj6jDfCRrbQgi4prcT4IgkiF/jo3i3CGfB0hn6CTeORUUbSM9SewTwX7UeT9DqSNb
         mp3XxalSetcrUAvpUgWYAB+5sL6KE96iqOKkW2cpeiE36Ns+nop+fz0rzFroe3FsEFf0
         s4awmbhDt40a24xbKavl0gmMPyK1P1qsAwznL1rF+Vc79Z8Lz8EocQ8cvxJBUbIXhHpH
         2AmrP16tfwpgDP5fNMp4ao/5M8ECQfWAkGow+asGM5QYsjnusoD/7/oLQyojFGFGL4lB
         gbbA==
X-Gm-Message-State: APjAAAXOj55fTGMwDtmPFGpo03sYzXeFxQPaXhYsBjfmJKrJ8UWiSnbk
        6ro22AZK8X2FxTDIMmr24QyhjA==
X-Google-Smtp-Source: APXvYqwFNc8j57WfHASb7dDdRvzJDRCUUK7Jd083Crpc8DfY36CzXhgw+rR0rcivqtg51F7xRMNXHQ==
X-Received: by 2002:a2e:8007:: with SMTP id j7mr8239471ljg.19.1572612164992;
        Fri, 01 Nov 2019 05:42:44 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:44 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 24/36] soc: fsl: qe: qe_io.c: access device tree property using be32_to_cpu
Date:   Fri,  1 Nov 2019 13:41:58 +0100
Message-Id: <20191101124210.14510-25-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to apply be32_to_cpu to make this work correctly on
little-endian hosts.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_io.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index 99aeb01586bd..61dd8eb8c0fe 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -142,7 +142,7 @@ int par_io_of_config(struct device_node *np)
 {
 	struct device_node *pio;
 	int pio_map_len;
-	const unsigned int *pio_map;
+	const __be32 *pio_map;
 
 	if (par_io == NULL) {
 		printk(KERN_ERR "par_io not initialized\n");
@@ -167,9 +167,15 @@ int par_io_of_config(struct device_node *np)
 	}
 
 	while (pio_map_len > 0) {
-		par_io_config_pin((u8) pio_map[0], (u8) pio_map[1],
-				(int) pio_map[2], (int) pio_map[3],
-				(int) pio_map[4], (int) pio_map[5]);
+		u8 port        = be32_to_cpu(pio_map[0]);
+		u8 pin         = be32_to_cpu(pio_map[1]);
+		int dir        = be32_to_cpu(pio_map[2]);
+		int open_drain = be32_to_cpu(pio_map[3]);
+		int assignment = be32_to_cpu(pio_map[4]);
+		int has_irq    = be32_to_cpu(pio_map[5]);
+
+		par_io_config_pin(port, pin, dir, open_drain,
+				  assignment, has_irq);
 		pio_map += 6;
 		pio_map_len -= 6;
 	}
-- 
2.23.0

