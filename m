Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA29E5C7ED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 05:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGBDnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 23:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbfGBDnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 23:43:25 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F39A521848;
        Tue,  2 Jul 2019 03:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562039005;
        bh=9xXXAaNVoQxMbnf7HOo9+uevM9EuW2CJWbh76Gnu18w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ue+Zsg+aHxkVlZDcResfbXU0BW6bW96I6vwIGPkWuc4UNCGY76NWHLJ8b9fdrpaWa
         Rkkb41xJx6UTpfeMrrOnffwCbmxAfKiN/NkYHHxFR1TAIhdwG5LygBDlJlCbZiFXk1
         rgtHYIQY9ssrwNr1hj5Y+/zUOJif/EJslTivWX2s=
From:   Andy Lutomirski <luto@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/3] x86/entry/64: Don't compile ignore_sysret if 32-bit emulation is enabled
Date:   Mon,  1 Jul 2019 20:43:20 -0700
Message-Id: <0f7dafa72fe7194689de5ee8cfe5d83509fabcf5.1562035429.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1562035429.git.luto@kernel.org>
References: <cover.1562035429.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's only used if !CONFIG_IA32_EMULATION, so disable it in normal
configs.  This will save a few bytes of text and reduce confusion.

Cc: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 7f9f5119d6b1..54b1b0468b2b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1743,11 +1743,17 @@ nmi_restore:
 	iretq
 END(nmi)
 
+#ifndef CONFIG_IA32_EMULATION
+/*
+ * This handles SYSCALL from 32-bit code.  There is no way to program
+ * MSRs to fully disable 32-bit SYSCALL.
+ */
 ENTRY(ignore_sysret)
 	UNWIND_HINT_EMPTY
 	mov	$-ENOSYS, %eax
 	sysret
 END(ignore_sysret)
+#endif
 
 ENTRY(rewind_stack_do_exit)
 	UNWIND_HINT_FUNC
-- 
2.21.0

