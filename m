Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A12D13467B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 16:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAHPmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 10:42:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43018 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgAHPmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:42:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id x6so1804105pfo.10;
        Wed, 08 Jan 2020 07:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzFFEei+JwG2EZuAl0ehAfcwGBgiwRJjuVINpXuZnf8=;
        b=KVEziDG5F7/xs1cRyrwrrAtV0AMGoout0aH231tCyCdZx40Nj3RlcgF+KpzPWkvGAQ
         UkYG9gSgmEi1q4A1563uJwVy3L/M7EwJBcN+BX3aLWU2XFA3j4v/BjKZId1lZR1wD00D
         EtEwtVD6lkSe9KjuDhJBhV/VT4voOFCbTWoNusW6+S0d2utwR+RphjiC1xg5JZbiadCp
         IR8sn3t5ibt47otmhn94/JdcLQFYnkkeBLqN7iXtFlDY41l2+WRI6R54nAkfULufB4DM
         FE6qZTVMqZTT4AdwcLwiZfjpEFOZ6la9kR0EoD9YaogBwNxDwYFNG6z0Z51vJHrlV5td
         5XBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzFFEei+JwG2EZuAl0ehAfcwGBgiwRJjuVINpXuZnf8=;
        b=awhIHQlXS82M89Ya2PQtOzfO2s8ctWMPY9J76tAnpHky+y/uGrg35f54rUmGfm1fLD
         3rEBRdp+eQy96/XEK6Qse2ZujWe/rhsO0+VdCB5H4J0hmxp6Nch4v59Ezc7oAUsrm7ac
         Z+mGBbl6O8IiKcd+WC3x4f/6fOBAcHGHCgftfsDohkgU0DdMgzUg8HVdPSgTg2bmwcJ+
         pg/z3zrpuefjtscYhB1yQi88X6zQ21qNgfh7YVJ36nPNnuNBM7r7MkPLm0Zd6h3JCB9o
         pIQgIUGiQdaxTqfgp407vM8TbB1w9pKQChlJNxwc2fKtfLbHqNZ9ypFWem8JDzAXdCiB
         +D7g==
X-Gm-Message-State: APjAAAW0H3GVfUngrdVEEeDPLIMYV/SPR87n1R9BPCU4cYBlZe+FRjg1
        wxjQPJ5dfI5MnPwgm1qr/YIiYGot
X-Google-Smtp-Source: APXvYqyw7/Tfbz/3km4S6vfphbbp3vGQJ4bGCeD8bUUwGESsP7pEwvYkiyKosoafMjrhlNfLVsytXA==
X-Received: by 2002:a62:2cc1:: with SMTP id s184mr5807578pfs.111.1578498123143;
        Wed, 08 Jan 2020 07:42:03 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id e1sm4286640pfl.98.2020.01.08.07.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 07:42:02 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v6 5/7] crypto: caam - invalidate entropy register during RNG initialization
Date:   Wed,  8 Jan 2020 07:40:45 -0800
Message-Id: <20200108154047.12526-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200108154047.12526-1-andrew.smirnov@gmail.com>
References: <20200108154047.12526-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make sure that we always use non-stale entropy data, change
the code to invalidate entropy register during RNG initialization.

Signed-off-by: Aymen Sghaier <aymen.sghaier@nxp.com>
Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
[andrew.smirnov@gmail.com ported to upstream kernel, rewrote commit msg]
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-imx@nxp.com
---
 drivers/crypto/caam/ctrl.c | 11 ++++++++---
 drivers/crypto/caam/regs.h |  3 ++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index c99a6a3b22de..22d8676dd610 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -338,8 +338,12 @@ static void kick_trng(struct platform_device *pdev, int ent_delay)
 	ctrl = (struct caam_ctrl __iomem *)ctrlpriv->ctrl;
 	r4tst = &ctrl->r4tst[0];
 
-	/* put RNG4 into program mode */
-	clrsetbits_32(&r4tst->rtmctl, 0, RTMCTL_PRGM);
+	/*
+	 * Setting both RTMCTL:PRGM and RTMCTL:TRNG_ACC causes TRNG to
+	 * properly invalidate the entropy in the entropy register and
+	 * force re-generation.
+	 */
+	clrsetbits_32(&r4tst->rtmctl, 0, RTMCTL_PRGM | RTMCTL_ACC);
 
 	/*
 	 * Performance-wise, it does not make sense to
@@ -369,7 +373,8 @@ static void kick_trng(struct platform_device *pdev, int ent_delay)
 	 * select raw sampling in both entropy shifter
 	 * and statistical checker; ; put RNG4 into run mode
 	 */
-	clrsetbits_32(&r4tst->rtmctl, RTMCTL_PRGM, RTMCTL_SAMP_MODE_RAW_ES_SC);
+	clrsetbits_32(&r4tst->rtmctl, RTMCTL_PRGM | RTMCTL_ACC,
+		      RTMCTL_SAMP_MODE_RAW_ES_SC);
 }
 
 static int caam_get_era_from_hw(struct caam_ctrl __iomem *ctrl)
diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 05127b70527d..c191e8fd0fa7 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -487,7 +487,8 @@ struct rngtst {
 
 /* RNG4 TRNG test registers */
 struct rng4tst {
-#define RTMCTL_PRGM	0x00010000	/* 1 -> program mode, 0 -> run mode */
+#define RTMCTL_ACC  BIT(5)  /* TRNG access mode */
+#define RTMCTL_PRGM BIT(16) /* 1 -> program mode, 0 -> run mode */
 #define RTMCTL_SAMP_MODE_VON_NEUMANN_ES_SC	0 /* use von Neumann data in
 						     both entropy shifter and
 						     statistical checker */
-- 
2.21.0

