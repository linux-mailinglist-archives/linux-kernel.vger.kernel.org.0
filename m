Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3D453B11E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 10:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388699AbfFJIpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 04:45:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37882 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388571AbfFJIo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:44:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id m15so6033194lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XlBqqPFxo7cPYwn+Uda7t8bSPWi1Ym5xI4tmKez88oU=;
        b=akcYbJG+EMEHuyktHUZxehludAWVvbXzug3nXiPrAg6KkyhcJDGTSMK8syNlanvUgN
         f/hfNQcmgW6qzY125P4en91PIDaTMtIUChSkMpsfTfbuHD26y+Tlzx1zTOues0HL8r/9
         4LkroMb8B38ifuJCocFP4HZcQLqMvQ8RDnARiRWkDYOT+dlgTACmx7RimR+Mcs2Y7gCU
         EZjlG6CP25NNf60EQLQkPY2t3n/WVIVgDAcaeV2wAkMh+9yOHjeckw4fjpoMy2tD1VmS
         9U0ziQ9CiTYqdSBjabaySXJ4kzP2qFeHdV+42ZnqTWgkjzak7bLIDtjQDK786qYhAPnr
         WXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XlBqqPFxo7cPYwn+Uda7t8bSPWi1Ym5xI4tmKez88oU=;
        b=C6MidSo+NAOAIh7Qi4MiijJwnF+N03zadPjdlyLxw1A9YIDzz44VKpymeFDd3FtYuG
         mneYBF2ApmcxvPFgTFoAtRixX9/Y9nGzaU9cDjdpsJyrWjxVzBC4se++pao9I0wrxfF8
         H8VN2ZHN/jTn9JRV4LdnDrgTlgXWfrup4HKJ0N0LlmRa/o3Lclw2T+FVm9JydAmvV5kI
         d612z7jHlK1l5Vj4unKV8QVeQdk6wgf92MhHq7AgOSW1soQYanuCAkF8xukXn8oVpn33
         +X1KGnz5uPeQjCYTdYNXL9s/Vx/MaUqZDn1ZGEuEJGTleFGkQW+oy0QNSkq0WRgJ+/JF
         WMEQ==
X-Gm-Message-State: APjAAAXnuyIvvh6L8R5L9wy3phpWR4kRX1z9ZzPutfo7ANFJgEL/Iapy
        miKejpkL6geyRuVZ2kuK/HHTGQ==
X-Google-Smtp-Source: APXvYqzr5fBdboTIMnsXpzQOs0AcoKbfsF0S4KG0fFF4gArjf2efwlStUrgW/uitQQjcm5KQeUstiA==
X-Received: by 2002:ac2:455a:: with SMTP id j26mr22568179lfm.18.1560156294028;
        Mon, 10 Jun 2019 01:44:54 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id e26sm1826486ljl.33.2019.06.10.01.44.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 01:44:53 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     =simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 5/5] staging: kpc2000: remove unnecessary debug prints in kpc_dma_driver.c
Date:   Mon, 10 Jun 2019 10:44:32 +0200
Message-Id: <20190610084432.12597-6-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610084432.12597-1-simon@nikanor.nu>
References: <20190610084432.12597-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debug prints that are used only to inform about function entry or exit
can be removed as ftrace can be used to get this information.

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
index 9acf1eafa024..4b854027e60a 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
@@ -106,8 +106,6 @@ int  kpc_dma_probe(struct platform_device *pldev)
 		goto err_rv;
 	}
 
-	dev_dbg(&pldev->dev, "%s(pldev = [%p]) ldev = [%p]\n", __func__, pldev, ldev);
-
 	INIT_LIST_HEAD(&ldev->list);
 
 	ldev->pldev = pldev;
@@ -183,8 +181,6 @@ int  kpc_dma_remove(struct platform_device *pldev)
 	if (!ldev)
 		return -ENXIO;
 
-	dev_dbg(&ldev->pldev->dev, "%s(pldev = [%p]) ldev = [%p]\n", __func__, pldev, ldev);
-
 	lock_engine(ldev);
 	sysfs_remove_files(&(ldev->pldev->dev.kobj), ndd_attr_list);
 	destroy_dma_engine(ldev);
-- 
2.20.1

