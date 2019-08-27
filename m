Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FC09E382
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 11:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfH0JAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 05:00:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:52616 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726091AbfH0JAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:00:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03690AFCF;
        Tue, 27 Aug 2019 09:00:41 +0000 (UTC)
Date:   Tue, 27 Aug 2019 11:00:40 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH -mm] mm: account deferred split THPs into MemAvailable
Message-ID: <20190827090040.GU7538@dhcp22.suse.cz>
References: <1566410125-66011-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190822080434.GF12785@dhcp22.suse.cz>
 <9e4ba38e-0670-7292-ab3a-38af391598ec@linux.alibaba.com>
 <20190826074350.GE7538@dhcp22.suse.cz>
 <416daa85-44d4-1ef9-cc4c-6b91a8354c79@linux.alibaba.com>
 <20190827055941.GL7538@dhcp22.suse.cz>
 <20190827083215.lrgaonueazq7etl5@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827083215.lrgaonueazq7etl5@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-08-19 11:32:15, Kirill A. Shutemov wrote:
> On Tue, Aug 27, 2019 at 07:59:41AM +0200, Michal Hocko wrote:
> > > > > > IIUC deferred splitting is mostly a workaround for nasty locking issues
> > > > > > during splitting, right? This is not really an optimization to cache
> > > > > > THPs for reuse or something like that. What is the reason this is not
> > > > > > done from a worker context? At least THPs which would be freed
> > > > > > completely sound like a good candidate for kworker tear down, no?
> > > > > Yes, deferred split THP was introduced to avoid locking issues according to
> > > > > the document. Memcg awareness would help to trigger the shrinker more often.
> > > > > 
> > > > > I think it could be done in a worker context, but when to trigger to worker
> > > > > is a subtle problem.
> > > > Why? What is the problem to trigger it after unmap of a batch worth of
> > > > THPs?
> > > 
> > > This leads to another question, how many THPs are "a batch of worth"?
> > 
> > Some arbitrary reasonable number. Few dozens of THPs waiting for split
> > are no big deal. Going into GB as you pointed out above is definitely a
> > problem.
> 
> This will not work if these GBs worth of THPs are pinned (like with
> RDMA).

Yes, but this is the case we cannot do anything about in any deferred
scheme unless we hood into unpinning call path. We might get there
eventually with the newly forming api.

> We can kick the deferred split each N calls of deferred_split_huge_page()
> if more than M pages queued or something.

Yes, that sounds reasonable to me. N can be few dozens of THPs. An
explicit flush API after unmap is done would be helpful as well.

> Do we want to kick it again after some time if split from deferred queue
> has failed?

I wouldn't mind to have reclaim path do the fallback and see how that 

-- 
Michal Hocko
SUSE Labs
