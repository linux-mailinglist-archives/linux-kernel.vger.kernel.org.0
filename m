Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0319A1B0F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 09:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfEMHNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 03:13:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12065 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbfEMHNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:13:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E61C7DD10;
        Mon, 13 May 2019 07:13:11 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65EA968435;
        Mon, 13 May 2019 07:13:07 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, lorenzo.pieralisi@arm.com,
        robin.murphy@arm.com, will.deacon@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com
Cc:     alex.williamson@redhat.com
Subject: [PATCH 0/4] RMRR related fixes
Date:   Mon, 13 May 2019 09:12:58 +0200
Message-Id: <20190513071302.30718-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 13 May 2019 07:13:11 +0000 (UTC)
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

Eric Auger (4):
  iommu: Pass a GFP flag parameter to iommu_alloc_resv_region()
  iommu/vt-d: Duplicate iommu_resv_region objects per device list
  iommu/vt-d: Handle RMRR with PCI bridge device scopes
  iommu/vt-d: Handle PCI bridge RMRR device scopes in
    intel_iommu_get_resv_regions

 drivers/acpi/arm64/iort.c   |  3 +-
 drivers/iommu/amd_iommu.c   |  7 ++--
 drivers/iommu/arm-smmu-v3.c |  2 +-
 drivers/iommu/arm-smmu.c    |  2 +-
 drivers/iommu/intel-iommu.c | 68 +++++++++++++++++++++++--------------
 drivers/iommu/iommu.c       |  7 ++--
 include/linux/iommu.h       |  2 +-
 7 files changed, 55 insertions(+), 36 deletions(-)

-- 
2.20.1

