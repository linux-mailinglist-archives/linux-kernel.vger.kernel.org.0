Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 567604197D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 02:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407494AbfFLAgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 20:36:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:50299 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407288AbfFLAgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 20:36:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 17:36:06 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga001.jf.intel.com with ESMTP; 11 Jun 2019 17:36:04 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        sai.praneeth.prakhya@intel.com, cai@lca.pw,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/7] iommu/vt-d: Fixes and cleanups for linux-next
Date:   Wed, 12 Jun 2019 08:28:44 +0800
Message-Id: <20190612002851.17103-1-baolu.lu@linux.intel.com>
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

Change log:
  v1->v2:
  - Refine "iommu/vt-d: Cleanup after delegating DMA domain to
    generic iommu" by removing an unnecessary cleanup.
  - Add "Allow DMA domain attaching to rmrr locked device" which
    fix a driver load issue.

Lu Baolu (6):
  iommu/vt-d: Don't return error when device gets right domain
  iommu/vt-d: Set domain type for a private domain
  iommu/vt-d: Don't enable iommu's which have been ignored
  iommu/vt-d: Allow DMA domain attaching to rmrr locked device
  iommu/vt-d: Fix suspicious RCU usage in probe_acpi_namespace_devices()
  iommu/vt-d: Consolidate domain_init() to avoid duplication

Sai Praneeth Prakhya (1):
  iommu/vt-d: Cleanup after delegating DMA domain to generic iommu

 drivers/iommu/intel-iommu.c | 200 +++++++++---------------------------
 1 file changed, 49 insertions(+), 151 deletions(-)

-- 
2.17.1

