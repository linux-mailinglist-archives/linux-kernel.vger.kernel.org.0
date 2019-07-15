Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1868669864
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 17:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbfGOPej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 11:34:39 -0400
Received: from ns.iliad.fr ([212.27.33.1]:57348 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730296AbfGOPee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:34:34 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 5E0A5202B3;
        Mon, 15 Jul 2019 17:34:32 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 441271FF44;
        Mon, 15 Jul 2019 17:34:32 +0200 (CEST)
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
Message-ID: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
Date:   Mon, 15 Jul 2019 17:34:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Jul 15 17:34:32 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide devm variants for automatic resource release on device removal.
probe() error-handling is simpler, and remove is no longer required.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 Documentation/driver-model/devres.rst |  3 +++
 drivers/clk/clk.c                     | 24 ++++++++++++++++++++++++
 include/linux/clk.h                   |  8 ++++++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/driver-model/devres.rst b/Documentation/driver-model/devres.rst
index 1b6ced8e4294..9357260576ef 100644
--- a/Documentation/driver-model/devres.rst
+++ b/Documentation/driver-model/devres.rst
@@ -253,6 +253,9 @@ CLOCK
   devm_clk_hw_register()
   devm_of_clk_add_hw_provider()
   devm_clk_hw_register_clkdev()
+  devm_clk_prepare()
+  devm_clk_enable()
+  devm_clk_prepare_enable()
 
 DMA
   dmaenginem_async_device_register()
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..5e85548357c0 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -914,6 +914,18 @@ int clk_prepare(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_prepare);
 
+static void unprepare(void *clk)
+{
+	clk_unprepare(clk);
+}
+
+int devm_clk_prepare(struct device *dev, struct clk *clk)
+{
+	int rc = clk_prepare(clk);
+	return rc ? : devm_add_action_or_reset(dev, unprepare, clk);
+}
+EXPORT_SYMBOL_GPL(devm_clk_prepare);
+
 static void clk_core_disable(struct clk_core *core)
 {
 	lockdep_assert_held(&enable_lock);
@@ -1136,6 +1148,18 @@ int clk_enable(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_enable);
 
+static void disable(void *clk)
+{
+	clk_disable(clk);
+}
+
+int devm_clk_enable(struct device *dev, struct clk *clk)
+{
+	int rc = clk_enable(clk);
+	return rc ? : devm_add_action_or_reset(dev, disable, clk);
+}
+EXPORT_SYMBOL_GPL(devm_clk_enable);
+
 static int clk_core_prepare_enable(struct clk_core *core)
 {
 	int ret;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 3c096c7a51dc..d09b5207e3f1 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -895,6 +895,14 @@ static inline void clk_restore_context(void) {}
 
 #endif
 
+int devm_clk_prepare(struct device *dev, struct clk *clk);
+int devm_clk_enable(struct device *dev, struct clk *clk);
+static inline int devm_clk_prepare_enable(struct device *dev, struct clk *clk)
+{
+	int rc = devm_clk_prepare(dev, clk);
+	return rc ? : devm_clk_enable(dev, clk);
+}
+
 /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
 static inline int clk_prepare_enable(struct clk *clk)
 {
-- 
2.17.1
