Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 946E446673
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 19:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfFNRzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 13:55:03 -0400
Received: from foss.arm.com ([217.140.110.172]:39414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfFNRzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ED5DCFC;
        Fri, 14 Jun 2019 10:55:01 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D092E3F718;
        Fri, 14 Jun 2019 10:54:59 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-usb@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 08/28] drivers: Add generic helper to match by device type
Date:   Fri, 14 Jun 2019 18:54:03 +0100
Message-Id: <1560534863-15115-9-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to match a device by its type. This will be used
later for providing wrappers to the device iterators for bus/class/driver.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-usb@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Joe Perches <joe@perches.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/core.c    | 6 ++++++
 include/linux/device.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index efcdb96..b827ca1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3340,3 +3340,9 @@ int device_match_fwnode(struct device *dev, const void *fwnode)
 	return dev_fwnode(dev) == fwnode;
 }
 EXPORT_SYMBOL_GPL(device_match_fwnode);
+
+int device_match_devt(struct device *dev, const void *pdevt)
+{
+	return dev->devt == *(dev_t *)pdevt;
+}
+EXPORT_SYMBOL_GPL(device_match_devt);
diff --git a/include/linux/device.h b/include/linux/device.h
index 08aa087..f315692 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -165,6 +165,7 @@ void subsys_dev_iter_exit(struct subsys_dev_iter *iter);
 
 int device_match_of_node(struct device *dev, const void *np);
 int device_match_fwnode(struct device *dev, const void *fwnode);
+int device_match_devt(struct device *dev, const void *pdevt);
 
 int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 		     int (*fn)(struct device *dev, void *data));
-- 
2.7.4

