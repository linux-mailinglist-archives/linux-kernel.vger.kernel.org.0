Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55ABD2B925
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2019 18:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfE0QhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 May 2019 12:37:11 -0400
Received: from proxy04.fsdata.se ([89.221.252.227]:50417 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726704AbfE0QhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:37:08 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 May 2019 12:37:03 EDT
Received: from localhost (94.234.40.49) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 May 2019 18:21:48
 +0200
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <dvhart@infradead.org>, <andy@infradead.org>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] platform/x86: wmi: add context pointer field to struct wmi_device_id
Date:   Mon, 27 May 2019 18:21:29 +0200
Message-ID: <c69e613dc6087487962166dbf2e780db77ee8a82.1558968964.git.2pi@mok.nu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558968964.git.2pi@mok.nu>
References: <cover.1558968964.git.2pi@mok.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [94.234.40.49]
X-ClientProxiedBy: PROXY02.HMC.local (192.168.46.52) To DAG01.HMC.local
 (192.168.46.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using wmi_install_notify_handler() to initialize a WMI handler a
data pointer can be supplied which will be passed on to the notification
handler. No similar feature exist when handling WMI events via struct
wmi_driver.

Add a context field pointer to struct wmi_device_id and add a function
find_guid_context() to retrieve that context pointer.

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
---
 drivers/platform/x86/wmi.c      | 22 ++++++++++++++++++++++
 include/linux/mod_devicetable.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7b26b6ccf1a0..f41f1410da9d 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -146,6 +146,28 @@ static bool find_guid(const char *guid_string, struct wmi_block **out)
 	return false;
 }
 
+static const void *find_guid_context(struct wmi_block *wblock,
+				      struct wmi_driver *wdriver)
+{
+	const struct wmi_device_id *id;
+	uuid_le guid_input;
+
+	if (wblock == NULL || wdriver == NULL)
+		return NULL;
+	if (wdriver->id_table == NULL)
+		return NULL;
+
+	id = wdriver->id_table;
+	while (*id->guid_string) {
+		if (uuid_le_to_bin(id->guid_string, &guid_input))
+			continue;
+		if (!memcmp(wblock->gblock.guid, &guid_input, 16))
+			return id->context;
+		id++;
+	}
+	return NULL;
+}
+
 static int get_subobj_info(acpi_handle handle, const char *pathname,
 			   struct acpi_device_info **info)
 {
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 448621c32e4d..09366859aac2 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -798,6 +798,7 @@ struct tee_client_device_id {
  */
 struct wmi_device_id {
 	const char guid_string[UUID_STRING_LEN+1];
+	const void *context;
 };
 
 #endif /* LINUX_MOD_DEVICETABLE_H */
-- 
2.21.0

