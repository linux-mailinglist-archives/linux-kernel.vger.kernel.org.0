Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDBD10E9A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 12:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfLBLlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 06:41:42 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:39535 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfLBLlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 06:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575286900; x=1606822900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kpBDFf/k+zrPeTbYdI5I7muMlPtyB4e1OuL/tO791VQ=;
  b=ZMSMbM27skGfOIFMZBj0RK+yfgjGhhmCD5XAqF0G1eXNTDQCexUyda1R
   FDgu/2lFj5uMMDokJDHSgzbWfu0/2AEKUiWnmMP1r0U8VkZG8sAdv+BNi
   1NNdIK/tmcBKkdR2kfTDAOmHUyifJHzE9jLZ4Pa3cj7kx6YERI9PIvUNd
   g=;
IronPort-SDR: ZS7ql7Tvf8YlX0tNkMrzXQYROPJAbsMMMFcadgL2BM02EspQF2dEPdMjhLQU0GicnTzzeKr6d1
 J10Mvso1JoqQ==
X-IronPort-AV: E=Sophos;i="5.69,268,1571702400"; 
   d="scan'208";a="6617703"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 02 Dec 2019 11:41:39 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 828DAA2372;
        Mon,  2 Dec 2019 11:41:37 +0000 (UTC)
Received: from EX13D32EUB003.ant.amazon.com (10.43.166.165) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 2 Dec 2019 11:41:37 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D32EUB003.ant.amazon.com (10.43.166.165) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 2 Dec 2019 11:41:36 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 2 Dec 2019 11:41:33 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Jan Beulich <jbeulich@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v3 1/2] xen/xenbus: reference count registered modules
Date:   Mon, 2 Dec 2019 11:41:16 +0000
Message-ID: <20191202114117.1264-2-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191202114117.1264-1-pdurrant@amazon.com>
References: <20191202114117.1264-1-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent a PV driver module being removed whilst attached to its other
end, and hence xenbus calling into potentially invalid text, take a
reference on the module before calling the probe() method (dropping it if
unsuccessful) and drop the reference after returning from the remove()
method.

Suggested-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>

v2:
 - New in v2

v3:
 - Use try_module_get() rather than __module)get() and handle failure
 - Not added Juergen's R-b because of the change
---
 drivers/xen/xenbus/xenbus_probe.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 5b471889d723..4461f4583476 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -232,9 +232,16 @@ int xenbus_dev_probe(struct device *_dev)
 		return err;
 	}
 
+	if (!try_module_get(drv->driver.owner)) {
+		dev_warn(&dev->dev, "failed to acquire module reference on '%s'.\n",
+			 drv->driver.name);
+		err = -ESRCH;
+		goto fail;
+        }
+
 	err = drv->probe(dev, id);
 	if (err)
-		goto fail;
+		goto fail_put;
 
 	err = watch_otherend(dev);
 	if (err) {
@@ -244,6 +251,8 @@ int xenbus_dev_probe(struct device *_dev)
 	}
 
 	return 0;
+fail_put:
+	module_put(drv->driver.owner);
 fail:
 	xenbus_dev_error(dev, err, "xenbus_dev_probe on %s", dev->nodename);
 	xenbus_switch_state(dev, XenbusStateClosed);
@@ -263,6 +272,8 @@ int xenbus_dev_remove(struct device *_dev)
 	if (drv->remove)
 		drv->remove(dev);
 
+	module_put(drv->driver.owner);
+
 	free_otherend_details(dev);
 
 	xenbus_switch_state(dev, XenbusStateClosed);
-- 
2.20.1

