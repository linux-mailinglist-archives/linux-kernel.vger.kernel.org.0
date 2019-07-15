Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6877C69C92
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 22:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbfGOUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 16:20:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45926 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732633AbfGOUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 16:20:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so8851437plr.12;
        Mon, 15 Jul 2019 13:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v0KaQPCfQffqqno8qfHHdJ/uoZgjFiZttDU6BoijTkI=;
        b=DV8BDn8EKkL9wrYL1UFWA+m0J3q1uZCRTagWuHIXWawKky4QL1HUe0DAw4APOEhQUc
         I5GXS6lPzJk6ZNvpQEmCxAstySoI1hNhxWJSf8triLR367NpG3phEJ2RY7WS3mkcfQ3W
         q9zHdteuEFq6+bv2ds2DKrjdudSJdpSnS9SFlq2Ajbe/JeMaC23m7ZCmAn/ArNjb8iv7
         bHwRys1XU9ujhIzXWYwa5cBssIDKZqm8RFWpiazSRdGUUJokoTHPr5EoRDM5NiA426S+
         aYKokJ/HAKfAmMI7Z36f/ClK52xkxVYeb0/0HB4rdr0kx0XNz8ZWLBnWYmZ1MEFwCWxI
         lO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0KaQPCfQffqqno8qfHHdJ/uoZgjFiZttDU6BoijTkI=;
        b=eUZOdKZecAS+BVbFWkSDNIZY8Ju5tpyAizK3iWGL9DnQqhXABYuzabsx0qDmYn6i/5
         RrzLnY4ltiZ0TzGynbn8V/g4eRvmftmbIPbgMGprGix7Iv6AyGyZIrqLr/tZihRqlM/u
         XUutZ832mQ4lkJLUaVWOftSSjotEt4HZYHXwp/kea2cj+1L6mOwIAg72yErp7yXZW4rF
         gx8Vsnl9YXe3jNazC/0RsY6ZQJun8efwQMprI4xTCSFYIP2GRVkmONsqW2G0V3dhV77w
         D33HTqxn47CWSRnMLW0vfHZTk8RcwLQeyAaLlZgX57NBPjB4G7fWzt0PRXdbwNTRgaRC
         cO4w==
X-Gm-Message-State: APjAAAWxSTVwtId26BJiJGAtNSeBAlh/cFQGmHV2CWEsL7sWcWyXELXw
        UChAcnb4qmmQNs2C+f36fAeB6Yct
X-Google-Smtp-Source: APXvYqwJC5XZ/9TJdRsYk08Bn8E7oAHF0rw5vl+CC64O+Kc34gcrHYYi5RInPAg6h5SbItJsh/xIKA==
X-Received: by 2002:a17:902:788f:: with SMTP id q15mr30988867pll.236.1563222002701;
        Mon, 15 Jul 2019 13:20:02 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id h1sm22730534pfg.55.2019.07.15.13.20.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 13:20:02 -0700 (PDT)
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
Subject: [PATCH v5 10/14] crypto: caam - drop explicit usage of struct jr_outentry
Date:   Mon, 15 Jul 2019 13:19:38 -0700
Message-Id: <20190715201942.17309-11-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715201942.17309-1-andrew.smirnov@gmail.com>
References: <20190715201942.17309-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using struct jr_outentry to specify the layout of JobR output ring is
not appropriate for all 64-bit SoC, since some of them, like i.MX8MQ,
use 32-bit pointers there which doesn't match 64-bit
dma_addr_t. Convert existing code to use explicit helper functions to
access any of the JobR output ring elements, so that the support for
i.MX8MQ can be added later. No functional change intended.

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
 drivers/crypto/caam/intern.h |  2 +-
 drivers/crypto/caam/jr.c     | 10 +++++----
 drivers/crypto/caam/regs.h   | 40 ++++++++++++++++++++++++++++++++----
 3 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index 1f01703f510a..081805c0f88b 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -58,7 +58,7 @@ struct caam_drv_private_jr {
 	dma_addr_t *inpring;	/* Base of input ring, alloc DMA-safe */
 	int out_ring_read_index;	/* Output index "tail" */
 	int tail;			/* entinfo (s/w ring) tail index */
-	struct jr_outentry *outring;	/* Base of output ring, DMA-safe */
+	void *outring;			/* Base of output ring, DMA-safe */
 };
 
 /*
diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c
index 98e0a504322f..138f71adb7e6 100644
--- a/drivers/crypto/caam/jr.c
+++ b/drivers/crypto/caam/jr.c
@@ -211,7 +211,7 @@ static void caam_jr_dequeue(unsigned long devarg)
 		for (i = 0; CIRC_CNT(head, tail + i, JOBR_DEPTH) >= 1; i++) {
 			sw_idx = (tail + i) & (JOBR_DEPTH - 1);
 
-			if (jrp->outring[hw_idx].desc ==
+			if (jr_outentry_desc(jrp->outring, hw_idx) ==
 			    caam_dma_to_cpu(jrp->entinfo[sw_idx].desc_addr_dma))
 				break; /* found */
 		}
