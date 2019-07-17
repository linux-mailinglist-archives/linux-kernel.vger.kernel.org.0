Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACAAB6BF0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 17:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfGQPZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 11:25:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34934 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbfGQPZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:25:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so11016504pfn.2;
        Wed, 17 Jul 2019 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2S+4Wu18TuNun2kRV8rUzm050n/dG1pF/iF6/mOeQ14=;
        b=h62ST06lVLXpzmY/6uRDjVPneyVRkSf8sXjY+l1Cbg4v0fMnjOQnVJ8XlBRMto4u6d
         oMJM5zZuSOnjQWW+flIVtULUA7ZKSyiSpUmOZ1+sunR3dXz7P/TZtGM9s53Pf4lGRWL1
         LXEOr8SntyY344ATKOJgvsVjSCNRZXRPSm1DnnfaFcA9lYPYgf2Gx5SKakJ7bsZLoXsQ
         5BOC8nTB9cdVZ5/briC2t4wgS1m+cEsYUinTucFsqhRDgMG8ABUF4SvzICoUawmCQ9A0
         yaTb37NxjEiSelg2YU4rq9f4xYVHXQM5+IPJCeCSia/hek1QjmgZJfFys1TzCc+fiZQn
         Y+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2S+4Wu18TuNun2kRV8rUzm050n/dG1pF/iF6/mOeQ14=;
        b=YMvevtI0Tu+0C/yt9bhg8+4Z9HRhfLUIzj6UBwiIjdzbXOggILWdMFw5y00K4hpjBH
         uCl13xILCD6oew2VSPmqL1dOSQbXm4MqavzWcYoW/5brvEeKjucgBaSHuW8JnXYZpgA8
         H4majvy64rDdgKmLJVIKhI1E9vvEAQ8f82FJRKnbRwQAhhpU7GNMml3eg55RXsVuzxfq
         VvDK1pWNOT6RDgZXmVquI9XRqk4oHWS0vVlO10Xdj1YzV06kqG3m1L5co8uifw1FhHtt
         9icBljK2/fuklxZtWFV1o4qe1UJYW/B40Ogx18v/VjGWbIxunyclWVOFMFlDsZfeWqpc
         E86w==
X-Gm-Message-State: APjAAAW/UKzHFdc8yvU6X4ESiGWOSwPYpfZuryslKYqIDAp4Azk05Ume
        yJWxtSH8SHC1lmJhsyKZYmN+dbKG
X-Google-Smtp-Source: APXvYqyGDQq1P5kMdOvKhZAFSSYnr/CPyQkSvc/n1A1gFU8JOvKmRkQO+nMFniQeIuDDzcX48MnZYQ==
X-Received: by 2002:a17:90a:20c6:: with SMTP id f64mr45043405pjg.57.1563377128009;
        Wed, 17 Jul 2019 08:25:28 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id l1sm33771386pfl.9.2019.07.17.08.25.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 08:25:27 -0700 (PDT)
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
Subject: [PATCH v6 11/14] crypto: caam - don't hardcode inpentry size
Date:   Wed, 17 Jul 2019 08:24:55 -0700
Message-Id: <20190717152458.22337-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717152458.22337-1-andrew.smirnov@gmail.com>
References: <20190717152458.22337-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dma_addr_t for elements of JobR input ring is not appropriate on
all 64-bit SoCs, some of which, like i.MX8MQ, use only 32-bit wide
pointers there. Convert all of the code to use explicit helper
function that can be later extended to support i.MX8MQ. No functional
change intended.

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
 drivers/crypto/caam/intern.h | 3 ++-
 drivers/crypto/caam/jr.c     | 4 ++--
 drivers/crypto/caam/regs.h   | 9 +++++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 081805c0f88b..c00c7c84ec84 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -55,7 +55,8 @@ struct caam_drv_private_jr {
 	spinlock_t inplock ____cacheline_aligned; /* Input ring index lock */
 	u32 inpring_avail;	/* Number of free entries in input ring */
 	int head;			/* entinfo (s/w ring) head index */
-	dma_addr_t *inpring;	/* Base of input ring, alloc DMA-safe */
+	void *inpring;			/* Base of input ring, alloc
+					 * DMA-safe */
 	int out_ring_read_index;	/* Output index "tail" */
 	int tail;			/* entinfo (s/w ring) tail index */
 	void *outring;			/* Base of output ring, DMA-safe */
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 138f71adb7e6..4d7a302d0b9b 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -388,7 +388,7 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,
 	head_entry->cbkarg = areq;
 	head_entry->desc_addr_dma = desc_dma;
 
-	jrp->inpring[head] = cpu_to_caam_dma(desc_dma);
+	jr_inpentry_set(jrp->inpring, head, cpu_to_caam_dma(desc_dma));
 
 	/*
 	 * Guarantee that the descriptor's DMA address has been written to
@@ -435,7 +435,7 @@ static int caam_jr_init(struct device *dev)
 		return error;
 
 	error = -ENOMEM;
-	jrp->inpring = dmam_alloc_coherent(dev, sizeof(*jrp->inpring) *
+	jrp->inpring = dmam_alloc_coherent(dev, SIZEOF_JR_INPENTRY *
 					   JOBR_DEPTH, &inpbusaddr,
 					   GFP_KERNEL);
 	if (!jrp->inpring)
diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 0cc4a48dfc30..ec49f5ba9689 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -244,6 +244,15 @@ static inline u32 jr_outentry_jrstatus(void *outring, int hw_idx)
 	return jrstatus;
 }
 
+static inline void jr_inpentry_set(void *inpring, int hw_idx, dma_addr_t val)
+{
+	dma_addr_t *inpentry = inpring;
+
+	inpentry[hw_idx] = val;
+}
+
+#define SIZEOF_JR_INPENTRY	caam_ptr_sz
+
 
 /* Version registers (Era 10+)	e80-eff */
 struct version_regs {
-- 
2.21.0

