Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF4F235CB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 14:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391334AbfETMiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 08:38:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:15751 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390990AbfETMiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:38:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 05:38:51 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2019 05:38:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8841E9B; Mon, 20 May 2019 15:38:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] device property: Add helpers to count items in an array
Date:   Mon, 20 May 2019 15:38:48 +0300
Message-Id: <20190520123848.56422-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usual pattern to allocate the necessary space for an array of properties is
to count them fist using:

  count = device_property_read_uXX_array(dev, propname, NULL, 0);

Introduce helpers device_property_count_uXX() to count items by supplying hard
coded last two parameters to device_property_readXX_array().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/linux/property.h b/include/linux/property.h
index a29369c89e6e..65e31c090f9f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -144,6 +144,26 @@ static inline int device_property_read_u64(struct device *dev,
 	return device_property_read_u64_array(dev, propname, val, 1);
 }
 
+static inline int device_property_count_u8(struct device *dev, const char *propname)
+{
+	return device_property_read_u8_array(dev, propname, NULL, 0);
+}
+
+static inline int device_property_count_u16(struct device *dev, const char *propname)
+{
+	return device_property_read_u16_array(dev, propname, NULL, 0);
+}
+
+static inline int device_property_count_u32(struct device *dev, const char *propname)
+{
+	return device_property_read_u32_array(dev, propname, NULL, 0);
+}
+
+static inline int device_property_count_u64(struct device *dev, const char *propname)
+{
+	return device_property_read_u64_array(dev, propname, NULL, 0);
+}
+
 static inline bool fwnode_property_read_bool(const struct fwnode_handle *fwnode,
 					     const char *propname)
 {
@@ -174,6 +194,30 @@ static inline int fwnode_property_read_u64(const struct fwnode_handle *fwnode,
 	return fwnode_property_read_u64_array(fwnode, propname, val, 1);
 }
 
+static inline int fwnode_property_count_u8(const struct fwnode_handle *fwnode,
+					   const char *propname)
+{
+	return fwnode_property_read_u8_array(fwnode, propname, NULL, 0);
+}
+
+static inline int fwnode_property_count_u16(const struct fwnode_handle *fwnode,
+					    const char *propname)
+{
+	return fwnode_property_read_u16_array(fwnode, propname, NULL, 0);
+}
+
+static inline int fwnode_property_count_u32(const struct fwnode_handle *fwnode,
+					    const char *propname)
+{
+	return fwnode_property_read_u32_array(fwnode, propname, NULL, 0);
+}
+
+static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
+					    const char *propname)
+{
+	return fwnode_property_read_u64_array(fwnode, propname, NULL, 0);
+}
+
 /**
  * struct property_entry - "Built-in" device property representation.
  * @name: Name of the property.
-- 
2.20.1

