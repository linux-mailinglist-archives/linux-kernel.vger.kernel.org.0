Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2171FFAF7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 18:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfKQRbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 12:31:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:15562 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfKQRbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 12:31:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:31:45 -0800
X-IronPort-AV: E=Sophos;i="5.68,317,1569308400"; 
   d="scan'208";a="199732840"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2019 09:31:44 -0800
Subject: [PATCH v5] libnvdimm/namespace: Differentiate between probe mapping
 and runtime mapping
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 17 Nov 2019 09:17:28 -0800
Message-ID: <157401043806.4136370.17628933051475068094.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

The nvdimm core currently maps the full namespace to an ioremap range
while probing the namespace mode. This can result in probe failures on
architectures that have limited ioremap space.

For example, with a large btt namespace that consumes most of I/O remap
range, depending on the sequence of namespace initialization, the user
can find a pfn namespace initialization failure due to unavailable I/O
remap space which nvdimm core uses for temporary mapping.

nvdimm core can avoid this failure by only mapping the reserved info
block area to check for pfn superblock type and map the full namespace
resource only before using the namespace.

Given that personalities like BTT can be layered on top of any namespace
type create a generic form of devm_nsio_enable (devm_namespace_enable)
and use it inside the per-personality attach routines. Now
devm_namespace_enable() is always paired with disable unless the mapping
is going to be used for long term runtime access.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/20191017073308.32645-1-aneesh.kumar@linux.ibm.com
[djbw: reworks to move devm_namespace_{en,dis}able into *attach helpers]
Reported-by: kbuild test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/20191031105741.102793-2-aneesh.kumar@linux.ibm.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v4:
- Fix a 0day report for devm_nsio_disable() being redefined due to it
  not being inlined.

 drivers/dax/pmem/core.c         |    6 +++---
 drivers/nvdimm/btt.c            |   10 ++++++++--
 drivers/nvdimm/claim.c          |   14 ++++++--------
 drivers/nvdimm/namespace_devs.c |   17 +++++++++++++++++
 drivers/nvdimm/nd-core.h        |   17 +++++++++++++++++
 drivers/nvdimm/nd.h             |   22 +++++++++-------------
 drivers/nvdimm/pfn_devs.c       |   18 +++++++++++-------
 drivers/nvdimm/pmem.c           |   17 +++++++++++++----
 8 files changed, 84 insertions(+), 37 deletions(-)

diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index 6eb6dfdf19bf..2bedf8414fff 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -25,20 +25,20 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	ndns = nvdimm_namespace_common_probe(dev);
 	if (IS_ERR(ndns))
 		return ERR_CAST(ndns);
-	nsio = to_nd_namespace_io(&ndns->dev);
 
 	/* parse the 'pfn' info block via ->rw_bytes */
-	rc = devm_nsio_enable(dev, nsio);
+	rc = devm_namespace_enable(dev, ndns, nd_info_block_reserve());
 	if (rc)
 		return ERR_PTR(rc);
 	rc = nvdimm_setup_pfn(nd_pfn, &pgmap);
 	if (rc)
 		return ERR_PTR(rc);
-	devm_nsio_disable(dev, nsio);
+	devm_namespace_disable(dev, ndns);
 
 	/* reserve the metadata area, device-dax will reserve the data */
 	pfn_sb = nd_pfn->pfn_sb;
 	offset = le64_to_cpu(pfn_sb->dataoff);
+	nsio = to_nd_namespace_io(&ndns->dev);
 	if (!devm_request_mem_region(dev, nsio->res.start, offset,
 				dev_name(&ndns->dev))) {
 		dev_warn(dev, "could not reserve metadata\n");
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 3e9f45aec8d1..8cb890a987b0 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1674,7 +1674,8 @@ int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns)
 	struct nd_region *nd_region;
 	struct btt_sb *btt_sb;
 	struct btt *btt;
-	size_t rawsize;
+	size_t size, rawsize;
+	int rc;
 
 	if (!nd_btt->uuid || !nd_btt->ndns || !nd_btt->lbasize) {
 		dev_dbg(&nd_btt->dev, "incomplete btt configuration\n");
@@ -1685,6 +1686,11 @@ int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns)
 	if (!btt_sb)
 		return -ENOMEM;
 
+	size = nvdimm_namespace_capacity(ndns);
+	rc = devm_namespace_enable(&nd_btt->dev, ndns, size);
+	if (rc)
+		return rc;
+
 	/*
 	 * If this returns < 0, that is ok as it just means there wasn't
 	 * an existing BTT, and we're creating a new one. We still need to
@@ -1693,7 +1699,7 @@ int nvdimm_namespace_attach_btt(struct nd_namespace_common *ndns)
 	 */
 	nd_btt_version(nd_btt, ndns, btt_sb);
 
