Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF9CCBA5C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfJDM1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 08:27:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:52720 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730101AbfJDM1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:27:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7EC52AD14;
        Fri,  4 Oct 2019 12:27:28 +0000 (UTC)
Date:   Fri, 4 Oct 2019 14:27:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap: piggyback lru_add_drain_all() calls
Message-ID: <20191004122727.GA10845@dhcp22.suse.cz>
References: <157018386639.6110.3058050375244904201.stgit@buzz>
 <20191004121017.GG32665@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004121017.GG32665@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-10-19 05:10:17, Matthew Wilcox wrote:
> On Fri, Oct 04, 2019 at 01:11:06PM +0300, Konstantin Khlebnikov wrote:
> > This is very slow operation. There is no reason to do it again if somebody
> > else already drained all per-cpu vectors after we waited for lock.
> > +	seq = raw_read_seqcount_latch(&seqcount);
> > +
> >  	mutex_lock(&lock);
> > +
> > +	/* Piggyback on drain done by somebody else. */
> > +	if (__read_seqcount_retry(&seqcount, seq))
> > +		goto done;
> > +
> > +	raw_write_seqcount_latch(&seqcount);
> > +
> 
> Do we really need the seqcount to do this?  Wouldn't a mutex_trylock()
> have the same effect?

Yeah, this makes sense. From correctness point of view it should be ok
because no caller can expect that per-cpu pvecs are empty on return.
This might have some runtime effects that some paths might retry more -
e.g. offlining path drains pcp pvces before migrating the range away, if
there are pages still waiting for a worker to drain them then the
migration would fail and we would retry. But this not a correctness
issue.

-- 
Michal Hocko
SUSE Labs
