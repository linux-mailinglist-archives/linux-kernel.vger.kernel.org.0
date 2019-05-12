Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF0001AE77
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 01:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfELXkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 19:40:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45988 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfELXkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 19:40:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id a5so5478874pls.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 16:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V/9aP4sXBWazgP7P1SMPOO9GhyiSLOQpBIXJQm36sCA=;
        b=uaC+lCMkuXnDyHkEOZfK1yewRColyHvVkl0QxzhnlelKBTkU+k8dKryWZ/YzA6wVMK
         YAiNhJ24rhHhqeqqPagttd+7ZaCQ4noMSuwrzMZ0dxTIzgIezAps2s8ejjQ1mM6Cz/5h
         5vr718Jrl9wbwEUjMjBphyj1cCjnZ8MZGsXjGtKnTc7e/plebBRmOon2I60SgRd5hmkZ
         3Ud1VNtV5UCkBMNLd3G+4yzgrDti8X2dFzYVOb9hnpI1awbt6bpp5Um2FXOqS4IXau00
         skHlqRnp2zsJBKxCmVjtxDlCnCrDQn87ASAFO2WqxU3tDzmW5kuo7jTodWaQ1JePEnZV
         tpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V/9aP4sXBWazgP7P1SMPOO9GhyiSLOQpBIXJQm36sCA=;
        b=g4fol/+8EISFPXknFPwhn7mPjmuK7GrYX3BmAYdXc6xidr6D3wGVMKAOH7nrwrp1Hw
         jrtt0Y6ODM7qqfFybIw0p+znkwp1ZDc0iA8I/nF/C458ewj2IErtT+lPAxsfoBBGJb56
         ZY3jujT0NmRyMjt93MzM2SxO4I8MhDC/jCN+9xWniixfR8Ea2a1bglXWLZj1Ir8gzJxt
         IWxI+wjrnruhAirgdcXX19JlnwV5w6WkpPtT6tZdGBsGsLzw6sBzJ5ueR7mr9G9B06z5
         5dvgwYfMI6CYc7VJlubkt28bRjTK9MTWRYe1eJ6HjcICm9JPgMhKRnRGhtWWuYio1IvN
         dEQQ==
X-Gm-Message-State: APjAAAXgwHJImSvcZ3feUxnEbM2rU2VpTY1IKn1henMVosoP3VCc8/Sr
        I1MMbc7DE8X6FjFpZed/3SY=
X-Google-Smtp-Source: APXvYqycVl+mVmGsXkjcTIs/TP0YbWeE+vrg0qUqSF5yOkD4TgrWAGxgCbUc4QpP7G+K66NVnGjraA==
X-Received: by 2002:a17:902:e708:: with SMTP id co8mr27022182plb.141.1557704438416;
        Sun, 12 May 2019 16:40:38 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.241.202.125])
        by smtp.gmail.com with ESMTPSA id e29sm13528376pgb.37.2019.05.12.16.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 16:40:37 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v2 5/8] Staging: kpc2000: kpc_dma: Resolve coding style error reported by checkpatch
Date:   Mon, 13 May 2019 05:09:57 +0530
Message-Id: <20190512234000.16555-5-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512234000.16555-1-bnvandana@gmail.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190512234000.16555-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below errors reported by checkpath
ERROR: Macros with complex values should be enclosed in parentheses
CHECK: Prefer using the BIT macro
ERROR: trailing statements should be on next line
ERROR: trailing statements should be on next line

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
index 0b8dcf046136..e996ced77bd6 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
@@ -14,7 +14,7 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Matt.Sickler@daktronics.com");
 
 #define KPC_DMA_CHAR_MAJOR    UNNAMED_MAJOR
-#define KPC_DMA_NUM_MINORS    1 << MINORBITS
+#define KPC_DMA_NUM_MINORS    BIT(MINORBITS)
 static DEFINE_MUTEX(kpc_dma_mtx);
 static int assigned_major_num;
 static LIST_HEAD(kpc_dma_list);
@@ -55,9 +55,11 @@ static ssize_t  show_engine_regs(struct device *dev, struct device_attribute *at
 {
 	struct kpc_dma_device *ldev;
 	struct platform_device *pldev = to_platform_device(dev);
-	if (!pldev) return 0;
+	if (!pldev)
+		return 0;
 	ldev = platform_get_drvdata(pldev);
-	if (!ldev) return 0;
+	if (!ldev)
+		return 0;
 
 	return scnprintf(buf, PAGE_SIZE,
 		"EngineControlStatus      = 0x%08x\n"
-- 
2.17.1

