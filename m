Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3984A1435AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 03:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgAUCal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 21:30:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36737 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAUCak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 21:30:40 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so638922pgc.3;
        Mon, 20 Jan 2020 18:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2TWeVdE7IiqXKwtqthavTGOK3VlPsF519h/qxKiwBH8=;
        b=UWr6M2vvnvogn67/lqEIk6nI3ETzsojv9QYOPYczZOB1zP322OYsEgG2SVrPYY5mej
         ZrPcaQiK2BjC3YUrwkwOB5tgPeggZdKqFMDOX5SONBdAWtVHd27or73BCSw4pbnx6naJ
         eux/dJ1gcl3dtOr1sMJfz1gCDWh+6oIqGcDyLr8JCH3Kipii8BmunWoLQMtRMqshey4q
         OuYQc2TFrTFoStVWKlWWORNl4G0Axt9d2r4jNQA/zxe/qD0x/eT7SrG7SI4z81F/9yY6
         fpYJUZnt9b6RfH47n1XggP0wFycqA9Apbix8AAPpfCI6Fw2U4OSP6G0FYuEjBZaHHauT
         cEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=2TWeVdE7IiqXKwtqthavTGOK3VlPsF519h/qxKiwBH8=;
        b=NasKvTUDiV6vTrIaeDCf/9KDmSeEGp5rXMHpu+mSI5qPVScZomYKaLUgJ69M7xPfvi
         Kc/IwP9m8HWXVXIvj7X/Hymwax3gQN0EYgl/qE1ZH3tLVdI4lq+DXmjB+0lE/rbfpgpe
         cKRSjhi9YGUbvf6nvSSooIq2+tbk4b6XNXB18IdibgL4d0uwKXnLptVVu8Dl2KXOQiCk
         rdXD4YT7NjAwJDcwDfDlPjwsg0qQMGfTDrw6Ohbmgr6ReLw5r/IKxMBi7UNrpRJN1LHJ
         mB4bxqyo+e0EL/WcnA344hW7WuAPcvN0IC62FgieeY+wrpuEEbenzIdiQYxqfIzapCqJ
         dVww==
X-Gm-Message-State: APjAAAXLcCoq65+cb+MuXyW5gaNBKsBXe8okNtMKrH9B2wLnay0VxXoC
        +kgCifyKAfx6Qg0baH1irSQimdrD
X-Google-Smtp-Source: APXvYqy2tO9VVNmNY4ECfNWMq/TIvWfh72QjB0FqxWDD+4MbXHGbqbeYPuhs4IGBsEZCZckN9WEXGA==
X-Received: by 2002:aa7:8181:: with SMTP id g1mr2253068pfi.215.1579573839061;
        Mon, 20 Jan 2020 18:30:39 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2sm763160pjt.31.2020.01.20.18.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Jan 2020 18:30:38 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        =?UTF-8?q?Ondrej=20=C4=8Cerman?= <ocerman@sda1.eu>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Michael Larabel <michael@phoronix.com>,
        Jonathan McDowell <noodles@earth.li>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 2/5] hmon: (k10temp) Convert to use devm_hwmon_device_register_with_info
Date:   Mon, 20 Jan 2020 18:30:24 -0800
Message-Id: <20200121023027.2081-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121023027.2081-1-linux@roeck-us.net>
References: <20200121023027.2081-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert driver to use devm_hwmon_device_register_with_info to simplify
the code and to reduce its size.

Old size (x86_64):
   text	   data	    bss	    dec	    hex	filename
   8247	   4488	     64	  12799	   31ff	drivers/hwmon/k10temp.o
New size:
   text	   data	    bss	    dec	    hex	filename
   6778	   2792	     64	   9634	   25a2	drivers/hwmon/k10temp.o

Tested-by: Brad Campbell <lists2009@fnarfbargle.com>
Tested-by: Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
Tested-by: Holger Kiehl <holger.kiehl@dwd.de>
Tested-by: Michael Larabel <michael@phoronix.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
Tested-by: Ken Moffat <zarniwhoop73@googlemail.com>
Tested-by: Darren Salt <devspam@moreofthesa.me.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 213 +++++++++++++++++++++-------------------
 1 file changed, 112 insertions(+), 101 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 8807d7da68db..c45f6498a59b 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -1,14 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * k10temp.c - AMD Family 10h/11h/12h/14h/15h/16h processor hardware monitoring
