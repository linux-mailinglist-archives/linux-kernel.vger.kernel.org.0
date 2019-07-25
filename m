Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C65E07473D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 08:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfGYGeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 02:34:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfGYGeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MC0YAzXDv4UW9aVepSWPET61pXC/qRZc/Q3SPMyp+PQ=; b=Esvg+F9BiaNCjmiQCK2JehhcKp
        zzy3Y/xqfF/imbthCGLbTIxT3Yk8Wt0IkMCnilvmnai8L8kxBcHxe+90/LFQH8ZsHtzu/eIQsnC1W
        DozJci7ibHxEpCNTCY4Cpr6I7Z473YFnBurzqqnb8YDNS+RUWbKX30Woy0NcYDvlY3ibiH0+4Xdfe
        OrG5KvVCVdOzhc3p8y/dwnwNrFC4ooOKry7hSnvcsyyTdN6jJwdBFmHGfkZNFtKzoV07zerTAE3XT
        +z2o9T8m3oXqkvgtGiGPDCWimt7cBljnOF9pSkrcOO/KVXVLJHC9CHpBFnL+3W40Q99QqGijLsLaX
        0sRt7JDQ==;
Received: from p57b3f613.dip0.t-ipconnect.de ([87.179.246.19] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqXKJ-0000Fp-Pl; Thu, 25 Jul 2019 06:34:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Robin Murphy <robin.murphy@arm.com>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] m68knommu: add a pgprot_noncached stub
Date:   Thu, 25 Jul 2019 08:33:57 +0200
Message-Id: <20190725063401.29904-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725063401.29904-1-hch@lst.de>
References: <20190725063401.29904-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a pgprot_noncached like all the other nommu ports so that
common code can rely on it being able to be present.  Note that this is
generally code that is not actually run on nommu, but at least we can
avoid nasty ifdefs by having a stub.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/include/asm/pgtable_no.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
index fc3a96c77bd8..06194c7ba151 100644
--- a/arch/m68k/include/asm/pgtable_no.h
+++ b/arch/m68k/include/asm/pgtable_no.h
@@ -29,6 +29,8 @@
 #define PAGE_READONLY	__pgprot(0)
 #define PAGE_KERNEL	__pgprot(0)
 
+#define pgprot_noncached(prot)   (prot)
+
 extern void paging_init(void);
 #define swapper_pg_dir ((pgd_t *) 0)
 
-- 
2.20.1

