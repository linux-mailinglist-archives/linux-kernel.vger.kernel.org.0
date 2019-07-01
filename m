Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 738B920322
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 12:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfEPKI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 06:08:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfEPKI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:08:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC666C057F3B;
        Thu, 16 May 2019 10:08:26 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EF4F5D6A9;
        Thu, 16 May 2019 10:08:19 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, lorenzo.pieralisi@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com
Cc:     alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com
Subject: [PATCH v3 0/7] RMRR related fixes and enhancements
Date:   Thu, 16 May 2019 12:08:10 +0200
Message-Id: <20190516100817.12076-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 16 May 2019 10:08:26 +0000 (UTC)
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
https://github.com/eauger/linux/tree/v5.1-rmrr-v3

History:

v2 -> v3:
s/||/&& in iommu_group_create_direct_mappings

v1 -> v2:
- introduce is_downstream_to_pci_bridge() in a separate patch, change param
  names and add kerneldoc comment
- add 6,7

Eric Auger (7):
  iommu: Pass a GFP flag parameter to iommu_alloc_resv_region()
  iommu/vt-d: Duplicate iommu_resv_region objects per device list
  iommu/vt-d: Introduce is_downstream_to_pci_bridge helper
  iommu/vt-d: Handle RMRR with PCI bridge device scopes
  iommu/vt-d: Handle PCI bridge RMRR device scopes in
    intel_iommu_get_resv_regions
  iommu: Introduce IOMMU_RESV_DIRECT_RELAXABLE reserved memory regions
  iommu/vt-d: Differentiate relaxable and non relaxable RMRRs

 drivers/acpi/arm64/iort.c   |  3 +-
 drivers/iommu/amd_iommu.c   |  7 ++--
 drivers/iommu/arm-smmu-v3.c |  2 +-
 drivers/iommu/arm-smmu.c    |  2 +-
 drivers/iommu/intel-iommu.c | 82 +++++++++++++++++++++++++------------
 drivers/iommu/iommu.c       | 19 +++++----
 include/linux/iommu.h       |  8 +++-
 7 files changed, 82 insertions(+), 41 deletions(-)

-- 
2.20.1

