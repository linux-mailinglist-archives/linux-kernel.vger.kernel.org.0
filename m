Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD112C5C6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 13:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfE1Lun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 07:50:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfE1Lum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:50:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4317B30C0DDF;
        Tue, 28 May 2019 11:50:38 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2E775D9CC;
        Tue, 28 May 2019 11:50:29 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, robin.murphy@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com,
        jean-philippe.brucker@arm.com
Subject: [PATCH v5 0/7] RMRR related fixes and enhancements
Date:   Tue, 28 May 2019 13:50:18 +0200
Message-Id: <20190528115025.17194-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 28 May 2019 11:50:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the Intel reserved region is attached to the
RMRR unit and when building the list of RMRR seen by a device
we link this unique reserved region without taking care of
potential multiple usage of this reserved region by several devices.

Also while reading the vtd spec it is unclear to me whether
the RMRR device scope referenced by an RMRR ACPI struct could
be a PCI-PCI bridge, in which case I think we also need to
check the device belongs to the PCI sub-hierarchy of the device
referenced in the scope. This would be true for device_has_rmrr()
and intel_iommu_get_resv_regions().

Last, the VFIO subsystem would need to compute the usable IOVA range
by querying the iommu_get_group_resv_regions() API. This would allow,
for instance, to report potential conflicts between the guest physical
address space and host reserved regions.

However iommu_get_group_resv_regions() currently fails to differentiate
RMRRs that are known safe for device assignment and RMRRs that must be
enforced. So we introduce a new reserved memory region type (relaxable),
reported when associated to an USB or GFX device. The last 2 patches aim
at unblocking [1] which is stuck since 4.18.

[1-5] are fixes
[6-7] are enhancements

The two parts can be considered separately if needed.

References:
[1] [PATCH v6 0/7] vfio/type1: Add support for valid iova list management
    https://patchwork.kernel.org/patch/10425309/

Branch: This series is available at:
https://github.com/eauger/linux/tree/v5.2-rc2-rmrr-v5

History:

v4 -> v5:
- remove iommu: Pass a GFP flag parameter to iommu_alloc_resv_region()
- use dmar_global_lock instead of rcu-lock in intel_iommu_get_resv_regions

v3 -> v4:
- added "iommu: Fix a leak in iommu_insert_resv_region"
- introduced device_rmrr_is_relaxable and fixed to_pci_dev call
  without checking dev_is_pci
- Despite Robin suggested to hide direct relaxable behind direct
  ones, I think this would lead to a very complex implementation
  of iommu_insert_resv_region while in general the relaxable
  regions are going to be ignored by the caller. By the way I
  found a leak in this function, hence the new first patch

v2 -> v3:
s/||/&& in iommu_group_create_direct_mappings

v1 -> v2:
- introduce is_downstream_to_pci_bridge() in a separate patch, change param
  names and add kerneldoc comment
- add 6,7


Eric Auger (7):
  iommu: Fix a leak in iommu_insert_resv_region
  iommu/vt-d: Duplicate iommu_resv_region objects per device list
  iommu/vt-d: Introduce is_downstream_to_pci_bridge helper
  iommu/vt-d: Handle RMRR with PCI bridge device scopes
  iommu/vt-d: Handle PCI bridge RMRR device scopes in
    intel_iommu_get_resv_regions
  iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE reserved memory regions
  iommu/vt-d: Differentiate relaxable and non relaxable RMRRs

 .../ABI/testing/sysfs-kernel-iommu_groups     |   9 ++
 drivers/iommu/intel-iommu.c                   | 128 ++++++++++++------
 drivers/iommu/iommu.c                         |  20 +--
 include/linux/iommu.h                         |   6 +
 4 files changed, 115 insertions(+), 48 deletions(-)

-- 
2.20.1

