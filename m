Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9772100C41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 20:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKRTiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 14:38:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:60271 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfKRTh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:37:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 11:37:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="380760842"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 18 Nov 2019 11:37:58 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, "Yi Liu" <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 00/10] VT-d Native Shared virtual memory cleanup and fixes
Date:   Mon, 18 Nov 2019 11:42:23 -0800
Message-Id: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly extracted from nested SVA/SVM series based on review comments of v7.
https://lkml.org/lkml/2019/10/24/852

This series also adds a few important fixes for native use of SVA. Nested
SVA new code will be submitted separately as a smaller set. Based on the
core branch of IOMMU tree staged for v5.5, where common APIs for vSVA were
applied.
git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git core

Changelog:
V2
	- Coding style fixes based on Baolu's input, no functional change
	- Added Acked-by tags.

Thanks,

Jacob


Jacob Pan (10):
  iommu/vt-d: Introduce native SVM capable flag
  iommu/vt-d: Fix CPU and IOMMU SVM feature matching checks
  iommu/vt-d: Reject SVM bind for failed capability check
  iommu/vt-d: Match CPU and IOMMU paging mode
  iommu/vt-d: Avoid duplicated code for PASID setup
  iommu/vt-d: Fix off-by-one in PASID allocation
  iommu/vt-d: Replace Intel specific PASID allocator with IOASID
  iommu/vt-d: Fix PASID cache flush
  iommu/vt-d: Avoid sending invalid page response
  iommu/vt-d: Misc macro clean up for SVM

 drivers/iommu/Kconfig       |   1 +
 drivers/iommu/intel-iommu.c |  23 +++----
 drivers/iommu/intel-pasid.c |  99 ++++++++------------------
 drivers/iommu/intel-svm.c   | 164 +++++++++++++++++++++++++-------------------
 include/linux/intel-iommu.h |   5 +-
 5 files changed, 138 insertions(+), 154 deletions(-)

-- 
2.7.4

