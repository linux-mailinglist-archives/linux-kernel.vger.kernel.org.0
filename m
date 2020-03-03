Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8004C177C27
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 17:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbgCCQmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 11:42:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39243 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCCQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:42:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so1553790plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 08:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XhGFUrx1v6eQV+qctC2ZOoxV4HtnB/sPU/5rxwGHIJ8=;
        b=sxQlJoDbSlbju8kAXlj03S3FItr9OTowlKd8NRmEFACViq4nO3qgLOv9p4Ulyev23X
         vRZERcYQvD4ZWlbBFvMBIpbS5tnebQMhNibSsLceR5tNKSsJiQfmXgVjDp+3uFGc3XbG
         IFojHEsbtzJ58RG2ZHyF99Gxae72FPN3fOEFmgQZLvRdGOOoGwNcaui7Ajjv57maNx2v
         z2bWB8//MFTgOY/zW01WYlPbUtkAGFIOFj+TuRdlhULBoEc6Fj/pA30nBI+NTvcx9oVe
         tGwOJ+pOmdLjsRe3HZ326pZXijx7f8gPIvFU3d1Kq2UgP7bFJbVBAd3iN0ou6u22Koot
         SrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XhGFUrx1v6eQV+qctC2ZOoxV4HtnB/sPU/5rxwGHIJ8=;
        b=HCM7yv/ZjIBcyFCLswNVoRjtxZDq63SjZZ74n7jEMxqwCIHagQbcIw/qRLKDkzLXXb
         SZf794KlRpKYFoeZ0BDZfjXPSIJfPfwDDqzHFwKYjOE+mkq4h9zHZ96fUaGCBJzTIWsu
         f/0C4bX7WLnd3lX4k02pqgfZhnhQMIVk3VdtDWeolzCqBra1VgN3RD6s/c/V5aIDO19F
         EjPs2yMmM8fTbv9FQHs11S1Hz3d6EW9FobGpyqWiBHNTvIjQx6jk8XVOtlT4VHu01CoD
         zg+Boq0GF28xCiftGdKzNUWOZsTE3XSjy9IHJs2I2KKBZ4VbAhk0F1J++wIfI7L6dMaJ
         d+QQ==
X-Gm-Message-State: ANhLgQ3wCO+iD/+F3omUGGjDW687Lu4uFA4McXB7A2/tofXnasGY1GEo
        8tRe4fS/kfULV4x/Eh/lioY=
X-Google-Smtp-Source: ADFU+vtGNyK1+zGHYNxi1/B2InSOJARhXWM2xnyRr/zjkbwpqKLeXBb08gR4H2rgWv5RDuBjOBWo6w==
X-Received: by 2002:a17:90b:3581:: with SMTP id mm1mr4728583pjb.169.1583253737264;
        Tue, 03 Mar 2020 08:42:17 -0800 (PST)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id 193sm2916138pfu.181.2020.03.03.08.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 08:42:16 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     tglx@linutronix.de, peterz@infradead.org
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ast@kernel.org,
        mhiramat@kernel.org, rick.p.edgecombe@intel.com, namit@vmware.com,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] x86/alternatives: Mark text_poke_loc_init static
Date:   Wed,  4 Mar 2020 00:42:12 +0800
Message-Id: <1583253732-18988-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, the function is only used in this file, so mark it with 'static'.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 15ac0d5..600da3cb 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1167,7 +1167,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		atomic_cond_read_acquire(&desc.refs, !VAL);
 }
 
-void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
+static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 			const void *opcode, size_t len, const void *emulate)
 {
 	struct insn insn;
-- 
1.8.3.1

