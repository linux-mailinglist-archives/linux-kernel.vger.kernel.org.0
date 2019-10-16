Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93462D8F85
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 13:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405058AbfJPLcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 07:32:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36998 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405036AbfJPLcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:32:09 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GBW7wx050015;
        Wed, 16 Oct 2019 06:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571225527;
        bh=NpTgzRPuWtGy7XqgqTEEYzUMhl497x1SrGIY18ty3Pk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QtsBS+151ygP8+0kDVOeXpCEWQ9sL762W4sCKe9siLMU0OGe3Rj8gRrqnwEsi7uf7
         DRdhKYHPkoQYv8TrSOTvLL99OX9nMkiXbqe+d8STTmBGFmo0YuUR9245QwMYlmYT8s
         eYEnkQNVcsshjFBe7P8BexgkxTp9RaOlhd+dzu2g=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GBW7sA037972
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 06:32:07 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 06:32:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 06:32:00 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GBVkmC097485;
        Wed, 16 Oct 2019 06:32:05 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>
CC:     Anil Varughese <aniljoy@cadence.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 08/13] phy: cadence: Sierra: Get reset control "array" for each link
Date:   Wed, 16 Oct 2019 17:01:12 +0530
Message-ID: <20191016113117.12370-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016113117.12370-1-kishon@ti.com>
References: <20191016113117.12370-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A link may have multiple lanes each with a separate reset. Get
reset control "array" in order to reset all the lanes associated
with the link.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index b555d4c3633b..2648a01f90b3 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -497,7 +497,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		struct phy *gphy;
 
 		sp->phys[node].lnk_rst =
-			of_reset_control_get_exclusive_by_index(child, 0);
+			of_reset_control_array_get_exclusive(child);
 
 		if (IS_ERR(sp->phys[node].lnk_rst)) {
 			dev_err(dev, "failed to get reset %s\n",
-- 
2.17.1