@@ -220,7 +220,8 @@ static void caam_jr_dequeue(unsigned long devarg)
 
 		/* Unmap just-run descriptor so we can post-process */
 		dma_unmap_single(dev,
-				 caam_dma_to_cpu(jrp->outring[hw_idx].desc),
+				 caam_dma_to_cpu(jr_outentry_desc(jrp->outring,
+								  hw_idx)),
 				 jrp->entinfo[sw_idx].desc_size,
 				 DMA_TO_DEVICE);
 
@@ -231,7 +232,8 @@ static void caam_jr_dequeue(unsigned long devarg)
 		usercall = jrp->entinfo[sw_idx].callbk;
 		userarg = jrp->entinfo[sw_idx].cbkarg;
 		userdesc = jrp->entinfo[sw_idx].desc_addr_virt;
-		userstatus = caam32_to_cpu(jrp->outring[hw_idx].jrstatus);
+		userstatus = caam32_to_cpu(jr_outentry_jrstatus(jrp->outring,
+								hw_idx));
 
 		/*
 		 * Make sure all information from the job has been obtained
@@ -439,7 +441,7 @@ static int caam_jr_init(struct device *dev)
 	if (!jrp->inpring)
 		return -ENOMEM;
 
-	jrp->outring = dmam_alloc_coherent(dev, sizeof(*jrp->outring) *
+	jrp->outring = dmam_alloc_coherent(dev, SIZEOF_JR_OUTENTRY *
 					   JOBR_DEPTH, &outbusaddr,
 					   GFP_KERNEL);
 	if (!jrp->outring)
diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index 511e28ba740a..0cc4a48dfc30 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -71,6 +71,7 @@
 
 extern bool caam_little_end;
 extern bool caam_imx;
+extern size_t caam_ptr_sz;
 
 #define caam_to_cpu(len)						\
 static inline u##len caam##len ## _to_cpu(u##len val)			\
@@ -208,10 +209,41 @@ static inline u64 caam_dma_to_cpu(u64 value)
  * jr_outentry
  * Represents each entry in a JobR output ring
  */
-struct jr_outentry {
-	dma_addr_t desc;/* Pointer to completed descriptor */
-	u32 jrstatus;	/* Status for completed descriptor */
-} __packed;
+
+static inline void jr_outentry_get(void *outring, int hw_idx, dma_addr_t *desc,
+				   u32 *jrstatus)
+{
+	struct {
+		dma_addr_t desc;/* Pointer to completed descriptor */
+		u32 jrstatus;	/* Status for completed descriptor */
+	} __packed *outentry = outring;
+
+	*desc = outentry[hw_idx].desc;
+	*jrstatus = outentry[hw_idx].jrstatus;
+}
+
+#define SIZEOF_JR_OUTENTRY	(caam_ptr_sz + sizeof(u32))
+
+static inline dma_addr_t jr_outentry_desc(void *outring, int hw_idx)
+{
+	dma_addr_t desc;
+	u32 unused;
+
+	jr_outentry_get(outring, hw_idx, &desc, &unused);
+
+	return desc;
+}
+
+static inline u32 jr_outentry_jrstatus(void *outring, int hw_idx)
+{
+	dma_addr_t unused;
+	u32 jrstatus;
+
+	jr_outentry_get(outring, hw_idx, &unused, &jrstatus);
+
+	return jrstatus;
+}
+
 
 /* Version registers (Era 10+)	e80-eff */
 struct version_regs {
-- 
2.21.0

