Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE34190282
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 01:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCXAKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 20:10:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:27952 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgCXAKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:10:50 -0400
IronPort-SDR: unSIPY7gdS7967RTYpBb1tJAxtRU0yHOFyIJ6eSTtDbXZmeX0TLa7bu6Dh1IE/BmOjfV2JtGGS
 oVblkAeLeZ3g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:10:50 -0700
IronPort-SDR: wrCwhew8c8zRErxRyNieFX0ol7sog5GCQVQ8yk/r/ORZ3TRhUfhxM2/4Uq80SYz12ao5+PuO2Z
 kWhp5ZSU5Mww==
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="235382018"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:10:50 -0700
Subject: [PATCH 02/12] device-dax: Move instance creation parameters to
 'struct dev_dax_data'
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     vishal.l.verma@intel.com, dave.hansen@linux.intel.com, hch@lst.de,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        jmoyer@redhat.com
Date:   Mon, 23 Mar 2020 16:54:43 -0700
Message-ID: <158500768347.2088294.5638260757259826816.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding more parameters to instance creation, move
existing parameters to a new struct.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c       |   14 +++++++-------
 drivers/dax/bus.h       |   16 ++++++++--------
 drivers/dax/hmem/hmem.c |    8 +++++++-
 drivers/dax/pmem/core.c |    9 ++++++++-
 4 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 5301c294e861..a5b1b7a82a87 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -395,9 +395,9 @@ static void unregister_dev_dax(void *dev)
 	put_device(dev);
 }
 
-struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
-		struct dev_pagemap *pgmap, enum dev_dax_subsys subsys)
+struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 {
+	struct dax_region *dax_region = data->dax_region;
 	struct device *parent = dax_region->dev;
 	struct dax_device *dax_dev;
 	struct dev_dax *dev_dax;
@@ -405,14 +405,14 @@ struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
 	struct device *dev;
 	int rc = -ENOMEM;
 
-	if (id < 0)
+	if (data->id < 0)
 		return ERR_PTR(-EINVAL);
 
 	dev_dax = kzalloc(sizeof(*dev_dax), GFP_KERNEL);
 	if (!dev_dax)
 		return ERR_PTR(-ENOMEM);
 
-	memcpy(&dev_dax->pgmap, pgmap, sizeof(*pgmap));
+	memcpy(&dev_dax->pgmap, data->pgmap, sizeof(struct dev_pagemap));
 
 	/*
 	 * No 'host' or dax_operations since there is no access to this
@@ -436,13 +436,13 @@ struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
 
 	inode = dax_inode(dax_dev);
 	dev->devt = inode->i_rdev;
-	if (subsys == DEV_DAX_BUS)
+	if (data->subsys == DEV_DAX_BUS)
 		dev->bus = &dax_bus_type;
 	else
 		dev->class = dax_class;
 	dev->parent = parent;
 	dev->type = &dev_dax_type;
-	dev_set_name(dev, "dax%d.%d", dax_region->id, id);
+	dev_set_name(dev, "dax%d.%d", dax_region->id, data->id);
 
 	rc = device_add(dev);
 	if (rc) {
@@ -462,7 +462,7 @@ struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
 
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_GPL(__devm_create_dev_dax);
+EXPORT_SYMBOL_GPL(devm_create_dev_dax);
 
 static int match_always_count;
 
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 55577e9791da..299c2e7fac09 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -13,18 +13,18 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct resource *res, int target_node, unsigned int align);
 
 enum dev_dax_subsys {
-	DEV_DAX_BUS,
+	DEV_DAX_BUS = 0, /* zeroed dev_dax_data picks this by default */
 	DEV_DAX_CLASS,
 };
 
-struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
-		struct dev_pagemap *pgmap, enum dev_dax_subsys subsys);
+struct dev_dax_data {
+	struct dax_region *dax_region;
+	struct dev_pagemap *pgmap;
+	enum dev_dax_subsys subsys;
+	int id;
+};
 
-static inline struct dev_dax *devm_create_dev_dax(struct dax_region *dax_region,
-		int id, struct dev_pagemap *pgmap)
-{
-	return __devm_create_dev_dax(dax_region, id, pgmap, DEV_DAX_BUS);
-}
+struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
 
 /* to be deleted when DEV_DAX_CLASS is removed */
 struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys);
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 506893861253..b84fe17178d8 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -11,6 +11,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	struct dev_pagemap pgmap = { };
 	struct dax_region *dax_region;
 	struct memregion_info *mri;
+	struct dev_dax_data data;
 	struct dev_dax *dev_dax;
 	struct resource *res;
 
@@ -26,7 +27,12 @@ static int dax_hmem_probe(struct platform_device *pdev)
 	if (!dax_region)
 		return -ENOMEM;
 
-	dev_dax = devm_create_dev_dax(dax_region, 0, &pgmap);
+	data = (struct dev_dax_data) {
+		.dax_region = dax_region,
+		.id = 0,
+		.pgmap = &pgmap,
+	};
+	dev_dax = devm_create_dev_dax(&data);
 	if (IS_ERR(dev_dax))
 		return PTR_ERR(dev_dax);
 
diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index ea52bb77a294..08ee5947a49c 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -14,6 +14,7 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	resource_size_t offset;
 	struct nd_pfn_sb *pfn_sb;
 	struct dev_dax *dev_dax;
+	struct dev_dax_data data;
 	struct nd_namespace_io *nsio;
 	struct dax_region *dax_region;
 	struct dev_pagemap pgmap = { };
@@ -57,7 +58,13 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	if (!dax_region)
 		return ERR_PTR(-ENOMEM);
 
-	dev_dax = __devm_create_dev_dax(dax_region, id, &pgmap, subsys);
+	data = (struct dev_dax_data) {
+		.dax_region = dax_region,
+		.id = id,
+		.pgmap = &pgmap,
+		.subsys = subsys,
+	};
+	dev_dax = devm_create_dev_dax(&data);
 
 	/* child dev_dax instances now own the lifetime of the dax_region */
 	dax_region_put(dax_region);

