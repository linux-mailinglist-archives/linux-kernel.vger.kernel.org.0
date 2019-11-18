Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC311003EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 12:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKRLXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 06:23:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35642 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfKRLXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:23:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id 8so18376899wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XBMri+/30LVPDwr/Z+UtZHm4sLSriiAUm4o/nxS90ZM=;
        b=XwxihX/gOwrx+y04fM23yehEh+sPis4cGHhlyJmxzkcnYDvy0QGxfaHnzbuslYnP8w
         vPQYU+JOn6T6eUjPcYuJdpGSZpQQ8KopPXBLQLO+Cnq00CmTVfqoGU0TVjG9XsGrTeRI
         3EObzG2+QC760zIH/Z5JnFmsHP9k/oZs5kUPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XBMri+/30LVPDwr/Z+UtZHm4sLSriiAUm4o/nxS90ZM=;
        b=aV60TACNmUJNWJ9vlW4j7mHP4v/tMfcMgc4GYMcqFn+fqz6gmZKs+yEEVibAG6nDq1
         BTe35xTcNzKbirHw6WONA5DAbjNf3rImUe15xfa4yRxUd5uZvIGxCnEbipBF4AS84mzi
         bdzOK27yZbcRULewfLjpVb8DNj31n0FcZlvBzcjJTokLEVCcPGCkYH79z90H6laC+mx3
         P3glHW+WEKtDglWrCJ+LwkBfZrtUgzChb/BaJG4mu9L6WHWvru831AlXDZZU6bPAZVwB
         PLomOb9ezFIZ7f/j+XO3X365kjrSf68scjr5EwR2o58J8CpFqQNm5srQrf2eE+nB63kB
         BvQA==
X-Gm-Message-State: APjAAAX5wQiW0HFbkj5kQ0DpONqOvP7OkfmX28hRgrF/tsLu2EHaSSkh
        HhDXORS8gU45pFPpSdr0FQLx2Q==
X-Google-Smtp-Source: APXvYqyofnRzcLiCqR4UEC7wz7/x2pof42n82PY10PtFAILsthfOJbkCddIWyFORHPtQjnOdgXG+Ww==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr30646195wmc.113.1574076224233;
        Mon, 18 Nov 2019 03:23:44 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:23:43 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 11/48] soc: fsl: qe: use qe_ic_cascade_{low,high}_mpic also on 83xx
Date:   Mon, 18 Nov 2019 12:22:47 +0100
Message-Id: <20191118112324.22725-12-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The *_ipic and *_mpic handlers are almost identical - the only
difference is that the latter end with an unconditional
chip->irq_eoi() call. Since IPIC does not have ->irq_eoi, we can
reduce some code duplication by calling irq_eoi conditionally.

This is similar to what is already done in mpc8xxx_gpio_irq_cascade().

This leaves the functions slightly misnamed, but that will be fixed in
a subsequent patch.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/platforms/83xx/misc.c |  2 +-
 include/soc/fsl/qe/qe_ic.h         | 24 ++++--------------------
 2 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index f46d7bf3b140..779791c0570f 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -100,7 +100,7 @@ void __init mpc83xx_qe_init_IRQ(void)
 		if (!np)
 			return;
 	}
-	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, qe_ic_cascade_high_ipic);
+	qe_ic_init(np, 0, qe_ic_cascade_low_mpic, qe_ic_cascade_high_mpic);
 	of_node_put(np);
 }
 
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index 714a9b890d8d..bfaa233d8328 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -74,24 +74,6 @@ void qe_ic_set_highest_priority(unsigned int virq, int high);
 int qe_ic_set_priority(unsigned int virq, unsigned int priority);
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 
-static inline void qe_ic_cascade_low_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
-static inline void qe_ic_cascade_high_ipic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-}
-
 static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 {
 	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
@@ -101,7 +83,8 @@ static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	chip->irq_eoi(&desc->irq_data);
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
 }
 
 static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
@@ -113,7 +96,8 @@ static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
 
-	chip->irq_eoi(&desc->irq_data);
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
 }
 
 static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
-- 
2.23.0

