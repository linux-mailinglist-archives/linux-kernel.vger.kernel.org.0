Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819BD17033C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 16:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgBZPzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 10:55:09 -0500
Received: from ns.iliad.fr ([212.27.33.1]:48552 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbgBZPzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:55:07 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 0862520581;
        Wed, 26 Feb 2020 16:55:05 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id EBC5E202EC;
        Wed, 26 Feb 2020 16:55:04 +0100 (CET)
Subject: [RFC PATCH v4 2/2] clk: Use devm_add in managed functions
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <68219a85-295d-7b7c-9658-c3045bbcbaeb@free.fr>
Message-ID: <e88ca46a-799d-9c86-f2d2-6284eb3c3419@free.fr>
Date:   Wed, 26 Feb 2020 16:51:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <68219a85-295d-7b7c-9658-c3045bbcbaeb@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Feb 26 16:55:05 2020 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the helper produces simpler code, and smaller object size.
E.g. with gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu:

    text           data     bss     dec     hex filename
-   1708             80       0    1788     6fc drivers/clk/clk-devres.o
+   1524             80       0    1604     644 drivers/clk/clk-devres.o

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/clk/clk-devres.c | 101 ++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 64 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index be160764911b..3f4b200b5328 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -4,26 +4,22 @@
 #include <linux/export.h>
 #include <linux/gfp.h>
 
-static void devm_clk_release(struct device *dev, void *res)
+static void my_clk_put(struct device *dev, void *res)
 {
 	clk_put(*(struct clk **)res);
 }
 
 struct clk *devm_clk_get(struct device *dev, const char *id)
 {
-	struct clk **ptr, *clk;
-
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
+	int ret;
+	struct clk *clk = clk_get(dev, id);
+
+	if (IS_ERR(clk))
+		return clk;
+
+	ret = devm_add(dev, my_clk_put, &clk, sizeof(clk));
+	if (ret)
+		return ERR_PTR(ret);
 
 	return clk;
 }
@@ -40,14 +36,14 @@ struct clk *devm_clk_get_optional(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL(devm_clk_get_optional);
 
-struct clk_bulk_devres {
-	struct clk_bulk_data *clks;
+struct clk_bulk_args {
 	int num_clks;
+	struct clk_bulk_data *clks;
 };
 
-static void devm_clk_bulk_release(struct device *dev, void *res)
+static void my_clk_bulk_put(struct device *dev, void *res)
 {
-	struct clk_bulk_devres *devres = res;
+	struct clk_bulk_args *devres = res;
 
 	clk_bulk_put(devres->num_clks, devres->clks);
 }
@@ -55,25 +51,17 @@ static void devm_clk_bulk_release(struct device *dev, void *res)
 static int __devm_clk_bulk_get(struct device *dev, int num_clks,
 			       struct clk_bulk_data *clks, bool optional)
 {
-	struct clk_bulk_devres *devres;
 	int ret;
 
-	devres = devres_alloc(devm_clk_bulk_release,
-			      sizeof(*devres), GFP_KERNEL);
-	if (!devres)
-		return -ENOMEM;
-
 	if (optional)
 		ret = clk_bulk_get_optional(dev, num_clks, clks);
 	else
 		ret = clk_bulk_get(dev, num_clks, clks);
-	if (!ret) {
-		devres->clks = clks;
-		devres->num_clks = num_clks;
-		devres_add(dev, devres);
-	} else {
-		devres_free(devres);
-	}
+
+	if (ret)
+		return ret;
+
+	ret = devm_vadd(dev, my_clk_bulk_put, clk_bulk_args, num_clks, clks);
 
 	return ret;
 }
@@ -95,24 +83,17 @@ EXPORT_SYMBOL_GPL(devm_clk_bulk_get_optional);
 int __must_check devm_clk_bulk_get_all(struct device *dev,
 				       struct clk_bulk_data **clks)
 {
-	struct clk_bulk_devres *devres;
 	int ret;
+	int num_clks = clk_bulk_get_all(dev, clks);
 
-	devres = devres_alloc(devm_clk_bulk_release,
-			      sizeof(*devres), GFP_KERNEL);
-	if (!devres)
-		return -ENOMEM;
-
-	ret = clk_bulk_get_all(dev, &devres->clks);
-	if (ret > 0) {
-		*clks = devres->clks;
-		devres->num_clks = ret;
-		devres_add(dev, devres);
-	} else {
-		devres_free(devres);
-	}
+	if (num_clks <= 0)
+		return num_clks;
 
-	return ret;
+	ret = devm_vadd(dev, my_clk_bulk_put, clk_bulk_args, num_clks, *clks);
+	if (ret)
+		return ret;
+
+	return num_clks;
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
 
@@ -128,30 +109,22 @@ static int devm_clk_match(struct device *dev, void *res, void *data)
 
 void devm_clk_put(struct device *dev, struct clk *clk)
 {
-	int ret;
-
-	ret = devres_release(dev, devm_clk_release, devm_clk_match, clk);
-
-	WARN_ON(ret);
+	WARN_ON(devres_release(dev, my_clk_put, devm_clk_match, clk));
 }
 EXPORT_SYMBOL(devm_clk_put);
 
 struct clk *devm_get_clk_from_child(struct device *dev,
 				    struct device_node *np, const char *con_id)
 {
-	struct clk **ptr, *clk;
-
-	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	clk = of_clk_get_by_name(np, con_id);
-	if (!IS_ERR(clk)) {
-		*ptr = clk;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	int ret;
+	struct clk *clk = of_clk_get_by_name(np, con_id);
+
+	if (IS_ERR(clk))
+		return clk;
+
+	ret = devm_add(dev, my_clk_put, &clk, sizeof(clk));
+	if (ret)
+		return ERR_PTR(ret);
 
 	return clk;
 }
-- 
2.17.1
