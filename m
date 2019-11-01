Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E221EC2E5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 13:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfKAMmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 08:42:47 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44691 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbfKAMmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id g3so4004915ljl.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCPu9Gq+U2RPRhQiWL2MkNy7+uq9EAlYdyc3guVWBBY=;
        b=WSqnr0Hm+/gFNdDem+IEaoGr/zYoFMMBc8+/ena2Ptteerae4XudwbeLORwFmVK1CS
         wMH7ZP+EjS6wrKCoznoFh6dE3i14Wbs6fWPVtfVanCB8IXedfSs54iBLG6yy4w5MSOk9
         iLNC8zJk2PGCzf4IqPU+QUiRSaQuwFNfXX/hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCPu9Gq+U2RPRhQiWL2MkNy7+uq9EAlYdyc3guVWBBY=;
        b=Ot69KMo8hX0oj8odCk2uj+NpX0S0arlH8bNvHzcmfs3lCazDVQl+nFe7zHpurJOaTD
         5IBgreGZvRDgYjeM36CTgxrfORzWSmsOyzWisaS9KZ9kYYjQ8mjeMYdSh6aMlqvHJg5o
         kJdddrhoN04QhCFYmvwp+WpDvHkdm44wtEdX4PS/4rUjVjYuoR8W980gbDysTqXgGYZ9
         72dwE240/DwqyUHg2MEP9BqVd4BBrh/t6pS3MpRf98Pq21auUhgPw5/0JMLu/ZSV/HJT
         T9lvxj5u/AtRNrmrIjCaQdTwnZ2ejMn5VE5mgVLfaXtQKjNi3HBmoU1OfM+C5t2krAIX
         tqWQ==
X-Gm-Message-State: APjAAAXfTjJhhv3zipam1ax99MHenG+1Vyk4r66pdTnrbRtqwmqLNa80
        VjFAORMUl3csr+z+PrD0zWQrVw==
X-Google-Smtp-Source: APXvYqzVq8AUgtdiqD8vjU5+oTOV5JeFRd7oj8Ye+Idv2/CjNlLXzzRz4SRdZ8W95LRMAd2VZLD0xQ==
X-Received: by 2002:a2e:320c:: with SMTP id y12mr8026980ljy.7.1572612160372;
        Fri, 01 Nov 2019 05:42:40 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:40 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 20/36] soc: fsl: qe: simplify qe_ic_init()
Date:   Fri,  1 Nov 2019 13:41:54 +0100
Message-Id: <20191101124210.14510-21-linux@rasmusvillemoes.dk>
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

