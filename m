Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C36ED52F7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2019 23:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfJLV6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Oct 2019 17:58:12 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:34648 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfJLV6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 17:58:11 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Oct 2019 17:58:10 EDT
Received: from trochilidae.cardiotech.int (unknown [37.17.234.113])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 99D1F5C0D8D;
        Sat, 12 Oct 2019 23:48:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1570916890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=f/t8Q8PGSqofmfNW09b8VZFKc3Ztm+m+ybxpjgknMqg=;
        b=z96AWkk+HA9+UnfVpjbAhaZKP7yRQublTuv1zeEABptBJw7eKebmKBznU3eh8VyXVT/DMM
        rmA9OOrng6E60IWcW2PniLkJ9Gi/pGwsDvOR5NeBp/XQ8eCHl8CC0Q/f95+lH/EeY8GTgU
        TXQy/Fdz/+JbrwprU6Suq6FX9Lqb4Eo=
From:   Stefan Agner <stefan@agner.ch>
To:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan.agner@toradex.com>
Subject: [PATCH] drivers: firmware: psci: use kernel restart handler functionality
Date:   Sat, 12 Oct 2019 23:47:35 +0200
Message-Id: <20191012214735.1127009-1-stefan@agner.ch>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Use the kernels restart handler to register the PSCI system reset
capability. The restart handler use notifier chains along with
priorities. This allows to use restart handlers with higher priority
(in case available) while still supporting PSCI.

Since the ARM handler had priority over the kernels restart handler
before this patch, use a slightly elevated priority of 160 to make
sure PSCI is used before most of the other handlers are called.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
---
 drivers/firmware/psci/psci.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 84f4ff351c62..d8677b54132f 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -82,6 +82,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
 
 static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
+static struct notifier_block psci_restart_handler;
 
 static inline bool psci_has_ext_power_state(void)
 {
@@ -250,7 +251,8 @@ static int get_set_conduit_method(struct device_node *np)
 	return 0;
 }
 
-static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
+static int psci_sys_reset(struct notifier_block *this,
+			    unsigned long reboot_mode, void *cmd)
 {
 	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
@@ -263,6 +265,8 @@ static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
 	} else {
 		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
 	}
+
+	return NOTIFY_DONE;
 }
 
 static void psci_sys_poweroff(void)
@@ -411,6 +415,8 @@ static void __init psci_init_smccc(void)
 
 static void __init psci_0_2_set_functions(void)
 {
+	int ret;
+
 	pr_info("Using standard PSCI v0.2 function IDs\n");
 	psci_ops.get_version = psci_get_version;
 
@@ -431,7 +437,14 @@ static void __init psci_0_2_set_functions(void)
 
 	psci_ops.migrate_info_type = psci_migrate_info_type;
 
-	arm_pm_restart = psci_sys_reset;
+	psci_restart_handler.notifier_call = psci_sys_reset;
+	psci_restart_handler.priority = 160;
+
+	ret = register_restart_handler(&psci_restart_handler);
+	if (ret) {
+		pr_err("Cannot register restart handler, %d\n", ret);
+		return;
+	}
 
 	pm_power_off = psci_sys_poweroff;
 }
-- 
2.23.0

