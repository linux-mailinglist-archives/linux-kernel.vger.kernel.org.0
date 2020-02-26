Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61BC1170338
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 16:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgBZPzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 10:55:06 -0500
Received: from ns.iliad.fr ([212.27.33.1]:48512 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbgBZPzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:55:06 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id E996020025;
        Wed, 26 Feb 2020 16:55:04 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id D6430204B1;
        Wed, 26 Feb 2020 16:55:04 +0100 (CET)
Subject: [RFC PATCH v4 1/2] devres: Provide new helper for devm functions
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
Message-ID: <f53767e0-e533-74bc-2967-e2cc4c3df15e@free.fr>
Date:   Wed, 26 Feb 2020 16:49:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <68219a85-295d-7b7c-9658-c3045bbcbaeb@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Feb 26 16:55:04 2020 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple wrapper for devres_alloc / devres_add.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/base/devres.c  | 28 ++++++++++++++++++++++++++++
 include/linux/device.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 0bbb328bd17f..7fe6cc34411e 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -685,6 +685,34 @@ int devres_release_group(struct device *dev, void *id)
 }
 EXPORT_SYMBOL_GPL(devres_release_group);
 
+/**
+ * devm_add - allocate and register new device resource
+ * @dev: device to add resource to
+ * @func: resource release function
+ * @arg: resource data
+ * @size: resource data size
+ *
+ * Simple wrapper for devres_alloc / devres_add.
+ * Release the resource if the allocation fails.
+ *
+ * RETURNS:
+ * 0 if the allocation succeeds, -ENOMEM otherwise.
+ */
+int devm_add(struct device *dev, dr_release_t func, void *arg, size_t size)
+{
+	void *data = devres_alloc(func, size, GFP_KERNEL);
+
+	if (!data) {
+		func(dev, arg);
+		return -ENOMEM;
+	}
+
+	memcpy(data, arg, size);
+	devres_add(dev, data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_add);
+
 /*
  * Custom devres actions allow inserting a simple function call
  * into the teadown sequence.
diff --git a/include/linux/device.h b/include/linux/device.h
index 0cd7c647c16c..55be3be9b276 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -247,6 +247,9 @@ void __iomem *devm_of_iomap(struct device *dev,
 			    struct device_node *node, int index,
 			    resource_size_t *size);
 
+int devm_add(struct device *dev, dr_release_t func, void *arg, size_t size);
+#define devm_vadd(dev, func, type, args...) \
+	devm_add(dev, func, &(struct type){args}, sizeof(struct type))
 /* allows to add/remove a custom action to devres stack */
 int devm_add_action(struct device *dev, void (*action)(void *), void *data);
 void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
-- 
2.17.1
