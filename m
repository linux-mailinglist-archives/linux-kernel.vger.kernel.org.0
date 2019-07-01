Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 556A35256A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfFYHxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 03:53:11 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:44604 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729892AbfFYHxK (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 25 Jun 2019 03:53:10 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 25 Jun 2019 09:53:08 +0200
Received: from suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Tue, 25 Jun 2019 08:52:34 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@soleen.com, Jonathan.Cameron@huawei.com,
        david@redhat.com, anshuman.khandual@arm.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 2/5] mm,memory_hotplug: Introduce MHP_VMEMMAP_FLAGS
Date:   Tue, 25 Jun 2019 09:52:24 +0200
Message-Id: <20190625075227.15193-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190625075227.15193-1-osalvador@suse.de>
References: <20190625075227.15193-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces MHP_MEMMAP_DEVICE and MHP_MEMMAP_MEMBLOCK flags,
and prepares the callers that add memory to take a "flags" parameter.
This "flags" parameter will be evaluated later on in Patch#3
to init mhp_restrictions struct.

The callers are:

add_memory
__add_memory
add_memory_resource

Unfortunately, we do not have a single entry point to add memory, as depending
on the requisites of the caller, they want to hook up in different places,
(e.g: Xen reserve_additional_memory()), so we have to spread the parameter
in the three callers.

The flags are either MHP_MEMMAP_DEVICE or MHP_MEMMAP_MEMBLOCK, and only differ
in the way they allocate vmemmap pages within the memory blocks.