-	rawsize = nvdimm_namespace_capacity(ndns) - nd_btt->initial_offset;
+	rawsize = size - nd_btt->initial_offset;
 	if (rawsize < ARENA_MIN_SIZE) {
 		dev_dbg(&nd_btt->dev, "%s must be at least %ld bytes\n",
 				dev_name(&ndns->dev),
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 2985ca949912..45964acba944 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -300,13 +300,14 @@ static int nsio_rw_bytes(struct nd_namespace_common *ndns,
 	return rc;
 }
 
-int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
+int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio,
+		resource_size_t size)
 {
 	struct resource *res = &nsio->res;
 	struct nd_namespace_common *ndns = &nsio->common;
 
-	nsio->size = resource_size(res);
-	if (!devm_request_mem_region(dev, res->start, resource_size(res),
+	nsio->size = size;
+	if (!devm_request_mem_region(dev, res->start, size,
 				dev_name(&ndns->dev))) {
 		dev_warn(dev, "could not reserve region %pR\n", res);
 		return -EBUSY;
@@ -318,12 +319,10 @@ int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio)
 	nvdimm_badblocks_populate(to_nd_region(ndns->dev.parent), &nsio->bb,
 			&nsio->res);
 
-	nsio->addr = devm_memremap(dev, res->start, resource_size(res),
-			ARCH_MEMREMAP_PMEM);
+	nsio->addr = devm_memremap(dev, res->start, size, ARCH_MEMREMAP_PMEM);
 
 	return PTR_ERR_OR_ZERO(nsio->addr);
 }
-EXPORT_SYMBOL_GPL(devm_nsio_enable);
 
 void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio)
 {
@@ -331,6 +330,5 @@ void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio)
 
 	devm_memunmap(dev, nsio->addr);
 	devm_exit_badblocks(dev, &nsio->bb);
-	devm_release_mem_region(dev, res->start, resource_size(res));
+	devm_release_mem_region(dev, res->start, nsio->size);
 }
-EXPORT_SYMBOL_GPL(devm_nsio_disable);
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 829f7bdaaa6d..c90664387ee5 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1759,6 +1759,23 @@ struct nd_namespace_common *nvdimm_namespace_common_probe(struct device *dev)
 }
 EXPORT_SYMBOL(nvdimm_namespace_common_probe);
 
+int devm_namespace_enable(struct device *dev, struct nd_namespace_common *ndns,
+		resource_size_t size)
+{
+	if (is_namespace_blk(&ndns->dev))
+		return 0;
+	return devm_nsio_enable(dev, to_nd_namespace_io(&ndns->dev), size);
+}
+EXPORT_SYMBOL_GPL(devm_namespace_enable);
+
+void devm_namespace_disable(struct device *dev, struct nd_namespace_common *ndns)
+{
+	if (is_namespace_blk(&ndns->dev))
+		return;
+	devm_nsio_disable(dev, to_nd_namespace_io(&ndns->dev));
+}
+EXPORT_SYMBOL_GPL(devm_namespace_disable);
+
 static struct device **create_namespace_io(struct nd_region *nd_region)
 {
 	struct nd_namespace_io *nsio;
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 25fa121104d0..96e8630f451c 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -171,6 +171,23 @@ ssize_t nd_namespace_store(struct device *dev,
 struct nd_pfn *to_nd_pfn_safe(struct device *dev);
 bool is_nvdimm_bus(struct device *dev);
 
+#if IS_ENABLED(CONFIG_ND_CLAIM)
+int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio,
+		resource_size_t size);
+void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio);
+#else
+static inline int devm_nsio_enable(struct device *dev,
+		struct nd_namespace_io *nsio, resource_size_t size)
+{
+	return -ENXIO;
+}
+
+static inline void devm_nsio_disable(struct device *dev,
+		struct nd_namespace_io *nsio)
+{
+}
+#endif
+
 #ifdef CONFIG_PROVE_LOCKING
 extern struct class *nd_class;
 
diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index ee5c04070ef9..a9f338d01a55 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -212,6 +212,11 @@ struct nd_dax {
 	struct nd_pfn nd_pfn;
 };
 
