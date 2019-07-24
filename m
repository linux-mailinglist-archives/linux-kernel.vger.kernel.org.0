Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2A0C73165
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfGXORO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 10:17:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbfGXORM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:17:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42C0BAFD4;
        Wed, 24 Jul 2019 14:17:11 +0000 (UTC)
Date:   Wed, 24 Jul 2019 16:17:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     YueHaibing <yuehaibing@huawei.com>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        yang.shi@linux.alibaba.com, jannh@google.com, walken@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/mmap.c: silence variable 'new_start' set but not used
Message-ID: <20190724141710.GD5584@dhcp22.suse.cz>
References: <20190724140739.59532-1-yuehaibing@huawei.com>
 <1563977465.11067.9.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1563977465.11067.9.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-07-19 10:11:05, Qian Cai wrote:
> On Wed, 2019-07-24 at 22:07 +0800, YueHaibing wrote:
> > 'new_start' is used in is_hugepage_only_range(),
> > which do nothing in some arch. gcc will warning:
> > 
> > mm/mmap.c: In function acct_stack_growth:
> > mm/mmap.c:2311:16: warning: variable new_start set but not used [-Wunused-but-
> > set-variable]
> 
> Nope. Convert them to inline instead.

Agreed. Obfuscating the code is not really something we want.

> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  mm/mmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index e2dbed3..56c2a92 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2308,7 +2308,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
> >  			     unsigned long size, unsigned long grow)
> >  {
> >  	struct mm_struct *mm = vma->vm_mm;
> > -	unsigned long new_start;
> > +	unsigned long __maybe_unused new_start;
> >  
> >  	/* address space limit tests */
> >  	if (!may_expand_vm(mm, vma->vm_flags, grow))

-- 
Michal Hocko
SUSE Labs
