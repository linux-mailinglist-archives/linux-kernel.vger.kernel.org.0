Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 676883A35F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 04:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfFICpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jun 2019 22:45:30 -0400
Received: from mga01.intel.com ([192.55.52.88]:21699 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfFICpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 22:45:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2019 19:45:29 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2019 19:45:27 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        sai.praneeth.prakhya@intel.com, cai@lca.pw,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/6] iommu/vt-d: Fixes and cleanups for linux-next
Date:   Sun,  9 Jun 2019 10:37:57 +0800
Message-Id: <20190609023803.23832-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

This series includes several fixes and cleanups after delegating
DMA domain to generic iommu. Please review and consider them for
linux-next.

Best regards,
Baolu

Lu Baolu (5):
  iommu/vt-d: Don't return error when device gets right domain
  iommu/vt-d: Set domain type for a private domain
  iommu/vt-d: Don't enable iommu's which have been ignored
  iommu/vt-d: Fix suspicious RCU usage in probe_acpi_namespace_devices()
  iommu/vt-d: Consolidate domain_init() to avoid duplication

Sai Praneeth Prakhya (1):
  iommu/vt-d: Cleanup after delegating DMA domain to generic iommu

 drivers/iommu/intel-iommu.c | 210 +++++++++---------------------------
 1 file changed, 53 insertions(+), 157 deletions(-)

-- 
2.17.1

