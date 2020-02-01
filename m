Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71ACD14F5C7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Feb 2020 02:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBABtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 20:49:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52214 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgBABtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 20:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=17fdwoTs7zyvxcbFHKjA+/Q+sSClqbZYiDlG6cIBJHs=; b=XAOPtE7vYPkWgdWpCpqHBo0XE
        za8ECBsVRuW44tdDssxs1Qk5BiQwae/f5hL0hsPDOjxgZVmUr+CwLtzVmDfKEVFgixapQFjFhkwpE
        /7QHzqBJYKi/VxdY92pCgeGXa8o0yIc/adpg4tnK+OTIP5SnAOwFMbbA+izWxAU0lbemcUrK0VekM
        Xx3WxOgYyjHBHChrTstV40hQnStwxCPlUIhjQtzXI/k7LLbaUlCD7p8+APidm95qCJKPqLaAdf5jx
        iJzWZOUovpvcSw50jjwCyJHzyfFgoXNGKD8eZNdWnPvInD12gpVLb3r7iSWoYWXFmJU/2vWCxmw3f
        QcBZ56YOg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixhuh-0004Go-8P; Sat, 01 Feb 2020 01:49:35 +0000
To:     Vineet Gupta <vgupta@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] arch/arc: fix some Kconfig typos
Message-ID: <cbd02a9e-5529-1054-957f-766072496009@infradead.org>
Date:   Fri, 31 Jan 2020 17:49:33 -0800
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

Fix language typos in arch/arc/Kconfig.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200131.orig/arch/arc/Kconfig
+++ linux-next-20200131/arch/arc/Kconfig
@@ -154,7 +154,7 @@ config ARC_CPU_HS
 	help
 	  Support for ARC HS38x Cores based on ARCv2 ISA
 	  The notable features are:
-	    - SMP configurations of upto 4 core with coherency
+	    - SMP configurations of up to 4 cores with coherency
 	    - Optional L2 Cache and IO-Coherency
 	    - Revised Interrupt Architecture (multiple priorites, reg banks,
 	        auto stack switch, auto regfile save/restore)
@@ -192,7 +192,7 @@ config ARC_SMP_HALT_ON_RESET
 	help
 	  In SMP configuration cores can be configured as Halt-on-reset
 	  or they could all start at same time. For Halt-on-reset, non
-	  masters are parked until Master kicks them so they can start of
+	  masters are parked until Master kicks them so they can start off
 	  at designated entry point. For other case, all jump to common
 	  entry point and spin wait for Master's signal.
 