MHP_MEMMAP_MEMBLOCK:
	- With this flag, we will allocate vmemmap pages in each memory block.
	  This means that if we hot-add a range that spans multiple memory blocks,
	  we will use the beginning of each memory block for the vmemmap pages.
	  This strategy is good for cases where the caller wants the flexiblity
	  to hot-remove memory in a different granularity than when it was added.

	  E.g:
		We allocate a range (x,y], that spans 3 memory blocks, and given
		memory block size = 128MB.
		[memblock#0  ]
		[0 - 511 pfns      ] - vmemmaps for section#0
		[512 - 32767 pfns  ] - normal memory

		[memblock#1 ]
		[32768 - 33279 pfns] - vmemmaps for section#1
		[33280 - 65535 pfns] - normal memory

		[memblock#2 ]
		[65536 - 66047 pfns] - vmemmap for section#2
		[66048 - 98304 pfns] - normal memory

MHP_MEMMAP_DEVICE:
	- With this flag, we will store all vmemmap pages at the beginning of
	  hot-added memory.

	  E.g:
		We allocate a range (x,y], that spans 3 memory blocks, and given
		memory block size = 128MB.
		[memblock #0 ]
		[0 - 1533 pfns    ] - vmemmap for section#{0-2}
		[1534 - 98304 pfns] - normal memory

When using larger memory blocks (1GB or 2GB), the principle is the same.

Of course, MHP_MEMMAP_DEVICE is nicer when it comes to have a large contigous
area, while MHP_MEMMAP_MEMBLOCK allows us to have flexibility when removing the
memory.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/acpi/acpi_memhotplug.c |  2 +-
 drivers/base/memory.c          |  2 +-
 drivers/dax/kmem.c             |  2 +-
 drivers/hv/hv_balloon.c        |  2 +-
 drivers/s390/char/sclp_cmd.c   |  2 +-
 drivers/xen/balloon.c          |  2 +-
 include/linux/memory_hotplug.h | 22 +++++++++++++++++++---
 mm/memory_hotplug.c            | 10 +++++-----
 8 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index db013dc21c02..860f84e82dd0 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -218,7 +218,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 		if (node < 0)
 			node = memory_add_physaddr_to_nid(info->start_addr);
 
-		result = __add_memory(node, info->start_addr, info->length);
+		result = __add_memory(node, info->start_addr, info->length, 0);
 
 		/*
 		 * If the memory block has been used by the kernel, add_memory()
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 07ba731beb42..ad9834b8b7f7 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -516,7 +516,7 @@ static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
 
 	nid = memory_add_physaddr_to_nid(phys_addr);
 	ret = __add_memory(nid, phys_addr,
-			   MIN_MEMORY_BLOCK_SIZE * sections_per_block);
+			   MIN_MEMORY_BLOCK_SIZE * sections_per_block, 0);
 
 	if (ret)
 		goto out;
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 3d0a7e702c94..e159184e0ba0 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -65,7 +65,7 @@ int dev_dax_kmem_probe(struct device *dev)
 	new_res->flags = IORESOURCE_SYSTEM_RAM;
 	new_res->name = dev_name(dev);
 
-	rc = add_memory(numa_node, new_res->start, resource_size(new_res));
+	rc = add_memory(numa_node, new_res->start, resource_size(new_res), 0);
 	if (rc) {
 		release_resource(new_res);
 		kfree(new_res);
diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 6fb4ea5f0304..beb92bc56186 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -731,7 +731,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 
 		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
 		ret = add_memory(nid, PFN_PHYS((start_pfn)),
-				(HA_CHUNK << PAGE_SHIFT));
+				(HA_CHUNK << PAGE_SHIFT), 0);
 
 		if (ret) {
 			pr_err("hot_add memory failed error is %d\n", ret);
diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index 37d42de06079..f61026c7db7e 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -406,7 +406,7 @@ static void __init add_memory_merged(u16 rn)
 	if (!size)
 		goto skip_add;
 	for (addr = start; addr < start + size; addr += block_size)
-		add_memory(numa_pfn_to_nid(PFN_DOWN(addr)), addr, block_size);
+		add_memory(numa_pfn_to_nid(PFN_DOWN(addr)), addr, block_size, 0);
 skip_add:
 	first_rn = rn;
 	num = 1;
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 37a36c6b9f93..33814b3513ca 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -349,7 +349,7 @@ static enum bp_state reserve_additional_memory(void)
 	mutex_unlock(&balloon_mutex);
 	/* add_memory_resource() requires the device_hotplug lock */
 	lock_device_hotplug();
-	rc = add_memory_resource(nid, resource);
+	rc = add_memory_resource(nid, resource, 0);
 	unlock_device_hotplug();
 	mutex_lock(&balloon_mutex);
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 0b8a5e5ef2da..6fdbce9d04f9 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -54,6 +54,22 @@ enum {
 };
 
 /*
+ * We want memmap (struct page array) to be allocated from the hotadded range.
+ * To do so, there are two possible ways depending on what the caller wants.
+ * 1) Allocate memmap pages per device (whole hot-added range)
+ * 2) Allocate memmap pages per memblock
+ * The former implies that we wil use the beginning of the hot-added range
+ * to store the memmap pages of the whole range, while the latter implies
+ * that we will use the beginning of each memblock to store its own memmap
+ * pages.
+ * Please note that only SPARSE_VMEMMAP implements this feature and some
+ * architectures might not support it even for that memory model (e.g. s390)
+ */
+#define MHP_MEMMAP_DEVICE	(1UL<<0)
+#define MHP_MEMMAP_MEMBLOCK	(1UL<<1)
+#define MHP_VMEMMAP_FLAGS	(MHP_MEMMAP_DEVICE|MHP_MEMMAP_MEMBLOCK)
+
+/*
  * Restrictions for the memory hotplug:
  * flags:  MHP_ flags
  * altmap: alternative allocator for memmap array
@@ -342,9 +358,9 @@ static inline void __remove_memory(int nid, u64 start, u64 size) {}
 extern void __ref free_area_init_core_hotplug(int nid);
 extern int walk_memory_range(unsigned long start_pfn, unsigned long end_pfn,
 		void *arg, int (*func)(struct memory_block *, void *));
-extern int __add_memory(int nid, u64 start, u64 size);
-extern int add_memory(int nid, u64 start, u64 size);
-extern int add_memory_resource(int nid, struct resource *resource);
+extern int __add_memory(int nid, u64 start, u64 size, unsigned long flags);
+extern int add_memory(int nid, u64 start, u64 size, unsigned long flags);
+extern int add_memory_resource(int nid, struct resource *resource, unsigned long flags);
 extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap);
 extern bool is_memblock_offlined(struct memory_block *mem);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4e8e65954f31..e4e3baa6eaa7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1057,7 +1057,7 @@ static int online_memory_block(struct memory_block *mem, void *arg)
  *
  * we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG
  */
-int __ref add_memory_resource(int nid, struct resource *res)
+int __ref add_memory_resource(int nid, struct resource *res, unsigned long flags)
 {
 	struct mhp_restrictions restrictions = {};
 	u64 start, size;
@@ -1135,7 +1135,7 @@ int __ref add_memory_resource(int nid, struct resource *res)
 }
 
 /* requires device_hotplug_lock, see add_memory_resource() */
-int __ref __add_memory(int nid, u64 start, u64 size)
+int __ref __add_memory(int nid, u64 start, u64 size, unsigned long flags)
 {
 	struct resource *res;
 	int ret;
@@ -1144,18 +1144,18 @@ int __ref __add_memory(int nid, u64 start, u64 size)
 	if (IS_ERR(res))
 		return PTR_ERR(res);
 
-	ret = add_memory_resource(nid, res);
+	ret = add_memory_resource(nid, res, flags);
 	if (ret < 0)
 		release_memory_resource(res);
 	return ret;
 }
 
-int add_memory(int nid, u64 start, u64 size)
+int add_memory(int nid, u64 start, u64 size, unsigned long flags)
 {
 	int rc;
 
 	lock_device_hotplug();
-	rc = __add_memory(nid, start, size);
+	rc = __add_memory(nid, start, size, flags);
 	unlock_device_hotplug();
 
 	return rc;
-- 
2.12.3

