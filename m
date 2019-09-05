Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D76AA5A6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbfIEOUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 10:20:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:47510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbfIEOUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:20:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5554AF92;
        Thu,  5 Sep 2019 14:20:11 +0000 (UTC)
Date:   Thu, 5 Sep 2019 16:20:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Tim Murray <timmurray@google.com>,
        carmenjackson@google.com, mayankgupta@google.com,
        dancol@google.com, rostedt@goodmis.org, minchan@kernel.org,
        akpm@linux-foundation.org, kernel-team@android.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jerome Glisse <jglisse@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
Message-ID: <20190905142010.GC3838@dhcp22.suse.cz>
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <20190904084508.GL3838@dhcp22.suse.cz>
 <20190904153258.GH240514@google.com>
 <20190904153759.GC3838@dhcp22.suse.cz>
 <20190904162808.GO240514@google.com>
 <20190905105424.GG3838@dhcp22.suse.cz>
 <20190905141452.GA26466@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905141452.GA26466@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-09-19 10:14:52, Joel Fernandes wrote:
> On Thu, Sep 05, 2019 at 12:54:24PM +0200, Michal Hocko wrote:
> > On Wed 04-09-19 12:28:08, Joel Fernandes wrote:
> > > On Wed, Sep 4, 2019 at 11:38 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Wed 04-09-19 11:32:58, Joel Fernandes wrote:
> > > > > On Wed, Sep 04, 2019 at 10:45:08AM +0200, Michal Hocko wrote:
> > > > > > On Tue 03-09-19 16:09:05, Joel Fernandes (Google) wrote:
> > > > > > > Useful to track how RSS is changing per TGID to detect spikes in RSS and
> > > > > > > memory hogs. Several Android teams have been using this patch in various
> > > > > > > kernel trees for half a year now. Many reported to me it is really
> > > > > > > useful so I'm posting it upstream.
> > > > > > >
> > > > > > > Initial patch developed by Tim Murray. Changes I made from original patch:
> > > > > > > o Prevent any additional space consumed by mm_struct.
> > > > > > > o Keep overhead low by checking if tracing is enabled.
> > > > > > > o Add some noise reduction and lower overhead by emitting only on
> > > > > > >   threshold changes.
> > > > > >
> > > > > > Does this have any pre-requisite? I do not see trace_rss_stat_enabled in
> > > > > > the Linus tree (nor in linux-next).
> > > > >
> > > > > No, this is generated automatically by the tracepoint infrastructure when a
> > > > > tracepoint is added.
> > > >
> > > > OK, I was not aware of that.
> > > >
> > > > > > Besides that why do we need batching in the first place. Does this have a
> > > > > > measurable overhead? How does it differ from any other tracepoints that we
> > > > > > have in other hotpaths (e.g.  page allocator doesn't do any checks).
> > > > >
> > > > > We do need batching not only for overhead reduction,
> > > >
> > > > What is the overhead?
> > > 
> > > The overhead is occasionally higher without the threshold (that is if we
> > > trace every counter change). I would classify performance benefit to be
> > > almost the same and within the noise.
> > 
> > OK, so the additional code is not really justified.
> 
> It is really justified. Did you read the whole of the last email?

Of course I have. The information that numbers are in noise with some
outliers (without any details about the underlying reason) is simply
showing that you are optimizing something probably not worth it.

I would recommend adding a simple tracepoint. That should be pretty non
controversial. And if you want to add an optimization on top then
provide data to justify it.
-- 
Michal Hocko
SUSE Labs
