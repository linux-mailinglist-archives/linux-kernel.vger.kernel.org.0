Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC304E2675
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 00:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407944AbfJWWjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 18:39:10 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57324 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407932AbfJWWjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:39:10 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iNPHR-0004FB-3T; Thu, 24 Oct 2019 00:39:01 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     kishon@ti.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bivvy.bi@rock-chips.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/3] phy: add PHY_MODE_LVDS
Date:   Thu, 24 Oct 2019 00:38:49 +0200
Message-Id: <20191023223851.3030-1-heiko@sntech.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are combo phys out there that can be switched between doing
dsi and lvds. So add a mode definition for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/linux/phy/phy.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 15032f145063..56d3a100006a 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -38,7 +38,8 @@ enum phy_mode {
 	PHY_MODE_PCIE,
 	PHY_MODE_ETHERNET,
 	PHY_MODE_MIPI_DPHY,
-	PHY_MODE_SATA
+	PHY_MODE_SATA,
+	PHY_MODE_LVDS,
 };
 
 /**
-- 
2.23.0

