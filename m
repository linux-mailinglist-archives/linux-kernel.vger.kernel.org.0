Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76CAD116F55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 15:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfLIOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 09:43:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39168 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfLIOnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:43:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id s14so15204212wmh.4;
        Mon, 09 Dec 2019 06:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NV+OtFNHEPzK4aALA3wGiz+UFBKhhJOcbOzMP5xc22k=;
        b=bwiWLgywo4bf2Dm4Ihu3a9OQzCW+Bcm0MRmMhP3dm7qO/brttTj8L67XJibxd6vTix
         3G+uINewRv4VhP7E8F03AWBILGLSbVisz/lwn+KlM22BnGqwogFN9uMxSZsGliB0Xonm
         DfLcXpIDyUJNd3iAs4fo17prGdJ2Pw1ZxtYFsBSDsaa9k2oF2tM2ZdQ0POIj3QThtByc
         2IYQ6VQpbE/rxx4ktCnSocpdE56KR6KLf0cB1pwS1W33hBSan/WK1DezW0reo4WaxshO
         B6vjyjQ6+MIxm+lttNugyuDpOpTxTlqpqeGDjzhLKcVQA2PIoS+nW+3So8WR8p051Lou
         Wa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NV+OtFNHEPzK4aALA3wGiz+UFBKhhJOcbOzMP5xc22k=;
        b=tmJ2L1kJQM3zQScA/hk0rKY56EQ5Mfd7FGGBM2XzxXrqhepFLxELDgc9WIovP58yVg
         No3dH/iMwIXjaLwx6JYNHeeKsb8Ef0CsOb1D9NZHdjZRDxTMOUULvGiPDY8k5yCNc949
         OObHnaLt9TtamizyiQPOft4ALhQ7M0U2G4RtuI3zlIpHFJWrBmH2ee+3Oxou3yqqN5Y5
         EFnb1WdHjMMe3d1RfduLsqsYBTpQzIllXgHY+2qwh2Ya9UY2mNfk+cIK4Ig1TzlPdItq
         uJIHa3C5ZalJpABdvkjpC8LgDSKoV4Z/SosSQM7wfGb4A+R3dkncctdQFF8AOBqFSBZX
         8L1g==
X-Gm-Message-State: APjAAAUSr62M0Jc7a5MOhktOlQ+JGzna71ncV5JtAZD92Ok4PwZ0uP8s
        kxAI23/ChtBYYJ2EW3Qvx2Y=
X-Google-Smtp-Source: APXvYqyJwFHV7cm833OQ2PvjlHHPlHPTguHfZPFEEjeLQsJeto1AdNMXKAMXnzYvun173UkWc3IHKA==
X-Received: by 2002:a05:600c:2383:: with SMTP id m3mr12937576wma.32.1575902581139;
        Mon, 09 Dec 2019 06:43:01 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id b10sm8756152wmb.48.2019.12.09.06.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:43:00 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2 2/2] iommu: dma: Use of_iommu_get_resv_regions()
Date:   Mon,  9 Dec 2019 15:42:56 +0100
Message-Id: <20191209144256.2396808-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191209144256.2396808-1-thierry.reding@gmail.com>
References: <20191209144256.2396808-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

For device tree nodes, use the standard of_iommu_get_resv_regions()
implementation to obtain the reserved memory regions associated with a
device.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 76ef31123cd9..2b2ec643b7e8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
 #include <linux/iova.h>
 #include <linux/irq.h>
 #include <linux/mm.h>
+#include <linux/of_iommu.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
@@ -165,6 +166,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
 		iort_iommu_msi_get_resv_regions(dev, list);
 
+	if (dev->of_node)
+		of_iommu_get_resv_regions(dev, list);
 }
 EXPORT_SYMBOL(iommu_dma_get_resv_regions);
 
-- 
2.23.0