+ * k10temp.c - AMD Family 10h/11h/12h/14h/15h/16h/17h
+ *		processor hardware monitoring
  *
  * Copyright (c) 2009 Clemens Ladisch <clemens@ladisch.de>
+ * Copyright (c) 2020 Guenter Roeck <linux@roeck-us.net>
  */
 
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -127,10 +128,10 @@ static void read_tempreg_nb_f17(struct pci_dev *pdev, u32 *regval)
 		     F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
 }
 
-static unsigned int get_raw_temp(struct k10temp_data *data)
+static long get_raw_temp(struct k10temp_data *data)
 {
-	unsigned int temp;
 	u32 regval;
+	long temp;
 
 	data->read_tempreg(data->pdev, &regval);
 	temp = (regval >> CUR_TEMP_SHIFT) * 125;
@@ -139,118 +140,108 @@ static unsigned int get_raw_temp(struct k10temp_data *data)
 	return temp;
 }
 
-static ssize_t temp1_input_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct k10temp_data *data = dev_get_drvdata(dev);
-	unsigned int temp = get_raw_temp(data);
-
-	if (temp > data->temp_offset)
-		temp -= data->temp_offset;
-	else
-		temp = 0;
-
-	return sprintf(buf, "%u\n", temp);
-}
-
-static ssize_t temp2_input_show(struct device *dev,
-				struct device_attribute *devattr, char *buf)
-{
-	struct k10temp_data *data = dev_get_drvdata(dev);
-	unsigned int temp = get_raw_temp(data);
-
-	return sprintf(buf, "%u\n", temp);
-}
-
-static ssize_t temp_label_show(struct device *dev,
-			       struct device_attribute *devattr, char *buf)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-
-	return sprintf(buf, "%s\n", attr->index ? "Tctl" : "Tdie");
-}
+const char *k10temp_temp_label[] = {
+	"Tdie",
+	"Tctl",
+};
 
-static ssize_t temp1_max_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static int k10temp_read_labels(struct device *dev,
+			       enum hwmon_sensor_types type,
+			       u32 attr, int channel, const char **str)
 {
-	return sprintf(buf, "%d\n", 70 * 1000);
+	*str = k10temp_temp_label[channel];
+	return 0;
 }
 
-static ssize_t temp_crit_show(struct device *dev,
-			      struct device_attribute *devattr, char *buf)
+static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct k10temp_data *data = dev_get_drvdata(dev);
-	int show_hyst = attr->index;
 	u32 regval;
-	int value;
 
