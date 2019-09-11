Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F63B058C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 00:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfIKW2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 18:28:51 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5900 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfIKW2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 18:28:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d7975250001>; Wed, 11 Sep 2019 15:28:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 11 Sep 2019 15:28:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 11 Sep 2019 15:28:49 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Sep
 2019 22:28:45 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 11 Sep 2019 22:28:45 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d79751d0000>; Wed, 11 Sep 2019 15:28:45 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 2/4] mm/hmm: allow snapshot of the special zero page
Date:   Wed, 11 Sep 2019 15:28:27 -0700
Message-ID: <20190911222829.28874-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190911222829.28874-1-rcampbell@nvidia.com>
References: <20190911222829.28874-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1568240933; bh=fLP9rLpp/B9jcH+odOuRb1hMtcNtVrRutVa3Z9zrd1w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Type:Content-Transfer-Encoding;
        b=A1bY8PdkcziCRUc95de9wfnPNEuSMB6Y3FKusyqS8R55ozU6HDmd3v2d9mBoXhgm5
         2bxAt+kPjvO3iSt1qlE0mn8Tlh4Q1ODHh5ZkPxIQUjAIss5dP8jeD6cgsF7Vc0rWMQ
         9GmKXF2zlU2NeOoeJHx3RTwWj+BhWak6vZppWo/AGbLbkn4eeFiDGQK89qYr3KTKS/
         2/LH0I6lWeKKXi8MhSc8/EbwuTAXcfSxq0pVvOEGTn10DdWwkRbViknH0YT0sutLm0
         6Ay8DJzD4kBdk3IO5ILhq7pSw0yq2z2/yyzGsPdazJXbNTaHqt6XCst6QK0EZOmwiM
         Kdq2asvg502PA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow hmm_range_fault() to return success (0) when the CPU pagetable
entry points to the special shared zero page.
The caller can then handle the zero page by possibly clearing device
private memory instead of DMAing a zero page.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 06041d4399ff..7217912bef13 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -532,7 +532,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, uns=
igned long addr,
 			return -EBUSY;
 	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) {
 		*pfn =3D range->values[HMM_PFN_SPECIAL];
-		return -EFAULT;
+		return is_zero_pfn(pte_pfn(pte)) ? 0 : -EFAULT;
 	}
=20
 	*pfn =3D hmm_device_entry_from_pfn(range, pte_pfn(pte)) | cpu_flags;
--=20
2.20.1

