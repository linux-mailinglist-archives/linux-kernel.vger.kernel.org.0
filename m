Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B10D964043
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 07:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfGJFFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 01:05:02 -0400
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:34413 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726098AbfGJFEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:04:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 739BD100E86C6;
        Wed, 10 Jul 2019 05:04:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1345:1359:1437:1534:1540:1567:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:3138:3139:3140:3141:3142:3867:4321:5007:6261:6642:8784:10004:10848:11026:11473:11658:11914:12043:12297:12438:12555:12895:12986:13069:13311:13357:14096:14181:14384:14394:14721:21080:21451:21627:30054,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: hose32_d6edeaac7419
X-Filterd-Recvd-Size: 1698
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 05:04:52 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 10/12] phy: amlogic: G12A: Fix misuse of GENMASK macro
Date:   Tue,  9 Jul 2019 22:04:23 -0700
Message-Id: <d149d2851f9aa2425c927cb8e311e20c4b83e186.1562734889.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1562734889.git.joe@perches.com>
References: <cover.1562734889.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/phy/amlogic/phy-meson-g12a-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
index 9065ffc85eb4..cd7eccab2649 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-usb2.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
@@ -66,7 +66,7 @@
 #define PHY_CTRL_R14						0x38
 	#define PHY_CTRL_R14_I_RDP_EN				BIT(0)
 	#define PHY_CTRL_R14_I_RPU_SW1_EN			BIT(1)
-	#define PHY_CTRL_R14_I_RPU_SW2_EN			GENMASK(2, 3)
+	#define PHY_CTRL_R14_I_RPU_SW2_EN			GENMASK(3, 2)
 	#define PHY_CTRL_R14_PG_RSTN				BIT(4)
 	#define PHY_CTRL_R14_I_C2L_DATA_16_8			BIT(5)
 	#define PHY_CTRL_R14_I_C2L_ASSERT_SINGLE_EN_ZERO	BIT(6)
-- 
2.15.0

