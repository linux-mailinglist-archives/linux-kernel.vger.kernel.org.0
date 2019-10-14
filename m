Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13910D67C0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 18:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbfJNQyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 12:54:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:16851 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfJNQyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:54:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46sPlh5Rfnz9vBK2;
        Mon, 14 Oct 2019 18:53:52 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=smvGD9Gq; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mS0_ARcL3Rjz; Mon, 14 Oct 2019 18:53:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46sPlh3ySvz9vBJy;
        Mon, 14 Oct 2019 18:53:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1571072032; bh=F+FqcoHNzTzUli2Rd3wOSO58hJBknlQ50ktIOzFIMx0=;
        h=From:Subject:To:Cc:Date:From;
        b=smvGD9Gq+OGPg0XkhvxiDvGLTKuTFKYycUPbI8fZElapLKBIncGL56ViH2eptl89A
         nMQMMN8z1FnfbKTPosH20g+GYfevOwQtg0X4084aowt9U/JhV/IUOPiAWa7g1hKR3P
         TTaNZ3WS9F9fIxhjfXzmn3Jd3fdaqIDhNPv62cM4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 08C858B89C;
        Mon, 14 Oct 2019 18:53:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id H2ksinrXYDvu; Mon, 14 Oct 2019 18:53:57 +0200 (CEST)
Received: from po16098vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 808A38B88F;
        Mon, 14 Oct 2019 18:53:55 +0200 (CEST)
Received: by po16098vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B0F9668DED; Mon, 14 Oct 2019 16:51:28 +0000 (UTC)
Message-Id: <067a1b09f15f421d40797c2d04c22d4049a1cee8.1571071875.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32s: fix allow/prevent_user_access() when crossing
 segment boundaries.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 14 Oct 2019 16:51:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure starting addr is aligned to segment boundary so that when
incrementing the segment, the starting address of the new segment is
below the end address. Otherwise the last segment might get  missed.

Fixes: a68c31fc01ef ("powerpc/32s: Implement Kernel Userspace Access Protection")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/kup.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 677e9babef80..f9dc597b0b86 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -91,6 +91,7 @@
 
 static inline void kuap_update_sr(u32 sr, u32 addr, u32 end)
 {
+	addr &= 0xf0000000;	/* align addr to start of segment */
 	barrier();	/* make sure thread.kuap is updated before playing with SRs */
 	while (addr < end) {
 		mtsrin(sr, addr);
-- 
2.13.3

