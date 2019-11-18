Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC01100780
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 15:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfKROhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 09:37:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46961 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKROhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:37:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id 193so10465922pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 06:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mvcfD7jITpqxjPheoMWCVxZTnjlcuW9ormSnkwSOmcw=;
        b=gx9t8ngLd1CKC2pOlKZxYKX/nb5b9Fla8ZmjaRV/f8hRHqcWzKT0SkQjuOeLUjkKzn
         bFiG1jbyJFszN6zUVehwdvnzDa7wZFbptFOlC8GAokKRZ3Q+zT4GLa1Dc5f2kvdflX5K
         +M+f/XLEWA3bayoKRh2Nze4IHteHT7+NASZQ8d29w77i2HMTvYoB2mSW8SALJd3zeKJm
         SBVQv3hzaaye8Qo/qR4EM4KkduTQLorIhb0ox4uMXRTsllk1x22dGuN2bKMV/fkDCMGp
         h9eaKaNwdcjjSMo77ClhglL2Ih9Xy7ydV2KvQq7MbYshPYZ3HtTJZIAAQqepUV5ttn64
         jhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mvcfD7jITpqxjPheoMWCVxZTnjlcuW9ormSnkwSOmcw=;
        b=qS3dTt0Un6AJhjgL1ZHkmA0XxADetXhum1dBqqudaB0vHc10o60AP/eFlmGUow6u4/
         drAz4GVqfsV1BwBlUQgoSjAeSehjPyFWw76Q9O+tH+m4BU+Ok1+ebbj6jc9Bm4iiBejb
         D2ujaePIHpCDncZcMcqLld6BIxTNWw80wWznY5huSgBk5+H6PoXwxRIoFfQAk5KKibUg
         EeViKNGC4XqiL96dIFiirL9uJK4Ve3lfXjkD2T/BW0yIi/di7JBHqnCJnev3dVsOusyH
         ZVRHxKPt6UBGniul4MohsOvfwsDir4cFABSHrvvSn7oaTxWxpvQ68U9dn5qFjO3QxxR/
         Zf5g==
X-Gm-Message-State: APjAAAXcrj6SL4gpMZO+V10iEkGEU9NjsisdopxVzaHw0anDKTfjK9On
        qmqMq497KvW48a8tHXQpQukoVg==
X-Google-Smtp-Source: APXvYqynVHo9DCmHG04AdxQEaRenl+NyG/k0fpAYb6SsXQrD+cOLuHrcjkW15y7tKXTly3zWYi5gEw==
X-Received: by 2002:a63:5b0c:: with SMTP id p12mr5854647pgb.196.1574087823195;
        Mon, 18 Nov 2019 06:37:03 -0800 (PST)
Received: from localhost.localdomain (1-169-21-101.dynamic-ip.hinet.net. [1.169.21.101])
        by smtp.gmail.com with ESMTPSA id x10sm21910996pfn.36.2019.11.18.06.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 06:37:02 -0800 (PST)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dmaengine: sf-pdma: move macro to header file
Date:   Mon, 18 Nov 2019 22:35:53 +0800
Message-Id: <20191118143554.16129-2-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118143554.16129-1-green.wan@sifive.com>
References: <20191118143554.16129-1-green.wan@sifive.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The place where the macro, SF_PDMA_REG_BASE(), is cause kernel-doc
using wrong function declaration. Move it to header file.

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 1 -
 drivers/dma/sf-pdma/sf-pdma.h | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index e8b9770dcfba..465256fe8b1f 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -435,7 +435,6 @@ static int sf_pdma_irq_init(struct platform_device *pdev, struct sf_pdma *pdma)
  *
  * Return: none
  */
-#define SF_PDMA_REG_BASE(ch)	(pdma->membase + (PDMA_CHAN_OFFSET * (ch)))
 static void sf_pdma_setup_chans(struct sf_pdma *pdma)
 {
 	int i;
diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
index aab65a0bdfcc..0c20167b097d 100644
--- a/drivers/dma/sf-pdma/sf-pdma.h
+++ b/drivers/dma/sf-pdma/sf-pdma.h
@@ -57,6 +57,8 @@
 /* Error Recovery */
 #define MAX_RETRY					1
 
+#define SF_PDMA_REG_BASE(ch)	(pdma->membase + (PDMA_CHAN_OFFSET * (ch)))
+
 struct pdma_regs {
 	/* read-write regs */
 	void __iomem *ctrl;		/* 4 bytes */
-- 
2.17.1

