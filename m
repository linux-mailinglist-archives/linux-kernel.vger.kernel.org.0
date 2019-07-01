Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE8358129
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 13:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfF0LJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 07:09:19 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52298 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0LJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 07:09:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5RB93dx025270;
        Thu, 27 Jun 2019 06:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561633743;
        bh=ekUCxxoe9vEIujVz3zsQS2Mq1QFgkunAduREqmkufFQ=;
        h=From:To:CC:Subject:Date;
        b=fQyRsN1iLcO40yP3GNOGFlFMDDlT12fTQfLOlODDwa0out0hf42MD+c5N5IBTkwTK
         Un905zZZH46rYatfUxZp8atS73cxXWO46NQQyn22r/sU2Dni+8LfsjRUUvTPqR+fcb
         9Kn/X/IRQPt76m4VLfntBWJ5vNMEvDpZk0oKuc3k=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5RB934x044050
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jun 2019 06:09:03 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 27
 Jun 2019 06:09:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 27 Jun 2019 06:09:03 -0500
Received: from a0393675ula.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5RB8x04110512;
        Thu, 27 Jun 2019 06:09:00 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <will.deacon@arm.com>,
        <catalin.marinas@arm.com>, <shawnguo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-keerthy@ti.com>,
        <nm@ti.com>, <lokeshvutla@ti.com>
Subject: [PATCH v2] arm64: Kconfig.platforms: Enable GPIO_DAVINCI for ARCH_K3
Date:   Thu, 27 Jun 2019 16:39:20 +0530
Message-ID: <20190627110920.15099-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable GPIO_DAVINCI and related configs for TI K3 AM6 platforms.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Enabling configs in Kconfig.platforms file instead of defconfig.
  * Removed GPIO_DEBUG config.

 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4778c775de1b..6e43a0995ed4 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -97,6 +97,8 @@ config ARCH_K3
 	select TI_SCI_PROTOCOL
 	select TI_SCI_INTR_IRQCHIP
 	select TI_SCI_INTA_IRQCHIP
+	select GPIO_SYSFS
+	select GPIO_DAVINCI
 	help
 	  This enables support for Texas Instruments' K3 multicore SoC
 	  architecture.
-- 
2.17.1

