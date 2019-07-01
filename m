Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 802D7F19B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 09:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfD3HpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 03:45:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfD3HpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:45:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 965C537E88;
        Tue, 30 Apr 2019 07:45:12 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5894799A;
        Tue, 30 Apr 2019 07:45:03 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, akpm@linux-foundation.org, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com
Subject: [PATCH 3/3 v3] kdump,proc/vmcore: Enable dumping encrypted memory when SEV was active
Date:   Tue, 30 Apr 2019 15:44:21 +0800
Message-Id: <20190430074421.7852-4-lijiang@redhat.com>
In-Reply-To: <20190430074421.7852-1-lijiang@redhat.com>
References: <20190430074421.7852-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Tue, 30 Apr 2019 07:45:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the kdump kernel, the memory of the first kernel needs to be dumped
into the vmcore file.

It is similar to the SME kdump, if SEV was enabled in the first kernel,
the old memory has to be remapped with memory encryption mask in order
to access it properly. Following commit 992b649a3f01 ("kdump, proc/vmcore:
Enable kdumping encrypted memory with SME enabled") took care of the
SME case but it uses sme_active() which checks for SME only. Lets use
the mem_encrypt_active() which returns true when either of them are
active.

Unlike the SME, the second kernel images(kernel and initrd) are loaded
to the encrypted memory when SEV is active, hence the kernel elf header
must be remapped as encrypted in order to access it properly.

Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 fs/proc/vmcore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 3fe90443c1bb..cda6c1922e4f 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -165,7 +165,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
  */
 ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, false);
+	return read_from_oldmem(buf, count, ppos, 0, sev_active());
 }
 
 /*
@@ -173,7 +173,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, sme_active());
+	return read_from_oldmem(buf, count, ppos, 0, mem_encrypt_active());
 }
 
 /*
@@ -373,7 +373,7 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 					    buflen);
 			start = m->paddr + *fpos - m->offset;
 			tmp = read_from_oldmem(buffer, tsz, &start,
-					       userbuf, sme_active());
+					       userbuf, mem_encrypt_active());
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
-- 
2.17.1

