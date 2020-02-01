Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0EE14F5DA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 02:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgBAB5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 20:57:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgBAB5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 20:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NCZT6F0OZBbEmQvGzy3muvrfvpDV7Xo7WQ7COpovKnE=; b=iFff6DneIlw/FZCsZIiW7nf+/
        5wyqhIPTNXRLj3XWq7qALkhTrCvROVIThJFj1QXE51LKoeSj3h9UKFWzt791dflIosIz1MkUBQd82
        GBRePw84ae0r6UUK27AaaODdnS8IYogXPJRHDDNY4zCtdIqRjOjNFEcHFRums745nY7XREN7u3Tr3
        57NQyE4BCJ7/sggAw0qlJzoZV2vLwV1HtCfx4lB7bN4AKoZlcfBeYnOJyArpxU7fQsflX4SQj65TD
        jT3YoKCdE3FZWbwhAb9Xv55dOIxuOm+V2GI0NZBuXJm+ojETnJGaqLks2hFt2xpriN+ZOlOXbvk79
        0RHi4pUHw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixi2j-0007Xe-OD; Sat, 01 Feb 2020 01:57:54 +0000
To:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/sh: add hyphenation in NUMA Kconfig prompt
Message-ID: <6bae5963-2696-024d-b993-695367a1009c@infradead.org>
Date:   Fri, 31 Jan 2020 17:57:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Hyphenate Non-Uniform in the NUMA kconfig prompt.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/mm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200131.orig/arch/sh/mm/Kconfig
+++ linux-next-20200131/arch/sh/mm/Kconfig
@@ -107,7 +107,7 @@ config VSYSCALL
 	  (the default value) say Y.
 
 config NUMA
-	bool "Non Uniform Memory Access (NUMA) Support"
+	bool "Non-Uniform Memory Access (NUMA) Support"
 	depends on MMU && SYS_SUPPORTS_NUMA
 	select ARCH_WANT_NUMA_VARIABLE_LOCALITY
 	default n


