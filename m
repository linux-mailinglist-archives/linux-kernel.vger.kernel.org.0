Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4356114EA55
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 11:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgAaKBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 05:01:13 -0500
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:56100 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgAaKBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:01:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id C790F3FD13;
        Fri, 31 Jan 2020 11:01:09 +0100 (CET)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=GoYqswts;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SHs2n_T6gOEa; Fri, 31 Jan 2020 11:01:08 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 243553FC05;
        Fri, 31 Jan 2020 11:01:07 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 714F1360093;
        Fri, 31 Jan 2020 11:01:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1580464867; bh=fAsEaB9XUES6Qvb9+NO+aU7Kv7uOMIgjlqELbkBztfo=;
        h=From:To:Cc:Subject:Date:From;
        b=GoYqswts+r1eIgAFejbB8049UuZsWY2tUAMf9kM07OHNyvFVEGxt3Ctq+W35kN3rz
         uiEc4fxS9GEx4D3NH1HhU8Bl+LSwE+enaE0OB/2jFRn7Q67ppqn2HlUggXj5prsv8V
         YKI37tidhdfb5a+kRPd9Rg4fhD5zQXaWuqgWcHRE=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] mm/mapping_dirty_helpers: Update huge page-table entry callbacks
Date:   Fri, 31 Jan 2020 11:00:52 +0100
Message-Id: <20200131100052.58761-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Following the update of pagewalk code
commit a07984d48146 ("mm: pagewalk: add p4d_entry() and pgd_entry()")
we can modify the mapping_dirty_helpers' huge page-table entry callbacks
to avoid splitting when a huge pud or -pmd is encountered.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Steven Price <steven.price@arm.com>
---
 mm/mapping_dirty_helpers.c | 42 ++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 71070dda9643..2c7d03675903 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -111,26 +111,60 @@ static int clean_record_pte(pte_t *pte, unsigned long addr,
 	return 0;
 }
 
-/* wp_clean_pmd_entry - The pagewalk pmd callback. */
+/*
+ * wp_clean_pmd_entry - The pagewalk pmd callback.
+ *
+ * Dirty-tracking should take place on the PTE level, so
+ * WARN() if encountering a dirty huge pmd.
+ * Furthermore, never split huge pmds, since that currently
+ * causes dirty info loss. The pagefault handler should do
+ * that if needed.
+ */
 static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
-	/* Dirty-tracking should be handled on the pte level */
 	pmd_t pmdval = pmd_read_atomic(pmd);
 
+	if (!pmd_trans_unstable(&pmdval))
+		return 0;
+
+	if (pmd_none(pmdval)) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
+
+	/* Huge pmd, present or migrated */
+	walk->action = ACTION_CONTINUE;
 	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
 		WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval));
 
 	return 0;
 }
 
-/* wp_clean_pud_entry - The pagewalk pud callback. */
+/*
+ * wp_clean_pud_entry - The pagewalk pud callback.
+ *
+ * Dirty-tracking should take place on the PTE level, so
+ * WARN() if encountering a dirty huge puds.
+ * Furthermore, never split huge puds, since that currently
+ * causes dirty info loss. The pagefault handler should do
+ * that if needed.
+ */
 static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
-	/* Dirty-tracking should be handled on the pte level */
 	pud_t pudval = READ_ONCE(*pud);
 
+	if (!pud_trans_unstable(&pudval))
+		return 0;
+
+	if (pud_none(pudval)) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
+
+	/* Huge pud */
+	walk->action = ACTION_CONTINUE;
 	if (pud_trans_huge(pudval) || pud_devmap(pudval))
 		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
 
-- 
2.21.1