-	data->read_htcreg(data->pdev, &regval);
-	value = ((regval >> 16) & 0x7f) * 500 + 52000;
-	if (show_hyst)
-		value -= ((regval >> 24) & 0xf) * 500;
-	return sprintf(buf, "%d\n", value);
+	switch (attr) {
+	case hwmon_temp_input:
+		switch (channel) {
+		case 0:		/* Tdie */
+			*val = get_raw_temp(data) - data->temp_offset;
+			if (*val < 0)
+				*val = 0;
+			break;
+		case 1:		/* Tctl */
+			*val = get_raw_temp(data);
+			if (*val < 0)
+				*val = 0;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_temp_max:
+		*val = 70 * 1000;
+		break;
+	case hwmon_temp_crit:
+		data->read_htcreg(data->pdev, &regval);
+		*val = ((regval >> 16) & 0x7f) * 500 + 52000;
+		break;
+	case hwmon_temp_crit_hyst:
+		data->read_htcreg(data->pdev, &regval);
+		*val = (((regval >> 16) & 0x7f)
+			- ((regval >> 24) & 0xf)) * 500 + 52000;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
 }
 
-static DEVICE_ATTR_RO(temp1_input);
-static DEVICE_ATTR_RO(temp1_max);
-static SENSOR_DEVICE_ATTR_RO(temp1_crit, temp_crit, 0);
-static SENSOR_DEVICE_ATTR_RO(temp1_crit_hyst, temp_crit, 1);
-
-static SENSOR_DEVICE_ATTR_RO(temp1_label, temp_label, 0);
-static DEVICE_ATTR_RO(temp2_input);
-static SENSOR_DEVICE_ATTR_RO(temp2_label, temp_label, 1);
-
-static umode_t k10temp_is_visible(struct kobject *kobj,
-				  struct attribute *attr, int index)
+static umode_t k10temp_is_visible(const void *_data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct k10temp_data *data = dev_get_drvdata(dev);
+	const struct k10temp_data *data = _data;
 	struct pci_dev *pdev = data->pdev;
 	u32 reg;
 
-	switch (index) {
-	case 0 ... 1:	/* temp1_input, temp1_max */
-	default:
-		break;
-	case 2 ... 3:	/* temp1_crit, temp1_crit_hyst */
-		if (!data->read_htcreg)
-			return 0;
-
-		pci_read_config_dword(pdev, REG_NORTHBRIDGE_CAPABILITIES,
-				      &reg);
-		if (!(reg & NB_CAP_HTC))
-			return 0;
-
-		data->read_htcreg(data->pdev, &reg);
-		if (!(reg & HTC_ENABLE))
-			return 0;
-		break;
-	case 4 ... 6:	/* temp1_label, temp2_input, temp2_label */
-		if (!data->show_tdie)
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			if (channel && !data->show_tdie)
+				return 0;
+			break;
+		case hwmon_temp_max:
+			if (channel)
+				return 0;
+			break;
+		case hwmon_temp_crit:
+		case hwmon_temp_crit_hyst:
+			if (channel || !data->read_htcreg)
+				return 0;
+
+			pci_read_config_dword(pdev,
+					      REG_NORTHBRIDGE_CAPABILITIES,
+					      &reg);
+			if (!(reg & NB_CAP_HTC))
+				return 0;
+
+			data->read_htcreg(data->pdev, &reg);
+			if (!(reg & HTC_ENABLE))
+				return 0;
+			break;
+		case hwmon_temp_label:
+			if (!data->show_tdie)
+				return 0;
+			break;
+		default:
 			return 0;
+		}
 		break;
+	default:
+		return 0;
 	}
-	return attr->mode;
+	return 0444;
 }
 
-static struct attribute *k10temp_attrs[] = {
-	&dev_attr_temp1_input.attr,
-	&dev_attr_temp1_max.attr,
-	&sensor_dev_attr_temp1_crit.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
-	&sensor_dev_attr_temp1_label.dev_attr.attr,
-	&dev_attr_temp2_input.attr,
-	&sensor_dev_attr_temp2_label.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group k10temp_group = {
-	.attrs = k10temp_attrs,
-	.is_visible = k10temp_is_visible,
-};
-__ATTRIBUTE_GROUPS(k10temp);
-
 static bool has_erratum_319(struct pci_dev *pdev)
 {
 	u32 pkg_type, reg_dram_cfg;
@@ -285,8 +276,27 @@ static bool has_erratum_319(struct pci_dev *pdev)
 	       (boot_cpu_data.x86_model == 4 && boot_cpu_data.x86_stepping <= 2);
 }
 
-static int k10temp_probe(struct pci_dev *pdev,
-				   const struct pci_device_id *id)
+static const struct hwmon_channel_info *k10temp_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_CRIT_HYST |
+			   HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	NULL
+};
+
+static const struct hwmon_ops k10temp_hwmon_ops = {
+	.is_visible = k10temp_is_visible,
+	.read = k10temp_read,
+	.read_string = k10temp_read_labels,
+};
+
+static const struct hwmon_chip_info k10temp_chip_info = {
+	.ops = &k10temp_hwmon_ops,
+	.info = k10temp_info,
+};
+
+static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int unreliable = has_erratum_319(pdev);
 	struct device *dev = &pdev->dev;
@@ -334,8 +344,9 @@ static int k10temp_probe(struct pci_dev *pdev,
 		}
 	}
 
-	hwmon_dev = devm_hwmon_device_register_with_groups(dev, "k10temp", data,
-							   k10temp_groups);
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "k10temp", data,
+							 &k10temp_chip_info,
+							 NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-- 
2.17.1

