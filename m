Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 076D2EC307
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 13:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfKAMoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 08:44:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36616 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbfKAMmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id a6so3735505lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I90vJMFtkMg4SHfbJTMtwkyg7nT+nson2WyIsvh49PY=;
        b=fwz3W8VIOVgCMOZ3elYmFERXD1wdd6CQzpFZDqpzOtPhfUvapxE7zvE83wOlPLx8R4
         hoCFytPkXsTDkFU6Y+nBeH1vmebe1Azh0chnoB74nX5Fi0PC3qGL+JOdXMyHg8ydY4jT
         zFjyHLiURO77q4P2IujqAj8OFzaEQMRccWueA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I90vJMFtkMg4SHfbJTMtwkyg7nT+nson2WyIsvh49PY=;
        b=hPusy6kM91bgBzuiSD7C7j+CaVnYphdslB13dnbXw2U3Dg3nnxwQLLZXKLB4ZuigfX
         mLTjsSLVLS/iED9m+6HjDzvO6mNjAQ5UPkZxP3qdQGb67k+vIRcZW9Q6EHA6w4LrMWGc
         c9ygETiXla17vjhld23VYV1PtadmevXrCpkLV26Os3NB8SJAWiA14lWBlyC6BwQLybDT
         OKJPw9uXhlZ17PGlb/YzQzMdGcl7gjtACaI9ekniJxyFTvoclNb2XxxSJbvrfUOUytie
         wmfpaf1YswVGq2/lDhGQNMoFnWexJMF753g9z52/3QCYQu/hGIta+yZf4R4rdxrw1Upp
         uwKA==
X-Gm-Message-State: APjAAAXFKiOtiPvfYJd3YISs+ivyHPMbkrpYLds1BvpW70uZOrpCa5iH
        /9WVsn+3WoeRTBEAMUgsUwthdza4Tgw7wpcF
X-Google-Smtp-Source: APXvYqwtMoUta6sPcxyB93WEK9wGQ4hplYQLe3KghtN6vYeIbE0oXmJPnN4Xf+vakJ51f6NsmM6g8w==
X-Received: by 2002:a19:ad4a:: with SMTP id s10mr7031466lfd.159.1572612154761;
        Fri, 01 Nov 2019 05:42:34 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:34 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 15/36] soc: fsl: qe: move qe_ic_cascade_* functions to qe_ic.c
Date:   Fri,  1 Nov 2019 13:41:49 +0100
Message-Id: <20191101124210.14510-16-linux@rasmusvillemoes.dk>
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

These functions are only ever called through a function pointer, and
therefore it makes no sense for them to be "static inline" - gcc has
no choice but to emit a copy in each translation unit that takes the
address of one of these. Since they are now only referenced from
qe_ic.c, just make them local to that file.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_ic.c | 42 ++++++++++++++++++++++++++++++++++++++
 include/soc/fsl/qe/qe_ic.h | 42 --------------------------------------
 2 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index a062efac398b..94ccbeeb1ad1 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -314,6 +314,48 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
 	return irq_linear_revmap(qe_ic->irqhost, irq);
 }
 
+static void qe_ic_cascade_low_mpic(struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+}
+
+static void qe_ic_cascade_high_mpic(struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+}
+
+static void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
+{
+	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
+	unsigned int cascade_irq;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	cascade_irq = qe_ic_get_high_irq(qe_ic);
+	if (cascade_irq == NO_IRQ)
+		cascade_irq = qe_ic_get_low_irq(qe_ic);
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+
+	chip->irq_eoi(&desc->irq_data);
+}
+
 static void __init qe_ic_init(struct device_node *node, unsigned int flags)
 {
 	void (*low_handler)(struct irq_desc *desc);
diff --git a/include/soc/fsl/qe/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
index a47a0d26acbd..43e4ce95c6a0 100644
--- a/include/soc/fsl/qe/qe_ic.h
+++ b/include/soc/fsl/qe/qe_ic.h
@@ -67,46 +67,4 @@ void qe_ic_set_highest_priority(unsigned int virq, int high);
 int qe_ic_set_priority(unsigned int virq, unsigned int priority);
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 
-static inline void qe_ic_cascade_low_mpic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-
-	if (chip->irq_eoi)
-		chip->irq_eoi(&desc->irq_data);
-}
-
-static inline void qe_ic_cascade_high_mpic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-
-	if (chip->irq_eoi)
-		chip->irq_eoi(&desc->irq_data);
-}
-
-static inline void qe_ic_cascade_muxed_mpic(struct irq_desc *desc)
-{
-	struct qe_ic *qe_ic = irq_desc_get_handler_data(desc);
-	unsigned int cascade_irq;
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	cascade_irq = qe_ic_get_high_irq(qe_ic);
-	if (cascade_irq == NO_IRQ)
-		cascade_irq = qe_ic_get_low_irq(qe_ic);
-
-	if (cascade_irq != NO_IRQ)
-		generic_handle_irq(cascade_irq);
-
-	chip->irq_eoi(&desc->irq_data);
-}
-
 #endif /* _ASM_POWERPC_QE_IC_H */
-- 
2.23.0

