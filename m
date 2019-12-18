Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23866123B70
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 01:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLRATE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 19:19:04 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40449 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLRATD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:19:03 -0500
Received: by mail-pj1-f67.google.com with SMTP id n67so11541pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=oCKoHe1lxe0PuESdkrD15D9EeMySLR5I9RS5subxYv0=;
        b=OegfkyV7Z/WtDb+kzEq9Eg6X6wokHNhhjYvhBDnSMS2oW/lTMraChWNqKy+XbjcIIY
         2MfUEgry3rg6wb+bxA+6yoLR4OrGRhso5ZNYnT0lxtpapggxOTQz8KvUWxwKpYORe89i
         Jgt3l36325rdKDMHTTa0ALUkIi1bMVszC0+Ts0a4HAE98jJ4RCmJcKNOXdvDo436tpvl
         g9vVGNdoQCXeNgxwNCNZzu8xIgSt32rFWKtjcqKL4Hd/iYRsRi5a4fLrxjrK5LYWs11q
         9qCa4vihhgMh80xY1DQY9w2T5tN88/Y1+w2lQuvATVGqc9VumhJ2JRawYCIOqd+yK64I
         +SaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oCKoHe1lxe0PuESdkrD15D9EeMySLR5I9RS5subxYv0=;
        b=CnOWEOMy9UcK53oMF7SXzWYhQaHMhW6rsWVdr72qVpPv+xAnQW+W9GrYAO7xB5lfjr
         HGkUXhqcqAdQ5LtOWp6x9t7tqc9mevuYKOljG6xBIfw0fugDSSmeK1cVzfuSn/TJjFHV
         S1VE2tVXGO3ETWQdiDWU+sUhMFw4rcSj1+gIGUbkDe0JA4jQi0tEQItTf40eQ/TrazOI
         zL6Mx7afZKzkNaQATAF3cBii7gI1KdIST8tXPCIc32FYHzSVshYjAH762DrFd9agLZUE
         wZ/GbRvzx6fxA4WNeqkZpuNwAkxXmXnns8kknzoPqxwpoNLG3yk2H+/XYYS4t597BTej
         PimA==
X-Gm-Message-State: APjAAAVyFmyi2lvo93pe5r3ZkM+uFr3DOucSCEtoC5cC2NH/tLsEVgCL
        9s3jdUbd7iyZWXe2HuaZIKy5Yg==
X-Google-Smtp-Source: APXvYqxB1waYmvRr3KkK8PGRDfUSYKoGNfyfaAZskT8PdRB1quQidke6t4GMeDoXYUzsHkF1aXKe1g==
X-Received: by 2002:a17:90a:e98d:: with SMTP id v13mr11895pjy.107.1576628342864;
        Tue, 17 Dec 2019 16:19:02 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id k190sm152197pga.73.2019.12.17.16.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 16:19:01 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@armlinux.co.uk, Olof Johansson <olof@lixom.net>
Subject: [PATCH] ARM: mm: mark free_memmap as __init
Date:   Tue, 17 Dec 2019 16:18:49 -0800
Message-Id: <20191218001849.41415-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
forcibly"), free_memmap() might not always be inlined, and thus is
triggering a section warning:

WARNING: vmlinux.o(.text.unlikely+0x904): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free()

Mark it as __init, since the faller (free_unused_memmap) already is.

Fixes: ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")
Signed-off-by: Olof Johansson <olof@lixom.net>
---
KernelVersion: v5.5-rc2

 arch/arm/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 3ef204137e732..054be44d1cdb4 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -324,7 +324,7 @@ static inline void poison_init_mem(void *s, size_t count)
 		*p++ = 0xe7fddef0;
 }
 
-static inline void
+static inline void __init
 free_memmap(unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct page *start_pg, *end_pg;
-- 
2.11.0

