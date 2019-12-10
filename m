Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A358118BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 15:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfLJOyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 09:54:13 -0500
Received: from foss.arm.com ([217.140.110.172]:47140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbfLJOyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:54:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43EF61396;
        Tue, 10 Dec 2019 06:54:09 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 940C63F67D;
        Tue, 10 Dec 2019 06:54:08 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 05/15] firmware: arm_scmi: Add versions and identifier attributes using dev_groups
Date:   Tue, 10 Dec 2019 14:53:35 +0000
Message-Id: <20191210145345.11616-6-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210145345.11616-1-sudeep.holla@arm.com>
References: <20191210145345.11616-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform drivers now have the option to have the platform core create
and remove any needed sysfs attribute files. Using the same, let's add
the scmi firmware and protocol version attributes as well as vendor and
sub-vendor identifiers to sysfs.

It helps to identify the firmware details from the sysfs entries similar
to ARM SCPI implementation.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 0bbdc7c9eb0f..26b2c438bd59 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -979,6 +979,52 @@ static int scmi_remove(struct platform_device *pdev)
 	return ret;
 }

+static ssize_t protocol_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct scmi_info *info = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u.%u\n", info->version.major_ver,
+		       info->version.minor_ver);
+}
+static DEVICE_ATTR_RO(protocol_version);
+
+static ssize_t firmware_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct scmi_info *info = dev_get_drvdata(dev);
+
+	return sprintf(buf, "0x%x\n", info->version.impl_ver);
+}
+static DEVICE_ATTR_RO(firmware_version);
+
+static ssize_t vendor_id_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct scmi_info *info = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", info->version.vendor_id);
+}
+static DEVICE_ATTR_RO(vendor_id);
+
+static ssize_t sub_vendor_id_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct scmi_info *info = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", info->version.sub_vendor_id);
+}
+static DEVICE_ATTR_RO(sub_vendor_id);
+
+static struct attribute *versions_attrs[] = {
+	&dev_attr_firmware_version.attr,
+	&dev_attr_protocol_version.attr,
+	&dev_attr_vendor_id.attr,
+	&dev_attr_sub_vendor_id.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(versions);
+
 static const struct scmi_desc scmi_generic_desc = {
 	.max_rx_timeout_ms = 30,	/* We may increase this if required */
 	.max_msg = 20,		/* Limited by MBOX_TX_QUEUE_LEN */
@@ -997,6 +1043,7 @@ static struct platform_driver scmi_driver = {
 	.driver = {
 		   .name = "arm-scmi",
 		   .of_match_table = scmi_of_match,
+		   .dev_groups = versions_groups,
 		   },
 	.probe = scmi_probe,
 	.remove = scmi_remove,
--
2.17.1

