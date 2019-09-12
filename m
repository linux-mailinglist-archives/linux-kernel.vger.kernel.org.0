Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D86B123C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbfILPeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 11:34:31 -0400
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:35895 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732699AbfILPeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 11:34:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id E876C18224D65;
        Thu, 12 Sep 2019 15:34:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2691:2828:2829:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3874:4321:5007:6119:7903:8603:8908:9010:10004:10400:10562:10848:11026:11232:11658:11914:12050:12297:12740:12760:12895:13069:13095:13311:13357:13439:14096:14097:14181:14659:14721:14777:21080:21433:21627:21819:30022:30054:30070:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: room66_4419114b8213b
X-Filterd-Recvd-Size: 2754
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 15:34:27 +0000 (UTC)
Message-ID: <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
From:   Joe Perches <joe@perches.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Tobin C. Harding" <me@tobin.cc>
Date:   Thu, 12 Sep 2019 08:34:26 -0700
In-Reply-To: <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
         <yq1o8zqeqhb.fsf@oracle.com> <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 14:31 +0100, Bart Van Assche wrote:
> On 9/11/19 5:40 PM, Martin K. Petersen wrote:
> > * Do not use custom To: and Cc: for individual patches. We want to see the
> >   whole series, even patches that potentially need to go through a different
> >   subsystem tree.

That's not currently feasible when cc'ing any vger.kernel.org list
as those lists have a maximum email header size and patches that
span multiple subsystems can have very long to: and cc: lists.

> > * The patch must compile without warnings (make C=1 CF="-D__CHECK_ENDIAN__")
> >   and does not incur any zeroday test robot complaints.
> 
> How about adding W=1 to that make command?

That's rather too compiler version dependent and new
warnings frequently get introduced by new compiler versions.

> How about existing drivers that trigger tons of endianness warnings,
> e.g. qla2xxx? How about requiring that no new warnings are introduced?

Adding a sparse clean C=2 requirement might be useful.

> > * The patch must have a commit message that describes, comprehensively and in
> >   plain English, what the patch does.
> 
> How about making this requirement more detailed and requiring that not
> only what has been changed is document but also why that change has been
> made?

I believe the "why" is rather more important than the "how"
and should be the primary thing described in the commit message.


