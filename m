Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC4EF9B884
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2019 00:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436998AbfHWWSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 18:18:18 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10172 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405055AbfHWWSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 18:18:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6066230001>; Fri, 23 Aug 2019 15:18:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 23 Aug 2019 15:18:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 23 Aug 2019 15:18:11 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Aug
 2019 22:18:11 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 23 Aug
 2019 22:18:09 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 23 Aug 2019 22:18:09 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6066210001>; Fri, 23 Aug 2019 15:18:09 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christoph Hellwig" <hch@lst.de>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 2/2] mm/hmm: hmm_range_fault() infinite loop
Date:   Fri, 23 Aug 2019 15:17:53 -0700
Message-ID: <20190823221753.2514-3-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190823221753.2514-1-rcampbell@nvidia.com>
References: <20190823221753.2514-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566598691; bh=H0xCNFTKe9KT+REMj7c8+VZLGl6bVqw61h/FiyncJWs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Py/+nEgUIjhIZbSu7cNxlYuXfEoZik6c6x3VzsIs38x5i57ELvn5JRlErcGl1DLSm
         OPm61FMKufS0D/REIhl99DbtgwiyufGaCiuLtD8EtwBjFC2UWBQZpe9L/R3XF+LaCc
         pQYGZc/IOqyS2G+1GlYqg8wySXYGft4IwgvkW/lneMjxIKzhvyBTvhGlLWRH96F7be
         Fjkol1850wsIJiuiZ2VkFIBG8mjuuMqEH9je3XnpBUdEIlN96xf1lgzs2F34kKu7gW
         AU8/C52wqkZa4aBqUpmIEWGA90tAL+iwPA08Ennyfoh6kGscOu2VY2sukBo6VVT5Uz
         8g47hs3zUIkNw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, callers to handle_mm_fault() are supposed to check the
vma->vm_flags first. hmm_range_fault() checks for VM_READ but doesn't
check for VM_WRITE if the caller requests a page to be faulted in
with write permission (via the hmm_range.pfns[] value).
If the vma is write protected, this can result in an infinite loop:
  hmm_range_fault()
    walk_page_range()
      ...
      hmm_vma_walk_hole()
        hmm_vma_walk_hole_()
          hmm_vma_do_fault()
            handle_mm_fault(FAULT_FLAG_WRITE)
            /* returns VM_FAULT_WRITE */
          /* returns -EBUSY */
        /* returns -EBUSY */
      /* returns -EBUSY */
    /* loops on -EBUSY and range->valid */
Prevent this by checking for vma->vm_flags & VM_WRITE before calling
handle_mm_fault().

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/hmm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hmm.c b/mm/hmm.c
index 29371485fe94..4882b83aeccb 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -292,6 +292,9 @@ static int hmm_vma_walk_hole_(unsigned long addr, unsig=
ned long end,
 	hmm_vma_walk->last =3D addr;
 	i =3D (addr - range->start) >> PAGE_SHIFT;
=20
+	if (write_fault && walk->vma && !(walk->vma->vm_flags & VM_WRITE))
+		return -EPERM;
+
 	for (; addr < end; addr +=3D PAGE_SIZE, i++) {
 		pfns[i] =3D range->values[HMM_PFN_NONE];
 		if (fault || write_fault) {
--=20
2.20.1

