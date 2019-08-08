Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8E3086913
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 20:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390249AbfHHSxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 14:53:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732758AbfHHSxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:53:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B533AFD4;
        Thu,  8 Aug 2019 18:53:15 +0000 (UTC)
Date:   Thu, 8 Aug 2019 20:53:13 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Cyril Hrubis <chrubis@suse.cz>, xishi.qiuxishi@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlbfs: fix hugetlb page migration/fault race causing
 SIGBUS
Message-ID: <20190808185313.GG18351@dhcp22.suse.cz>
References: <20190808000533.7701-1-mike.kravetz@oracle.com>
 <20190808074607.GI11812@dhcp22.suse.cz>
 <20190808074736.GJ11812@dhcp22.suse.cz>
 <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416ee59e-9ae8-f72d-1b26-4d3d31501330@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-08-19 09:55:45, Mike Kravetz wrote:
> On 8/8/19 12:47 AM, Michal Hocko wrote:
> > On Thu 08-08-19 09:46:07, Michal Hocko wrote:
> >> On Wed 07-08-19 17:05:33, Mike Kravetz wrote:
> >>> Li Wang discovered that LTP/move_page12 V2 sometimes triggers SIGBUS
> >>> in the kernel-v5.2.3 testing.  This is caused by a race between hugetlb
> >>> page migration and page fault.
> <snip>
> >>> Reported-by: Li Wang <liwang@redhat.com>
> >>> Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
> >>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>> Tested-by: Li Wang <liwang@redhat.com>
> >>
> >> Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > Btw. is this worth marking for stable? I haven't seen it triggering
> > anywhere but artificial tests. On the other hand the patch is quite
> > straightforward so it shouldn't hurt in general.
> 
> I don't think this really is material for stable.  I added the tag as the
> stable AI logic seems to pick up patches whether marked for stable or not.
> For example, here is one I explicitly said did not need to go to stable.
> 
> https://lkml.org/lkml/2019/6/1/165
> 
> Ironic to find that commit message in a stable backport.
> 
> I'm happy to drop the Fixes tag.

No, please do not drop the Fixes tag. That is a very _useful_
information. If the stable tree maintainers want to abuse it so be it.
They are responsible for their tree. If you do not think this is a
stable material then fine with me. I tend to agree but that doesn't mean
that we should obfuscate Fixes.

-- 
Michal Hocko
SUSE Labs
