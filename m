Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE171967A7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 17:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgC1Qp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 12:45:59 -0400
Received: from mx.sdf.org ([205.166.94.20]:50072 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbgC1Qn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:43:29 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhQkO024822
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:26 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhQZ8022500;
        Sat, 28 Mar 2020 16:43:26 GMT
Message-Id: <202003281643.02SGhQZ8022500@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Fri, 29 Nov 2019 19:05:57 -0500
Subject: [RFC PATCH v1 49/50] arch/x86/entry/vdso/vma.c: Use
 get_random_max32() for vdso_addr
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Which is faster and more uniform than get_random_int() % range.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/vdso/vma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index f5937742b2901..beb4ef8f85987 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -227,7 +227,7 @@ static unsigned long vdso_addr(unsigned long start, unsigned len)
 	end -= len;
 
 	if (end > start) {
-		offset = get_random_int() % (((end - start) >> PAGE_SHIFT) + 1);
+		offset = get_random_max32(((end - start) >> PAGE_SHIFT) + 1);
 		addr = start + (offset << PAGE_SHIFT);
 	} else {
 		addr = start;
-- 
2.26.0

