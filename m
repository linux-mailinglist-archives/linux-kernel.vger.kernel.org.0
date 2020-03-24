Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E909119165D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgCXQ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:27:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgCXQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=m7GIWdVj/NEvdV02hRT9I7IOblpBtVvEgifUUc4ndo4=; b=gSjUcJf+2VKpCazqHLWR5+MARi
        UC5TsGNQ32+S7Yquf4FDVc8aDgiQvIqe5ArSSv8YexjObQPj6rkMkb36xy5adiui79fsDX1rrhLLT
        Cpv4oHJcdDWshfFxfIm2FYnTwZkvbXno90sn2Ob09sEXGHVrpISgc6UD+R77aFak80iPh8LpqNFwQ
        L77cZqOyL1Rd3+HTwYYghA+nqSThCZHUsYt8BdyUfIw0KZ3jZTTu3prygZYGIWQCnSZMKn/olHJ6D
        d/NWnUFmnREbGWpqXoE09FmbNR9jZ34b2XgloUNPzA7j+wTSYegv83CydmCY3mwsD5wO6jMVahZaw
        HYWWSKxg==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGmO9-0007eF-9U; Tue, 24 Mar 2020 16:26:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] sh: don't include <asm/io_trapped.h> in <asm/io.h>
Date:   Tue, 24 Mar 2020 17:26:29 +0100
Message-Id: <20200324162633.754714-7-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324162633.754714-1-hch@lst.de>
References: <20200324162633.754714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to expose the details of trapped I/O to drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/io.h | 1 -
 arch/sh/kernel/ioport.c  | 1 +
 arch/sh/mm/ioremap.c     | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 282ec476c06e..6beb55cadc21 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -22,7 +22,6 @@
 
 #define __IO_PREFIX     generic
 #include <asm/io_generic.h>
-#include <asm/io_trapped.h>
 #include <asm-generic/pci_iomap.h>
 #include <mach/mangle-port.h>
 
diff --git a/arch/sh/kernel/ioport.c b/arch/sh/kernel/ioport.c
index 34f8cdbbcf0b..f39446a658bd 100644
--- a/arch/sh/kernel/ioport.c
+++ b/arch/sh/kernel/ioport.c
@@ -7,6 +7,7 @@
  */
 #include <linux/module.h>
 #include <linux/io.h>
+#include <asm/io_trapped.h>
 
 unsigned long sh_io_port_base __read_mostly = -1;
 EXPORT_SYMBOL(sh_io_port_base);
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index a8170fa07bc1..3a13c1d3aa54 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/pci.h>
 #include <linux/io.h>
+#include <asm/io_trapped.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/addrspace.h>
-- 
2.25.1

