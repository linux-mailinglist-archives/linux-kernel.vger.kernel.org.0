Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8672D16062D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 21:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBPUQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 15:16:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:39966 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgBPUQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 15:16:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2020 12:16:47 -0800
X-IronPort-AV: E=Sophos;i="5.70,450,1574150400"; 
   d="scan'208";a="381986279"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2020 12:16:47 -0800
Subject: [PATCH v5 0/6] Memory Hierarchy: Enable target node lookups for
 reserved memory
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     David Hildenbrand <david@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        kbuild test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@suse.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Oliver O'Halloran <oohall@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Sun, 16 Feb 2020 12:00:42 -0800
Message-ID: <158188324272.894464.5941332130956525504.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4 [1]:
- Rename CONFIG_KEEP_NUMA to CONFIG_NUMA_KEEP_MEMINFO (Ingo)
- Rename __initdata_numa to __initdata_or_meminfo (Thomas)
- Capitalize NUMA throughout (Ingo)
- Replace explicit memcpy with implicit structure copy to address an 80
  column violation, and fixup a function definition line-wrap (Ingo)
- Rename numa_move_memblk() to numa_move_tail_memblk(), and remove the
  stale kernel-doc that implied @dst was optional (Thomas)
- Comment that phys_to_target_node() is an optional arch implementation
  detail that consumers must gate with "depends on $ARCH"
- Apply Ingo's conditional reviewed-by

[1]: http://lore.kernel.org/r/157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com

---

Merge notes: I believe this addresses all outstanding comments, barring
additional feedback I will push to libnvdimm-for-next.

---

Cover:

Arrange for platform NUMA info to be preserved for determining
'target_node' data. Where a 'target_node' is the node a reserved memory
range will become when it is onlined.

This new infrastructure is expected to be more valuable over time for
Memory Tiers / Hierarchy management as more platforms (via the ACPI HMAT
and EFI Specific Purpose Memory) publish reserved or "soft-reserved"
ranges to Linux. Linux system administrators will expect to be able to
interact with those ranges with a unique NUMA node number when/if that
memory is onlined via the dax_kmem driver [2].

One configuration that currently fails to properly convey the target
node for the resulting memory hotplug operation is persistent memory
defined by the memmap=nn!ss parameter. For example, today if node1 is a
memory only node, and all the memory from node1 is specified to
memmap=nn!ss and subsequently onlined, it will end up being onlined as
node0 memory. As it stands, memory_add_physaddr_to_nid() can only
identify online nodes and since node1 in this example has no online cpus
/ memory the target node is initialized node0.

The fix is to preserve rather than discard the numa_meminfo entries that
are relevant for reserved memory ranges, and to uplevel the node
distance helper for determining the "local" (closest) node relative to
an initiator node.

[2]: https://pmem.io/ndctl/daxctl-reconfigure-device.html

---

Dan Williams (6):
      ACPI: NUMA: Up-level "map to online node" functionality
      mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
      powerpc/papr_scm: Switch to numa_map_to_online_node()
      x86/mm: Introduce CONFIG_NUMA_KEEP_MEMINFO
      x86/NUMA: Provide a range-to-target_node lookup facility
      libnvdimm/e820: Retrieve and populate correct 'target_node' info


 arch/powerpc/platforms/pseries/papr_scm.c |   21 ---------
 arch/x86/Kconfig                          |    1 
 arch/x86/mm/numa.c                        |   67 +++++++++++++++++++++++------
 drivers/acpi/numa/srat.c                  |   41 ------------------
 drivers/nvdimm/e820.c                     |   18 ++------
 include/linux/acpi.h                      |   23 ++++++++++
 include/linux/numa.h                      |   30 +++++++++++++
 mm/Kconfig                                |    5 ++
 mm/mempolicy.c                            |   26 +++++++++++
 9 files changed, 140 insertions(+), 92 deletions(-)

base-commit: bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9
