Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AECF37A51
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 18:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfFFQ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 12:56:26 -0400
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:56548 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725267AbfFFQ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:56:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 58A02180A8CDF;
        Thu,  6 Jun 2019 16:56:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::,RULES_HIT:41:69:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6742:7514:7576:7974:10007:10400:10848:11232:11658:11914:12043:12291:12295:12550:12683:12740:12895:13019:13439:13618:13894:14096:14097:14181:14659:14721:21080:21121:21325:21433:21451:21627:21740:30054:30055:30064:30090:30091,0,RBL:172.58.75.111:@perches.com:.lbl8.mailshell.net-62.14.0.180 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: nut86_1a1703edf4d45
X-Filterd-Recvd-Size: 3676
Received: from XPS-9350 (unknown [172.58.75.111])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Jun 2019 16:56:19 +0000 (UTC)
Message-ID: <8ce6c5322918828db16134b45d7b0d6b208f943d.camel@perches.com>
Subject: Re: [PATCH 2/5] mm/hmm: Clean up some coding style and comments
From:   Joe Perches <joe@perches.com>
To:     Jerome Glisse <jglisse@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     rcampbell@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 06 Jun 2019 09:55:49 -0700
In-Reply-To: <20190606155213.GB8053@redhat.com>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
         <20190506232942.12623-3-rcampbell@nvidia.com>
         <20190606141644.GA2876@ziepe.ca> <20190606142743.GA8053@redhat.com>
         <20190606154129.GB17373@ziepe.ca> <20190606155213.GB8053@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 11:52 -0400, Jerome Glisse wrote:
> On Thu, Jun 06, 2019 at 12:41:29PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 06, 2019 at 10:27:43AM -0400, Jerome Glisse wrote:
> > > On Thu, Jun 06, 2019 at 11:16:44AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, May 06, 2019 at 04:29:39PM -0700, rcampbell@nvidia.com wrote:
> > > > > From: Ralph Campbell <rcampbell@nvidia.com>
> > > > > 
> > > > > There are no functional changes, just some coding style clean ups and
> > > > > minor comment changes.
> > > > > 
> > > > > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > > > > Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> > > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > > Cc: Balbir Singh <bsingharora@gmail.com>
> > > > > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > Cc: Matthew Wilcox <willy@infradead.org>
> > > > > Cc: Souptick Joarder <jrdr.linux@gmail.com>
> > > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > >  include/linux/hmm.h | 71 +++++++++++++++++++++++----------------------
> > > > >  mm/hmm.c            | 51 ++++++++++++++++----------------
> > > > >  2 files changed, 62 insertions(+), 60 deletions(-)
> > > > 
> > > > Applied to hmm.git, thanks
> > > 
> > > 
> > > Can you hold off, i was already collecting patches and we will
> > > be stepping on each other toe ... for instance i had
> > 
> > I'd really rather not, I have a lot of work to do for this cycle and
> > this part needs to start to move forward now. I can't do everything
> > last minute, sorry.
> > 
> > The patches I picked up all look very safe to move ahead.
> 
> I want to post all the patch you need to apply soon, it is really
> painful because they are lot of different branches i have to work
> with if you start pulling patches that differ from the below branch
> then you are making thing ever more difficult for me.
> 
> If you hold of i will be posting all the patches in one big set so
> that you can apply all of them in one go and it will be a _lot_
> easier for me that way.

Easier for you is not necessarily easier for a community.
Publish early and often.



