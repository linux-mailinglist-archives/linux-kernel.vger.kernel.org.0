Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB328ADE88
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 20:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405432AbfIISMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 14:12:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41443 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405418AbfIISMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:12:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id j10so17239675qtp.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PMN+GU/7lAwuo7DCEIP2WVoBijVCk7hpbqQ7uFmtqns=;
        b=nnzdApBloMLNe7CmaSyIXPwdwXUub97dhH0hmTNuPhU6Ey5v2IK6XwrSriwQ8EMtik
         1vrTnTVLsxI946LCFlzno1fZjJbbkSBdiwKX/O1V2Sr23i93JseUgZz92ReGWyU9xzMz
         5PnosW9KUenjWvGEQg1FYBtiL4AY/NQ5R2BoydvlYSWk78rThpghy/DJwC9veyytWXCv
         J6VATeAnl1BI6kHItkqSnWP4w0jL/n5QNSwz8LSXfEgxN1LcVaHcptxnHyozclpwZbXv
         t4Bv5epj9+nYTFy0S8Q1O1I/adisDjKUjth8bD3anE6TV0dCTJwQFLgiUbyM23E4rPs4
         vGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMN+GU/7lAwuo7DCEIP2WVoBijVCk7hpbqQ7uFmtqns=;
        b=b4pco5u0Ckre3s4VL2uiyYZn84ihwk8GnQxMk6ddz8vxJyHKrAOPfR0BrhPXNUrM9G
         oCTz8MNjUqJAMj2tf+i/bQsYYx6mJ4P9m41qPjPoocdTNDHjHLMPq5jHznQcpbzgNact
         I3gm06btOmQGsbijKhVtKOtCBxjWoPX8lZQBcqBNumaxkCOPLhlB6x6d6D+O/S5fKSJi
         xEON9XXNrtW4xytt5FSmYvrxDraygOHL+BYS0T9m89hx1qtbyKO/SD6Smrcn01QMJt8+
         XODMn9Wo4zZcV8DeBz8GnK31BzmwgPyrI/W7bxlUG9UwEGr7WDtXu8SU/uRGKDxFutUT
         rpDg==
X-Gm-Message-State: APjAAAUTSf/kmovWoDOrLUlk57V0178zFLUh+wVJXmSw1YCgGOzA+Cyp
        WDFJZAxTo/p8NOVAryC8tnG5lw==
X-Google-Smtp-Source: APXvYqz6jhv4a/IfFo65uSy2aKVphPkzU4Qff5D49UQCU1mAfkT1Y9m5gUkUa74hm3EqOo/yODu9Uw==
X-Received: by 2002:ad4:4441:: with SMTP id l1mr15336417qvt.7.1568052749777;
        Mon, 09 Sep 2019 11:12:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q8sm5611310qtj.76.2019.09.09.11.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 11:12:29 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com
Subject: [PATCH v4 04/17] arm64: hibernate: use get_safe_page directly
Date:   Mon,  9 Sep 2019 14:12:08 -0400
Message-Id: <20190909181221.309510-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909181221.309510-1-pasha.tatashin@soleen.com>
References: <20190909181221.309510-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_safe_exec_page() uses hibernate's allocator to create a set of page
table to map a single page that will contain the relocation code.

Remove the allocator related arguments, and use get_safe_page directly, as
it is done in other local functions in this file to simplify function
prototype.

Removing this function pointer makes it easier to refactor the code later.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/hibernate.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 227cc26720f7..47a861e0cb0c 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -196,9 +196,7 @@ EXPORT_SYMBOL(arch_hibernation_header_restore);
  */
 static int create_safe_exec_page(void *src_start, size_t length,
 				 unsigned long dst_addr,
-				 phys_addr_t *phys_dst_addr,
-				 void *(*allocator)(gfp_t mask),
-				 gfp_t mask)
+				 phys_addr_t *phys_dst_addr)
 {
 	int rc = 0;
 	pgd_t *trans_pgd;
@@ -206,7 +204,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	pud_t *pudp;
 	pmd_t *pmdp;
 	pte_t *ptep;
-	unsigned long dst = (unsigned long)allocator(mask);
+	unsigned long dst = get_safe_page(GFP_ATOMIC);
 
 	if (!dst) {
 		rc = -ENOMEM;
@@ -216,7 +214,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	memcpy((void *)dst, src_start, length);
 	__flush_icache_range(dst, dst + length);
 
-	trans_pgd = allocator(mask);
+	trans_pgd = (void *)get_safe_page(GFP_ATOMIC);
 	if (!trans_pgd) {
 		rc = -ENOMEM;
 		goto out;
@@ -224,7 +222,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 	pgdp = pgd_offset_raw(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
-		pudp = allocator(mask);
+		pudp = (void *)get_safe_page(GFP_ATOMIC);
 		if (!pudp) {
 			rc = -ENOMEM;
 			goto out;
@@ -234,7 +232,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 	pudp = pud_offset(pgdp, dst_addr);
 	if (pud_none(READ_ONCE(*pudp))) {
-		pmdp = allocator(mask);
+		pmdp = (void *)get_safe_page(GFP_ATOMIC);
 		if (!pmdp) {
 			rc = -ENOMEM;
 			goto out;
@@ -244,7 +242,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 
 	pmdp = pmd_offset(pudp, dst_addr);
 	if (pmd_none(READ_ONCE(*pmdp))) {
-		ptep = allocator(mask);
+		ptep = (void *)get_safe_page(GFP_ATOMIC);
 		if (!ptep) {
 			rc = -ENOMEM;
 			goto out;
@@ -530,8 +528,7 @@ int swsusp_arch_resume(void)
 	 */
 	rc = create_safe_exec_page(__hibernate_exit_text_start, exit_size,
 				   (unsigned long)hibernate_exit,
-				   &phys_hibernate_exit,
-				   (void *)get_safe_page, GFP_ATOMIC);
+				   &phys_hibernate_exit);
 	if (rc) {
 		pr_err("Failed to create safe executable page for hibernate_exit code.\n");
 		goto out;
-- 
2.23.0

