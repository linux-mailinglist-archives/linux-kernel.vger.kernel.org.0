Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2584C10D040
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2019 01:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfK2AtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 19:49:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44002 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfK2AtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 19:49:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id h14so3646687pfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 16:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v5zqGpmnTc6SxNeb5w/Q1Y9kq3jWnzDuFhNnFCBX/qU=;
        b=pxhxNTnnkSAXUci2pIu0+EV0WX14xp63D61nJdMYEhol8f3vQLhGpbS56tdfJLxLAd
         Z3an68S0UbHmAp88r8befGd/JiO0fYYOQcRgFIqs2V68FWJ42MomZvbP+Q6XaGPsYvsk
         UlUxzYRSv4zgIZc8LwLaI1eczRSlnQbbese4rzlHLxmnl5cSGSIs0+n3Ik+K8Otf44J8
         3JI+Ecqw9GuPi4gPDry+j2z/Icq9vhL5ErsK5iPmSpi9iHz6v2/5VIS26R57kiPYQmXj
         3WpeAd5n03RsAr6eQBNy754eT/yyQ9J0APR1duwu4q3vp/UL3ZL4/j/z9r/gnWg9b39H
         SkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5zqGpmnTc6SxNeb5w/Q1Y9kq3jWnzDuFhNnFCBX/qU=;
        b=shNF9T2YLQnLe7s9PqQakYkfctaaqdRn6psk4f8ujMGQyPui6JCXTGISbVvSUwkEah
         781IYzJnS4eQzmPh3tPCBrNxlSgFZ9ClsczR6CAts3UdYTJU9rhCD0f3AlzE6V6aVrpS
         S5b1AEi2hEZrQWdHEsrptuBYPlWubMBoyEkShtoRukjNjoP0+nqG3qSrFrz/DX4V2MDz
         GsjiPot8llrrToo8snPDDP2f5SnG2C/OGB7oprIfyeIhdY52zTVCtJzYBBRFZz2Mhw4F
         JHgexk42StsIPf+uJEipk5UNdRH9v8iBW+A1w1MQDyNDZKlmXAme95KjjRbH+On6nOMo
         8T9Q==
X-Gm-Message-State: APjAAAXtZzKjJxwExuVZnGVbRXumiqPmNECICaQzYY5YBKhK4/ZEffv+
        TOEgVawvxXzkIPz6fpwXaV4=
X-Google-Smtp-Source: APXvYqwA0F6jKEcoyaP+Gbo67KhumBWjnESPPjQgXKURaT8QeqLrAp9F0H265OL4vWrTkcVAc+cxnQ==
X-Received: by 2002:a63:c406:: with SMTP id h6mr14263803pgd.213.1574988560678;
        Thu, 28 Nov 2019 16:49:20 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id 64sm22418202pfe.147.2019.11.28.16.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 16:49:20 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v2 2/3] iommu: optimize iova_magazine_free_pfns()
Date:   Thu, 28 Nov 2019 16:48:54 -0800
Message-Id: <20191129004855.18506-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the maganize is empty, iova_magazine_free_pfns() should
be a nop, however it misses the case of mag->size==0. So we
should just call iova_magazine_empty().

This should reduce the contention on iovad->iova_rbtree_lock
a little bit.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/iommu/iova.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index cb473ddce4cf..184d4c0e20b5 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -797,13 +797,23 @@ static void iova_magazine_free(struct iova_magazine *mag)
 	kfree(mag);
 }
 
+static bool iova_magazine_full(struct iova_magazine *mag)
+{
+	return (mag && mag->size == IOVA_MAG_SIZE);
+}
+
+static bool iova_magazine_empty(struct iova_magazine *mag)
+{
+	return (!mag || mag->size == 0);
+}
+
 static void
 iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 {
 	unsigned long flags;
 	int i;
 
-	if (!mag)
+	if (iova_magazine_empty(mag))
 		return;
 
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
@@ -820,16 +830,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, struct iova_domain *iovad)
 	mag->size = 0;
 }
 
-static bool iova_magazine_full(struct iova_magazine *mag)
-{
-	return (mag && mag->size == IOVA_MAG_SIZE);
-}
-
-static bool iova_magazine_empty(struct iova_magazine *mag)
-{
-	return (!mag || mag->size == 0);
-}
-
 static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 				       unsigned long limit_pfn)
 {
-- 
2.21.0

