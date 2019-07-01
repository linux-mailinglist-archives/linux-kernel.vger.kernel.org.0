Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9414F47C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 10:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfFVIvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 04:51:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51836 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfFVIvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 04:51:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so8287019wma.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 01:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HO4NlEgMlVr7RQNzUTkiZe3whDgA7iGbSEYeXfsjzfo=;
        b=iz2Wh5lKIKrtIT+GilYCiOborf/BB+0KAnXOBgcowZHsTrFSpVUgXEsP8RADKbgcjA
         AiNEbMFDsQHqYVnWhYpACbjywEFmgTQHxJbOZh0qTYuoixUa9GwiPPPJ7c9Pohwgpt+k
         usZtN0O+w4JAQj2x3sfCJefE7RL8k9GJwvaw6Q4C065/h9Z0VFvC/r/CllXb4R5ZPrDV
         +a49/gi4z3nP3UUHtSONU1xhrt+djS34PKGvVpsc4yihqBsw7ULFsoBJS4VNLegoUAqE
         kYjdwP3jxhffTl7ROUZHCgTdMj8VgCtkkMDZcwxIueXwu5dCXzu3BIFp6fCTwkKb+fym
         LquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HO4NlEgMlVr7RQNzUTkiZe3whDgA7iGbSEYeXfsjzfo=;
        b=Nenr8ADncjCOBt5g3EUhGFQSNzJYZjGTVOS7ZEDhceWGt5Jd98wVrllic/lbsN3juZ
         baCDEMqWPmuYvODVuvr859gr19dGirVSo49Pis8RAc4OrQu6+tBSjM9umaXvN3KGu8Cu
         R0bb+RmRI3lj3lrq3ZoXOD37ISgKIuJNrzCxsehvCK6rVaItsznJ8O45wgferexUCKd6
         BCCRY5qKGpDbuRqVOJXQdhezsttxFRB/SOQcSSNQCzuCl0pxGu2eVtsyeIIESyPpPvoc
         F6kMNSr6uY+pdmxl4Jqryj4L1evD4EqJdjTVnTGCyE6+Rzy3CB8Zi+yyMi0qeK8tyP5C
         OTHA==
X-Gm-Message-State: APjAAAUAHM6ayM2u9S85FFW27L6XXFLjiT5BdpfkX5vf+Zyh194/lq1K
        I9OZlAJUK4Rh9M8ZnzuajDVzew==
X-Google-Smtp-Source: APXvYqzFnpgqxmtOy6/8NHQqNbTQ+elWE4WF/mHbUz0J17z0cEJj/TLZyZd5RkNkH5JI9MXqXsFM5A==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr7720525wmi.0.1561193472725;
        Sat, 22 Jun 2019 01:51:12 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:4bd:3f91:4ef8:ae7e])
        by smtp.gmail.com with ESMTPSA id v15sm4863589wrt.25.2019.06.22.01.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 01:51:12 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jonathan Richardson <jonathan.richardson@broadcom.com>,
        Luo XinanX <xinanx.luo@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Qian Cai <cai@lca.pw>, Tian Baofeng <baofeng.tian@intel.com>
Subject: [PATCH 1/4] efi/memreserve: deal with memreserve entries in unmapped memory
Date:   Sat, 22 Jun 2019 10:51:03 +0200
Message-Id: <20190622085106.24859-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190622085106.24859-1-ard.biesheuvel@linaro.org>
References: <20190622085106.24859-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the EFI memreserve entries can be accessed, even if they
are located in memory that the kernel (e.g., a crashkernel) omits from
the linear map.

Fixes: 80424b02d42b ("efi: Reduce the amount of memblock reservations ...")
Cc: <stable@vger.kernel.org> # 5.0+
Reported-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Reviewed-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 16b2137d117c..4b7cf7bc0ded 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -1009,14 +1009,16 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 
 	/* first try to find a slot in an existing linked list entry */
 	for (prsv = efi_memreserve_root->next; prsv; prsv = rsv->next) {
-		rsv = __va(prsv);
+		rsv = memremap(prsv, sizeof(*rsv), MEMREMAP_WB);
 		index = atomic_fetch_add_unless(&rsv->count, 1, rsv->size);
 		if (index < rsv->size) {
 			rsv->entry[index].base = addr;
 			rsv->entry[index].size = size;
 
+			memunmap(rsv);
 			return 0;
 		}
+		memunmap(rsv);
 	}
 
 	/* no slot found - allocate a new linked list entry */
@@ -1024,7 +1026,13 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	if (!rsv)
 		return -ENOMEM;
 
-	rsv->size = EFI_MEMRESERVE_COUNT(PAGE_SIZE);
+	/*
+	 * The memremap() call above assumes that a linux_efi_memreserve entry
+	 * never crosses a page boundary, so let's ensure that this remains true
+	 * even when kexec'ing a 4k pages kernel from a >4k pages kernel, by
+	 * using SZ_4K explicitly in the size calculation below.
+	 */
+	rsv->size = EFI_MEMRESERVE_COUNT(SZ_4K);
 	atomic_set(&rsv->count, 1);
 	rsv->entry[0].base = addr;
 	rsv->entry[0].size = size;
-- 
2.20.1

