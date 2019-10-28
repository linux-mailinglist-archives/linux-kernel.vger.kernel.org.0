Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19210E77F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 18:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbfJ1R74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 13:59:56 -0400
Received: from smtprelay0173.hostedemail.com ([216.40.44.173]:44184 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729738AbfJ1R74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 13:59:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 559525DD5;
        Mon, 28 Oct 2019 17:59:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2828:2895:3138:3139:3140:3141:3142:3280:3354:3622:3865:3867:3868:3870:3872:3873:3874:4321:4362:4605:5007:6691:7974:9040:10004:10400:10848:11026:11232:11233:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:12986:13161:13229:13255:13439:14096:14097:14181:14659:14721:21080:21325:21433:21451:21627:30051:30054:30070:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:27,LUA_SUMMARY:none
X-HE-Tag: room92_5654232a53661
X-Filterd-Recvd-Size: 3478
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Oct 2019 17:59:53 +0000 (UTC)
Message-ID: <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
Subject: Re: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Mon, 28 Oct 2019 10:59:47 -0700
In-Reply-To: <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
         <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-28 at 18:37 +0100, Miguel Ojeda wrote:
> On Mon, Oct 28, 2019 at 12:43 PM Joe Perches <joe@perches.com> wrote:
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index 72393a..b8c2145 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -5,27 +5,27 @@
> >  #ifndef __ASSEMBLY__
> > 
> >  #ifdef __CHECKER__
> > -# define __user                __attribute__((noderef, address_space(1)))
[]
> Just in case: for these ones (i.e. __CHECKER__), did you check if
> sparse handles this syntax? (I don't recall myself if it does).
> 
> Other than that, thanks for the cleanup too! I can pick it up in the
> the compiler-attributes tree and put it in -next.

Thanks for asking and no, I did  not until just now.
Turns out sparse does _not_ handle these changes and
the checking fails for these __<changes>__.

sparse would have to update parse.c or the __CHECKER__
changes would need to be reverted.

Perhaps update parse.c like:
---
 parse.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/parse.c b/parse.c
index 48a63..4464e 100644
--- a/parse.c
+++ b/parse.c
@@ -549,13 +549,19 @@ static struct init_keyword {
 	{ "aligned",	NS_KEYWORD, .op = &aligned_op },
 	{ "__aligned__",NS_KEYWORD, .op = &aligned_op },
 	{ "nocast",	NS_KEYWORD,	MOD_NOCAST,	.op = &attr_mod_op },
+	{ "__nocast__",	NS_KEYWORD,	MOD_NOCAST,	.op = &attr_mod_op },
 	{ "noderef",	NS_KEYWORD,	MOD_NODEREF,	.op = &attr_mod_op },
+	{ "__noderef__",NS_KEYWORD,	MOD_NODEREF,	.op = &attr_mod_op },
 	{ "safe",	NS_KEYWORD,	MOD_SAFE, 	.op = &attr_mod_op },
+	{ "__safe__",	NS_KEYWORD,	MOD_SAFE, 	.op = &attr_mod_op },
 	{ "force",	NS_KEYWORD,	.op = &attr_force_op },
+	{ "__force__",	NS_KEYWORD,	.op = &attr_force_op },
 	{ "bitwise",	NS_KEYWORD,	MOD_BITWISE,	.op = &attr_bitwise_op },
 	{ "__bitwise__",NS_KEYWORD,	MOD_BITWISE,	.op = &attr_bitwise_op },
 	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
+	{ "__address_space__",NS_KEYWORD,	.op = &address_space_op },
 	{ "context",	NS_KEYWORD,	.op = &context_op },
+	{ "__context__",NS_KEYWORD,	.op = &context_op },
 	{ "designated_init",	NS_KEYWORD,	.op = &designated_init_op },
 	{ "__designated_init__",	NS_KEYWORD,	.op = &designated_init_op },
 	{ "transparent_union",	NS_KEYWORD,	.op = &transparent_union_op },


