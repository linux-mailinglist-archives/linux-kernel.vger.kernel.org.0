Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35845388F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 13:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfFGL0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 07:26:44 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:37516 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfFGL0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:26:43 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id MnSh2000Z3XaVaC01nShAN; Fri, 07 Jun 2019 13:26:41 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD17-0004Ev-FI; Fri, 07 Jun 2019 13:26:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD17-0003bz-Du; Fri, 07 Jun 2019 13:26:41 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] regulator: cpcap: Spelling s/configuraion/configuration/
Date:   Fri,  7 Jun 2019 13:26:40 +0200
Message-Id: <20190607112640.13842-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/regulator/cpcap-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index d3284361e594b06c..f80781d58a2823f2 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -90,7 +90,7 @@
 #define CPCAP_REG_OFF_MODE_SEC		BIT(15)
 
 /**
- * SoC specific configuraion for CPCAP regulator. There are at least three
+ * SoC specific configuration for CPCAP regulator. There are at least three
  * different SoCs each with their own parameters: omap3, omap4 and tegra2.
  *
  * The assign_reg and assign_mask seem to allow toggling between primary
-- 
2.17.1

