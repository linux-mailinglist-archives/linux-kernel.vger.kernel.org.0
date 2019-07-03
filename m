Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161995EDA2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 22:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfGCUeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 16:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfGCUeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:34:11 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE8E6218BA;
        Wed,  3 Jul 2019 20:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562186050;
        bh=qyml9S6CXXCCpL8rmU1nbZwbMkGu/5gFSbg4hXJdmVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDy/bf8vASrPtcxPCGsYrDPrmJptR+3fVFDdK+pJ6lfOx6XC1AWfQ6PwDzKSWzZQl
         gD/TzLMCACOhS1cYuR1h7+DiGUBMdKeXlp4Dv6qfrWWlXuolYwHxCbAYeLCBTF2xd4
         3U6FGaY3hW2obWfWJtXb9VOmDWvcXGGT2oAck2KU=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 4/4] x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long
Date:   Wed,  3 Jul 2019 13:34:05 -0700
Message-Id: <99b0d83ad891c67105470a1a6b63243fd63a5061.1562185330.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1562185330.git.luto@kernel.org>
References: <cover.1562185330.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, it's an int.  This is bizarre.  Fortunately, the code
using it still works: ~__X32_SYSCALL_BIT is also int, so, if nr is
unsigned long, then C kindly sign-extends the ~__X32_SYSCALL_BIT
part, and we actually get the desired value.

This is far more subtle than it deserves to be.  Syscall numbers
are, for all practical purposes, unsigned long, so make
__X32_SYSCALL_BIT be unsigned long.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/uapi/asm/unistd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/unistd.h b/arch/x86/include/uapi/asm/unistd.h
index 30d7d04d72d6..196fdd02b8b1 100644
--- a/arch/x86/include/uapi/asm/unistd.h
+++ b/arch/x86/include/uapi/asm/unistd.h
@@ -3,7 +3,7 @@
 #define _UAPI_ASM_X86_UNISTD_H
 
 /* x32 syscall flag bit */
-#define __X32_SYSCALL_BIT	0x40000000
+#define __X32_SYSCALL_BIT	0x40000000UL
 
 #ifndef __KERNEL__
 # ifdef __i386__
-- 
2.21.0

