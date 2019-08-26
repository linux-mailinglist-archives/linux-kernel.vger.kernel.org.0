Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440769CAD5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 09:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfHZHnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 03:43:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:59628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728198AbfHZHnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:43:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED493AE79;
        Mon, 26 Aug 2019 07:43:50 +0000 (UTC)
Date:   Mon, 26 Aug 2019 09:43:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        vbabka@suse.cz, rientjes@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH -mm] mm: account deferred split THPs into MemAvailable
Message-ID: <20190826074350.GE7538@dhcp22.suse.cz>
References: <1566410125-66011-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190822080434.GF12785@dhcp22.suse.cz>
 <9e4ba38e-0670-7292-ab3a-38af391598ec@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4ba38e-0670-7292-ab3a-38af391598ec@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-08-19 08:33:40, Yang Shi wrote:
> 
> 
> On 8/22/19 1:04 AM, Michal Hocko wrote:
> > On Thu 22-08-19 01:55:25, Yang Shi wrote:
[...]
> > > And, they seems very common with the common workloads when THP is
> > > enabled.  A simple run with MariaDB test of mmtest with THP enabled as
> > > always shows it could generate over fifteen thousand deferred split THPs
> > > (accumulated around 30G in one hour run, 75% of 40G memory for my VM).
> > > It looks worth accounting in MemAvailable.
> > OK, this makes sense. But your above numbers are really worrying.
> > Accumulating such a large amount of pages that are likely not going to
> > be used is really bad. They are essentially blocking any higher order
> > allocations and also push the system towards more memory pressure.
> 
> That is accumulated number, during the running of the test, some of them
> were freed by shrinker already. IOW, it should not reach that much at any
> given time.

Then the above description is highly misleading. What is the actual
number of lingering THPs that wait for the memory pressure in the peak?
 
> > IIUC deferred splitting is mostly a workaround for nasty locking issues
> > during splitting, right? This is not really an optimization to cache
> > THPs for reuse or something like that. What is the reason this is not
> > done from a worker context? At least THPs which would be freed
> > completely sound like a good candidate for kworker tear down, no?
> 
> Yes, deferred split THP was introduced to avoid locking issues according to
> the document. Memcg awareness would help to trigger the shrinker more often.
> 
> I think it could be done in a worker context, but when to trigger to worker
> is a subtle problem.

Why? What is the problem to trigger it after unmap of a batch worth of
THPs?
-- 
Michal Hocko
SUSE Labs
