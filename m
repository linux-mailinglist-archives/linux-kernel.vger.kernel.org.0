Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8848C15167E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 08:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBDHhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 02:37:55 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55499 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgBDHhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:37:55 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Bc404254z9vC1Z;
        Tue,  4 Feb 2020 08:37:52 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=YJvzz9xk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 36ijhWjZF_9L; Tue,  4 Feb 2020 08:37:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Bc402ltrz9vC1c;
        Tue,  4 Feb 2020 08:37:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580801872; bh=2rd8qlLlpkX1BdaONPB2UupCXZuKoBgAK38pBszsWNk=;
        h=From:Subject:To:Cc:Date:From;
        b=YJvzz9xkMOFYsr6EVEph5R1Myd4IiyaKhRFL67S2BQUsqvlgCqfz66/3auiBINhmM
         mJ3yt6dXJV6UpkZeUFB3+XRdJKyi/L2WgqMUqbdqxn41K4F2kSN3j02BFZ8M4bonOg
         AouTrITGEKao7/tBHhmeuoRrUk5oCB94TXvcyfQA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 51D8C8B7B6;
        Tue,  4 Feb 2020 08:37:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id T9QVY0qwbEkJ; Tue,  4 Feb 2020 08:37:53 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0ABF68B755;
        Tue,  4 Feb 2020 08:37:53 +0100 (CET)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8AEA7652B3; Tue,  4 Feb 2020 07:37:52 +0000 (UTC)
Message-Id: <f96ed94dc57ea810b738c4e02263e08c2c8781b6.1580801787.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  4 Feb 2020 07:37:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures like powerpc64 have the capability to separate
read access and write access protection.
For get_user() and copy_from_user(), powerpc64 only open read access.
For put_user() and copy_to_user(), powerpc64 only open write access.
But when using unsafe_get_user() or unsafe_put_user(),
user_access_begin open both read and write.

In order to avoid any risk based of hacking some variable parameters
passed to user_access_begin/end that would allow hacking and
leaving user access open or opening too much, it is preferable to
use dedicated static functions that can't be overridden.

Add a user_read_access_begin and user_read_access_end to only open
read access.

Add a user_write_access_begin and user_write_access_end to only open
write access.

By default, when undefined, those new access helpers default on the
existing user_access_begin and user_access_end.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 include/linux/uaccess.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 67f016010aad..9861c89f93be 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -378,6 +378,14 @@ extern long strnlen_unsafe_user(const void __user *unsafe_addr, long count);
 static inline unsigned long user_access_save(void) { return 0UL; }
 static inline void user_access_restore(unsigned long flags) { }
 #endif
+#ifndef user_write_access_begin
+#define user_write_access_begin user_access_begin
+#define user_write_access_end user_access_end
+#endif
+#ifndef user_read_access_begin
+#define user_read_access_begin user_access_begin
+#define user_read_access_end user_access_end
+#endif
 
 #ifdef CONFIG_HARDENED_USERCOPY
 void usercopy_warn(const char *name, const char *detail, bool to_user,
-- 
2.25.0

