Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC7C161BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 20:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgBQTjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 14:39:08 -0500
Received: from 8bytes.org ([81.169.241.247]:54498 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbgBQTjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:39:08 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B27293C3; Mon, 17 Feb 2020 20:39:06 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Joerg Roedel <joro@8bytes.org>, jroedel@suse.de,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] iommu/vt-d: Fix kdump boot with VT-d enabled
Date:   Mon, 17 Feb 2020 20:38:53 +0100
Message-Id: <20200217193858.26990-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

booting into a crashdump kernel with Intel IOMMU enabled and
configured into passthrough mode does not succeed with the current
kernel. The reason is that the check for identity mappings happen
before the check for deferred device attachments. That results in
wrong results returned from iommu_need_mapping() and subsequently in a
wrong domain-type used in __intel_map_single(). A stripped oops is in
the commit-message of patch 3.

The patch-set fixes the issue and does a few code cleanups along the
way. I have not yet researched the stable and fixes tags, but when the
patches are fine I will add the tags before applying the patches.

Please review.

Thanks,

	Joerg

Joerg Roedel (5):
  iommu/vt-d: Add attach_deferred() helper
  iommu/vt-d: Move deferred device attachment into helper function
  iommu/vt-d: Do deferred attachment in iommu_need_mapping()
  iommu/vt-d: Remove deferred_attach_domain()
  iommu/vt-d: Simplify check in identity_mapping()

 drivers/iommu/intel-iommu.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

-- 
2.17.1

