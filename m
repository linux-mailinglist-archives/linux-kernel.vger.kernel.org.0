Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19E619344C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 00:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgCYXLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 19:11:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:3368 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgCYXLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:11:24 -0400
IronPort-SDR: C4ajVmlgzXTXLPpb7jkEnusiLd822e8LlcZcWEpvZBCluPrvc6x6DtlxgPzpmbKDGe9EfetV4Q
 cy4s+CPFEiHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 16:11:24 -0700
IronPort-SDR: w231FeYMX1qlC26S1fobhpS9w1G2THEmgk6xNgH7LXe0Z9HxNZ77GcXYtv+d1jHOU6Ca6tjMw/
 jLHcWy2nOa6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; 
   d="scan'208";a="236083686"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2020 16:11:24 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 0/3] IOMMU user API enhancement
Date:   Wed, 25 Mar 2020 16:17:04 -0700
Message-Id: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU user API header was introduced to support nested DMA translation and
related fault handling. The current UAPI data structures consist of three
areas that cover the interactions between host kernel and guest:
 - fault handling
 - cache invalidation
 - bind guest page tables, i.e. guest PASID

With future extensions in mind, the UAPI structures passed from user to kernel
always starts with a mandatory version field (u32). While this is flexible
for extensions of individual structures, it is difficult to maintain support
of combinations of version numbers.

This patchset introduces a unified UAPI version number that governs all the
UAPI data structure versions. When userspace query UAPI version for check on
compatibility, a single match would be sufficient.

After UAPI version check, users such as VFIO can also retrieve the matching
data structure size based on version and type. Kernel IOMMU UAPI support is
always backward compatible. Data structures are also only open to extension
and closed to modifications.

The introduction of UAPI version does not change the existing UAPI but rather
simplify the data structure version and size matching.

Changelog:
- v2 Rewrite the extension rules that disallows adding new members at the end
     of each UAPI data structures. Only padding bytes and union can be extended.
     Clarified size look up array extension rules with examples.

Thanks,

Jacob


Jacob Pan (3):
  iommu/uapi: Define uapi version and capabilities
  iommu/uapi: Use unified UAPI version
  iommu/uapi: Add helper function for size lookup

 drivers/iommu/intel-iommu.c |  3 +-
 drivers/iommu/intel-svm.c   |  2 +-
 drivers/iommu/iommu.c       | 75 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/iommu.h       |  6 ++++
 include/uapi/linux/iommu.h  | 62 +++++++++++++++++++++++++++++++++----
 5 files changed, 139 insertions(+), 9 deletions(-)

-- 
2.7.4

