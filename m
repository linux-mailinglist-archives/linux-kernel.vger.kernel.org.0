Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46771118402
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 10:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfLJJvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 04:51:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37908 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfLJJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:51:00 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBA9otj8055691;
        Tue, 10 Dec 2019 03:50:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575971455;
        bh=EW8lyngOZ0xu4oujP21x2gdJOB/XYSQJYaDt1najk+U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iJcaQcPfRY4unXNhj4dJXZ6paaRn0uua8o7K2S5qv96q2+YIy1sUPjEL6ARSx0cbQ
         Kwrxkn46m1s6uxKqTs/4XiL8pDY0YGIrcO+f1yBmZk/5OYag2PQ6Ksv+vWlBEL/wLB
         xsZt2sn9LTt9TIZ48h5zPV1c3vrXya5Z1qGGG1LM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBA9otWE130509
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Dec 2019 03:50:55 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 03:50:54 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 03:50:54 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBA9oZVo048503;
        Tue, 10 Dec 2019 03:50:52 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <adrian.hunter@intel.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <ulf.hansson@linaro.org>,
        <zhang.chunyan@linaro.org>, <tony@atomide.com>
Subject: [PATCH v3 5/7] mmc: sdhci-omap: Add DISABLE_DTO_FOR_ERASE Quirk
Date:   Tue, 10 Dec 2019 15:21:49 +0530
Message-ID: <20191210095151.15441-6-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20191210095151.15441-1-faiz_abbas@ti.com>
References: <20191210095151.15441-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Quirk to disable DTO during an erase command.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 84d85aa743da..c54c864fe419 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -879,6 +879,7 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
 	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN |
 		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 		   SDHCI_QUIRK2_RSP_136_HAS_CRC |
+		   SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE |
 		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
 	.ops = &sdhci_omap_ops,
 };
-- 
2.19.2

