Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 696B927BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 13:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfEWLgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 07:36:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34497 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWLge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:36:34 -0400
Received: by mail-lj1-f193.google.com with SMTP id j24so5147210ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uczS2eJvsUBeIqufjqAGGrhpIgILdXWM7PJHAl+INQ0=;
        b=JTKvuPUwewVb7Htxx1J62Fww7wlyJ+5AgM1TEPAC+XGlI218KAO66eobowelkww13E
         xSH6Z7McjsZFQca5Dxva+1KwzpJDchsbBYteKBsALyWb581xIfbbvgdApiMl0MZfxy/D
         Q02+1AXRvrStd+fA3FYJK7ZdGcsxjQbOAhTKntWFuEVEwga5v3gyviGeYzKFnfR+tq+n
         WX7OC6zKRwqbwwq+UqHDfxaN/GqA73lSRVT4Fjr0g8MCNXiKcftnqpBfXpb6djcXPApx
         pSHJNXAZ0CkOKFgplHJU3QCbPHxY6Q/RenFl9olZ1YTKqDVi+eelex6kPSmdzOH8I0ZP
         w01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uczS2eJvsUBeIqufjqAGGrhpIgILdXWM7PJHAl+INQ0=;
        b=AzxQWotrKSJryHPWHb8NsLxu3ldtp3yfh+I1cTXljoiXBK+FR4xZEP9/bwEEZsyLuG
         Vda9UNcgqSgYk63Q2lbeNbt807o8qS0+KBTpNB5cUi8Qfhq7oECZ+Q4ehEDkDSujP74D
         PDix/9sHzKLwLnxAKT37wFvwEARwUZ5SBpGtXSosMC82g+afzhfAIhnezFzKmZaiCGGd
         iSVizCypQyMHUX3NExB119fK+mXeQslV7U2EY12AdbrM+44z+a1W8aL6XiUrYF8zlJOh
         QD8VYdgrZJd16Auv7eRda9hcXM8tz0+g7YELOAmn6BT186UrlxWSy+Csfvmql4bYwobj
         R+xA==
X-Gm-Message-State: APjAAAUntB1FFJZWRmzScb5o7+ftdzNPRKyC+NJ2M+l181x/ZNT8YODm
        xXCsRKeros05N+2wSZij3n5DGg==
X-Google-Smtp-Source: APXvYqxQYY5UbK9BuRUvb4+lXuzCqrazAeGbimzmuthBWScDlwfYcOjs3yfRhZZENsPttDCrJ6tFRg==
X-Received: by 2002:a2e:60a:: with SMTP id 10mr3789534ljg.126.1558611392274;
        Thu, 23 May 2019 04:36:32 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id d68sm5269287lfg.23.2019.05.23.04.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 04:36:31 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] staging: kpc2000: use __func__ in debug messages
Date:   Thu, 23 May 2019 13:36:07 +0200
Message-Id: <20190523113613.28342-3-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523113613.28342-1-simon@nikanor.nu>
References: <20190523113613.28342-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning "Prefer using '"%s...", __func__' to using
'<function name>', this function's name, in a string".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 22 +++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index 95bfbe4aae4d..7b850f3e808b 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -299,7 +299,8 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 
 	kudev = kzalloc(sizeof(struct kpc_uio_device), GFP_KERNEL);
 	if (!kudev) {
-		dev_err(&pcard->pdev->dev, "probe_core_uio: failed to kzalloc kpc_uio_device\n");
+		dev_err(&pcard->pdev->dev, "%s: failed to kzalloc kpc_uio_device\n",
+			__func__);
 		return -ENOMEM;
 	}
 
@@ -327,7 +328,8 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 
 	kudev->dev = device_create(kpc_uio_class, &pcard->pdev->dev, MKDEV(0, 0), kudev, "%s.%d.%d.%d", kudev->uioinfo.name, pcard->card_num, cte.type, kudev->core_num);
 	if (IS_ERR(kudev->dev)) {
-		dev_err(&pcard->pdev->dev, "probe_core_uio device_create failed!\n");
+		dev_err(&pcard->pdev->dev, "%s: device_create failed!\n",
+			__func__);
 		kfree(kudev);
 		return -ENODEV;
 	}
@@ -335,7 +337,8 @@ static int probe_core_uio(unsigned int core_num, struct kp2000_device *pcard,
 
 	rv = uio_register_device(kudev->dev, &kudev->uioinfo);
 	if (rv) {
-		dev_err(&pcard->pdev->dev, "probe_core_uio failed uio_register_device: %d\n", rv);
+		dev_err(&pcard->pdev->dev, "%s: failed uio_register_device: %d\n",
+			__func__, rv);
 		put_device(kudev->dev);
 		kfree(kudev);
 		return rv;
@@ -410,7 +413,8 @@ static int  kp2000_setup_dma_controller(struct kp2000_device *pcard)
 	return 0;
 
 err_out:
-	dev_err(&pcard->pdev->dev, "kp2000_setup_dma_controller: failed to add a DMA Engine: %d\n", err);
+	dev_err(&pcard->pdev->dev, "%s: failed to add a DMA Engine: %d\n",
+		__func__, err);
 	return err;
 }
 
@@ -423,7 +427,8 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 	unsigned int highest_core_id = 0;
 	struct core_table_entry cte;
 
-	dev_dbg(&pcard->pdev->dev, "kp2000_probe_cores(pcard = %p / %d)\n", pcard, pcard->card_num);
+	dev_dbg(&pcard->pdev->dev, "%s(pcard = %p / %d)\n", __func__, pcard,
+		pcard->card_num);
 
 	err = kp2000_setup_dma_controller(pcard);
 	if (err)
@@ -472,8 +477,8 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 			}
 			if (err) {
 				dev_err(&pcard->pdev->dev,
-					"kp2000_probe_cores: failed to add core %d: %d\n",
-					i, err);
+					"%s: failed to add core %d: %d\n",
+					__func__, i, err);
 				goto error;
 			}
 			core_num++;
@@ -492,7 +497,8 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 	cte.irq_base_num        = 0;
 	err = probe_core_uio(0, pcard, "kpc_uio", cte);
 	if (err) {
-		dev_err(&pcard->pdev->dev, "kp2000_probe_cores: failed to add board_info core: %d\n", err);
+		dev_err(&pcard->pdev->dev, "%s: failed to add board_info core: %d\n",
+			__func__, err);
 		goto error;
 	}
 
-- 
2.20.1

