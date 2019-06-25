Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0D551FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 02:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfFYAWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 20:22:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34723 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfFYAWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:22:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so8444882pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 17:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T7DwszIH6Vg5Lzuq4GDQX3dAFFq7h/uJlY/TUYoAObM=;
        b=iaZcsMGUqQlurRX0i3Xesu0XzlVzbmR1e9NkBBm1eOP2eQKwMuaEkCSwig0P4FZA1t
         4XzmWPIUy2ZbU000oUTQiitUAOOVWQUDLAFXAkqVTiB/BOKhCTI8l7kUvmlifG64c3rW
         G0doKdrgaZxuLaqKGtytqAggvIYEbeKgbUQaThyWcgqe1gL6JQrN48jCBIoLKcrN0Uyf
         BCfszognm0RtgIViZIrmPms1Au/eYGN9HSCvx49DyOu7ICf/HjihDNDZI3f6sS7tE7Yd
         fuoYkr2lhZOhiaTAZFVY2EVM02mWpVULVolelLGF1+VCm0qaivdvGy/gwxEll+Mu77MY
         SwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T7DwszIH6Vg5Lzuq4GDQX3dAFFq7h/uJlY/TUYoAObM=;
        b=t52fKkJdaJBelPlIB1Mk2Uyc2xcHL1lecag3Pmr+WMEfJHmdHb3LBwjZafMZA1nLqI
         qjNNo/L0U6oE65RNGkIaBvDxpSg/XWEgFoQKLIy9ZKbC55EmBHoR5GxbmeyY618tViqk
         nNpSltHomluc0HCw0YjvyDLsR5uLTOm7PGcUSBWEx2qocWqbgdQ9ADZAjpyM/tx2v2iE
         +oWIPDgM+k3SGrRT6uu3kQG/5EjErmk29UL67ytVHeODL3jD3a898M++zAX6ESDDMmeo
         MFdgdTtG+mIHIGQCvUp+nLNhIF2nKKdT9GglZwt/Oq/15nR04QF1aH2jSAcTEpFZdIMb
         ol8g==
X-Gm-Message-State: APjAAAVadouhRHzfXqTwpnJawpHxETmblMYQv+WeuaK2cIEeaLGFlQ4d
        +NTUjPVR7xaAYGsBhUNwOw4=
X-Google-Smtp-Source: APXvYqzPM49rOZ8vmVvwAtovOCK0SCaWGfo4w+Ak62VDZnpyFCw2j0kqppwfk3cfPTPcxEwFsSdKIQ==
X-Received: by 2002:a63:a506:: with SMTP id n6mr30915336pgf.161.1561422122677;
        Mon, 24 Jun 2019 17:22:02 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f197sm12607324pfa.161.2019.06.24.17.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 17:22:02 -0700 (PDT)
From:   Doug Berger <opendmb@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yue Hu <huyue2@yulong.com>, Mike Rapoport <rppt@linux.ibm.com>,
        =?UTF-8?q?Micha=C5=82=20Nazarewicz?= <mina86@mina86.com>,
        Laura Abbott <labbott@redhat.com>, Peng Fan <peng.fan@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH] cma: fail if fixed declaration can't be honored
Date:   Mon, 24 Jun 2019 17:20:51 -0700
Message-Id: <1561422051-16142-1-git-send-email-opendmb@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description of the cma_declare_contiguous() function indicates
that if the 'fixed' argument is true the reserved contiguous area
must be exactly at the address of the 'base' argument.

However, the function currently allows the 'base', 'size', and
'limit' arguments to be silently adjusted to meet alignment
constraints. This commit enforces the documented behavior through
explicit checks that return an error if the region does not fit
within a specified region.

Fixes: 5ea3b1b2f8ad ("cma: add placement specifier for "cma=" kernel parameter")
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 mm/cma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index 3340ef34c154..4973d253dc83 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -278,6 +278,12 @@ int __init cma_declare_contiguous(phys_addr_t base,
 	 */
 	alignment = max(alignment,  (phys_addr_t)PAGE_SIZE <<
 			  max_t(unsigned long, MAX_ORDER - 1, pageblock_order));
+	if (fixed && base & (alignment - 1)) {
+		ret = -EINVAL;
+		pr_err("Region at %pa must be aligned to %pa bytes\n",
+			&base, &alignment);
+		goto err;
+	}
 	base = ALIGN(base, alignment);
 	size = ALIGN(size, alignment);
 	limit &= ~(alignment - 1);
@@ -308,6 +314,13 @@ int __init cma_declare_contiguous(phys_addr_t base,
 	if (limit == 0 || limit > memblock_end)
 		limit = memblock_end;
 
+	if (base + size > limit) {
+		ret = -EINVAL;
+		pr_err("Size (%pa) of region at %pa exceeds limit (%pa)\n",
+			&size, &base, &limit);
+		goto err;
+	}
+
 	/* Reserve memory */
 	if (fixed) {
 		if (memblock_is_region_reserved(base, size) ||
-- 
2.7.4

