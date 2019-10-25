Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08743E55D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfJYVZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 17:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfJYVZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:25:32 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 537C92084C;
        Fri, 25 Oct 2019 21:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572038729;
        bh=kEfjHO6oNibA4rpD7BZt5/bc6vP5kbCOVkqfe8i1laE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vBxLZda3SmNmIzubNaJAHWdryG5otSiXjxJo39W1tZUQUwHG1J/Udt9gww0bvwi7G
         G20Cp/tzU39paZxYD6ka53naYFEFeBbM3G+JOrzkw5m9FeIWxtWzMqHgTncMl0aEhK
         OsRipbz7jkiF7DWKiv5fEfAk2WRjMnKGDvTKnpeU=
Date:   Fri, 25 Oct 2019 14:25:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
Message-Id: <20191025142528.366148a0ffadf80946d62bbb@linux-foundation.org>
In-Reply-To: <192965B3-B446-499C-AEE8-DFF087D46B87@lca.pw>
References: <192965B3-B446-499C-AEE8-DFF087D46B87@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 07:18:37 -0400 Qian Cai <cai@lca.pw> wrote:

> ﻿
> 
> > On Oct 25, 2019, at 3:26 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Considering the pagetypeinfo is a debugging tool we do not really need
> > exact numbers here. The primary reason to look at the outuput is to see
> > how pageblocks are spread among different migratetypes and low number of
> > pages is much more interesting therefore putting a bound on the number
> > of pages on the free_list sounds like a reasonable tradeoff.
> > 
> > The new output will simply tell
> > [...]
> > Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >100000  41019  31560  23996  10054   3229    983    648
> 
> It was mentioned that developers could use this file is to see the movement of those numbers for debugging, so this supposed to introduce regressions as there is no movement anymore for those 100k+ items?

There are risks, but we have to do something!

I'd be inclined to remove the ">" though - that'll unnecessarily break
code which parses this data.

otoh, maybe that's a feature: breaking those parsers will alert people
to go in and find out what changed.

