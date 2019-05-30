Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B64592F708
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 07:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfE3FGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 01:06:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39285 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfE3FGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 01:06:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so3148438pfe.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=471RtXe1UXBWmO9V0tHQdL3qmf1+11dEHQ7BpybB+PE=;
        b=RI7EzQb/M/CcAHTc8S4WrXUzCm+WIGyI3SftLZJJnbXwcZhXORjprHP60+53pX00Ey
         rcnOE74/AAiNr3M3419C6MljaHWFaEriztx1L+8vNrMDfrLJwz6yRWbFvK0Sx2ZI6QzW
         2/KfLiMzKdxmhWoepoiZrWSyFnJgeaFSaRnyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=471RtXe1UXBWmO9V0tHQdL3qmf1+11dEHQ7BpybB+PE=;
        b=MIR0u65/xLzXX+2OZKzwFInJIafil7ib4ue3R/2WSFD+twZ33e+AGkrdFAKoameUgi
         qyX5Jy0rvi007ycgjOsaLpOzp79qPZCyAbVRUux29NiQ6zvoEGOBrFjbZ62Coo21d8Ge
         Fuz9UJCjX530wjeaq5G1O2CHgU3LZE0AgS76PoV5wRnY03ebuWeGRwhVJGOKMATFasN+
         fbppcVMsnU1cdDRv3ImQHz3IzmnnKFmK8vxfO8OL9PZ6XWvKahkm+512+0GXB9O2SwUR
         b0glr9mxibscQiZXsQ7ePga379xf3PJMmt5op3MCidiKsgt3nOlB0FuK/VGWhbiPHcv2
         p+xQ==
X-Gm-Message-State: APjAAAVJUXIILrVWdtSpHVidc3BTX8x/9ScmTxJabzr34dZJbXpqtXXE
        cJszns/UVLp/drw/T1tD1UbDmG7IHqk=
X-Google-Smtp-Source: APXvYqwX7bem3flmwMHVAUUo8QOnTzGP+RQylHxKnMa94V6FQv9HForlf84NLP6f2VgM4WxUoPrKyA==
X-Received: by 2002:a62:b40a:: with SMTP id h10mr1908195pfn.216.1559192772734;
        Wed, 29 May 2019 22:06:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h7sm1428273pfo.108.2019.05.29.22.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 22:06:11 -0700 (PDT)
Date:   Wed, 29 May 2019 22:06:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/kconfig: Fix neighboring typos
Message-ID: <201905292203.CD000546EB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a couple typos I noticed in the slab Kconfig:

	sacrifies -> sacrifices
	accellerate -> accelerate

Seeing as no other instances of these typos are found elsewhere in the
kernel and that I originally added one of the two, I can only assume
working on slab must have caused damage to the spelling centers of
my brain.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 init/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 4592bf7997c0..2dfb3d7f8079 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1750,7 +1750,7 @@ config SLAB_FREELIST_HARDENED
 	help
 	  Many kernel heap attacks try to target slab cache metadata and
 	  other infrastructure. This options makes minor performance
-	  sacrifies to harden the kernel slab allocator against common
+	  sacrifices to harden the kernel slab allocator against common
 	  freelist exploit methods.
 
 config SLUB_CPU_PARTIAL
@@ -1758,7 +1758,7 @@ config SLUB_CPU_PARTIAL
 	depends on SLUB && SMP
 	bool "SLUB per cpu partial cache"
 	help
-	  Per cpu partial caches accellerate objects allocation and freeing
+	  Per cpu partial caches accelerate objects allocation and freeing
 	  that is local to a processor at the price of more indeterminism
 	  in the latency of the free. On overflow these caches will be cleared
 	  which requires the taking of locks that may cause latency spikes.
-- 
2.17.1


-- 
Kees Cook
