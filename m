Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6D87D530
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 08:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfHAGCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 02:02:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:50823 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfHAGCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:02:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2019 23:02:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,333,1559545200"; 
   d="scan'208";a="184119205"
Received: from allen-box.sh.intel.com ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 31 Jul 2019 23:02:50 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/3] iommu/vtd: Per device dma ops
Date:   Thu,  1 Aug 2019 14:01:53 +0800
Message-Id: <20190801060156.8564-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current Intel IOMMU driver sets the system level dma_ops. This
means every dma API call will be routed to the iommu driver,
even the privileged user might select to bypass iommu for some
specific devices.

Furthermore,  if the priviledged user requests to bypass iommu
translation for a device, the iommu driver might fall back to
use dma domain blindly if the device is not able to address all
system memory.
    
This sets the per-device dma_ops only if a device is using DMA
domain. Otherwise, use the default dma_ops for direct dma.

Lu Baolu (3):
  iommu/vt-d: Refactor find_domain() helper
  iommu/vt-d: Apply per-device dma_ops
  iommu/vt-d: Cleanup after using per-device dma ops

 drivers/iommu/intel-iommu.c | 131 ++++++++++--------------------------
 1 file changed, 34 insertions(+), 97 deletions(-)

-- 
2.17.1

