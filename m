Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2EF1418B5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jan 2020 18:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgARR0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 12:26:40 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44168 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgARR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 12:26:38 -0500
Received: by mail-yb1-f196.google.com with SMTP id f136so7689411ybg.11;
        Sat, 18 Jan 2020 09:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fVQtk4i9wxO1OHUyYdDMGfK80i/Af+du55cVTUFfbuU=;
        b=aeHiAns7vp1zaRgHubpxtzRcOC1eKOf4bA3lRD3/SwwpGiUxLN28EKeF2pd02Q1Mj4
         d2Id/PiltMtj4CNihKGaH52pwUPFXieh7Gng3MDdf/7nhPfwXtjwBMcscFU6DWUKf/2V
         XLQ51eLqL9Ydo4CoVhaHolK1iOFRuG55EEmfJMlmTqO06x5L0W7vzVcis8nWD+VBmf3/
         Uxn5LVAOoTA6gh++VbY1Yw64uvNM5ZbowsgwjxL5ZebuYqQhF72UVO8nmq81zg4Y1kUv
         kSM8D7YEA2AdSnVQ3+0Lb9Exoj7FfaWtlDKvo33JjHORuPpSpP3sPVYxxowuG07ZIQTc
         RNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=fVQtk4i9wxO1OHUyYdDMGfK80i/Af+du55cVTUFfbuU=;
        b=Xd+F9FGsU/RjnGMiCXALlQwfzZCKl2PjLUizac0HEuQUaOSck6/woNDyBk+q4dwclY
         A6vBTdY6NfOd6AZI2xs9kCZJpUCUEqeTcorOEjVS5cQ2dHbqc+WZpKh3NyHtfN+cIo4F
         1RDi7A4pY7mUlsusVwZ+jJtfnLm61t10UNRfh8HT0j0qXDNFl9OuNYk4Ei6oM7WuyV3w
         IXutWRjLQlB8JJ1krJKnWlMXNfqflUqAqrOioOLMmlomZAu6afdlemq0AIrPIDywg+XS
         OfL5JodK9nTcwSquaZbM45l8OO0oB5guEk016gBk5y7ow1yAYwqW9ZoU4cwXj5kl1oEJ
         w/sA==
X-Gm-Message-State: APjAAAW6i2OBqofxl9Cpa+GtgHfhjslDegOptbhUNSnqemYJvHS572it
        uHjyZ9nwD1xhDdDzQEL4Vzcg85SE
X-Google-Smtp-Source: APXvYqzpHUehfJJB3bnS0qjJAuh6PcxgRPYFNtzVqbUEh7vvpkXo5UAdB4BCQG2SG119I0PFk2qGpw==
X-Received: by 2002:a5b:591:: with SMTP id l17mr33504386ybp.238.1579368396970;
        Sat, 18 Jan 2020 09:26:36 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l200sm13458445ywl.106.2020.01.18.09.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jan 2020 09:26:36 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/5] hwmon: (k10temp) Report temperatures per CPU die
Date:   Sat, 18 Jan 2020 09:26:13 -0800
Message-Id: <20200118172615.26329-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200118172615.26329-1-linux@roeck-us.net>
References: <20200118172615.26329-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zen2 reports reporting temperatures per CPU die (called Core Complex Dies,
or CCD, by AMD). Add support for it to the k10temp driver.

Tested-by: Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
Tested-by: Darren Salt <devspam@moreofthesa.me.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Tested-by: tags

 drivers/hwmon/k10temp.c | 79 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index c45f6498a59b..944ba8008bc4 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -5,6 +5,12 @@
  *
  * Copyright (c) 2009 Clemens Ladisch <clemens@ladisch.de>
  * Copyright (c) 2020 Guenter Roeck <linux@roeck-us.net>
+ *
+ * Implementation notes:
+ * - CCD1 and CCD2 register address information as well as the calculation to
+ *   convert raw register values is from https://github.com/ocerman/zenpower.
+ *   The information is not confirmed from chip datasheets, but experiments
+ *   suggest that it provides reasonable temperature values.
  */
 
 #include <linux/bitops.h>
@@ -61,6 +67,8 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 
 /* F17h M01h Access througn SMN */
 #define F17H_M01H_REPORTED_TEMP_CTRL_OFFSET	0x00059800
