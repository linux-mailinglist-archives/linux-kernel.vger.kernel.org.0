Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7419C11542F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2019 16:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLFP0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Dec 2019 10:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfLFP0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:26:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F26E24670;
        Fri,  6 Dec 2019 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575645962;
        bh=fqycieHlI+As5koAnAyKvNZuwJaNdCV5a0O0yQxQtLE=;
        h=Date:From:To:Subject:From;
        b=RxwXcPsYC46P3i/aZhSAhdB8NDkHoAkuIi3GPKLsTZBZPlseynv82fLq5iGlbzxuO
         hopxdfEJyDKTwJSI98YcTdbikq/KUVkly1xJjE9PrvqH/hvW6EqIF6L9qRmipPCbL1
         b8FnfL1Rb8dbWBeVokJvsmwC8p1UwLCS/JUMZOSw=
Date:   Fri, 6 Dec 2019 16:26:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib: raid6: fix awk build warnings
Message-ID: <20191206152600.GA75093@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer versions of awk spit out these fun warnings:
	awk: ../lib/raid6/unroll.awk:16: warning: regexp escape sequence `\#' is not a known regexp operator

As commit 700c1018b86d ("x86/insn: Fix awk regexp warnings") showed, it
turns out that there are a number of awk strings that do not need to be
escaped and newer versions of awk now warn about this.

Fix the string up so that no warning is produced.  The exact same kernel
module gets created before and after this patch, showing that it wasn't
needed.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/raid6/unroll.awk |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/raid6/unroll.awk
+++ b/lib/raid6/unroll.awk
@@ -13,7 +13,7 @@ BEGIN {
 	for (i = 0; i < rep; ++i) {
 		tmp = $0
 		gsub(/\$\$/, i, tmp)
-		gsub(/\$\#/, n, tmp)
+		gsub(/\$#/, n, tmp)
 		gsub(/\$\*/, "$", tmp)
 		print tmp
 	}
