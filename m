Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E898415F663
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 20:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbgBNTIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 14:08:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57666 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387995AbgBNTIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:08:18 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01EJ8IQg052303
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:08:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581707298;
        bh=dAnRFRULQT7vNL0nAlIsw9Ukq2ALrmhmYSiJyP4+Qk4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=usRelqHJLeZbUZbpeAD5xevCPQIo8HifLSXh5fET7SyPjnEqCCPMtOOa+q58m4mxX
         Bu2Xp3j5khZZvQNsKfFo/2ntpJl9xRMtyoyxHwFhqTf+rwU6NTt2qgINKhu8ixjSTE
         7abvjOR1syWYWizaf7rpJN6SaGgd+UPUnafWydAQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01EJ8Imc092174
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:08:18 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 14
 Feb 2020 13:08:17 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 14 Feb 2020 13:08:17 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01EJ8GU4073290;
        Fri, 14 Feb 2020 13:08:17 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/2] phy: ti: gmii-sel: do not fail in case of gmii
Date:   Fri, 14 Feb 2020 21:08:01 +0200
Message-ID: <20200214190801.3030-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214190801.3030-1-grygorii.strashko@ti.com>
References: <20200214190801.3030-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "gmii" PHY interface mode is supported on TI AM335x/437x/5xx SoCs, so
don't fail if it's selected.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index e998e9cd8d1f..1c536fc03c83 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -80,6 +80,7 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
 		break;
 
 	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_GMII:
 		gmii_sel_mode = AM33XX_GMII_SEL_MODE_MII;
 		break;
 
-- 
2.17.1

