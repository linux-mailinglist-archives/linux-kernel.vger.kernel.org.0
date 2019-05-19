Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4262022833
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2019 20:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfESSGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 May 2019 14:06:09 -0400
Received: from smtprelay0160.hostedemail.com ([216.40.44.160]:41984 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727623AbfESSGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 14:06:08 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id DC7AE182D7B29
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 05:07:55 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C7428837F24A;
        Sun, 19 May 2019 05:07:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 20,1.5,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2904:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3873:3874:4250:4321:5007:8957:9010:9012:10004:10026:10400:10848:11232:11658:11914:12043:12294:12296:12740:12760:12895:13069:13311:13357:13439:13868:13972:14096:14097:14181:14659:14721:14989:21080:21451:21611:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: money15_44f87b89aa330
X-Filterd-Recvd-Size: 1863
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun, 19 May 2019 05:07:53 +0000 (UTC)
Message-ID: <201b9ab622b8359225f3a3b673a05047ffce5744.camel@perches.com>
Subject: Re: [PATCH] scripts/spelling.txt: drop "sepc" from the misspelling
 list
From:   Joe Perches <joe@perches.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Date:   Sat, 18 May 2019 22:07:52 -0700
In-Reply-To: <20190518210037.13674-1-paul.walmsley@sifive.com>
References: <20190518210037.13674-1-paul.walmsley@sifive.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-18 at 14:00 -0700, Paul Walmsley wrote:
> The RISC-V architecture has a register named the "Supervisor Exception
> Program Counter", or "sepc".  This abbreviation triggers
> checkpatch.pl's misspelling detector, resulting in noise in the
> checkpatch output.  The risk that this noise could cause more useful
> warnings to be missed seems to outweigh the harm of an occasional
> misspelling of "spec".  Thus drop the "sepc" entry from the
> misspelling list.

I would agree if you first fixed the existing sepc/spec
and sepcific/specific typos.

arch/powerpc/kvm/book3s_xics.c:	 * a pending interrupt, this is a SW error and PAPR sepcifies
arch/unicore32/include/mach/regs-gpio.h: * Sepcial Voltage Detect Reg GPIO_GPIR.
drivers/net/wireless/realtek/rtlwifi/wifi.h:/* Ref: 802.11i sepc D10.0 7.3.2.25.1
drivers/scsi/lpfc/lpfc_init.c:		/* Stop any OneConnect device sepcific driver timers */
drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c:* OverView:	Read "sepcific bits" from BB register


