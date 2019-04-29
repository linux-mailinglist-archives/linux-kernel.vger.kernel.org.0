Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E62C1E6D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 17:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfD2PrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 11:47:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728518AbfD2PrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:47:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 982D0307EA87;
        Mon, 29 Apr 2019 15:47:00 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-148.ams2.redhat.com [10.36.116.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C6F92899C;
        Mon, 29 Apr 2019 15:46:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Renz <appswert@gmail.com>
Subject: [PATCH] platform/x86: touchscreen_dmi: Add info for 'jumper ezpad 6 pro b' touchscreen
Date:   Mon, 29 Apr 2019 17:46:57 +0200
Message-Id: <20190429154657.26797-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 29 Apr 2019 15:47:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Renz <appswert@gmail.com>

Add touchscreen platform data for the 'jumper ezpad 6 pro b' touchscreen.

Signed-off-by: Benjamin Renz <appswert@gmail.com>
[hdegoede@redhat.com: Cleanup commit msg, fix some checkpatch warnings]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index 3319f0cbb558..bd0856d2e825 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -249,6 +249,21 @@ static const struct ts_dmi_data jumper_ezpad_6_pro_data = {
 	.properties	= jumper_ezpad_6_pro_props,
 };
 
+static const struct property_entry jumper_ezpad_6_pro_b_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-jumper-ezpad-6-pro-b.fw"),
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data jumper_ezpad_6_pro_b_data = {
+	.acpi_name      = "MSSL1680:00",
+	.properties     = jumper_ezpad_6_pro_b_props,
+};
+
 static const struct property_entry jumper_ezpad_mini3_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 23),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 16),
@@ -690,6 +705,17 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_DATE, "08/18/2017"),
 		},
 	},
+	{
+		/* Jumper EZpad 6 Pro B */
+		.driver_data = (void *)&jumper_ezpad_6_pro_b_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Jumper"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EZpad"),
+			DMI_MATCH(DMI_BIOS_VERSION, "5.12"),
+			/* Above matches are too generic, add bios-date match */
+			DMI_MATCH(DMI_BIOS_DATE, "04/24/2018"),
+		},
+	},
 	{
 		/* Jumper EZpad mini3 */
 		.driver_data = (void *)&jumper_ezpad_mini3_data,
-- 
2.21.0

