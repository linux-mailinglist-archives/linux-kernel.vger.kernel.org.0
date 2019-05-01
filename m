Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA610D23
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 21:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfEATSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 15:18:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44687 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfEATSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:18:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id s10so21050071qtc.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=154pK5P8ksWbhOO3IYrUyqpSsi0GfqRRa2gpHRslqUk=;
        b=h5z1bbu8My60moCWezm7iQzfloAmd6aTxFKQXLUkDNyrqdYqTncDVWNt2X09qLxS3O
         XbNJsC/XnK1M4hHGHUsGpsWWJ1i66/0sC4pt//GILaeXj67jLKultNg/URuZLHxy9DUB
         n145ZqRuwWAPC05ewtKDW6T9fCTUIC1kV7gqHfS7NkOhqxEGKbdYX3L3QdBy8QG0TK+2
         p6Kiqtc4e3Q23gKMdpkbaVSUh5m4WX/FZssFEru/tThscoqK4pj6kyblkhFibSSTqHps
         jlV9ibZk/xaZpnwzsnlF3l2rW+yE2UD5A3zFgwhJCF3/xcOWS93XsJ8nIPrSkr14x6H6
         r4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=154pK5P8ksWbhOO3IYrUyqpSsi0GfqRRa2gpHRslqUk=;
        b=hzt1JOvnj4GdQczzdCffjU59CxmUIykp+Wyg3jGqcicXvrw3Z4fs5kmX7dqs8IQt1q
         7W44v/o/4/wvV6wMnX/qxgJ+oQszzYYomGtZuZE/UIkaOb1aeYMYPCmO4xYu+POVV6Z5
         xsw2TlzH+kl4/GKzWTaDxjHGzrs8ksBURUeXat6YV1FJHc/AsRE7fZvwUd5z1LxLB8lD
         qNuHfAhgNwWlEQxZ49DfBMByrF8kV2inYTwhfeKQNdDDdASD/hhQGs8E9JFA3sYXhRzF
         I0UtO03Q/oWuwSRHkkYIYSleNByPrsig6JtERcLVnG0x7rMd1CwQlxcH9D5KwhguzCal
         U6ow==
X-Gm-Message-State: APjAAAWXCRhmKULXJ+xNOzHeXo4jA+LWPExKol3Wm6Bnn0DN5R/RFbHy
        LgIRkEAlIE+Whvg3rq0Kt9avtQ==
X-Google-Smtp-Source: APXvYqzlA1gs8NVCmNdnzWYF++bUyEWeUdXTHpCbd3dCNNP+aZRzqljBcQRUhKZSNsgRGIhKd6+NhA==
X-Received: by 2002:ac8:1c82:: with SMTP id f2mr8326722qtl.68.1556738330592;
        Wed, 01 May 2019 12:18:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x47sm12610946qth.68.2019.05.01.12.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:18:49 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, akpm@linux-foundation.org,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, keith.busch@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, zwisler@kernel.org,
        thomas.lendacky@amd.com, ying.huang@intel.com,
        fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com,
        david@redhat.com
Subject: [v4 1/2] device-dax: fix memory and resource leak if hotplug fails
Date:   Wed,  1 May 2019 15:18:45 -0400
Message-Id: <20190501191846.12634-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501191846.12634-1-pasha.tatashin@soleen.com>
References: <20190501191846.12634-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When add_memory() function fails, the resource and the memory should be
freed.

Fixes: c221c0b0308f ("device-dax: "Hotplug" persistent memory for use like normal RAM")

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
---
 drivers/dax/kmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a02318c6d28a..4c0131857133 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -66,8 +66,11 @@ int dev_dax_kmem_probe(struct device *dev)
 	new_res->name = dev_name(dev);
 
 	rc = add_memory(numa_node, new_res->start, resource_size(new_res));
-	if (rc)
+	if (rc) {
+		release_resource(new_res);
+		kfree(new_res);
 		return rc;
+	}
 
 	return 0;
 }
-- 
2.21.0

