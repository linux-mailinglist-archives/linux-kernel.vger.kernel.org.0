Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A367153EE1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 07:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgBFGsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 01:48:46 -0500
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:42253 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726538AbgBFGsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:48:46 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 8AD8818029154;
        Thu,  6 Feb 2020 06:48:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3873:3874:4321:4605:5007:6119:7774:9121:10004:10400:10432:10433:10450:10455:11232:11233:11658:11914:12043:12262:12296:12297:12438:12679:12740:12760:12895:13069:13072:13161:13229:13311:13357:13439:13846:14096:14097:14181:14659:14721:14777:19903:19904:19997:19999:21080:21365:21433:21451:21611:21627:21819:30003:30022:30029:30054:30064:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wax40_6955ca1ea6d28
X-Filterd-Recvd-Size: 2208
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Feb 2020 06:48:43 +0000 (UTC)
Message-ID: <973a8964e7d8b8a98ec34c4efa8e2726cd88013a.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Remove uses of P: for maintainer name
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Feb 2020 22:47:32 -0800
In-Reply-To: <CAPcyv4g65_Jxv3GUHsTtH6KmR=AYbx4s+TAC+tLE8YeLNiH8pw@mail.gmail.com>
References: <ca53823fc5d25c0be32ad937d0207a0589c08643.camel@perches.com>
         <CAPcyv4g65_Jxv3GUHsTtH6KmR=AYbx4s+TAC+tLE8YeLNiH8pw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-05 at 20:14 -0800, Dan Williams wrote:
> On Wed, Feb 5, 2020 at 7:23 PM Joe Perches <joe@perches.com> wrote:
> > commit 1ca84ed6425f ("MAINTAINERS: Reclaim the P: tag for
> > Maintainer Entry Profile") changed the use of the "P:" tag
> > from "Person" to "Profile (ie: special subsystem coding styles
> > and characteristics)"
> > 
> > Change how get_maintainer.pl parses the "P:" tag to match.
> 
> Looks ok to me:
> 
> Acked-by: Dan Williams <dan.j.william@intel.com>
> 
> ...although I was not able to trigger any unexpected results running
> against drivers/nvdimm/.

Because there aren't any entries like

P:	First Last
M:	maintainer@domain.tld

where the name was a P: entry and the
email address was on the next line.

That was the form before 2009, but there
were still a few entries until you changed
them recently.

A long time ago:

commit 8b58be884a9fd650abb7f7adf3f885fb9cecd79d
Author: Joe Perches <joe@perches.com>
Date:   Wed Jul 29 15:04:30 2009 -0700

    MAINTAINERS: coalesce name and email address lines
    
    Switch the MAINTAINERS email address format from
    
    P:      Linus Torvalds
    M:      torvalds@linux-foundation.org
    
    to
    
    M:      Linus Torvalds <torvalds@linux-foundation.org>


