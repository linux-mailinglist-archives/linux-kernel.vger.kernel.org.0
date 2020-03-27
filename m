Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C7C194EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 03:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgC0C2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 22:28:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47812 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgC0C2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 22:28:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHejd-003hFf-FJ; Fri, 27 Mar 2020 02:28:37 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC][PATCH v2 2/8] sh: no need of access_ok() in arch_futex_atomic_op_inuser()
Date:   Fri, 27 Mar 2020 02:28:30 +0000
Message-Id: <20200327022836.881203-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327022836.881203-1-viro@ZenIV.linux.org.uk>
References: <x86: unsafe_put-style macro for sigmask>
 <20200327022836.881203-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

everything it uses is doing access_ok() already

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sh/include/asm/futex.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/include/asm/futex.h b/arch/sh/include/asm/futex.h
index 324fa680b13d..b39cda09fb95 100644
--- a/arch/sh/include/asm/futex.h
+++ b/arch/sh/include/asm/futex.h
@@ -34,9 +34,6 @@ static inline int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval,
 	u32 oldval, newval, prev;
 	int ret;
 
-	if (!access_ok(uaddr, sizeof(u32)))
-		return -EFAULT;
-
 	do {
 		ret = get_user(oldval, uaddr);
 
-- 
2.11.0

