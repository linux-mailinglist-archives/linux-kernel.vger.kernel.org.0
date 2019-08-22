Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DED798922
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 03:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbfHVBxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 21:53:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbfHVBxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 21:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xqDOeTURg2Fykia4WSTGNWpmrzbOKbwYtdB/Qwf+KBw=; b=ejWaZ6eMSPt9T1dbg58JdahPX
        60Y7JwFdDPkmME2rTj6HeYreNzSQ+S6997qmfQD6LXtlzLZ0grqssIDrpk7oRwgbj+pfXhgYFG5ey
        ZrV3p2O0bIKl1aRiJ8CgRs9GHwOZufC70HGnzJRB4IJz6Q36zXuD3jYrX3gAEbeHfQOe7Uqs/vsku
        lMeoznhrhnSH1tO1AuiEBpEpK3YIxKnojUebDSWV7ScQqoCs49lkycQkK/uxsCT7tGviaRnVP0wg1
        J/PYCrVG2tMIffKSzV2v264M6j9ZMVMst+cuwXh8+vrgopmaR+gNNCvdj7mZ2z9vorCZWloC8V4QG
        kg/cul7rQ==;
Received: from [199.255.47.11] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0cIL-0002mM-5Y; Thu, 22 Aug 2019 01:53:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     paulmck@linux.ibm.com, josh@joshtriplett.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: don't include <linux/ktime.h> in rcutiny.h
Date:   Thu, 22 Aug 2019 10:53:43 +0900
Message-Id: <20190822015343.4058-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kbuild reported a built failure due to a header loop when RCUTINY is
enabled with my pending riscv-nommu port.  Switch rcutiny.h to only
include the minimal required header to get HZ instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/rcutiny.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 8e727f57d814..9bf1dfe7781f 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -12,7 +12,7 @@
 #ifndef __LINUX_TINY_H
 #define __LINUX_TINY_H
 
-#include <linux/ktime.h>
+#include <asm/param.h> /* for HZ */
 
 /* Never flag non-existent other CPUs! */
 static inline bool rcu_eqs_special_set(int cpu) { return false; }
-- 
2.20.1