+static inline u32 nd_info_block_reserve(void)
+{
+	return ALIGN(SZ_8K, PAGE_SIZE);
+}
+
 enum nd_async_mode {
 	ND_SYNC,
 	ND_ASYNC,
@@ -370,29 +375,20 @@ const char *nvdimm_namespace_disk_name(struct nd_namespace_common *ndns,
 unsigned int pmem_sector_size(struct nd_namespace_common *ndns);
 void nvdimm_badblocks_populate(struct nd_region *nd_region,
 		struct badblocks *bb, const struct resource *res);
+int devm_namespace_enable(struct device *dev, struct nd_namespace_common *ndns,
+		resource_size_t size);
+void devm_namespace_disable(struct device *dev,
+		struct nd_namespace_common *ndns);
 #if IS_ENABLED(CONFIG_ND_CLAIM)
-
 /* max struct page size independent of kernel config */
 #define MAX_STRUCT_PAGE_SIZE 64
-
 int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
-int devm_nsio_enable(struct device *dev, struct nd_namespace_io *nsio);
-void devm_nsio_disable(struct device *dev, struct nd_namespace_io *nsio);
 #else
 static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
 				   struct dev_pagemap *pgmap)
 {
 	return -ENXIO;
 }
-static inline int devm_nsio_enable(struct device *dev,
-		struct nd_namespace_io *nsio)
-{
-	return -ENXIO;
-}
-static inline void devm_nsio_disable(struct device *dev,
-		struct nd_namespace_io *nsio)
-{
-}
 #endif
 int nd_blk_region_init(struct nd_region *nd_region);
 int nd_region_activate(struct nd_region *nd_region);
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 96727fd493f7..3ca6c97cd14d 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -382,6 +382,15 @@ static int nd_pfn_clear_memmap_errors(struct nd_pfn *nd_pfn)
 	meta_start = (SZ_4K + sizeof(*pfn_sb)) >> 9;
 	meta_num = (le64_to_cpu(pfn_sb->dataoff) >> 9) - meta_start;
 
+	/*
+	 * re-enable the namespace with correct size so that we can access
+	 * the device memmap area.
+	 */
+	devm_namespace_disable(&nd_pfn->dev, ndns);
+	rc = devm_namespace_enable(&nd_pfn->dev, ndns, le64_to_cpu(pfn_sb->dataoff));
+	if (rc)
+		return rc;
+
 	do {
 		unsigned long zero_len;
 		u64 nsoff;
@@ -635,11 +644,6 @@ int nd_pfn_probe(struct device *dev, struct nd_namespace_common *ndns)
 }
 EXPORT_SYMBOL(nd_pfn_probe);
 
-static u32 info_block_reserve(void)
-{
-	return ALIGN(SZ_8K, PAGE_SIZE);
-}
-
 /*
  * We hotplug memory at sub-section granularity, pad the reserved area
  * from the previous section base to the namespace base address.
@@ -653,7 +657,7 @@ static unsigned long init_altmap_base(resource_size_t base)
 
 static unsigned long init_altmap_reserve(resource_size_t base)
 {
-	unsigned long reserve = info_block_reserve() >> PAGE_SHIFT;
+	unsigned long reserve = nd_info_block_reserve() >> PAGE_SHIFT;
 	unsigned long base_pfn = PHYS_PFN(base);
 
 	reserve += base_pfn - SUBSECTION_ALIGN_DOWN(base_pfn);
@@ -668,7 +672,7 @@ static int __nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap)
 	u64 offset = le64_to_cpu(pfn_sb->dataoff);
 	u32 start_pad = __le32_to_cpu(pfn_sb->start_pad);
 	u32 end_trunc = __le32_to_cpu(pfn_sb->end_trunc);
-	u32 reserve = info_block_reserve();
+	u32 reserve = nd_info_block_reserve();
 	struct nd_namespace_common *ndns = nd_pfn->ndns;
 	struct nd_namespace_io *nsio = to_nd_namespace_io(&ndns->dev);
 	resource_size_t base = nsio->res.start + start_pad;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index f9f76f6ba07b..7a6f4501dcda 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -372,6 +372,10 @@ static int pmem_attach_disk(struct device *dev,
 	if (!pmem)
 		return -ENOMEM;
 
+	rc = devm_namespace_enable(dev, ndns, nd_info_block_reserve());
+	if (rc)
+		return rc;
+
 	/* while nsio_rw_bytes is active, parse a pfn info block if present */
 	if (is_nd_pfn(dev)) {
 		nd_pfn = to_nd_pfn(dev);
@@ -381,7 +385,7 @@ static int pmem_attach_disk(struct device *dev,
 	}
 
 	/* we're attaching a block device, disable raw namespace access */
-	devm_nsio_disable(dev, nsio);
+	devm_namespace_disable(dev, ndns);
 
 	dev_set_drvdata(dev, pmem);
 	pmem->phys_addr = res->start;
@@ -497,15 +501,16 @@ static int nd_pmem_probe(struct device *dev)
 	if (IS_ERR(ndns))
 		return PTR_ERR(ndns);
 
-	if (devm_nsio_enable(dev, to_nd_namespace_io(&ndns->dev)))
-		return -ENXIO;
-
 	if (is_nd_btt(dev))
 		return nvdimm_namespace_attach_btt(ndns);
 
 	if (is_nd_pfn(dev))
 		return pmem_attach_disk(dev, ndns);
 
+	ret = devm_namespace_enable(dev, ndns, nd_info_block_reserve());
+	if (ret)
+		return ret;
+
 	ret = nd_btt_probe(dev, ndns);
 	if (ret == 0)
 		return -ENXIO;
@@ -532,6 +537,10 @@ static int nd_pmem_probe(struct device *dev)
 		return -ENXIO;
 	else if (ret == -EOPNOTSUPP)
 		return ret;
+
+	/* probe complete, attach handles namespace enabling */
+	devm_namespace_disable(dev, ndns);
+
 	return pmem_attach_disk(dev, ndns);
 }
 

