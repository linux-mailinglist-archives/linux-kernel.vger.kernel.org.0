Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA78123120
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 17:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfLQQIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 11:08:39 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:35988 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfLQQIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576598918; x=1608134918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6HH7PeknGCYANJeR4Z4A5j/5EdY1wACfauzPdOr50Ks=;
  b=cSoUdgSFdJE+lxYQty5pUxOKu4tt57xZYDow1pHEPiRpYiPn4zmu9Y1K
   5di3IJwnFcWyXyCF8+GiO6+ifSuD7YIYewYdLtk9gJC6f1Pai04S3dcSp
   /jRyxTZIEXD32Curo732HpAETxzDy1jJzavAvQJ/mWFfy2k+LXKf9bhyl
   w=;
IronPort-SDR: Y/c/L64BR2vb4mZFdkz9IAcWWNkm9OE9LnG16oFDGHGeSxjlzpVmO/csdSa8Jw8TYbdlgENFKv
 jPLBb9Ci6daw==
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="8883285"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 17 Dec 2019 16:08:37 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id 12232A06FA;
        Tue, 17 Dec 2019 16:08:34 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 16:08:33 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.179) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 16:08:28 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.de>, <pdurrant@amazon.com>,
        <sjpark@amazon.com>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 1/6] xenbus/backend: Add memory pressure handler callback
Date:   Tue, 17 Dec 2019 17:07:43 +0100
Message-ID: <20191217160748.693-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217160748.693-1-sjpark@amazon.com>
References: <20191217160748.693-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.179]
X-ClientProxiedBy: EX13d09UWC002.ant.amazon.com (10.43.162.102) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Granting pages consumes backend system memory.  In systems configured
with insufficient spare memory for those pages, it can cause a memory
pressure situation.  However, finding the optimal amount of the spare
memory is challenging for large systems having dynamic resource
utilization patterns.  Also, such a static configuration might lack
flexibility.

To mitigate such problems, this commit adds a memory reclaim callback to
'xenbus_driver'.  If a memory pressure is detected, 'xenbus' requests
every backend driver to volunarily release its memory.

Note that it would be able to improve the callback facility for more
sophisticated handlings of general pressures.  For example, it would be
possible to monitor the memory consumption of each device and issue the
release requests to only devices which causing the pressure.  Also, the
callback could be extended to handle not only memory, but general
resources.  Nevertheless, this version of the implementation defers such
sophisticated goals as a future work.

Reviewed-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/xen/xenbus/xenbus_probe_backend.c | 32 +++++++++++++++++++++++
 include/xen/xenbus.h                      |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index b0bed4faf44c..7e78ebef7c54 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -248,6 +248,35 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
 	return NOTIFY_DONE;
 }
 
+static int backend_reclaim_memory(struct device *dev, void *data)
+{
+	const struct xenbus_driver *drv;
+
+	if (!dev->driver)
+		return 0;
+	drv = to_xenbus_driver(dev->driver);
+	if (drv && drv->reclaim_memory)
+		drv->reclaim_memory(to_xenbus_device(dev));
+	return 0;
+}
+
+/*
+ * Returns 0 always because we are using shrinker to only detect memory
+ * pressure.
+ */
+static unsigned long backend_shrink_memory_count(struct shrinker *shrinker,
+				struct shrink_control *sc)
+{
+	bus_for_each_dev(&xenbus_backend.bus, NULL, NULL,
+			backend_reclaim_memory);
+	return 0;
+}
+
+static struct shrinker backend_memory_shrinker = {
+	.count_objects = backend_shrink_memory_count,
+	.seeks = DEFAULT_SEEKS,
+};
+
 static int __init xenbus_probe_backend_init(void)
 {
 	static struct notifier_block xenstore_notifier = {
@@ -264,6 +293,9 @@ static int __init xenbus_probe_backend_init(void)
 
 	register_xenstore_notifier(&xenstore_notifier);
 
+	if (register_shrinker(&backend_memory_shrinker))
+		pr_warn("shrinker registration failed\n");
+
 	return 0;
 }
 subsys_initcall(xenbus_probe_backend_init);
diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
index 869c816d5f8c..c861cfb6f720 100644
--- a/include/xen/xenbus.h
+++ b/include/xen/xenbus.h
@@ -104,6 +104,7 @@ struct xenbus_driver {
 	struct device_driver driver;
 	int (*read_otherend_details)(struct xenbus_device *dev);
 	int (*is_ready)(struct xenbus_device *dev);
+	void (*reclaim_memory)(struct xenbus_device *dev);
 };
 
 static inline struct xenbus_driver *to_xenbus_driver(struct device_driver *drv)
-- 
2.17.1

