Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEBF457AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 06:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfF0Erd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 00:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0Erd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 00:47:33 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 906C421855;
        Thu, 27 Jun 2019 04:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561610852;
        bh=ee2Mq/h/NzrSn+b/TDwwROThTXdyfId0zMmsuBEqsMU=;
        h=From:To:Cc:Subject:Date:From;
        b=Zc4eXXrCC+my0ISOPpsD7SHbwK4BXOHry6fuWv+QzJmA6E5k0q37IYowiw7w3iRlj
         3WwcSJJ3XONzRL8zvUCluuh9GGE93md4NJt+0WpPuYMkACU9z1R9jW4eIe8BRfuT0L
         fo2hfanS8R3FoK3oUJrGErGCyFUaaUdA8XeLL7Uo=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] mm/gup: Remove some BUG_ONs from get_gate_page()
Date:   Wed, 26 Jun 2019 21:47:30 -0700
Message-Id: <a1d9f4efb75b9d464e59fd6af00104b21c58f6f7.1561610798.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we end up without a PGD or PUD entry backing the gate area, don't
BUG -- just fail gracefully.

It's not entirely implausible that this could happen some day on
x86.  It doesn't right now even with an execute-only emulated
vsyscall page because the fixmap shares the PUD, but the core mm
code shouldn't rely on that particular detail to avoid OOPSing.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 mm/gup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ddde097cf9e4..9883b598fd6f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -585,11 +585,14 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 		pgd = pgd_offset_k(address);
 	else
 		pgd = pgd_offset_gate(mm, address);
-	BUG_ON(pgd_none(*pgd));
+	if (pgd_none(*pgd))
+		return -EFAULT;
 	p4d = p4d_offset(pgd, address);
-	BUG_ON(p4d_none(*p4d));
+	if (p4d_none(*p4d))
+		return -EFAULT;
 	pud = pud_offset(p4d, address);
-	BUG_ON(pud_none(*pud));
+	if (pud_none(*pud))
+		return -EFAULT;
 	pmd = pmd_offset(pud, address);
 	if (!pmd_present(*pmd))
 		return -EFAULT;
-- 
2.21.0

