Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 451C814EE97
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 15:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgAaOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 09:38:12 -0500
Received: from ned.t-8ch.de ([212.47.237.191]:37370 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbgAaOiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:38:11 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1580481445;
        bh=d/HBCqKEtu13ihHegP4tYREK/3yRPONvTZnf4qI8ZCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZVQtTJaW72oLYszbZhRPQo4xGsWLMoyESnDL+o7J319cFH+B9GCpB2i1pYD30eRyp
         K8HQR2ycFZMprJJc9VGildCStKEd3GVi6ufrcnCW+YtMThGan2MCY4oV/uddjiBNoe
         FbwMa/wwxGUWrzjah06clsXgCfiDukyQ2j0vNUz8=
To:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 2/3] platform/x86: thinkpad_acpi: use standard charge control attribute names
Date:   Fri, 31 Jan 2020 15:36:49 +0100
Message-Id: <20200131143650.4149-3-linux@weissschuh.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131143650.4149-2-linux@weissschuh.net>
References: <20200131143650.4149-1-linux@weissschuh.net>
 <20200131143650.4149-2-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard attributes were only introduced after the ones from
thinkpad_acpi in commit 813cab8f3994 ("power: supply: core: Add CHARGE_CONTROL_{START_THRESHOLD,END_THRESHOLD} properties").

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/thinkpad_acpi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 2d3a99e3efb7..5f0e3299778a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9608,40 +9608,40 @@ static ssize_t tpacpi_battery_show(int what,
 	return sprintf(buf, "%d\n", ret);
 }
 
-static ssize_t charge_start_threshold_show(struct device *device,
+static ssize_t charge_control_start_threshold_show(struct device *device,
 				struct device_attribute *attr,
 				char *buf)
 {
 	return tpacpi_battery_show(THRESHOLD_START, device, buf);
 }
 
-static ssize_t charge_stop_threshold_show(struct device *device,
+static ssize_t charge_control_end_threshold_show(struct device *device,
 				struct device_attribute *attr,
 				char *buf)
 {
 	return tpacpi_battery_show(THRESHOLD_STOP, device, buf);
 }
 
-static ssize_t charge_start_threshold_store(struct device *dev,
+static ssize_t charge_control_start_threshold_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
 	return tpacpi_battery_store(THRESHOLD_START, dev, buf, count);
 }
 
-static ssize_t charge_stop_threshold_store(struct device *dev,
+static ssize_t charge_control_end_threshold_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
 	return tpacpi_battery_store(THRESHOLD_STOP, dev, buf, count);
 }
 
-static DEVICE_ATTR_RW(charge_start_threshold);
-static DEVICE_ATTR_RW(charge_stop_threshold);
+static DEVICE_ATTR_RW(charge_control_start_threshold);
+static DEVICE_ATTR_RW(charge_control_end_threshold);
 
 static struct attribute *tpacpi_battery_attrs[] = {
-	&dev_attr_charge_start_threshold.attr,
-	&dev_attr_charge_stop_threshold.attr,
+	&dev_attr_charge_control_start_threshold.attr,
+	&dev_attr_charge_control_end_threshold.attr,
 	NULL,
 };
 
-- 
2.25.0

