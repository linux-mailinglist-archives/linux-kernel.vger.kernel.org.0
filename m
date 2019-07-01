Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD512776C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 09:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfEWHts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 03:49:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfEWHtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wWU2/ZcIvaZLxR1lu0OL6bskmNcVChQrVDukB7aBvq0=; b=PRlxrwyf03cYYF5YnQkZUY9nqI
        S/VqKVe4MWCQqKC4H/T1THKyp/fQAA3p+rdte7nijCwajE+AX/15mkMTawApdO/avsh5Sn8/TBsJU
        vhgGzTOy5d7sPj3huOy83wcYCOCz5A5lFAjNtKpOiZU/PizFcAdJEz9sfovtlNWQZLxj4SF/Ab2/D
        Nli9Evvpwh+WU319kdcoYPMKUIYaW1LGY1pI0VWOgdYHjqk1GhpOWPMzKX5am0cnHdFDL/N2lwepY
        uzZ/EvKkOUQESfpYsrc/VkW9hK1CaQELzuU6vSVMP3BZBPv8Ec8rO8z4wP2PQczp3MwWJAYCL0qtp
        TC/8YxXg==;
Received: from 213-225-10-46.nat.highway.a1.net ([213.225.10.46] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTiTp-00043w-4v; Thu, 23 May 2019 07:49:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] powerpc/powernv: remove the unused vas_win_paste_addr and vas_win_id functions
Date:   Thu, 23 May 2019 09:49:24 +0200
Message-Id: <20190523074924.19659-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523074924.19659-1-hch@lst.de>
References: <20190523074924.19659-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two function have never been used since they were added to the
kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/vas.h              | 10 ----------
 arch/powerpc/platforms/powernv/vas-window.c | 19 -------------------
 arch/powerpc/platforms/powernv/vas.h        | 20 --------------------
 3 files changed, 49 deletions(-)

diff --git a/arch/powerpc/include/asm/vas.h b/arch/powerpc/include/asm/vas.h
index 771456227496..9b5b7261df7b 100644
--- a/arch/powerpc/include/asm/vas.h
+++ b/arch/powerpc/include/asm/vas.h
@@ -167,14 +167,4 @@ int vas_copy_crb(void *crb, int offset);
  */
 int vas_paste_crb(struct vas_window *win, int offset, bool re);
 
-/*
- * Return a system-wide unique id for the VAS window @win.
- */
-extern u32 vas_win_id(struct vas_window *win);
-
-/*
- * Return the power bus paste address associated with @win so the caller
- * can map that address into their address space.
- */
-extern u64 vas_win_paste_addr(struct vas_window *win);
 #endif /* __ASM_POWERPC_VAS_H */
diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
index e59e0e60e5b5..e48c44cb3a16 100644
--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -44,16 +44,6 @@ static void compute_paste_address(struct vas_window *window, u64 *addr, int *len
 	pr_debug("Txwin #%d: Paste addr 0x%llx\n", winid, *addr);
 }
 
-u64 vas_win_paste_addr(struct vas_window *win)
-{
-	u64 addr;
-
-	compute_paste_address(win, &addr, NULL);
-
-	return addr;
-}
-EXPORT_SYMBOL(vas_win_paste_addr);
-
 static inline void get_hvwc_mmio_bar(struct vas_window *window,
 			u64 *start, int *len)
 {
@@ -1268,12 +1258,3 @@ int vas_win_close(struct vas_window *window)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vas_win_close);
-
-/*
- * Return a system-wide unique window id for the window @win.
- */
-u32 vas_win_id(struct vas_window *win)
-{
-	return encode_pswid(win->vinst->vas_id, win->winid);
-}
-EXPORT_SYMBOL_GPL(vas_win_id);
diff --git a/arch/powerpc/platforms/powernv/vas.h b/arch/powerpc/platforms/powernv/vas.h
index f5493dbdd7ff..551affaddd59 100644
--- a/arch/powerpc/platforms/powernv/vas.h
+++ b/arch/powerpc/platforms/powernv/vas.h
@@ -448,26 +448,6 @@ static inline u64 read_hvwc_reg(struct vas_window *win,
 	return in_be64(win->hvwc_map+reg);
 }
 
-/*
- * Encode/decode the Partition Send Window ID (PSWID) for a window in
- * a way that we can uniquely identify any window in the system. i.e.
- * we should be able to locate the 'struct vas_window' given the PSWID.
- *
- *	Bits	Usage
- *	0:7	VAS id (8 bits)
- *	8:15	Unused, 0 (3 bits)
- *	16:31	Window id (16 bits)
- */
-static inline u32 encode_pswid(int vasid, int winid)
-{
-	u32 pswid = 0;
-
-	pswid |= vasid << (31 - 7);
-	pswid |= winid;
-
-	return pswid;
-}
-
 static inline void decode_pswid(u32 pswid, int *vasid, int *winid)
 {
 	if (vasid)
-- 
2.20.1

