Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE881174B15
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 05:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCAEkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Feb 2020 23:40:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgCAEkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 23:40:01 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E9A721744;
        Sun,  1 Mar 2020 04:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583037600;
        bh=gobused7njiojKjjqHPxsxE2sYg6sCzrDITBeT2chUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kOBtoWw+pxLOXT1F1ojHWEG/BsRFH4DkCpCzD+woTNzE3ZsGY0Gtfdg9TG7vGfEJF
         P6jY+hSeTZ3Gx/tEdeUBTasBiKIk50O2k6Wj5l4qcb3G+UTR0rvclOL+qgUqj632xi
         HIBld3Epnf9/SaD3mBpezZ+KO9z5jWmTMcCceAng=
Date:   Sat, 29 Feb 2020 20:40:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com
Subject: Re: [PATCH v2 0/9] workingset protection/detection on the anonymous
 LRU list
Message-Id: <20200229204000.298de32521885b8af858a50d@linux-foundation.org>
In-Reply-To: <20200227074748.GA18113@js1304-desktop>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
        <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
        <20200227074748.GA18113@js1304-desktop>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 16:48:47 +0900 Joonsoo Kim <js1304@gmail.com> wrote:

> Hello, Andrew.
> 
> > > * SOLUTION
> > > Since this is what we want to avoid, this patchset implements workingset
> > > protection. Like as the file LRU list, newly created or swap-in anonymous
> > > page is started on the inactive list. Also, like as the file LRU list,
> > > if enough reference happens, the page will be promoted. This simple
> > > modification changes the above example as following.
> > 
> > One wonders why on earth we weren't doing these things in the first
> > place?
> 
> I don't know. I tried to find the origin of this behaviour and found
> that it's from you 18 years ago. :)
> 
> It mentions that starting pages on the active list boosts throughput on
> stupid swapstormy test but I cannot guess the exact reason of such
> improvement.
> 
> Anyway, Following is the related patch history. Could you remember
> anything about it?
> 

erm, yes, that was a long time ago ;) I guess enough other things have
changed since then to necessitate a revisit!

