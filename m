Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9436B5FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 07:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfGQFfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 01:35:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:60774 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfGQFfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:35:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1366AC84;
        Wed, 17 Jul 2019 05:35:22 +0000 (UTC)
Date:   Wed, 17 Jul 2019 07:35:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, catalin.marinas@arm.com,
        dvyukov@google.com, rientjes@google.com, willy@infradead.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "kmemleak: allow to coexist with fault injection"
Message-ID: <20190717053521.GC16284@dhcp22.suse.cz>
References: <1563299431-111710-1-git-send-email-yang.shi@linux.alibaba.com>
 <1563301410.4610.8.camel@lca.pw>
 <a198d00d-d1f4-0d73-8eb8-6667c0bdac04@linux.alibaba.com>
 <1563304877.4610.10.camel@lca.pw>
 <20190716200715.GA14663@dhcp22.suse.cz>
 <1563308901.4610.12.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563308901.4610.12.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-07-19 16:28:21, Qian Cai wrote:
> On Tue, 2019-07-16 at 22:07 +0200, Michal Hocko wrote:
> > On Tue 16-07-19 15:21:17, Qian Cai wrote:
> > [...]
> > > Thanks to this commit, there are allocation with __GFP_DIRECT_RECLAIM that
> > > succeeded would keep trying with __GFP_NOFAIL for kmemleak tracking object
> > > allocations.
> > 
> > Well, not really. Because low order allocations with
> > __GFP_DIRECT_RECLAIM basically never fail (they keep retrying) even
> > without GFP_NOFAIL because that flag is actually to guarantee no
> > failure. And for high order allocations the nofail mode is actively
> > harmful. It completely changes the behavior of a system. A light costly
> > order workload could put the system on knees and completely change the
> > behavior. I am not really convinced this is a good behavior of a
> > debugging feature TBH.
> 
> While I agree your general observation about GFP_NOFAIL, I am afraid the
> discussion here is about "struct kmemleak_object" slab cache from a single call
> site create_object(). 

OK, this makes it less harmfull because the order aspect doesn't really
apply here. But still stretches the NOFAIL semantic a lot. The kmemleak
essentially asks for NORETRY | NOFAIL which means no oom but retry for
ever semantic for sleeping allocations. This can still lead to
unexpected side effects. Just consider a call site that holds locks and
now cannot make any forward progress without anybody else hitting the
oom killer for example. As noted in other email, I would simply drop
NORETRY flag as well and live with the fact that the oom killer can be
invoked. It still wouldn't solve the NOWAIT contexts but those need a
proper solution anyway.
-- 
Michal Hocko
SUSE Labs
