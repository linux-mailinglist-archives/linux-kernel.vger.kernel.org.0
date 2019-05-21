Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEAD52498A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfEUH5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 03:57:43 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:37087 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbfEUH5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:57:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EA649180178A1;
        Tue, 21 May 2019 07:57:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:421:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3874:4321:5007:6120:7901:7903:10004:10400:10848:11232:11658:11914:12043:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:21080:21627:30054:30060:30090:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.8.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: sort67_430d7b49e2635
X-Filterd-Recvd-Size: 1832
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 May 2019 07:57:40 +0000 (UTC)
Message-ID: <38aa2fcceaf7c2c7c6cd7c3abe2999fe7ef98a44.camel@perches.com>
Subject: Re: [PATCH] powerpc/mm: mark more tlb functions as __always_inline
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 21 May 2019 00:57:39 -0700
In-Reply-To: <CAK7LNAQNp+wsvNK84oYcGwR24=Kf=_N8WJdyZ2aUL9T3qDsVsA@mail.gmail.com>
References: <20190521061659.6073-1-yamada.masahiro@socionext.com>
         <16d967dd-9f8f-4e9e-97fd-3f9761e5d97c@c-s.fr>
         <CAK7LNAQNp+wsvNK84oYcGwR24=Kf=_N8WJdyZ2aUL9T3qDsVsA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-21 at 16:27 +0900, Masahiro Yamada wrote:
> On Tue, May 21, 2019 at 3:54 PM Christophe Leroy
> > powerpc accepts lines up to 90 chars, see arch/powerpc/tools/checkpatch.pl
> 
> Ugh, I did not know this. Horrible.
> 
> The Linux coding style should be global in the kernel tree.
> No subsystem should adopts its own coding style.

I don't see a problem using 90 column lines by arch/<foo>

There are other subsystem specific variations like the net/

	/* multiline comments without initial blank comment lines
	 * look like this...
	 */

If there were arch specific drivers with style variations
in say drivers/net, then that might be more of an issue.

