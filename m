Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 052A6C9286
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 21:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfJBTiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 15:38:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:10181 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfJBTih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:38:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2019 12:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,249,1566889200"; 
   d="scan'208";a="275456097"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 02 Oct 2019 12:38:34 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 0/4] User API for nested shared virtual address (SVA)
Date:   Wed,  2 Oct 2019 12:42:39 -0700
Message-Id: <1570045363-24856-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set consists of IOMMU APIs to support SVA in the guest, a.k.a nested
SVA. As the complete SVA support is complex, we break down the enabling
effort into three stages:
1. PCI device direct assignment
2. Fault handling, especially page request service support
3. Mediated device assignment

Each stage includes common API and vendor specific IOMMU driver changes. This
series is the common uAPI for stage #1. It is intended to build consensus on
the interface which all vendors reply on.

This series is extracted from the complete stage1 set which includes VT-d code.
https://lkml.org/lkml/2019/8/15/951

Changes:
 - Use spinlock instead of mutex to protect ioasid custom allocators. This is
   to support callers in atomic context
 - Added more padding to guest PASID bind data for future extensions, suggested
   by Joerg.
After much thinking, I did not do name change from PASID to IOASID in the uAPI,
considering we have been using PASID in the rest of uAPIs. IOASID will remain
used within the kernel.

For more discussions lead to this series, checkout LPC 2019 VFIO/IOMMU/PCI
microconference materials.
https://linuxplumbersconf.org/event/4/sessions/66/#20190909


Change log:
v4:    - minor patch regroup and fixes based on review from Jean
v3:    - include errno.h in ioasid.h to fix compile error
       - rebased to v5.4-rc1, no change
 
v2:
	- Addressed review comments by Jean on IOASID custom allocators, locking
	fix, misc control flow fix.
	- Fixed a compile error with missing header errno.h
	- Updated Jean-Philiippe's new email and updateded reviewed-by tag

Jacob Pan (2):
  iommu/ioasid: Add custom allocators
  iommu: Introduce guest PASID bind function

Jean-Philippe Brucker (1):
  iommu: Add I/O ASID allocator

Yi L Liu (1):
  iommu: Introduce cache_invalidate API

 drivers/iommu/Kconfig      |   4 +
 drivers/iommu/Makefile     |   1 +
 drivers/iommu/ioasid.c     | 422 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c      |  30 ++++
 include/linux/ioasid.h     |  76 ++++++++
 include/linux/iommu.h      |  36 ++++
 include/uapi/linux/iommu.h | 169 ++++++++++++++++++
 7 files changed, 738 insertions(+)
 create mode 100644 drivers/iommu/ioasid.c
 create mode 100644 include/linux/ioasid.h

-- 
2.7.4

