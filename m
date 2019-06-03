Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3AF33406
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfFCPwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:52:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53962 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729477AbfFCPwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:52:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A565215AB;
        Mon,  3 Jun 2019 08:52:01 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2241C3F246;
        Mon,  3 Jun 2019 08:51:59 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH 41/57] drivers: net: phy: Use class_find_device_by_of_node helper
Date:   Mon,  3 Jun 2019 16:50:07 +0100
Message-Id: <1559577023-558-42-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic helper to find a device matching the of_node.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/net/phy/mdio_bus.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index bd04fe7..c868a40 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -262,11 +262,6 @@ static struct class mdio_bus_class = {
 };
 
 #if IS_ENABLED(CONFIG_OF_MDIO)
-/* Helper function for of_mdio_find_bus */
-static int of_mdio_bus_match(struct device *dev, const void *mdio_bus_np)
-{
-	return dev->of_node == mdio_bus_np;
-}
 /**
  * of_mdio_find_bus - Given an mii_bus node, find the mii_bus.
  * @mdio_bus_np: Pointer to the mii_bus.
@@ -287,9 +282,7 @@ struct mii_bus *of_mdio_find_bus(struct device_node *mdio_bus_np)
 	if (!mdio_bus_np)
 		return NULL;
 
-	d = class_find_device(&mdio_bus_class, NULL,  mdio_bus_np,
-			      of_mdio_bus_match);
-
+	d = class_find_device_by_of_node(&mdio_bus_class, NULL,  mdio_bus_np);
 	return d ? to_mii_bus(d) : NULL;
 }
 EXPORT_SYMBOL(of_mdio_find_bus);
-- 
2.7.4

