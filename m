Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1AB8724D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 08:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405439AbfHIGkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 02:40:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:35444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726212AbfHIGkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:40:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF531ABD2;
        Fri,  9 Aug 2019 06:40:33 +0000 (UTC)
Date:   Fri, 9 Aug 2019 08:40:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Edward Chron <echron@arista.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Subject: Re: [PATCH] mm/oom: Add killed process selection information
Message-ID: <20190809064032.GJ18351@dhcp22.suse.cz>
References: <20190808183247.28206-1-echron@arista.com>
 <20190808185119.GF18351@dhcp22.suse.cz>
 <CAM3twVT0_f++p1jkvGuyMYtaYtzgEiaUtb8aYNCmNScirE4=og@mail.gmail.com>
 <20190808200715.GI18351@dhcp22.suse.cz>
 <CAM3twVS7tqcHmHqjzJqO5DEsxzLfBaYF0FjVP+Jjb1ZS4rA9qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM3twVS7tqcHmHqjzJqO5DEsxzLfBaYF0FjVP+Jjb1ZS4rA9qA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Again, please do not top post - it makes a mess of any longer
discussion]

On Thu 08-08-19 15:15:12, Edward Chron wrote:
> In our experience far more (99.9%+) OOM events are not kernel issues,
> they're user task memory issues.
> Properly maintained Linux kernel only rarely have issues.
> So useful information about the killed task, displayed in a manner
> that can be quickly digested, is very helpful.
> But it turns out the totalpages parameter is also critical to make
> sense of what is shown.

We already do print that information (see mem_cgroup_print_oom_meminfo
resp. show_mem).

> So if we report the fooWidget task was using ~15% of memory (I know
> this is just an approximation but it is often an adequate metric) we
> often can tell just from that the number is larger than expected so we
> can start there.
> Even though the % is a ballpark number, if you are familiar with the
> tasks on your system and approximately how much memory you expect them
> to use you can often tell if memory usage is excessive.
> This is not always the case but it is a fair amount of the time.
> So the % of memory field is helpful. But we've found we need totalpages as well.
> The totalpages effects the % of memory the task uses.

Is it too difficult to calculate that % from the data available in the
existing report? I would expect this would be a quite simple script
which I would consider a better than changing the kernel code.

[...]
> The oom_score tells us how Linux calculated the score for the task,
> the oom_score_adj effects this so it is helpful to have that in
> conjunction with the oom_score.
> If the adjust is high it can tell us that the task was acting as a
> canary and so it's oom_score is high even though it's memory
> utilization can be modest or low.

I am sorry but I still do not get it. How are you going to use that
information without seeing other eligible tasks. oom_score is just a
normalized memory usage + some heuristics potentially (we have given a
discount to root processes until just recently). So this value only
makes sense to the kernel oom killer implementation. Note that the
equation might change in the future (that has happen in the past several
times) so looking at the value in isolation might be quite misleading.

I can see some point in printing oom_score_adj, though. Seeing biased -
one way or the other - tasks being selected might confirm the setting is
reasonable or otherwise (e.g. seeing tasks with negative scores will
give an indication that they might be not biased enough). Then you can
go and check the eligible tasks dump and see what happened. So this part
makes some sense to me.
-- 
Michal Hocko
SUSE Labs
