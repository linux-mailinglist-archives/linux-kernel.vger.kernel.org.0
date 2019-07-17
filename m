Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526E56C04F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 19:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbfGQRWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 13:22:41 -0400
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:53567 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727260AbfGQRWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:22:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C9C23181D33FC;
        Wed, 17 Jul 2019 17:22:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:3874:4321:5007:9010:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:21080:21627:30054:30091,0,RBL:23.242.196.136:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:28,LUA_SUMMARY:none
X-HE-Tag: cream96_17037daa23b2d
X-Filterd-Recvd-Size: 2239
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 17 Jul 2019 17:22:37 +0000 (UTC)
Message-ID: <18469f4c80f3dbf04eda5415f4bcf1c8fa655370.camel@perches.com>
Subject: Re: [PATCH v8 4/5] x86/paravirt: Remove const mark from
 x86_hyper_xen_hvm variable
From:   Joe Perches <joe@perches.com>
To:     Juergen Gross <jgross@suse.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, sstabellini@kernel.org, x86@kernel.org,
        tglx@linutronix.de, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, mingo@redhat.com
Date:   Wed, 17 Jul 2019 10:22:36 -0700
In-Reply-To: <d4be507a-aa31-9ba3-9bf0-c8b60ec3f93a@suse.com>
References: <1563251169-30740-1-git-send-email-zhenzhong.duan@oracle.com>
         <9791d12717bba784f24f35c29ddfaab9ccb78965.camel@perches.com>
         <d4be507a-aa31-9ba3-9bf0-c8b60ec3f93a@suse.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-17 at 08:49 +0200, Juergen Gross wrote:
> On 17.07.19 08:46, Joe Perches wrote:
> > On Tue, 2019-07-16 at 12:26 +0800, Zhenzhong Duan wrote:
> > > .. as "nopv" support needs it to be changeable at boot up stage.
> > > 
> > > Checkpatch reports warning, so move variable declarations from
> > > hypervisor.c to hypervisor.h
> > []
> > > diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
> > []
> > > @@ -259,7 +259,7 @@ static __init void xen_hvm_guest_late_init(void)
> > >   #endif
> > >   }
> > >   
> > > -const __initconst struct hypervisor_x86 x86_hyper_xen_hvm = {
> > > +struct hypervisor_x86 x86_hyper_xen_hvm __initdata = {
> > 
> > static?
> 
> It is being referenced from arch/x86/kernel/cpu/hypervisor.c

But wasn't it also removed from the list of externs?

Rereading the .h file, no it wasn't.  I missed that.

Perhaps the extern list could be reordered to move this
x86_hyper_xen_hvm to be next to x86_hyper_type.

I also suggest that "extern bool nopv" might be a bit
non-specific and could use a longer identifier.


