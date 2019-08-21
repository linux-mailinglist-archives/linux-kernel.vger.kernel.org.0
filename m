Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74351972D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 08:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfHUGre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 02:47:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:50746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbfHUGre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:47:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D59E2ABE3;
        Wed, 21 Aug 2019 06:47:32 +0000 (UTC)
Date:   Wed, 21 Aug 2019 08:47:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Edward Chron <echron@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, colona@arista.com
Subject: Re: [PATCH] mm/oom: Add oom_score_adj value to oom Killed process
 message
Message-ID: <20190821064732.GW3111@dhcp22.suse.cz>
References: <20190821001445.32114-1-echron@arista.com>
 <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908202024300.141379@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-08-19 20:25:32, David Rientjes wrote:
> On Tue, 20 Aug 2019, Edward Chron wrote:
> 
> > For an OOM event: print oom_score_adj value for the OOM Killed process to
> > document what the oom score adjust value was at the time the process was
> > OOM Killed. The adjustment value can be set by user code and it affects
> > the resulting oom_score so it is used to influence kill process selection.
> > 
> > When eligible tasks are not printed (sysctl oom_dump_tasks = 0) printing
> > this value is the only documentation of the value for the process being
> > killed. Having this value on the Killed process message documents if a
> > miscconfiguration occurred or it can confirm that the oom_score_adj
> > value applies as expected.
> > 
> > An example which illustates both misconfiguration and validation that
> > the oom_score_adj was applied as expected is:
> > 
> > Aug 14 23:00:02 testserver kernel: Out of memory: Killed process 2692
> >  (systemd-udevd) total-vm:1056800kB, anon-rss:1052760kB, file-rss:4kB,
> >  shmem-rss:0kB oom_score_adj:1000
> > 
> > The systemd-udevd is a critical system application that should have an
> > oom_score_adj of -1000. Here it was misconfigured to have a adjustment
> > of 1000 making it a highly favored OOM kill target process. The output
> > documents both the misconfiguration and the fact that the process
> > was correctly targeted by OOM due to the miconfiguration. Having
> > the oom_score_adj on the Killed message ensures that it is documented.
> > 
> > Signed-off-by: Edward Chron <echron@arista.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Acked-by: David Rientjes <rientjes@google.com>
> 
> vm.oom_dump_tasks is pretty useful, however, so it's curious why you 
> haven't left it enabled :/

Because it generates a lot of output potentially. Think of a workload
with too many tasks which is not uncommon.
-- 
Michal Hocko
SUSE Labs
