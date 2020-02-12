Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F80B15A520
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 10:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgBLJnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 04:43:20 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:33084 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgBLJnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:43:19 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id 1ljJ2200Q5USYZQ06ljJnX; Wed, 12 Feb 2020 10:43:18 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1oYA-0000xk-Cl; Wed, 12 Feb 2020 10:43:18 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1oYA-0000Vp-Am; Wed, 12 Feb 2020 10:43:18 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of: clk: Make of_clk_get_parent_{count,name}() parameter const
Date:   Wed, 12 Feb 2020 10:43:17 +0100
Message-Id: <20200212094317.1150-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_clk_get_parent_count() and of_clk_get_parent_name() never modify the
device nodes passed, so they can be const.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/clk.c      | 4 ++--
 include/linux/of_clk.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e42145cd996a1f77..b6696c8e02518177 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4713,7 +4713,7 @@ EXPORT_SYMBOL(of_clk_get_by_name);
  *
  * Returns: The number of clocks that are possible parents of this node
  */
-unsigned int of_clk_get_parent_count(struct device_node *np)
+unsigned int of_clk_get_parent_count(const struct device_node *np)
 {
 	int count;
 
@@ -4725,7 +4725,7 @@ unsigned int of_clk_get_parent_count(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_clk_get_parent_count);
 
-const char *of_clk_get_parent_name(struct device_node *np, int index)
+const char *of_clk_get_parent_name(const struct device_node *np, int index)
 {
 	struct of_phandle_args clkspec;
 	struct property *prop;
diff --git a/include/linux/of_clk.h b/include/linux/of_clk.h
index c86fcad23fc21725..31b73a0da9db33e8 100644
--- a/include/linux/of_clk.h
+++ b/include/linux/of_clk.h
@@ -11,17 +11,17 @@ struct of_device_id;
 
 #if defined(CONFIG_COMMON_CLK) && defined(CONFIG_OF)
 
-unsigned int of_clk_get_parent_count(struct device_node *np);
-const char *of_clk_get_parent_name(struct device_node *np, int index);
+unsigned int of_clk_get_parent_count(const struct device_node *np);
+const char *of_clk_get_parent_name(const struct device_node *np, int index);
 void of_clk_init(const struct of_device_id *matches);
 
 #else /* !CONFIG_COMMON_CLK || !CONFIG_OF */
 
-static inline unsigned int of_clk_get_parent_count(struct device_node *np)
+static inline unsigned int of_clk_get_parent_count(const struct device_node *np)
 {
 	return 0;
 }
-static inline const char *of_clk_get_parent_name(struct device_node *np,
+static inline const char *of_clk_get_parent_name(const struct device_node *np,
 						 int index)
 {
 	return NULL;
-- 
2.17.1

