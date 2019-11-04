Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB86FEEFF6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 23:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbfKDWYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 17:24:43 -0500
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:48872 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729795AbfKDWYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:24:36 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E4CF6182CF668;
        Mon,  4 Nov 2019 22:24:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2553:2559:2562:2689:2692:2828:3138:3139:3140:3141:3142:3352:3622:3865:3868:3871:3872:4250:4321:4605:5007:7809:7904:10004:10400:10848:11232:11658:11914:12043:12297:12555:12740:12760:12895:13069:13311:13357:13439:13523:13524:14096:14097:14181:14659:14721:21080:21627:21796:30036:30054:30060:30080:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: end02_27dc66145ce01
X-Filterd-Recvd-Size: 2071
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 Nov 2019 22:24:33 +0000 (UTC)
Message-ID: <46615f063c973eee649e3fdb8261978102c89108.camel@perches.com>
Subject: Re: spdxcheck.py complains about the second OR?
From:   Joe Perches <joe@perches.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-spdx@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 04 Nov 2019 14:24:23 -0800
In-Reply-To: <alpine.DEB.2.21.1911042310040.17054@nanos.tec.linutronix.de>
References: <CAK7LNASwF9y+MkhkvCRATu0qXSJkxx8fZ-DUjQTfWOi9+1YrfQ@mail.gmail.com>
         <alpine.DEB.2.21.1911042310040.17054@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-04 at 23:11 +0100, Thomas Gleixner wrote:
> On Fri, 1 Nov 2019, Masahiro Yamada wrote:
> > scripts/spdxcheck.py warns the following two files.
> > 
> > $ ./scripts/spdxcheck.py
> > drivers/net/ethernet/pensando/ionic/ionic_if.h: 1:52 Syntax error: OR
> > drivers/net/ethernet/pensando/ionic/ionic_regs.h: 1:52 Syntax error: OR
> > 
> > I do not understand what is wrong with them.
> > 
> > I think "A OR B OR C" is sane.
> 
> Yes it is, but obviously we did not expect files with 3 possible
> alternative licenses.

Perhaps just this, but the generic logic
obviously isn't complete.
---
 scripts/spdxcheck.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py
index 6374e0..00be34 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -150,6 +150,7 @@ class id_parser(object):
                 | ID WITH EXC
                 | expr AND expr
                 | expr OR expr
+                | expr OR expr OR expr
                 | LPAR expr RPAR'''
         pass
 


