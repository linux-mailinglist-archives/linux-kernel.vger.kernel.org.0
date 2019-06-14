Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5D674667A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 19:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfFNRzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 13:55:18 -0400
Received: from foss.arm.com ([217.140.110.172]:39574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfFNRzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2E6AD6E;
        Fri, 14 Jun 2019 10:55:15 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2CF1C3F718;
        Fri, 14 Jun 2019 10:55:15 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com
Subject: [PATCH v2 16/28] drivers: Introduce class_find_device_by_acpi_dev() helper
Date:   Fri, 14 Jun 2019 18:54:11 +0100
Message-Id: <1560534863-15115-17-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a wrapper to class_find_device() to search for a device
by the ACPI COMPANION device, reusing the generic match function.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 include/linux/device.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 2effcc2..b1b8c90 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -534,6 +534,27 @@ static inline struct device *class_find_device_by_devt(struct class *class,
 	return class_find_device(class, NULL, &devt, device_match_devt);
 }
 
+#ifdef CONFIG_ACPI
+struct acpi_device;
+/**
+ * class_find_device_by_acpi_dev : device iterator for locating a particular
+ * device matching the ACPI_COMPANION device.
+ * @class: class type
+ * @adev: ACPI_COMPANION device to match.
+ */
+static inline struct device *
+class_find_device_by_acpi_dev(struct class *class, const struct acpi_device *adev)
+{
+	return class_find_device(class, NULL, adev, device_match_acpi_dev);
+}
+#else
+static inline struct device *
+class_find_device_by_acpi_dev(struct class *class, const void *adev)
+{
+	return NULL;
+}
+#endif
+
 struct class_attribute {
 	struct attribute attr;
 	ssize_t (*show)(struct class *class, struct class_attribute *attr,
-- 
2.7.4

