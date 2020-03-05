Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2CE17A904
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 16:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCEPjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 10:39:41 -0500
Received: from smtprelay0184.hostedemail.com ([216.40.44.184]:42472 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726048AbgCEPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:39:41 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id DAB2B1802558A;
        Thu,  5 Mar 2020 15:39:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1714:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:2894:3138:3139:3140:3141:3142:3351:3622:3865:3867:3868:3870:3872:4250:4321:4385:5007:6119:7903:10004:10400:10848:11026:11232:11658:11914:12294:12296:12297:12555:12740:12760:12895:12986:13019:13069:13311:13357:13439:14096:14097:14659:14721:21080:21451:21627:30003:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: coach66_70fd47f5d3b57
X-Filterd-Recvd-Size: 2111
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu,  5 Mar 2020 15:39:36 +0000 (UTC)
Message-ID: <31d1567c4c195f3bc5c6b610386cf0f559f9094f.camel@perches.com>
Subject: Re: [PATCH] sh: Stop printing the virtual memory layout
From:   Joe Perches <joe@perches.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Mar 2020 07:38:01 -0800
In-Reply-To: <f672417e-1323-4ef2-58a1-1158c482d569@physik.fu-berlin.de>
References: <202003021038.8F0369D907@keescook>
         <20200305151010.835954-1-nivedita@alum.mit.edu>
         <f672417e-1323-4ef2-58a1-1158c482d569@physik.fu-berlin.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-05 at 16:18 +0100, John Paul Adrian Glaubitz wrote:
> On 3/5/20 4:10 PM, Arvind Sankar wrote:
> > For security, don't display the kernel's virtual memory layout.
> > 
> > Kees Cook points out:
> > "These have been entirely removed on other architectures, so let's
> > just do the same for ia32 and remove it unconditionally."
> > 
> > 071929dbdd86 ("arm64: Stop printing the virtual memory layout")
> > 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
> > 31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
> > fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
> > adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")
> Aww, why wasn't this made configurable? I found these memory map printouts
> very useful for development.

It could be changed from pr_info to pr_devel.

A #define DEBUG would have to be added to emit it.



