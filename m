Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 941E087259
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405511AbfHIGqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 02:46:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:36588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726233AbfHIGqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:46:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C910BB03B;
        Fri,  9 Aug 2019 06:46:34 +0000 (UTC)
Date:   Fri, 9 Aug 2019 08:46:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it,
        Li Wang <liwang@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Cyril Hrubis <chrubis@suse.cz>, xishi.qiuxishi@alibaba-inc.com
Subject: Re: [PATCH] hugetlbfs: fix hugetlb page migration/fault race causing
 SIGBUS
Message-ID: <20190809064633.GK18351@dhcp22.suse.cz>
References: <20190808000533.7701-1-mike.kravetz@oracle.com>
 <20190808074607.GI11812@dhcp22.suse.cz>
 <20190808074736.GJ11812@dhcp22.suse.cz>
 <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
 <20190808185313.GG18351@dhcp22.suse.cz>
 <20190808163928.118f8da4f4289f7c51b8ffd4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808163928.118f8da4f4289f7c51b8ffd4@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-08-19 16:39:28, Andrew Morton wrote:
> On Thu, 8 Aug 2019 20:53:13 +0200 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > > https://lkml.org/lkml/2019/6/1/165
> > > 
> > > Ironic to find that commit message in a stable backport.
> > > 
> > > I'm happy to drop the Fixes tag.
> > 
> > No, please do not drop the Fixes tag. That is a very _useful_
> > information. If the stable tree maintainers want to abuse it so be it.
> > They are responsible for their tree. If you do not think this is a
> > stable material then fine with me. I tend to agree but that doesn't mean
> > that we should obfuscate Fixes.
> 
> Well, we're responsible for stable trees too.

We are only responsible as far as to consider whether a patch is worth
backporting to stable trees and my view is that we are doing that
responsible. What do stable maintainers do in the end is their business.

> And yes, I find it
> irksome.  I/we evaluate *every* fix for -stable inclusion and if I/we
> decide "no" then dangit, it should be backported.

Exactly

> Maybe we should introduce the Fixes-no-stable: tag.  That should get
> their attention.

No please, Fixes shouldn't be really tight to any stable tree rules. It
is a very useful indication of which commit has introduced bug/problem
or whatever that the patch follows up to. We in Suse are using this tag
to evaluate potential fixes as the stable is not reliable. We could live
with Fixes-no-stable or whatever other name but does it really makes
sense to complicate the existing state when stable maintainers are doing
whatever they want anyway? Does a tag like that force AI from selecting
a patch? I am not really convinced.

-- 
Michal Hocko
SUSE Labs
