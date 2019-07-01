Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 651B03A364
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 04:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfFICpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 22:45:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:21699 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbfFICpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 22:45:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2019 19:45:36 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2019 19:45:34 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        sai.praneeth.prakhya@intel.com, cai@lca.pw,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/6] iommu/vt-d: Fix suspicious RCU usage in probe_acpi_namespace_devices()
Date:   Sun,  9 Jun 2019 10:38:01 +0800
Message-Id: <20190609023803.23832-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190609023803.23832-1-baolu.lu@linux.intel.com>
References: <20190609023803.23832-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drhd and device scope list should be iterated with the
iommu global lock held. Otherwise, a suspicious RCU usage
message will be displayed.

[    3.695886] =============================
[    3.695917] WARNING: suspicious RCU usage
[    3.695950] 5.2.0-rc2+ #2467 Not tainted
[    3.695981] -----------------------------
[    3.696014] drivers/iommu/intel-iommu.c:4569 suspicious rcu_dereference_check() usage!
[    3.696069]
               other info that might help us debug this:

[    3.696126]
               rcu_scheduler_active = 2, debug_locks = 1
[    3.696173] no locks held by swapper/0/1.
[    3.696204]
               stack backtrace:
[    3.696241] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc2+ #2467
[    3.696370] Call Trace:
[    3.696404]  dump_stack+0x85/0xcb
[    3.696441]  intel_iommu_init+0x128c/0x13ce
[    3.696478]  ? kmem_cache_free+0x16b/0x2c0
[    3.696516]  ? __fput+0x14b/0x270
[    3.696550]  ? __call_rcu+0xb7/0x300
[    3.696583]  ? get_max_files+0x10/0x10
[    3.696631]  ? set_debug_rodata+0x11/0x11
[    3.696668]  ? e820__memblock_setup+0x60/0x60
[    3.696704]  ? pci_iommu_init+0x16/0x3f
[    3.696737]  ? set_debug_rodata+0x11/0x11
[    3.696770]  pci_iommu_init+0x16/0x3f
[    3.696805]  do_one_initcall+0x5d/0x2e4
[    3.696844]  ? set_debug_rodata+0x11/0x11
[    3.696880]  ? rcu_read_lock_sched_held+0x6b/0x80
[    3.696924]  kernel_init_freeable+0x1f0/0x27c
[    3.696961]  ? rest_init+0x260/0x260
[    3.696997]  kernel_init+0xa/0x110
[    3.697028]  ret_from_fork+0x3a/0x50

Fixes: fa212a97f3a36 ("iommu/vt-d: Probe DMA-capable ACPI name space devices")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5251533a18a4..d1cd7e449161 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4793,8 +4793,10 @@ int __init intel_iommu_init(void)
 	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
 			  intel_iommu_cpu_dead);
 
+	down_read(&dmar_global_lock);
 	if (probe_acpi_namespace_devices())
 		pr_warn("ACPI name space devices didn't probe correctly\n");
+	up_read(&dmar_global_lock);
 
 	/* Finally, we enable the DMA remapping hardware. */
 	for_each_iommu(iommu, drhd) {
-- 
2.17.1