+#define F17H_M70H_CCD1_TEMP			0x00059954
+#define F17H_M70H_CCD2_TEMP			0x00059958
 
 #define CUR_TEMP_SHIFT				21
 #define CUR_TEMP_RANGE_SEL_MASK			BIT(19)
@@ -72,6 +80,8 @@ struct k10temp_data {
 	int temp_offset;
 	u32 temp_adjust_mask;
 	bool show_tdie;
+	bool show_tccd1;
+	bool show_tccd2;
 };
 
 struct tctl_offset {
@@ -143,6 +153,8 @@ static long get_raw_temp(struct k10temp_data *data)
 const char *k10temp_temp_label[] = {
 	"Tdie",
 	"Tctl",
+	"Tccd1",
+	"Tccd2",
 };
 
 static int k10temp_read_labels(struct device *dev,
@@ -172,6 +184,16 @@ static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
 			if (*val < 0)
 				*val = 0;
 			break;
+		case 2:		/* Tccd1 */
+			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
+				     F17H_M70H_CCD1_TEMP, &regval);
+			*val = (regval & 0xfff) * 125 - 305000;
+			break;
+		case 3:		/* Tccd2 */
+			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
+				     F17H_M70H_CCD2_TEMP, &regval);
+			*val = (regval & 0xfff) * 125 - 305000;
+			break;
 		default:
 			return -EOPNOTSUPP;
 		}
@@ -206,8 +228,24 @@ static umode_t k10temp_is_visible(const void *_data,
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_input:
-			if (channel && !data->show_tdie)
+			switch (channel) {
+			case 0:		/* Tdie, or Tctl if we don't show it */
+				break;
+			case 1:		/* Tctl */
+				if (!data->show_tdie)
+					return 0;
+				break;
+			case 2:		/* Tccd1 */
+				if (!data->show_tccd1)
+					return 0;
+				break;
+			case 3:		/* Tccd2 */
+				if (!data->show_tccd2)
+					return 0;
+				break;
+			default:
 				return 0;
+			}
 			break;
 		case hwmon_temp_max:
 			if (channel)
@@ -229,8 +267,24 @@ static umode_t k10temp_is_visible(const void *_data,
 				return 0;
 			break;
 		case hwmon_temp_label:
+			/* No labels if we don't show the die temperature */
 			if (!data->show_tdie)
 				return 0;
+			switch (channel) {
+			case 0:		/* Tdie */
+			case 1:		/* Tctl */
+				break;
+			case 2:		/* Tccd1 */
+				if (!data->show_tccd1)
+					return 0;
+				break;
+			case 3:		/* Tccd2 */
+				if (!data->show_tccd2)
+					return 0;
+				break;
+			default:
+				return 0;
+			}
 			break;
 		default:
 			return 0;
@@ -281,6 +335,8 @@ static const struct hwmon_channel_info *k10temp_info[] = {
 			   HWMON_T_INPUT | HWMON_T_MAX |
 			   HWMON_T_CRIT | HWMON_T_CRIT_HYST |
 			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL),
 	NULL
 };
@@ -326,9 +382,30 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		data->read_htcreg = read_htcreg_nb_f15;
 		data->read_tempreg = read_tempreg_nb_f15;
 	} else if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
+		u32 regval;
+
 		data->temp_adjust_mask = CUR_TEMP_RANGE_SEL_MASK;
 		data->read_tempreg = read_tempreg_nb_f17;
 		data->show_tdie = true;
+
+		switch (boot_cpu_data.x86_model) {
+		case 0x1:	/* Zen */
+		case 0x8:	/* Zen+ */
+		case 0x11:	/* Zen APU */
+		case 0x18:	/* Zen+ APU */
+			break;
+		case 0x71:	/* Zen2 */
+			amd_smn_read(amd_pci_dev_to_node_id(pdev),
+				     F17H_M70H_CCD1_TEMP, &regval);
+			if (regval & 0xfff)
+				data->show_tccd1 = true;
+
+			amd_smn_read(amd_pci_dev_to_node_id(pdev),
+				     F17H_M70H_CCD2_TEMP, &regval);
+			if (regval & 0xfff)
+				data->show_tccd2 = true;
+			break;
+		}
 	} else {
 		data->read_htcreg = read_htcreg_pci;
 		data->read_tempreg = read_tempreg_pci;
-- 
2.17.1

