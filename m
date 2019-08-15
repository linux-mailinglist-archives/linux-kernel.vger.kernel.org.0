Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7308E732
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 10:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbfHOIqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 04:46:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:41802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfHOIqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:46:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F4BCAF0D;
        Thu, 15 Aug 2019 08:46:34 +0000 (UTC)
Date:   Thu, 15 Aug 2019 10:46:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2 -mm] mm: account lazy free pages separately
Message-ID: <20190815084633.GF9477@dhcp22.suse.cz>
References: <1565308665-24747-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190809083216.GM18351@dhcp22.suse.cz>
 <1a3c4185-c7ab-8d6f-8191-77dce02025a7@linux.alibaba.com>
 <20190809180238.GS18351@dhcp22.suse.cz>
 <79c90f6b-fcac-02e1-015a-0eaa4eafdf7d@linux.alibaba.com>
 <fb1f4958-5147-2fab-531f-d234806c2f37@linux.alibaba.com>
 <20190812093430.GD5117@dhcp22.suse.cz>
 <297aefa2-ba64-cb91-d2c8-733054db01a3@linux.alibaba.com>
 <20190814110850.GT17933@dhcp22.suse.cz>
 <a8005ff4-4749-8c71-ee4e-7ebda5c49de6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8005ff4-4749-8c71-ee4e-7ebda5c49de6@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-08-19 21:51:47, Yang Shi wrote:
> 
> 
> On 8/14/19 4:08 AM, Michal Hocko wrote:
> > On Mon 12-08-19 10:00:17, Yang Shi wrote:
> > > 
> > > On 8/12/19 2:34 AM, Michal Hocko wrote:
> > > > On Fri 09-08-19 16:54:43, Yang Shi wrote:
> > > > > On 8/9/19 11:26 AM, Yang Shi wrote:
> > > > > > On 8/9/19 11:02 AM, Michal Hocko wrote:
> > > > [...]
> > > > > > > I have to study the code some more but is there any reason why those
> > > > > > > pages are not accounted as proper THPs anymore? Sure they are partially
> > > > > > > unmaped but they are still THPs so why cannot we keep them accounted
> > > > > > > like that. Having a new counter to reflect that sounds like papering
> > > > > > > over the problem to me. But as I've said I might be missing something
> > > > > > > important here.
> > > > > > I think we could keep those pages accounted for NR_ANON_THPS since they
> > > > > > are still THP although they are unmapped as you mentioned if we just
> > > > > > want to fix the improper accounting.
> > > > > By double checking what NR_ANON_THPS really means,
> > > > > Documentation/filesystems/proc.txt says "Non-file backed huge pages mapped
> > > > > into userspace page tables". Then it makes some sense to dec NR_ANON_THPS
> > > > > when removing rmap even though they are still THPs.
> > > > > 
> > > > > I don't think we would like to change the definition, if so a new counter
> > > > > may make more sense.
> > > > Yes, changing NR_ANON_THPS semantic sounds like a bad idea. Let
> > > > me try whether I understand the problem. So we have some THP in
> > > > limbo waiting for them to be split and unmapped parts to be freed,
> > > > right? I can see that page_remove_anon_compound_rmap does correctly
> > > > decrement NR_ANON_MAPPED for sub pages that are no longer mapped by
> > > > anybody. LRU pages seem to be accounted properly as well.  As you've
> > > > said NR_ANON_THPS reflects the number of THPs mapped and that should be
> > > > reflecting the reality already IIUC.
> > > > 
> > > > So the only problem seems to be that deferred THP might aggregate a lot
> > > > of immediately freeable memory (if none of the subpages are mapped) and
> > > > that can confuse MemAvailable because it doesn't know about the fact.
> > > > Has an skewed counter resulted in a user observable behavior/failures?
> > > No. But the skewed counter may make big difference for a big scale cluster.
> > > The MemAvailable is an important factor for cluster scheduler to determine
> > > the capacity.
> > But MemAvailable is a very rough estimation. Is relying on it really a
> > good measure? I mean there is a lot of reclaimable memory that is not
> > reflected there (some fs. internal data structures, networking buffers
> > etc.)
> 
> Yes, I agree there are other freeable objects not accounted into
> MemAvailable. Their size depends on the workload. But, deferred split THPs
> seems more common with the common workloads. A simple run with MariaDB test
> of mmtest shows it could generate over fifteen thousand deferred split THPs
> (accumulated around 30G in one hour run, 75% of 40G memory for my VM). So,
> it may be worth accounting deferred split THPs in MemAvailable.

This is a very useful information to put into the changelog.

-- 
Michal Hocko
SUSE Labs
