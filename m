Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0DBF2661
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 05:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfKGEL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 23:11:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:50390 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733289AbfKGEL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 23:11:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:58 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; 
   d="scan'208";a="229453323"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:11:58 -0800
Subject: [PATCH 12/16] dax: Add numa_node to the default device-dax
 attributes
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>, peterz@infradead.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Wed, 06 Nov 2019 19:57:41 -0800
Message-ID: <157309906102.1582359.4262088001244476001.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is confusing that device-dax instances publish a 'target_node'
attribute, but not a 'numa_node'. The 'numa_node' information is
available elsewhere in the sysfs device hierarchy, but it is not obvious
and not reliable from one device-dax instance-type (e.g. child devices
of nvdimm namespaces) to the next (e.g. 'hmem' devices defined by EFI
Specific Purpose Memory and the ACPI HMAT).

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index ce6d648d7670..0879b9663eb7 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -322,6 +322,13 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(modalias);
 
+static ssize_t numa_node_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", dev_to_node(dev));
+}
+static DEVICE_ATTR_RO(numa_node);
+
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -329,6 +336,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 
 	if (a == &dev_attr_target_node.attr && dev_dax_target_node(dev_dax) < 0)
 		return 0;
+	if (a == &dev_attr_numa_node.attr && !IS_ENABLED(CONFIG_NUMA))
+		return 0;
 	return a->mode;
 }
 
@@ -337,6 +346,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_size.attr,
 	&dev_attr_target_node.attr,
 	&dev_attr_resource.attr,
+	&dev_attr_numa_node.attr,
 	NULL,
 };
 

