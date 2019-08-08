Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF7878690F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390256AbfHHSvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 14:51:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:44802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733248AbfHHSvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:51:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E4BBAFA7;
        Thu,  8 Aug 2019 18:51:22 +0000 (UTC)
Date:   Thu, 8 Aug 2019 20:51:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Edward Chron <echron@arista.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] mm/oom: Add killed process selection information
Message-ID: <20190808185119.GF18351@dhcp22.suse.cz>
References: <20190808183247.28206-1-echron@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808183247.28206-1-echron@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-08-19 11:32:47, Edward Chron wrote:
> For an OOM event: print oomscore, memory pct, oom adjustment of the process
> that OOM kills and the totalpages value in kB (KiB) used in the calculation
> with the OOM killed process message. This is helpful to document why the
> process was selected by OOM at the time of the OOM event.
> 
> Sample message output:
> Jul 21 20:07:48 yoursystem kernel: Out of memory: Killed process 2826
>  (processname) total-vm:1056800kB, anon-rss:1052784kB, file-rss:4kB,
>  shmem-rss:0kB memory-usage:3.2% oom_score:1032 oom_score_adj:1000
>  total-pages: 32791748kB

A large part of this information is already printed in the oom eligible
task list. Namely rss, oom_score_adj, there is also page tables
consumption which might be a serious contributor as well. Why would you
like to see oom_score, memory-usage and total-pages to be printed as
well? How is that information useful?
-- 
Michal Hocko
SUSE Labs
