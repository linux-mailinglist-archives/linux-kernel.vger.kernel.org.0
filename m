Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F00E8A7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 22:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfHLUII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 16:08:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45770 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfHLUIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:08:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so6183671plr.12;
        Mon, 12 Aug 2019 13:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lf1Bp+42OlJDYkDhdg78vigaCDh56XZkLKRQRM+cZOU=;
        b=ivsV157OcUC416TIEiX5U0eGHo3eBnq1qK2ZvjV60lOEnlnd+y3defIb0CuhUZPj6w
         WUAs+TgnSu8XjvopPtG6m7PGImtagn+D9NRzwY2YghwuERVPWMy47/qNoBBHFudAFJty
         1uBRYfXq0wRbmGXBX9VMirM9M+/8i89a4DMl2KKnmE34Fiv4JeGdq+muqJuHgVn2ABKY
         vNDP9/cO/Qr+EN/iHUp/wZAetT7pLmLA8E8MBvbBHnbFzC6AghcuRTmJ5fEu4FsymF3S
         W1qodTmjp1YB+nAzf7WSnJvwcQSD3aSkVutV+zf9o+Z4fEANmhAl/Q6Aa0z/p8dg1nv6
         yu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lf1Bp+42OlJDYkDhdg78vigaCDh56XZkLKRQRM+cZOU=;
        b=H6tvTL4HmHAEijMV9Me3V6ADmCFtxh1wO+rqINYX7cgmK5vQhs1SnrbOw+Nm69az5g
         /fhIvv6IuW0rIWHRqC0qkH22QTSg/8TCMGqIFSg4YwAfhssd9RZwPNDQUC2hnJOkKXRA
         hAedqpcBgUFkJNmcWwvG8lrW+x7CMe41FF+xfHf69ZEznzNwR3IN2xTPTxCJm34r2Z+K
         SjE2gUKKbmd6oU909KgTFQnDBST5S5q0UYpkvYpAjJXuktp30nZwoVgItzGtCCxKYMk7
         9mwa1jLiL2PMbunlUqnJ5B+wo63VsH9xEeju3kumdwgTTKB89eIOScZJq43ecXIH1MAU
         errg==
X-Gm-Message-State: APjAAAW04swf544arICdU4RCReAu6Z6KMWakIduk7srfjghZhU7nq6FX
        odAARB9ekqqxB5lTY/tP0seIxQoY
X-Google-Smtp-Source: APXvYqw4zeKLzCv1iSaK1ebEQ5H4EVn0xHfHIR6hN3TsQ/WVs7Tjarqjia4gNcPg0bOgMEKOtgG2xg==
X-Received: by 2002:a17:902:2b8a:: with SMTP id l10mr34450069plb.283.1565640485748;
        Mon, 12 Aug 2019 13:08:05 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id o14sm352844pjp.19.2019.08.12.13.08.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:08:05 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Spencer <christopher.spencer@sea.co.uk>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/15] crypto: caam - request JR IRQ as the last step
Date:   Mon, 12 Aug 2019 13:07:28 -0700
Message-Id: <20190812200739.30389-5-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812200739.30389-1-andrew.smirnov@gmail.com>
References: <20190812200739.30389-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid any risk of JR IRQ request being handled while some
of the resources used for that are not yet allocated move the code
requesting said IRQ to the endo of caam_jr_init().

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Spencer <christopher.spencer@sea.co.uk>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/jr.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index ea02f7774f7c..98b308de42c0 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -428,38 +428,26 @@ static int caam_jr_init(struct device *dev)
 
 	jrp = dev_get_drvdata(dev);
 
-	tasklet_init(&jrp->irqtask, caam_jr_dequeue, (unsigned long)dev);
-
-	/* Connect job ring interrupt handler. */
-	error = devm_request_irq(dev, jrp->irq, caam_jr_interrupt, IRQF_SHARED,
-				 dev_name(dev), dev);
-	if (error) {
-		dev_err(dev, "can't connect JobR %d interrupt (%d)\n",
-			jrp->ridx, jrp->irq);
-		goto out_kill_deq;
-	}
-
 	error = caam_reset_hw_jr(dev);
 	if (error)
-		goto out_kill_deq;
+		return error;
 
-	error = -ENOMEM;
 	jrp->inpring = dmam_alloc_coherent(dev, sizeof(*jrp->inpring) *
 					   JOBR_DEPTH, &inpbusaddr,
 					   GFP_KERNEL);
 	if (!jrp->inpring)
-		goto out_kill_deq;
+		return -ENOMEM;
 
 	jrp->outring = dmam_alloc_coherent(dev, sizeof(*jrp->outring) *
 					   JOBR_DEPTH, &outbusaddr,
 					   GFP_KERNEL);
 	if (!jrp->outring)
-		goto out_kill_deq;
+		return -ENOMEM;
 
 	jrp->entinfo = devm_kcalloc(dev, JOBR_DEPTH, sizeof(*jrp->entinfo),
 				    GFP_KERNEL);
 	if (!jrp->entinfo)
-		goto out_kill_deq;
+		return -ENOMEM;
 
 	for (i = 0; i < JOBR_DEPTH; i++)
 		jrp->entinfo[i].desc_addr_dma = !0;
@@ -483,9 +471,17 @@ static int caam_jr_init(struct device *dev)
 		      (JOBR_INTC_COUNT_THLD << JRCFG_ICDCT_SHIFT) |
 		      (JOBR_INTC_TIME_THLD << JRCFG_ICTT_SHIFT));
 
-	return 0;
-out_kill_deq:
-	tasklet_kill(&jrp->irqtask);
+	tasklet_init(&jrp->irqtask, caam_jr_dequeue, (unsigned long)dev);
+
+	/* Connect job ring interrupt handler. */
+	error = devm_request_irq(dev, jrp->irq, caam_jr_interrupt, IRQF_SHARED,
+				 dev_name(dev), dev);
+	if (error) {
+		dev_err(dev, "can't connect JobR %d interrupt (%d)\n",
+			jrp->ridx, jrp->irq);
+		tasklet_kill(&jrp->irqtask);
+	}
+
 	return error;
 }
 
-- 
2.21.0

