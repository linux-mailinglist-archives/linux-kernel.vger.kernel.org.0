Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B907F00DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 16:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389716AbfKEPLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 10:11:06 -0500
Received: from smtprelay0144.hostedemail.com ([216.40.44.144]:34153 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389546AbfKEPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:11:06 -0500
X-Greylist: delayed 73910 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Nov 2019 10:11:05 EST
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id CFE671801DC08;
        Tue,  5 Nov 2019 15:11:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 40,2.5,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2194:2198:2199:2200:2393:2551:2553:2559:2562:2689:2692:2693:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3871:3872:3873:4250:4321:4605:5007:6117:6119:6238:7576:7809:7904:9010:9165:9545:10011:10400:11232:11658:11914:12043:12050:12297:12555:12740:12760:12895:13095:13161:13229:13436:13439:13972:14096:14097:14181:14659:14721:14877:21080:21433:21451:21627:21740:21796:30003:30036:30048:30054:30055:30060:30063:30080:30090:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:25,LUA_SUMMARY:none
X-HE-Tag: chalk38_6091a4e45df63
X-Filterd-Recvd-Size: 3595
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Nov 2019 15:11:03 +0000 (UTC)
Message-ID: <ec20c751ac1e4156aca0b02dfa0cef4b70cb8ec5.camel@perches.com>
Subject: Re: spdxcheck.py complains about the second OR?
From:   Joe Perches <joe@perches.com>
To:     "Zavras, Alexios" <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 05 Nov 2019 07:10:52 -0800
In-Reply-To: <CY4PR1101MB2360AB7647D9E2FA15044EE4897E0@CY4PR1101MB2360.namprd11.prod.outlook.com>
References: <CAK7LNASwF9y+MkhkvCRATu0qXSJkxx8fZ-DUjQTfWOi9+1YrfQ@mail.gmail.com>
         <alpine.DEB.2.21.1911042310040.17054@nanos.tec.linutronix.de>
         <46615f063c973eee649e3fdb8261978102c89108.camel@perches.com>
         <CY4PR1101MB2360AB7647D9E2FA15044EE4897E0@CY4PR1101MB2360.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-05 at 10:11 +0000, Zavras, Alexios wrote:
> This is not correct.
> Since the grammar includes the production "expr: expr OR expr",
> there is absolutely no need to add a rule with more than two operands --
> it will be handled recursively.

You sure about the recursion?

It does work and spdxcheck no longer emits a message for
these two files.

> -- zvr
> 
> -----Original Message-----
> From: linux-spdx-owner@vger.kernel.org <linux-spdx-owner@vger.kernel.org> On Behalf Of Joe Perches
> Sent: Monday, 4 November, 2019 23:24
> To: Thomas Gleixner <tglx@linutronix.de>; Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-spdx@vger.kernel.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: spdxcheck.py complains about the second OR?
> 
> On Mon, 2019-11-04 at 23:11 +0100, Thomas Gleixner wrote:
> > On Fri, 1 Nov 2019, Masahiro Yamada wrote:
> > > scripts/spdxcheck.py warns the following two files.
> > > 
> > > $ ./scripts/spdxcheck.py
> > > drivers/net/ethernet/pensando/ionic/ionic_if.h: 1:52 Syntax error: 
> > > OR
> > > drivers/net/ethernet/pensando/ionic/ionic_regs.h: 1:52 Syntax error: 
> > > OR
> > > 
> > > I do not understand what is wrong with them.
> > > 
> > > I think "A OR B OR C" is sane.
> > 
> > Yes it is, but obviously we did not expect files with 3 possible 
> > alternative licenses.
> 
> Perhaps just this, but the generic logic obviously isn't complete.
> ---
>  scripts/spdxcheck.py | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py index 6374e0..00be34 100755
> --- a/scripts/spdxcheck.py
> +++ b/scripts/spdxcheck.py
> @@ -150,6 +150,7 @@ class id_parser(object):
>                  | ID WITH EXC
>                  | expr AND expr
>                  | expr OR expr
> +                | expr OR expr OR expr
>                  | LPAR expr RPAR'''
>          pass
>  
> 
> 
> Intel Deutschland GmbH
> Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
> Tel: +49 89 99 8853-0, www.intel.de
> Managing Directors: Christin Eisenschmid, Gary Kershaw
> Chairperson of the Supervisory Board: Nicole Lau
> Registered Office: Munich
> Commercial Register: Amtsgericht Muenchen HRB 186928
> 

