Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6359E100401
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 12:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfKRLZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 06:25:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42716 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfKRLX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:23:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so18981099wrf.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCPu9Gq+U2RPRhQiWL2MkNy7+uq9EAlYdyc3guVWBBY=;
        b=Yk7p/G71NJ4xYDxkVfbpJ1+UrVSfYV+gyTCQfmi46U9LouNYDNp+cxJmMwhPBuXOUh
         zx3WOhz2CX4UJ3rdW9cXaDfJ5a8dpQfRnvTiQIDU/v9xJjXIeGSa28iLidu8W1G/bdi0
         J/Klx8ZYp7nbuJnGizHDFsLErPLTgtpoRRlfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCPu9Gq+U2RPRhQiWL2MkNy7+uq9EAlYdyc3guVWBBY=;
        b=hqpgVcIzaB/5maQdgEPqFG1OEfNhGqk8SgZ609ffT4Bby8NcAc/4u8f/Cn/iNdLxZy
         ryGp9fd6C/9TAmZ4qyz4zpO9zGKNuTTz0CphnC61LHdCcBPZ1ScA79HuC3tblkOrz2QA
         heKHVfbL3u0PNgujbVS8YsJjYtTMdnSqg+sY3xUcA4ubjZv71fnQkwYDlfEdmZCEML3N
         Q5e4256jdYS74SWH3cpyZLu9eLEBLc8NilVtl0SkpWXjaWa/8EItl+lXUKudtclY50Th
         ocV+ZISAfVVndifpNlbUCrLrUQsryvIFUck+gNlGW0upPbCaN0IXcFWtUhmRLgkOqM92
         h6wA==
X-Gm-Message-State: APjAAAVu6aWk3Iv1mE+SsUJDrcR9E654ZVA5q4PU2QGcEyfjXswXNQwi
        yAdN1Fp/vKuSUWtg59svoL9rBg==
X-Google-Smtp-Source: APXvYqyZQpRRB/MFghGLS7bJn/RObD/k7dDdrG7vxDwjNjB8Ot+1GZEzgAMa9xVYMp80+4l7TXQLQQ==
X-Received: by 2002:adf:e5c5:: with SMTP id a5mr14806776wrn.103.1574076236602;
        Mon, 18 Nov 2019 03:23:56 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:23:56 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 20/48] soc: fsl: qe: simplify qe_ic_init()
Date:   Mon, 18 Nov 2019 12:22:56 +0100
Message-Id: <20191118112324.22725-21-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qe_ic_init() takes a flags parameter, but all callers (including the
sole remaining one) have always passed 0. So remove that parameter and
simplify the body accordingly. We still explicitly initialize the
Interrupt Configuration Register (CICR) to its reset value of
all-zeroes, just in case the bootloader has played funny games.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 23b457e884d8..4832884da5bb 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -356,13 +356,13 @@ static void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
 	chip->irq_eoi(&desc->irq_data);
 }
 
-static void __init qe_ic_init(struct device_node *node, unsigned int flags)
+static void __init qe_ic_init(struct device_node *node)
 {
 	void (*low_handler)(struct irq_desc *desc);
 	void (*high_handler)(struct irq_desc *desc);
 	struct qe_ic *qe_ic;
 	struct resource res;
-	u32 temp = 0, ret;
+	u32 ret;
 
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret)
@@ -399,26 +399,7 @@ static void __init qe_ic_init(struct device_node *node, unsigned int flags)
 		high_handler = NULL;
 	}
 
-	/* default priority scheme is grouped. If spread mode is    */
-	/* required, configure cicr accordingly.                    */
-	if (flags & QE_IC_SPREADMODE_GRP_W)
-		temp |= CICR_GWCC;
-	if (flags & QE_IC_SPREADMODE_GRP_X)
-		temp |= CICR_GXCC;
-	if (flags & QE_IC_SPREADMODE_GRP_Y)
-		temp |= CICR_GYCC;
-	if (flags & QE_IC_SPREADMODE_GRP_Z)
-		temp |= CICR_GZCC;
-	if (flags & QE_IC_SPREADMODE_GRP_RISCA)
-		temp |= CICR_GRTA;
-	if (flags & QE_IC_SPREADMODE_GRP_RISCB)
-		temp |= CICR_GRTB;
-
-	/* choose destination signal for highest priority interrupt */
-	if (flags & QE_IC_HIGH_SIGNAL)
-		temp |= (SIGNAL_HIGH << CICR_HPIT_SHIFT);
-
-	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
+	qe_ic_write(qe_ic->regs, QEIC_CICR, 0);
 
 	irq_set_handler_data(qe_ic->virq_low, qe_ic);
 	irq_set_chained_handler(qe_ic->virq_low, low_handler);
@@ -439,7 +420,7 @@ static int __init qe_ic_of_init(void)
 		if (!np)
 			return -ENODEV;
 	}
-	qe_ic_init(np, 0);
+	qe_ic_init(np);
 	of_node_put(np);
 	return 0;
 }
-- 
2.23.0

