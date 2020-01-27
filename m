Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD0614A873
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 17:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgA0Q5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 11:57:30 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39170 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgA0Q5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:57:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so5171556pfs.6;
        Mon, 27 Jan 2020 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lq9n6SOnc0hSj1FFyZM2mcFj9cA359i3RcrvKhosWgE=;
        b=gYZ2iu3VsXA3qiwG2OYbTYh/yKOssH7yYlaE6Wjtj7IFjrOE37+Hz/xxtBTpSNbdf0
         lrx9ft3PWOtp4/KMoEQX/mv130d6cl/B7/fXd/AS6qz10YhCnd22LFtPTtRyViaC0ac3
         OH2511wNBKOxX4lzExyThiPV8ierATtYRFwC1zkBl9SoCk9If32piaP96WJETZsBlwGX
         /kLkoW59PRSbFF6GxPWkNZ82gIV6zXvKZbIDia+kq1Hu2yDhnYTIMbWGSv2viWgF6x7F
         4i8MIyQlpYQM5OXdX4tBZCGnLYwG2lGoXCQ8lf8ufqeYcnhsLKeGIoDvjVFL5HRUPQEi
         2dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lq9n6SOnc0hSj1FFyZM2mcFj9cA359i3RcrvKhosWgE=;
        b=BhYyG6a5+pTm1BnjFoWgySMQ3j2yD+aRRKadMyib3/ITZvGDmRsCpRZqZT/1PcLnrP
         AA0vu19TZtuzIzfeACH0P+bb5a3j/NWWK4YqnonKfe4Uss81yQxfTSA8g5FJjV++CApu
         kYpITgZYu8WORjmAJaLlrS6SO9mSHbUB05JP/fhmjll6vGO9JhT98NwznCDSs4lsOoWn
         2Ba5LDNhQ2xQOvl5186fU+Ug18ATvLontDzc3ACfhZWY9+Wf8crhGREFh9rs8IVO12m6
         mmWsFUqOr/2MsCvgT3zGRY88CVSxoO3rWwPkvUEqbATSdMrw9AKBhXS0+D5J6CzHD7Ex
         LRqA==
X-Gm-Message-State: APjAAAVRuxwmB6nMo68Ffuih7q+NwLuwlDeyiNGjE8R3uehcel3Mxn31
        rn2owhdZ8PZk/dYcwXLlTmdCXFO/
X-Google-Smtp-Source: APXvYqyLD95AlCbgEqM+4v6Kr8vCV6GDxYDLssTIspHzAHcPGuWACLzLPVklCIAoeReFVetQT0s/4g==
X-Received: by 2002:a63:30c:: with SMTP id 12mr20072591pgd.276.1580144235264;
        Mon, 27 Jan 2020 08:57:15 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id u23sm16368642pfm.29.2020.01.27.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 08:57:14 -0800 (PST)
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
Subject: [PATCH v7 7/9] crypto: caam - invalidate entropy register during RNG initialization
Date:   Mon, 27 Jan 2020 08:56:44 -0800
Message-Id: <20200127165646.19806-8-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200127165646.19806-1-andrew.smirnov@gmail.com>
References: <20200127165646.19806-1-andrew.smirnov@gmail.com>
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
index a11c13a89ef8..bcbc832b208e 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -339,8 +339,12 @@ static void kick_trng(struct platform_device *pdev, int ent_delay)
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
@@ -370,7 +374,8 @@ static void kick_trng(struct platform_device *pdev, int ent_delay)
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

