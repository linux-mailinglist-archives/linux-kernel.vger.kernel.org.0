Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE7AAD4F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 10:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389367AbfIIIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 04:37:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:47682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727003AbfIIIht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 04:37:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E10FFAC37;
        Mon,  9 Sep 2019 08:37:47 +0000 (UTC)
Date:   Mon, 9 Sep 2019 10:37:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <20190909083747.GD27159@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1909041252230.94813@chino.kir.corp.google.com>
 <CAHk-=wjmF_MGe5sBDmQB1WGpr+QFWkqboHpL37JYB5WgnG8nMA@mail.gmail.com>
 <alpine.DEB.2.21.1909051345030.217933@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909071249180.81471@chino.kir.corp.google.com>
 <CAHk-=wifuQ68e6Q4F2txGS48WgcoX2REE4te5_j36ypV-T2ZKw@mail.gmail.com>
 <alpine.DEB.2.21.1909071829440.200558@chino.kir.corp.google.com>
 <d76f8cc3-97aa-8da5-408d-397467ea768b@suse.cz>
 <alpine.DEB.2.21.1909081328220.178796@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909081328220.178796@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 08-09-19 13:45:13, David Rientjes wrote:
> If the reverts to 5.3 are not 
> applied, then I'm not at all confident that forward progress on this issue 
> will be made:

David, could you stop this finally? I think there is a good consensus
that the current (even after reverts) behavior is not going all the way
down where we want to get. There have been different ways forward
suggested to not fallback to remote nodes too easily, not to mention
a specialized memory policy to explicitly request the behavior you
presumably need (and as a bonus it wouldn't be THP specific which is
even better).

You seem to be deadlocked in "we've used to do something for 4 years
so we must preserve that behavior". All that based on a single and
odd workload which you are hand waving about without anything for
the rest of the community to reproduce. Please try to get out of the
argumentation loop. We are more likely to make a forward progress.

5.3 managed to fix the worst case behavior, now let's talk about more
clever tuning. You cannot expect such a tuning is an overnight work.
This area is full of subtle side effects and few liners might have hard
to predict consequences.
-- 
Michal Hocko
SUSE Labs
