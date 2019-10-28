Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52A18E7C59
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 23:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfJ1W20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 18:28:26 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:44446 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726510AbfJ1W20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:28:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 914C78384360;
        Mon, 28 Oct 2019 22:28:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:334:355:368:369:379:599:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2196:2198:2199:2200:2393:2553:2559:2562:2828:2895:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4385:4605:5007:6119:6691:7875:7974:9040:10004:10400:10848:11026:11232:11658:11914:12043:12297:12438:12555:12663:12740:12760:12895:12986:13161:13229:13255:13439:14096:14097:14659:14721:21080:21325:21433:21451:21627:21740:21741:30054:30070:30089:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: crown52_665b347525d29
X-Filterd-Recvd-Size: 4204
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 28 Oct 2019 22:28:23 +0000 (UTC)
Message-ID: <00c5ef125a4e62f538de7ddddc9d8fe7085794a3.camel@perches.com>
Subject: Re: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
From:   Joe Perches <joe@perches.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-sparse@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Mon, 28 Oct 2019 15:28:17 -0700
In-Reply-To: <20191028221523.vlzdk6dkcglxei6v@desk.local>
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
         <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
         <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
         <20191028221523.vlzdk6dkcglxei6v@desk.local>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-28 at 23:15 +0100, Luc Van Oostenryck wrote:
> On Mon, Oct 28, 2019 at 10:59:47AM -0700, Joe Perches wrote:
> > On Mon, 2019-10-28 at 18:37 +0100, Miguel Ojeda wrote:
> > > Just in case: for these ones (i.e. __CHECKER__), did you check if
> > > sparse handles this syntax? (I don't recall myself if it does).
> > > 
> > > Other than that, thanks for the cleanup too! I can pick it up in the
> > > the compiler-attributes tree and put it in -next.
> > 
> > Thanks for asking and no, I did  not until just now.
> > Turns out sparse does _not_ handle these changes and
> > the checking fails for these __<changes>__.
> > 
> > sparse would have to update parse.c or the __CHECKER__
> > changes would need to be reverted.
> > 
> > Perhaps update parse.c like:
> 
> ...
> 
> Yes, this was missing. Thanks.
> Can I have your SoB for this?

I'm not sure this actually works as there's
some possible sparse parsing changes in the
use of __context__.

There is a difference in linux compilation of
a defconfig output with sparse output of init/
with the new parse.c 

old:

$ make clean ; make C=1 init > old 2>&1

(recompile sparse with changes above)

new:

$ make clean ; make C=1 init > new 2>&1

$ diff -urN old new
--- old	2019-10-28 15:20:00.524678375 -0700
+++ new	2019-10-28 15:21:14.004674721 -0700
@@ -55,7 +55,25 @@
   CHK     include/generated/compile.h
   CHECK   init/main.c
 init/main.c:173:12: warning: symbol 'envp_init' was not declared. Should it be static?
+./include/linux/rcupdate.h:598:9: error: undefined identifier '__context__'
+./include/linux/rcupdate.h:651:9: error: undefined identifier '__context__'
+./include/linux/rcupdate.h:598:9: error: not a function <noident>
+./include/linux/rcupdate.h:598:9: error: undefined identifier 'RCU'
+./include/linux/rcupdate.h:651:9: error: not a function <noident>
+./include/linux/rcupdate.h:651:9: error: undefined identifier 'RCU'
 init/main.c:506:20: warning: symbol 'mem_encrypt_init' was not declared. Should it be static?
+./include/linux/rcupdate.h:716:9: error: undefined identifier '__context__'
+./include/linux/rcupdate.h:736:9: error: undefined identifier '__context__'
+./include/linux/rcupdate.h:716:9: error: not a function <noident>
+./include/linux/rcupdate.h:716:9: error: undefined identifier 'RCU_SCHED'
+./include/linux/rcupdate.h:736:9: error: not a function <noident>
+./include/linux/rcupdate.h:736:9: error: undefined identifier 'RCU_SCHED'
+./include/linux/rcupdate.h:716:9: error: not a function <noident>
+./include/linux/rcupdate.h:736:9: error: not a function <noident>
+./include/linux/rcupdate.h:716:9: error: not a function <noident>
+./include/linux/rcupdate.h:736:9: error: not a function <noident>
+./include/linux/spinlock.h:211:9: error: undefined identifier '__context__'
+init/main.c:1222:9: warning: context imbalance in 'kernel_init_freeable' - wrong count at exit
   CC      init/main.o
   CHECK   init/version.c
   CC      init/version.o

