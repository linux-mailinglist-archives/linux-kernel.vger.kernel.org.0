Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D9D982F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 20:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfHUSdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 14:33:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39667 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbfHUScU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id 125so2727007qkl.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=p2ZmPVW3GUksitLyy9jJ27m49TkI76nwQzxdL+NJyyg=;
        b=J7ncVAC/Ks/EVDWP1J6BghzJOVmI27MTR8joZZ9iGqN0eTRjFtj/eaN0Or61tK1y/4
         cpAOw5K8hLE3U5xetVDyi5wH1tGqXtzvQig9a2h9kkbrHAtcKIGjwURANE/QY+b8pvou
         enG2wH3J21xePJ0Bvbz8TyQP3ccy4TUVnry1I2OhVy+vOCKmvac2ZH+UrNh+P9qPYwT2
         UMFpaqOKsTMyOk2zzKuNIIRuWAHUxsJESpJ5QBAM77U0vMzOpdQFzb17OTpOcKe+muBB
         EB/JFZ9nEpIu9UtWXT3FlFKU7k5VuIWmAx2Ui4GDgJaTUSlEIrYzNQZXiE6ikxkq1vtM
         Hr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p2ZmPVW3GUksitLyy9jJ27m49TkI76nwQzxdL+NJyyg=;
        b=oTduVz5zZc5hocHBppacAeJQ1NsM5mgckX6s6XcSnukdXPYZNXFr4WLT16IPwhxO5X
         9HgozPZ0O5dMFho/x5mY+SfjPankwlEtBXYb7VQqwlWS8f3pdHrGCtJLTSRNnPaq7oXo
         0/xqvnBe98fovzBxarYhH5M3ogRq+YlzmzcAuAABasjDGHE8lCNq4vXD64LGcTBLRUdb
         VkWLGJIi/dfVevNxFZIlu24hXsvWZARXobnO4DHd5Yt1XWXhpCjAsCpK4lySvJ0aQqWx
         wqezDR3la385nLngOkMAEjQAAR4ie7wbQUElmYN4zYG7oaM1q3vIJmZ9gtc/CLrJo2ER
         Pu5w==
X-Gm-Message-State: APjAAAWnaFwpqWF7k8aSbVN7JfwHO7WttIQraKy8EMjsGAD5CNCPXtyq
        rSkF3e/ieJrkgDvSInuEy1cO2Q==
X-Google-Smtp-Source: APXvYqw7OKOPFGZGP2ShGpR47tsdJdXKOSIYQ93+AeAvfCBSHBXQT7Xapz16QlTiFuqHRCuJi7i9nA==
X-Received: by 2002:a37:9c0c:: with SMTP id f12mr33218821qke.442.1566412339244;
        Wed, 21 Aug 2019 11:32:19 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q13sm10443332qkm.120.2019.08.21.11.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 11:32:18 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v3 09/17] arm64, trans_pgd: add trans_pgd_create_empty
Date:   Wed, 21 Aug 2019 14:31:56 -0400
Message-Id: <20190821183204.23576-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190821183204.23576-1-pasha.tatashin@soleen.com>
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This functions returns a zeroed trans_pgd using the allocator that is
specified in the info argument.

trans_pgds should be created by using this function.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  3 +++
 arch/arm64/kernel/hibernate.c      |  6 +++---
 arch/arm64/mm/trans_pgd.c          | 12 ++++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index e3d022b1b526..26e5a63676b5 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -40,6 +40,9 @@ struct trans_pgd_info {
 	unsigned long trans_flags;
 };
 
+/* Create and empty trans_pgd page table */
+int trans_pgd_create_empty(struct trans_pgd_info *info, pgd_t **trans_pgd);
+
 int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
 			  unsigned long end);
 
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 17426dc8cb54..8c2641a9bb09 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -216,9 +216,9 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	memcpy(page, src_start, length);
 	__flush_icache_range((unsigned long)page, (unsigned long)page + length);
 
-	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
-	if (!trans_pgd)
-		return -ENOMEM;
+	rc = trans_pgd_create_empty(&trans_info, &trans_pgd);
+	if (rc)
+		return rc;
 
 	rc = trans_pgd_map_page(&trans_info, trans_pgd, page, dst_addr,
 				PAGE_KERNEL_EXEC);
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index dbabccd78cc4..ece797aa1841 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -164,6 +164,18 @@ static int copy_page_tables(pgd_t *dst_pgdp, unsigned long start,
 	return 0;
 }
 
+int trans_pgd_create_empty(struct trans_pgd_info *info, pgd_t **trans_pgd)
+{
+	pgd_t *dst_pgdp = trans_alloc(info);
+
+	if (!dst_pgdp)
+		return -ENOMEM;
+
+	*trans_pgd = dst_pgdp;
+
+	return 0;
+}
+
 int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
 			  unsigned long end)
 {
-- 
2.23.0

