Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF52630AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 08:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfGIGeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 02:34:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:33428 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbfGIGeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:34:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25E42AC90;
        Tue,  9 Jul 2019 06:34:04 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH] x86/irq: fix ENDPROC of common_spurious
Date:   Tue,  9 Jul 2019 08:34:02 +0200
Message-Id: <20190709063402.19847-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

common_spurious is currently ENDed erroneously. common_interrupt is used
in its ENDPROC. So fix this mistake.

Found by my asm macros rewrite patchset.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Fixes: f8a8fe61fec8 ("x86/irq: Seperate unused system vectors from
	spurious entry again")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/entry/entry_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 1285e5abf669..90b473297299 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1189,7 +1189,7 @@ common_spurious:
 	movl	%esp, %eax
 	call	smp_spurious_interrupt
 	jmp	ret_from_intr
-ENDPROC(common_interrupt)
+ENDPROC(common_spurious)
 #endif
 
 /*
-- 
2.22.0

