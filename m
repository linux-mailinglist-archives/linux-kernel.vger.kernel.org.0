Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1911095021
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfHSVuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 17:50:07 -0400
Received: from smtprelay0191.hostedemail.com ([216.40.44.191]:53388 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728014AbfHSVuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:50:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id DE9FE181D33FC;
        Mon, 19 Aug 2019 21:50:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3622:3865:3867:3868:3870:3872:3873:3874:4250:4321:4605:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:21939:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: rail53_3ae65148ed028
X-Filterd-Recvd-Size: 1653
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 19 Aug 2019 21:50:04 +0000 (UTC)
Message-ID: <40b5fa3133c223d64050feb5ec530ce6f86d1601.camel@perches.com>
Subject: Re: [PATCH] afs: Move comments after /* fallthrough */
From:   Joe Perches <joe@perches.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck@google.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 19 Aug 2019 14:50:03 -0700
In-Reply-To: <30555.1566248610@warthog.procyon.org.uk>
References: <af4cbaaeb54589a5255bd39baf6bacc2b07bf7b5.camel@perches.com>
         <d98d1f0150bec8b69a886f77fc375b8ca9d24262.camel@perches.com>
         <e77b0f32a2ce97c872eede52c88b84aa78094ae5.1565836130.git.joe@perches.com>
         <12308.1565876416@warthog.procyon.org.uk>
         <13106.1565951791@warthog.procyon.org.uk>
         <30555.1566248610@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-19 at 22:03 +0100, David Howells wrote:
> Joe Perches <joe@perches.com> wrote:
> 
> >                 /* extract the FID array and its count in two steps */
> > -               /* fall through */
> > +               fallthrough;
> >         case 1:
> 
> Okay, that doesn't look too bad.  I thought you might be going to combine it
> with the case inside a macro in some way.

Does that mean you will apply this?


