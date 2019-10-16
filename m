Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE005D8989
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 09:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbfJPHeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 03:34:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46032 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfJPHeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:34:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so14137314pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id;
        bh=pK2qwDb6039LW4fpVN7sB6lBT8h6fpy8/DAwlCYdB60=;
        b=ldLjKQ/2qpgiAHYu/ICIETehZvhdoXt5ztL5XbWzpuswY8fqmRkLZrDrw2PkpR9G9/
         yWWZFA7Ns+sGE/T2YpTj/vJfuzu0djXQvm2ymdi9hfJrJUwLg/oqhjNsQ6K3cJfH/NCN
         PVLcg60N/qmIiF5uUHiryyBEeNywkmTgNudmvbPQHhrOwG4vwG+TrSvrfUF0RrH2FCE6
         jN3MGHcQCb2YUM/Vivd7KPqzybdWbltY3MdR9WRjw4lBGkD8xLtd65uBGMsXxYmFsEnD
         LL8ytrVqLI8yC8sTLVHY7BOunZaiKp7CbOivpkxrPhf8TrdRYJJjiIqaqScO9Y93nl+c
         QuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=pK2qwDb6039LW4fpVN7sB6lBT8h6fpy8/DAwlCYdB60=;
        b=eg7FIVb4+ApcyNGf5UUqe8i1YQwDANiAo2q7SQ58UEUi68RusW0IukH4GuyoBdsTUF
         F+agLQ+ddg9W+msbVl+eo6PuM3lcFvLMP/EtW2GUKnw1p0dQMAViSsK9tCZ3QB1j4UEp
         nokW3Iy5dp5Cwy8n56L0ulx1Fwy/dacp8LCKJPwntcvWrPRJUxiLwEb5xNreF5fflSwh
         aMCssUWrRt6KFdSKh0vrTiGfh087/vTrdyI1L6tg7PikVhAmk/CzKYgvj5mdPbwc0GSh
         Q6W340o97WVjyWW4ia+wBJIxuJsljghdjgubyCoAS2hR/QIpoAUQAI4QIVJQO9psTyoJ
         5YIQ==
X-Gm-Message-State: APjAAAUtqe5G3+ncpK+MFyt6qsPfI9o1lAtrqOEfxb3YRIPC6g5TmjEp
        n6GogEkjK3MPeZ/UOmLbe+rZNQ==
X-Google-Smtp-Source: APXvYqwSkcsw+C+K2IFO+yRj+DBcxD9V8gX+qJfV1KUfjuPnIvFguE9Pi5u0/yESJK7ryR7aUNfipg==
X-Received: by 2002:aa7:9907:: with SMTP id z7mr43342933pff.133.1571211258753;
        Wed, 16 Oct 2019 00:34:18 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id 126sm26574767pgg.10.2019.10.16.00.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 00:34:18 -0700 (PDT)
From:   greentime.hu@sifive.com
To:     greentime.hu@sifive.com, green.hu@gmail.com,
        paul.walmsley@sifive.com, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RISC-V: fix virtual address overlapped in FIXADDR_START and VMEMMAP_START
Date:   Wed, 16 Oct 2019 15:34:08 +0800
Message-Id: <20191016073408.7299-1-greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greentime Hu <greentime.hu@sifive.com>

This patch fixes the virtual address layout in pgtable.h.
The virtual address of FIXADDR_START and VMEMMAP_START should not be overlapped.
These addresses will be existed at the same time in Linux kernel that they can't
be overlapped.

Fixes: d95f1a542c3d ("RISC-V: Implement sparsemem")
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/pgtable.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 4f4162d90586..b927fb4ecf1c 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -87,14 +87,6 @@ extern pgd_t swapper_pg_dir[];
 #define VMALLOC_END      (PAGE_OFFSET - 1)
 #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
 
-#define FIXADDR_TOP      VMALLOC_START
-#ifdef CONFIG_64BIT
-#define FIXADDR_SIZE     PMD_SIZE
-#else
-#define FIXADDR_SIZE     PGDIR_SIZE
-#endif
-#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
-
 /*
  * Roughly size the vmemmap space to be large enough to fit enough
  * struct pages to map half the virtual address space. Then
@@ -108,6 +100,14 @@ extern pgd_t swapper_pg_dir[];
 
 #define vmemmap		((struct page *)VMEMMAP_START)
 
+#define FIXADDR_TOP      (VMEMMAP_START)
+#ifdef CONFIG_64BIT
+#define FIXADDR_SIZE     PMD_SIZE
+#else
+#define FIXADDR_SIZE     PGDIR_SIZE
+#endif
+#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
+
 /*
  * ZERO_PAGE is a global shared page that is always zero,
  * used for zero-mapped memory areas, etc.
-- 
2.17.1

