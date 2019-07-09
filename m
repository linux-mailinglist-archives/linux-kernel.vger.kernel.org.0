Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C553963DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 00:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfGIWgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 18:36:11 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1978 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIWgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 18:36:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d2516d80000>; Tue, 09 Jul 2019 15:36:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 09 Jul 2019 15:36:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 09 Jul 2019 15:36:09 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Jul
 2019 22:36:09 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Jul
 2019 22:36:09 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 9 Jul 2019 22:36:09 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d2516d90000>; Tue, 09 Jul 2019 15:36:09 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] mm/hmm: Fix bad subpage pointer in try_to_unmap_one
Date:   Tue, 9 Jul 2019 15:35:56 -0700
Message-ID: <20190709223556.28908-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562711768; bh=WmDfProy1Dp6O/d7UXR/pCuB4a9yi2oJwRAiLHXR8FI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=THZRHUUfPOzbOu0G+mUFBwdXTkVaIRyYUhTmyBN+kxFrZrkuCZMB0QIbsgRmMgdxv
         fhWfhYtObglVZpAYUg9wae+eqbuKmR0WpWK1LgzKnYNDm90H4nC5PYbjMibG+FexFY
         ws73FQ7OyJbc5tGO4q0fM3859mCHmEWKlrqf/SNrUFffaP+vIxlTvmLpXnU87yW+LE
         GDaFsFG9TOopI7e6oMVFJP+A2eSqnP7NlydABKF5OpHYbq6I2XMDctzEZpY/8Ocvbt
         3kYpx8pU7JykioEa0fCpomdY+HONkVJg0Q0yDCVmmeO9IL42bJ2OA6u2X+0WLdnjKn
         Ki52Yfw+aFsCQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When migrating a ZONE device private page from device memory to system
memory, the subpage pointer is initialized from a swap pte which computes
an invalid page pointer. A kernel panic results such as:

BUG: unable to handle page fault for address: ffffea1fffffffc8

Initialize subpage correctly before calling page_remove_rmap().

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/rmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/rmap.c b/mm/rmap.c
index e5dfe2ae6b0d..ec1af8b60423 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1476,6 +1476,7 @@ static bool try_to_unmap_one(struct page *page, struc=
t vm_area_struct *vma,
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
 			 */
+			subpage =3D page;
 			goto discard;
 		}
=20
--=20
2.20.1

