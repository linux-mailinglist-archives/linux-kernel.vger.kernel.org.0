Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F22814E55B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 23:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgA3WJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 17:09:26 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:35380 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgA3WJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:09:26 -0500
Received: by mail-pf1-f173.google.com with SMTP id y73so2211418pfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FSpFegR/uhT5Xb3wnzx/7KLjvcI1MFWa8qXjZW0wnQM=;
        b=dJleeaJxajNi+kyTJ4VgiI4ZO5uEsOfD9937OB+WPMtZTKAJ+k/XOh1yQuLWzEQSK+
         jyV7ZvpBsIgoM/z45NwNx7N5Qvcz8/nDnspm3NLEULSH3f45N3SZhT+O99rZkZUJtWS9
         a0e72FwKRWXchao9eYSNC0ONJRYXA11D4Zpjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FSpFegR/uhT5Xb3wnzx/7KLjvcI1MFWa8qXjZW0wnQM=;
        b=nmYNIunN6viHVzw1suwj1ZUj9boWrNJA9tLnv/zW9NcQ+5QLzhuqeLkrVzmBKrwm80
         sbCEYhJ5PZAJzPxLBS5U+QekxQMK9l3JcmEUhFxzqQbbECMoz3wbqmGM8Xvxt75XjPOr
         dnCnYNuMPaEzVE6M65D+05c+BbyuW6Vm32P8CBtfhwc+RQp5YNRkhWN/NsDZyFWcLttZ
         qmVcT+y7szi38iGeY24PohAQ6ZkGBsEbR954ACfDEEaWSP79Qm920UpDrb57p45Lg0BC
         9I4acbEMstHMdCgxyW6O6rzdhVPpYluZ1JQiydIR79BhJMhp6ii5XnKnrMPu70eJ7ZEE
         jE8g==
X-Gm-Message-State: APjAAAWZjb+1CZtQPxTpUxlyRpuirfgXeiRt4CqXDSPhJ4A02G7uhgSg
        7EVMDVooFROoU69+MdmpSYr6hcKKAvfjOQ==
X-Google-Smtp-Source: APXvYqz+x/5fsxu0tboGrVgxXIAKAiL/JoIyYKjCLuyewCTiG9dzV4fKvMDPO/o+x04Sc4N8Ctci7w==
X-Received: by 2002:a63:7119:: with SMTP id m25mr7024857pgc.131.1580422163534;
        Thu, 30 Jan 2020 14:09:23 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id p16sm7403859pgi.50.2020.01.30.14.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:09:23 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [RFC v2 1/3] platform/chrome: Add Type C connector class driver
Date:   Thu, 30 Jan 2020 14:07:44 -0800
Message-Id: <20200130220747.163053-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130220747.163053-1-pmalani@chromium.org>
References: <20200130220747.163053-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a the Type C connector class port driver for Chrome OS devices with
an EC (Embedded Controllers).

The driver relies on firmware device specifications for various port
attributes. On ACPI platforms, this is specified using the logical
device with HID GOOG0014. On DT platforms, this is specified using the
DT node with compatible string "google,cros-ec-typec".

This patch reads the device FW node and uses the port attributes to
register the typec ports with the Type C connector class framework, but
doesn't do much else.

Subsequent patches will add more functionality to the driver, including
obtaining current port information (polarity, vconn role, current power
role etc.) after querying the EC.

Changes in v2:
- No Changes.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/Kconfig         |  11 ++
 drivers/platform/chrome/Makefile        |   1 +
 drivers/platform/chrome/cros_ec_typec.c | 198 ++++++++++++++++++++++++
 3 files changed, 210 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_typec.c

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 5f57282a28da00..60e3dbd7975aeb 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -214,6 +214,17 @@ config CROS_EC_SYSFS
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_sysfs.
 
+config CROS_EC_TYPEC
+	tristate "ChromeOS EC Type-C Connector Control"
+	depends on CROS_EC && TYPEC
+	default n
+	help
+	  If you say Y here, you get support for accessing Type C connector
+	  information from the Chrome OS EC.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called cros_ec_typec.
+
 config CROS_USBPD_LOGGER
 	tristate "Logging driver for USB PD charger"
 	depends on CHARGER_CROS_USBPD
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index aacd5920d8a180..caf2a9cdb5e6d1 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CROS_EC_ISHTP)		+= cros_ec_ishtp.o
 obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
