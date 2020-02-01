Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBDDC14F5D1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 02:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgBABwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 20:52:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgBABwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 20:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cWI5O2cv+SeehZ9KuYC3J+GruZ97y+6ngsaLCn03r54=; b=Q6XHR6t45O7XpvUbyEbEUFjde
        Gma0A+VGZJ3dz7NdLu04brCnvedzP+ot5Cmm07EAcBkqSd/ezAObJ0V9tAwKZx/z2PsILNmOWySU7
        U1p6FVo/1vYdGHJnBFG6tp+BZy5mp1aMweny5MYoPnrk22nVN6NF91k3X0WGws+P1XuOLmvhKUiws
        xJA3svr5btcjL+e8DXr5RsTwMFzL5pe8L32PNzG1/pvizbvVypPb0z/K8MztjBLxK5WKg5YsMbp/l
        G5QTchdlGobhev/MBrPkxpS0Z5Ufe1+1aBTR/39pXk4hxeAoINoxgkACesqcbTjJZFnNAE1vxyquo
        zytcPJrSw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixhxX-0005ol-8s; Sat, 01 Feb 2020 01:52:31 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/csky: fix some Kconfig typos
Message-ID: <c554f9e8-fdc7-ada3-8b6e-70a3f3aef89f@infradead.org>
Date:   Fri, 31 Jan 2020 17:52:30 -0800
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

Fix wording in help text for the CPU_HAS_LDSTEX symbol.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
---
 arch/csky/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200131.orig/arch/csky/Kconfig
+++ linux-next-20200131/arch/csky/Kconfig
@@ -77,7 +77,7 @@ config CPU_HAS_TLBI
 config CPU_HAS_LDSTEX
 	bool
 	help
-	  For SMP, CPU needs "ldex&stex" instrcutions to atomic operations.
+	  For SMP, CPU needs "ldex&stex" instructions for atomic operations.
 
 config CPU_NEED_TLBSYNC
 	bool

