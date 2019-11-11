Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 069E5F8319
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 23:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKKWts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 17:49:48 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13031 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfKKWts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 17:49:48 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dc9e54d0003>; Mon, 11 Nov 2019 14:48:45 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 11 Nov 2019 14:49:47 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 11 Nov 2019 14:49:47 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Nov
 2019 22:49:47 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 11 Nov 2019 22:49:47 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dc9e58a0006>; Mon, 11 Nov 2019 14:49:46 -0800
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] mm/debug:
Date:   Mon, 11 Nov 2019 14:49:35 -0800
Message-ID: <20191111224935.19464-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573512525; bh=s0u4JStRou+moTpBzyHx7DOfpoP7ck18LZeKksO8mgM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=B3eEl2O9qLQofFI6eunpksIKP3sN/p2y8i8PZKrmrGz9vSV5P0eVvFV819J4dzum/
         TA62gh1+zWNQF+q+Z8wzcDgDGE1/41ser3qJRIjj0FQ1HHv4DBrw+BQ1RIbgmjCVud
         Ujvf7X1NGnuQmwlXl2I2GKK3fZzYR6+w7Aj3NsZOlxi/+16wmaSea9sxI/j/EitqBB
         UpQUhg1oh3Y6CIjBqNZ2f5o+zRkhQHtHiUzN9tktvIMwShnU7E3uKOooH4Z0y5f1yH
         H1/m7w83Jf5pANJ/Syx9QZv/ajpuQI2ZtX4LUE09VcJNI18iCG2ZxZLhKs8kULOYgC
         gIyoGPS+FBrgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dumping struct page information, __dump_page() prints the page type
with a trailing blank followed by the page flags on a separate line:

anon
flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)

Fix this by using pr_cont() instead of pr_warn() to get a single line:

anon flags: 0x100000000090034(uptodate|lru|active|head|swapbacked)

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/debug.c b/mm/debug.c
index 8345bb6e4769..752c78721ea0 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -87,7 +87,7 @@ void __dump_page(struct page *page, const char *reason)
 	}
 	BUILD_BUG_ON(ARRAY_SIZE(pageflag_names) !=3D __NR_PAGEFLAGS + 1);
=20
-	pr_warn("flags: %#lx(%pGp)\n", page->flags, &page->flags);
+	pr_cont("flags: %#lx(%pGp)\n", page->flags, &page->flags);
=20
 hex_only:
 	print_hex_dump(KERN_WARNING, "raw: ", DUMP_PREFIX_NONE, 32,
--=20
2.20.1

