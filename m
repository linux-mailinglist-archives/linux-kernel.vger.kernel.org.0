Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73EB2F2670
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 05:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387659AbfKGEMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 23:12:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:50428 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733182AbfKGEMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 23:12:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:12:20 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400"; 
   d="scan'208";a="206041327"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:12:19 -0800
Subject: [PATCH 16/16] libnvdimm/e820: Retrieve and populate correct
 'target_node' info
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 06 Nov 2019 19:58:03 -0800
Message-ID: <157309908326.1582359.13665017314935413372.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Use the new memory_add_physaddr_to_target_node() and
numa_map_to_online_node() helpers to retrieve the correct id for
the 'numa_node' (online initiator) and 'target_node' (offline target
memory node) sysfs attributes.

Below is an example from a 4 numa node system where all the memory on
node2 is pmem / reserved. It should be noted that with the arrival of
the ACPI HMAT table and EFI Specific Purpose Memory the kernel will
start to see more platforms with reserved / performance differentiated
memory in its own numa node. Hence all the stakeholders on the Cc for
what is ostensibly a libnvdimm local patch.

=== Before ===

/* Notice no online memory on node2 at start */

# numactl --hardware
available: 3 nodes (0-1,3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
node 0 size: 3958 MB
node 0 free: 3708 MB
node 1 cpus: 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39
node 1 size: 4027 MB
node 1 free: 3871 MB
node 3 cpus:
node 3 size: 3994 MB
node 3 free: 3971 MB
node distances:
node   0   1   3
  0:  10  21  21
  1:  21  10  21
  3:  21  21  10

/*
 * Put the pmem namespace into devdax mode so it can be assigned to the
 * kmem driver
 */

# ndctl create-namespace -e namespace0.0 -m devdax -f
{
  "dev":"namespace0.0",
  "mode":"devdax",
  "map":"dev",
  "size":"3.94 GiB (4.23 GB)",
  "uuid":"1650af9b-9ba3-4704-acd6-10178399d9a3",
  [..]
}

/* Online Persistent Memory as System RAM */

# daxctl reconfigure-device --mode=system-ram dax0.0
libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
libdaxctl: memblock_in_dev: dax0.0: memory0: Unable to determine phys_index: Success
[
  {
    "chardev":"dax0.0",
    "size":4225761280,
    "target_node":0,
    "mode":"system-ram"
  }
]
reconfigured 1 device

/* Note that the memory is onlined by default to the wrong node, node0 */

# numactl --hardware
available: 3 nodes (0-1,3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
node 0 size: 7926 MB
node 0 free: 7655 MB
node 1 cpus: 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39
node 1 size: 4027 MB
node 1 free: 3871 MB
node 3 cpus:
node 3 size: 3994 MB
node 3 free: 3971 MB
node distances:
node   0   1   3
  0:  10  21  21
  1:  21  10  21
  3:  21  21  10


=== After ===

/* Notice that the "phys_index" error messages are gone */

# daxctl reconfigure-device --mode=system-ram dax0.0
[
  {
    "chardev":"dax0.0",
    "size":4225761280,
    "target_node":2,
    "mode":"system-ram"
  }
]
reconfigured 1 device

/* Notice that node2 is now correctly populated */

# numactl --hardware
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
node 0 size: 3958 MB
node 0 free: 3793 MB
node 1 cpus: 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39
node 1 size: 4027 MB
node 1 free: 3851 MB
node 2 cpus:
node 2 size: 3968 MB
node 2 free: 3968 MB
node 3 cpus:
node 3 size: 3994 MB
node 3 free: 3908 MB
node distances:
node   0   1   2   3
  0:  10  21  21  21
  1:  21  10  21  21
  2:  21  21  10  21
  3:  21  21  21  10

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/e820.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/e820.c b/drivers/nvdimm/e820.c
index b802291bcde1..23121dd6e494 100644
--- a/drivers/nvdimm/e820.c
+++ b/drivers/nvdimm/e820.c
@@ -20,11 +20,12 @@ static int e820_register_one(struct resource *res, void *data)
 {
 	struct nd_region_desc ndr_desc;
 	struct nvdimm_bus *nvdimm_bus = data;
+	int nid = memory_add_physaddr_to_target_node(res->start);
 
 	memset(&ndr_desc, 0, sizeof(ndr_desc));
 	ndr_desc.res = res;
-	ndr_desc.numa_node = memory_add_physaddr_to_nid(res->start);
-	ndr_desc.target_node = ndr_desc.numa_node;
+	ndr_desc.numa_node = numa_map_to_online_node(nid);
+	ndr_desc.target_node = nid;
 	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
 	if (!nvdimm_pmem_region_create(nvdimm_bus, &ndr_desc))
 		return -ENXIO;

