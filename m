Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A14A01676A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 09:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbgBUIhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 03:37:11 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44391 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731796AbgBUIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:05:20 -0500
Received: by mail-pf1-f202.google.com with SMTP id r127so811325pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 00:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y7uM3w77h2Gn0yEivNMhyewHaqjCcqiwBI+mwPIiJHs=;
        b=pHr2BkDof3Fi5RIfi45Obkf2Zn9XhrTRDiCQwEd+W7RBN7etnTZ1IyWFhtTlwLbIdr
         z8+GTqGz5A1U6oFjIMIgncwnPh6FTmw0fq1TS5w6vlSavXfLor8MvO0qvDREouv0pHKQ
         pIA+IKRPAM9epa6ygrjvw60f+Ym9nFDqq1eEjx/WKEHJLCM7gYY4m1s/kmtsLUxUfuMU
         ITpwSRr0sllPNnKOSSSIpCkehSqWMRLhkfu54QL8IMwSDpNjrwPQniGnNHz2KmvHR6fY
         qg6q3bAecNQqBw24Dgh4PcSANk7vTFq9eOYMZ6BpNYSgqi8OG3TpLPCpWaKx6AMpWewz
         QcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y7uM3w77h2Gn0yEivNMhyewHaqjCcqiwBI+mwPIiJHs=;
        b=bniDTvf2FYwkpclsFNIN6Cl2N+UkSY4eoYyQOu4+Lvww4eLsGBmUXCvywcl29iiQsG
         56lJUFMZphqFoAQNwOHsU1yv6xU/WYLXMaHLPJxW4bqUwMc800LwtODtJxKjjGyoFVL0
         StOlUGNUGHtuj0QkbIkB6FImeoQA/N1JywVFBNczU3FuYuMP3vkjZIn94k7muaaqIm+o
         1T8aMmR3eibRQ7AdrEbE+dKc9HuptoTLC+K6No1brW68KSjW1uMb6nw2PSYjImknVtIm
         PgAlUm/Z9OvB08e/xAe5H8OvWoSdYtxN0SmgKkU0Ds6f+SGfuw4Aa/gfHrKlO2ti1unK
         q+6Q==
X-Gm-Message-State: APjAAAVnxeCtj8+qLoiDTccofhHca/T2X4RUvaof1WGIKB3Jo2GhIxfx
        H55NYF9ibNWhAitJso6U1OYPAJXFNZTwNk0=
X-Google-Smtp-Source: APXvYqykOVdjdEqNtHV21Qvwnk++iTaOpWShiuvvh6OV2akSdZXrYA0OTzHtwlpD18117Ot8bVwkk20z1kngHgc=
X-Received: by 2002:a63:8f49:: with SMTP id r9mr37735880pgn.190.1582272319742;
 Fri, 21 Feb 2020 00:05:19 -0800 (PST)
Date:   Fri, 21 Feb 2020 00:05:08 -0800
In-Reply-To: <20200221080510.197337-1-saravanak@google.com>
Message-Id: <20200221080510.197337-2-saravanak@google.com>
Mime-Version: 1.0
References: <20200221080510.197337-1-saravanak@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 1/3] driver core: Call sync_state() even if supplier has no consumers
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial patch that added sync_state() support didn't handle the case
where a supplier has no consumers. This was because when a device is
successfully bound with a driver, only its suppliers were checked to see
if they are eligible to get a sync_state(). This is not sufficient for
devices that have no consumers but still need to do device state clean
up. So fix this.

Fixes: fc5a251d0fd7ca90 (driver core: Add sync_state driver/bus callback)
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 42a672456432..3306d5ae92a6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -745,25 +745,31 @@ static void __device_links_queue_sync_state(struct device *dev,
 /**
  * device_links_flush_sync_list - Call sync_state() on a list of devices
  * @list: List of devices to call sync_state() on
+ * @dont_lock_dev: Device for which lock is already held by the caller
  *
  * Calls sync_state() on all the devices that have been queued for it. This
- * function is used in conjunction with __device_links_queue_sync_state().
+ * function is used in conjunction with __device_links_queue_sync_state(). The
+ * @dont_lock_dev parameter is useful when this function is called from a
+ * context where a device lock is already held.
  */
-static void device_links_flush_sync_list(struct list_head *list)
+static void device_links_flush_sync_list(struct list_head *list,
+					 struct device *dont_lock_dev)
 {
 	struct device *dev, *tmp;
 
 	list_for_each_entry_safe(dev, tmp, list, links.defer_sync) {
 		list_del_init(&dev->links.defer_sync);
 
-		device_lock(dev);
+		if (dev != dont_lock_dev)
+			device_lock(dev);
 
 		if (dev->bus->sync_state)
 			dev->bus->sync_state(dev);
 		else if (dev->driver && dev->driver->sync_state)
 			dev->driver->sync_state(dev);
 
-		device_unlock(dev);
+		if (dev != dont_lock_dev)
+			device_unlock(dev);
 
 		put_device(dev);
 	}
@@ -801,7 +807,7 @@ void device_links_supplier_sync_state_resume(void)
 out:
 	device_links_write_unlock();
 
-	device_links_flush_sync_list(&sync_list);
+	device_links_flush_sync_list(&sync_list, NULL);
 }
 
 static int sync_state_resume_initcall(void)
@@ -865,6 +871,11 @@ void device_links_driver_bound(struct device *dev)
 			driver_deferred_probe_add(link->consumer);
 	}
 
+	if (defer_sync_state_count)
+		__device_links_supplier_defer_sync(dev);
+	else
+		__device_links_queue_sync_state(dev, &sync_list);
+
 	list_for_each_entry(link, &dev->links.suppliers, c_node) {
 		if (!(link->flags & DL_FLAG_MANAGED))
 			continue;
@@ -883,7 +894,7 @@ void device_links_driver_bound(struct device *dev)
 
 	device_links_write_unlock();
 
-	device_links_flush_sync_list(&sync_list);
+	device_links_flush_sync_list(&sync_list, dev);
 }
 
 static void device_link_drop_managed(struct device_link *link)
-- 
2.25.0.265.gbab2e86ba0-goog

