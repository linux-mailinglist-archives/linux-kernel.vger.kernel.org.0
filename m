Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23B0E15656
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 01:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfEFXay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 19:30:54 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4553 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfEFXaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:30:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd0c3a80000>; Mon, 06 May 2019 16:30:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 06 May 2019 16:30:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 06 May 2019 16:30:52 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 May
 2019 23:30:51 +0000
From:   <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/5] mm/hmm: hmm_vma_fault() doesn't always call hmm_range_unregister()
Date:   Mon, 6 May 2019 16:29:41 -0700
Message-ID: <20190506232942.12623-5-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506232942.12623-1-rcampbell@nvidia.com>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557185448; bh=7sEAG7BmE97PPZ9CLmnt92JqaAHK4dBbaboJKD5IMgE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         X-Originating-IP:X-ClientProxiedBy:Content-Transfer-Encoding:
         Content-Type;
        b=U4L0ZESXdXyu4HWeu/nKyyIqj74DonoGBT6SFnyPRAxU2VVbgRApkhErj1Q1lHVhn
         hDKrjw8OaE+4TPmGG7K+tvEa0IPgVTVALNe10MY6RAMneTRUExBPAa9QTbcSXgjawc
         YsETYgttxPSIe5L+FFEiF/0y/82hiXtBq78QwYYYkVXC0McXLmVwZXXAIkAsozuDto
         U4+R4b0iXWXeBU/tcZFJoxYXX7qb+74B6xFTqzHr2cOTdo37eAj4WGbYL2vcvUazhl
         7hehU8zjzQyFMHe1OtBiBzHA74ngo4oL5rgwjQ5tply3Wwok7XgXIWx1tDz48a2D1b
         hOAXoOVT2c3PQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

The helper function hmm_vma_fault() calls hmm_range_register() but is
missing a call to hmm_range_unregister() in one of the error paths.
This leads to a reference count leak and ultimately a memory leak on
struct hmm.

Always call hmm_range_unregister() if hmm_range_register() succeeded.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/hmm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 35a429621e1e..fa0671d67269 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -559,6 +559,7 @@ static inline int hmm_vma_fault(struct hmm_range *range=
, bool block)
 		return (int)ret;
=20
 	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
+		hmm_range_unregister(range);
 		/*
 		 * The mmap_sem was taken by driver we release it here and
 		 * returns -EAGAIN which correspond to mmap_sem have been
@@ -570,13 +571,13 @@ static inline int hmm_vma_fault(struct hmm_range *ran=
ge, bool block)
=20
 	ret =3D hmm_range_fault(range, block);
 	if (ret <=3D 0) {
+		hmm_range_unregister(range);
 		if (ret =3D=3D -EBUSY || !ret) {
 			/* Same as above, drop mmap_sem to match old API. */
 			up_read(&range->vma->vm_mm->mmap_sem);
 			ret =3D -EBUSY;
 		} else if (ret =3D=3D -EAGAIN)
 			ret =3D -EBUSY;
-		hmm_range_unregister(range);
 		return ret;
 	}
 	return 0;
--=20
2.20.1

