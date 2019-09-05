Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FE5AA624
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 16:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389160AbfIEOnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 10:43:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:37644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726080AbfIEOnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:43:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABAC9B0BA;
        Thu,  5 Sep 2019 14:43:11 +0000 (UTC)
Date:   Thu, 5 Sep 2019 16:43:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20190905144310.GA14491@dhcp22.suse.cz>
References: <20190903200905.198642-1-joel@joelfernandes.org>
 <20190904084508.GL3838@dhcp22.suse.cz>
 <20190904153258.GH240514@google.com>
 <20190904153759.GC3838@dhcp22.suse.cz>
 <20190904162808.GO240514@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904162808.GO240514@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Add Steven]

On Wed 04-09-19 12:28:08, Joel Fernandes wrote:
> On Wed, Sep 4, 2019 at 11:38 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 04-09-19 11:32:58, Joel Fernandes wrote:
[...]
> > > but also for reducing
> > > tracing noise. Flooding the traces makes it less useful for long traces and
> > > post-processing of traces. IOW, the overhead reduction is a bonus.
> >
> > This is not really anything special for this tracepoint though.
> > Basically any tracepoint in a hot path is in the same situation and I do
> > not see a point why each of them should really invent its own way to
> > throttle. Maybe there is some way to do that in the tracing subsystem
> > directly.
> 
> I am not sure if there is a way to do this easily. Add to that, the fact that
> you still have to call into trace events. Why call into it at all, if you can
> filter in advance and have a sane filtering default?
> 
> The bigger improvement with the threshold is the number of trace records are
> almost halved by using a threshold. The number of records went from 4.6K to
> 2.6K.

Steven, would it be feasible to add a generic tracepoint throttling?
-- 
Michal Hocko
SUSE Labs
