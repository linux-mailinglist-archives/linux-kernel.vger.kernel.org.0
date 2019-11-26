Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8619110A1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 17:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfKZQRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 11:17:12 -0500
Received: from ns.iliad.fr ([212.27.33.1]:35412 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfKZQRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 11:17:12 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id CB34F215C7;
        Tue, 26 Nov 2019 17:17:09 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id BA55D215C6;
        Tue, 26 Nov 2019 17:17:09 +0100 (CET)
To:     linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v1] clk: Convert managed get functions to devm_add_action API
Message-ID: <3d8a58bf-0814-1ec1-038a-10a20b9646ad@free.fr>
Date:   Tue, 26 Nov 2019 17:13:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Nov 26 17:17:09 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Tue, 26 Nov 2019 13:56:53 +0100

Using devm_add_action_or_reset() produces simpler code and smaller
object size:

1 file changed, 16 insertions(+), 46 deletions(-)

    text	   data	    bss	    dec	    hex	filename
-   1797	     80	      0	   1877	    755	drivers/clk/clk-devres.o
+   1499	     56	      0	   1555	    613	drivers/clk/clk-devres.o

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/clk/clk-devres.c | 62 +++++++++++-----------------------------
 1 file changed, 16 insertions(+), 46 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index be160764911b..04379c1f203e 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -4,31 +4,29 @@
 #include <linux/export.h>
 #include <linux/gfp.h>
 
-static void devm_clk_release(struct device *dev, void *res)
+static void __clk_put(void *clk)
 {
-	clk_put(*(struct clk **)res);
+	clk_put(clk);
 }
 
 struct clk *devm_clk_get(struct device *dev, const char *id)
 {
-	struct clk **ptr, *clk;
+	struct clk *clk = clk_get(dev, id);
 
-	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	clk = clk_get(dev, id);
-	if (!IS_ERR(clk)) {
-		*ptr = clk;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	if (!IS_ERR(clk))
+		if (devm_add_action_or_reset(dev, __clk_put, clk))
+			clk = ERR_PTR(-ENOMEM);
 
 	return clk;
 }
 EXPORT_SYMBOL(devm_clk_get);
 
+void devm_clk_put(struct device *dev, struct clk *clk)
+{
+	devm_release_action(dev, __clk_put, clk);
+}
+EXPORT_SYMBOL(devm_clk_put);
+
 struct clk *devm_clk_get_optional(struct device *dev, const char *id)
 {
 	struct clk *clk = devm_clk_get(dev, id);
@@ -116,42 +114,14 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
 
-static int devm_clk_match(struct device *dev, void *res, void *data)
-{
-	struct clk **c = res;
-	if (!c || !*c) {
-		WARN_ON(!c || !*c);
-		return 0;
-	}
-	return *c == data;
-}
-
-void devm_clk_put(struct device *dev, struct clk *clk)
-{
-	int ret;
-
-	ret = devres_release(dev, devm_clk_release, devm_clk_match, clk);
-
-	WARN_ON(ret);
-}
-EXPORT_SYMBOL(devm_clk_put);
-
 struct clk *devm_get_clk_from_child(struct device *dev,
 				    struct device_node *np, const char *con_id)
 {
-	struct clk **ptr, *clk;
-
-	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	struct clk *clk = of_clk_get_by_name(np, con_id);
 
-	clk = of_clk_get_by_name(np, con_id);
-	if (!IS_ERR(clk)) {
-		*ptr = clk;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	if (!IS_ERR(clk))
+		if (devm_add_action_or_reset(dev, __clk_put, clk))
+			clk = ERR_PTR(-ENOMEM);
 
 	return clk;
 }
-- 
2.17.1
