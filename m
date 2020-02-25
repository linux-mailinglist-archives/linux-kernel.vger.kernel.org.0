Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7B16B59D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 00:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgBXXb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 18:31:58 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40657 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbgBXXbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:31:55 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48RJHY3J95z9sQx; Tue, 25 Feb 2020 10:31:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582587113;
        bh=eU9PRGdwkqGR+XaxfNgvc4i2nXKN+QYEl3ouFzBRDbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDw4UtfhFG6qv243lzcRBOUEyawDqK8JQT0PoAmzWj2xLYda6U2gHJTQJxFZw5+af
         Ob0oWDBa4owzV9XVP4vVbJDMY5uVniDVn8wiVmZXD1aVlx0INVZhEWVsXFeeC5lKoP
         KQE9Mo0HkNJp7E7mGwcahgz0vvsjnrvF6t6YVjYbCfmjAVktC4DqfaT6zpjdONjT4r
         bbLrhNNurvRv8QiU/38xvRwgECTZoq7WDnu7BN3AVVlMO0Tjx/WzWYR1Gnoy6u57z1
         gL+NVpCoTyoM71QhSqBjsavrqbig+hbjJH1pK3vDVfBK3L8ZwxpH0/KGzXhfeXOpQz
         45SQ7Lzyjd6pw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 6/8] powerpc: Update MPC5XXX MAINTAINERS entry
Date:   Tue, 25 Feb 2020 10:31:44 +1100
Message-Id: <20200224233146.23734-6-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200224233146.23734-1-mpe@ellerman.id.au>
References: <20200224233146.23734-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's several years since the last commit from Anatolij, so mark
MPC5XXX as "Odd Fixes" rather than "Maintained".

Also the git link no longer works so remove it.

Cc: Anatolij Gustschin <agust@denx.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5db5cac5a39..a46e19aadcbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9639,8 +9639,7 @@ N:	pseries
 LINUX FOR POWERPC EMBEDDED MPC5XXX
 M:	Anatolij Gustschin <agust@denx.de>
 L:	linuxppc-dev@lists.ozlabs.org
-T:	git git://git.denx.de/linux-denx-agust.git
-S:	Maintained
+S:	Odd Fixes
 F:	arch/powerpc/platforms/512x/
 F:	arch/powerpc/platforms/52xx/
 
-- 
2.21.1