+obj-$(CONFIG_CROS_EC_TYPEC)		+= cros_ec_typec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
new file mode 100644
index 00000000000000..f48bb0172c565f
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2020 Google LLC
+ *
+ * This driver provides the ability to view and manage Type C ports through the
+ * Chrome OS EC.
+ */
+
+#include <linux/acpi.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/usb/typec.h>
+
+#define DRV_NAME "cros-ec-typec"
+
+/* Platform-specific data for the Chrome OS EC Type C controller. */
+struct cros_typec_data {
+	struct device *dev;
+	struct cros_ec_device *ec;
+	int num_ports;
+	/* Array of ports, indexed by port number. */
+	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
+};
+
+void cros_typec_parse_port_props(struct typec_capability *cap,
+				 const struct fwnode_handle *fwnode,
+				 struct device *dev)
+{
+	const char *buf;
+	int ret;
+
+	memset(cap, 0, sizeof(*cap));
+	ret = fwnode_property_read_string(fwnode, "power-role", &buf);
+	if (ret) {
+		dev_warn(dev, "power-role not found: %d\n", ret);
+	} else {
+		if (!strcmp(buf, "source"))
+			cap->type = TYPEC_PORT_SRC;
+		else if (!strcmp(buf, "sink"))
+			cap->type = TYPEC_PORT_SNK;
+		else if (!strcmp(buf, "dual"))
+			cap->type = TYPEC_PORT_DRP;
+		else
+			dev_warn(dev, "Unknown power-role: %s\n", buf);
+	}
+
+	ret = fwnode_property_read_string(fwnode, "data-role", &buf);
+	if (ret) {
+		dev_warn(dev, "data-role not found: %d\n", ret);
+	} else {
+		if (!strcmp(buf, "dfp"))
+			cap->data = TYPEC_PORT_UFP;
+		else if (!strcmp(buf, "ufp"))
+			cap->data = TYPEC_PORT_DFP;
+		else if (!strcmp(buf, "dual"))
+			cap->data = TYPEC_PORT_DRD;
+		else
+			dev_warn(dev, "Unknown data-role: %s\n", buf);
+	}
+
+	ret = fwnode_property_read_string(fwnode, "try-power-role", &buf);
+	if (ret) {
+		dev_warn(dev, "try-power-role not found: %d\n", ret);
+	} else {
+		if (!strcmp(buf, "source"))
+			cap->prefer_role = TYPEC_SOURCE;
+		else if (!strcmp(buf, "sink"))
+			cap->prefer_role = TYPEC_SINK;
+		else
+			dev_warn(dev, "Unknown try-power-role: %s\n", buf);
+	}
+}
+
+static int cros_typec_init_ports(struct cros_typec_data *typec)
+{
+	struct device *dev = typec->dev;
+	struct typec_capability cap;
+	struct fwnode_handle *fwnode;
+	int ret;
+	int i;
+	int nports;
+	u32 port_num;
+
+	nports = device_get_child_node_count(dev);
+	if (nports == 0) {
+		dev_err(dev, "No port entries found.\n");
+		return -ENODEV;
+	}
+
+	device_for_each_child_node(dev, fwnode) {
+		if (fwnode_property_read_u32(fwnode, "port-number",
+					     &port_num)) {
+			dev_warn(dev, "No port-number for port, skipping.\n");
+			continue;
+		}
+
+		if (port_num >= typec->num_ports) {
+			dev_err(dev, "Invalid port number.\n");
+			ret = -EINVAL;
+			goto unregister_ports;
+		}
+
+		dev_dbg(dev, "Registering port %d\n", port_num);
+		cros_typec_parse_port_props(&cap, fwnode, dev);
+		typec->ports[port_num] = typec_register_port(dev, &cap);
+		if (IS_ERR_OR_NULL(typec->ports[port_num])) {
+			dev_err(dev, "Failed to register port %d\n", port_num);
+			ret = PTR_ERR(typec->ports[port_num]);
+			goto unregister_ports;
+		}
+	}
+
+	return 0;
+
+unregister_ports:
+	for (i = 0; i < typec->num_ports; i++)
+		typec_unregister_port(typec->ports[i]);
+	return ret;
+}
+
+static int cros_typec_get_num_ports(struct cros_typec_data *typec)
+{
+	struct ec_response_usb_pd_ports resp;
+	int ret;
+
+	ret = cros_ec_send_cmd_msg(typec->ec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
+				   &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	typec->num_ports = resp.num_ports;
+
+	return 0;
+}
+
+static int cros_typec_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_typec_data *typec;
+	int ret;
+
+	typec = devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
+	if (!typec)
+		return -ENOMEM;
+	typec->dev = dev;
+	typec->ec = dev_get_drvdata(pdev->dev.parent);
+	platform_set_drvdata(pdev, typec);
+
+	ret = cros_typec_get_num_ports(typec);
+	if (ret < 0)
+		return ret;
+
+	if (typec->num_ports > EC_USB_PD_MAX_PORTS) {
+		dev_err(dev, "EC reported too many ports. got: %d, max: %d\n",
+			typec->num_ports, EC_USB_PD_MAX_PORTS);
+		return -EOVERFLOW;
+	}
+
+	ret = cros_typec_init_ports(typec);
+	if (!ret)
+		return ret;
+
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cros_typec_acpi_id[] = {
+	{ "GOOG0014", 0 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_typec_acpi_id);
+#endif
+
+#ifdef CONFIG_OF
+static const struct of_device_id cros_typec_of_match[] = {
+	{ .compatible = "google,cros-ec-typec", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, cros_typec_of_match);
+#endif
+
+static struct platform_driver cros_typec_driver = {
+	.driver	= {
+		.name	= DRV_NAME,
+		.acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
+		.of_match_table = of_match_ptr(cros_typec_of_match),
+	},
+	.probe		= cros_typec_probe,
+};
+
+module_platform_driver(cros_typec_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Chrome OS EC Type C control");
-- 
2.25.0.341.g760bfbb309-goog

