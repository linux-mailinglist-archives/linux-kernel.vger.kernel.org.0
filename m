Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09498A7E8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 22:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfHLUI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 16:08:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33002 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfHLUIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:08:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so50248910pfq.0;
        Mon, 12 Aug 2019 13:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BNJCQUNcof8kUIy33ye35eh+3AWm1VC+G5oQzkM3XSE=;
        b=WHTEtjXRo8DrdN1VRmDhMPuVlMxvMxS/wA2pCm1btxsleh+qXPysnYVh2SBw9+cs9V
         Smrq1ymVhBkbZYnOTYKYKm8OQTpIVvesEqfDKJwTCgqdYagoxUdDkKe5fNrIkQNjnINf
         TpHRkerNv0m6HyHwMKsLApHXVglSzMFOUdwGfYcIUxAii/KEpaFGmTBC+WD205zuJVrp
         xndidFP4sBLRhfp3iz0zE0r3Kh2bxV46JAkCHxSuOK4EHbMRukOrYh9RptRHBkIaDBp9
         E/6hfNDViIjtHS9c1IFENz91N45cGLZQMnvCErls6rw937S7MlIWfz66nWd+ZpCfYL/I
         eV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNJCQUNcof8kUIy33ye35eh+3AWm1VC+G5oQzkM3XSE=;
        b=BVH8ToZVcu+dtB+N9vA8TRMjYDwISkWFHio9aQrWQqzD1TAlbodZ8/OjVDcPGy1OJP
         s2K5NwywlkjjEAPUiIeQC8764AfGaoBXX94hw3J6IrULxEvvm1lJv3ZiMRBcmLHaB7Et
         GYcNDJhU/TYoefMPjprmUEP71+cVleHn51Pp2TtW37kg6TxZZLbkJacBv0P0v5QPU5gc
         NpHBs+ZDGFO+qo/8MGgd7iDyc3rM7pZGo+lNyEAmAkVYi1dwVpezIaaDI5qK2XC18dLH
         9QRVPTOC0OUT6M5LzIOB/i2fuRmeocvJKxUOrteKy8WpFWvumL3HbuF8k/JGNuVyx8N4
         XOGA==
X-Gm-Message-State: APjAAAVfoeI3sBHX+aMoleCLdyjxNsU0jRRU+0J1PnC4DsPziTxJGg4q
        tYPEoAGXxS8bzUwuw+kO+1GQtRHt
X-Google-Smtp-Source: APXvYqx8qUaZUXh2jl63iVLoehuXgxWsETKSHBB1LArwgeHCYiAIVWk/xu1RDPcUa4EESI7ev7VV7Q==
X-Received: by 2002:a63:ff0c:: with SMTP id k12mr30297926pgi.186.1565640494071;
        Mon, 12 Aug 2019 13:08:14 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id o14sm352844pjp.19.2019.08.12.13.08.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 13:08:13 -0700 (PDT)
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
Subject: [PATCH v7 10/15] crypto: caam - move cpu_to_caam_dma() selection to runtime
Date:   Mon, 12 Aug 2019 13:07:34 -0700
Message-Id: <20190812200739.30389-11-andrew.smirnov@gmail.com>
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

Instead of selecting the implementation of
cpu_to_caam_dma()/caam_dma_to_cpu() at build time using the
preprocessor, convert the code to do that at run-time using IS_ENABLED
macro. This is needed to add support for i.MX8MQ. No functional change
intended.

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
 drivers/crypto/caam/regs.h | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index fb494d14f262..511e28ba740a 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -188,13 +188,21 @@ static inline u64 caam_dma64_to_cpu(u64 value)
 	return caam64_to_cpu(value);
 }
 
-#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
-#define cpu_to_caam_dma(value) cpu_to_caam_dma64(value)
-#define caam_dma_to_cpu(value) caam_dma64_to_cpu(value)
-#else
-#define cpu_to_caam_dma(value) cpu_to_caam32(value)
-#define caam_dma_to_cpu(value) caam32_to_cpu(value)
-#endif /* CONFIG_ARCH_DMA_ADDR_T_64BIT */
+static inline u64 cpu_to_caam_dma(u64 value)
+{
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
+		return cpu_to_caam_dma64(value);
+	else
+		return cpu_to_caam32(value);
+}
+
+static inline u64 caam_dma_to_cpu(u64 value)
+{
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
+		return caam_dma64_to_cpu(value);
+	else
+		return caam32_to_cpu(value);
+}
 
 /*
  * jr_outentry
-- 
2.21.0

