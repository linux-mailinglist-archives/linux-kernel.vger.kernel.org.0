Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B74048E61B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfHOITD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 04:19:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:34614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729971AbfHOITC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:19:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80243ACF2;
        Thu, 15 Aug 2019 08:19:00 +0000 (UTC)
Date:   Thu, 15 Aug 2019 10:18:58 +0200
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
Message-ID: <20190815081858.GB9477@dhcp22.suse.cz>
References: <20190808183247.28206-1-echron@arista.com>
 <20190808185119.GF18351@dhcp22.suse.cz>
 <CAM3twVT0_f++p1jkvGuyMYtaYtzgEiaUtb8aYNCmNScirE4=og@mail.gmail.com>
 <20190808200715.GI18351@dhcp22.suse.cz>
 <CAM3twVS7tqcHmHqjzJqO5DEsxzLfBaYF0FjVP+Jjb1ZS4rA9qA@mail.gmail.com>
 <20190809064032.GJ18351@dhcp22.suse.cz>
 <CAM3twVRCTLdn+Lhcr+4ZdY3nYVvXFe1O19UR9H121W34H=oV7g@mail.gmail.com>
 <20190812114256.GG5117@dhcp22.suse.cz>
 <CAM3twVSXEwN+r8YG=z3fmnN0G55N5HD-Bnh6g=MVk75qB1kpWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM3twVSXEwN+r8YG=z3fmnN0G55N5HD-Bnh6g=MVk75qB1kpWQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-08-19 23:24:51, Edward Chron wrote:
> On Mon, Aug 12, 2019 at 4:42 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 09-08-19 15:15:18, Edward Chron wrote:
> > [...]
> > > So it is optimal if you only have to go and find the correct log and search
> > > or run your script(s) when you absolutely need to, not on every OOM event.
> >
> > OK, understood.
> >
> > > That is the whole point of triage and triage is easier when you have
> > > relevant information to decide which events require action and with what
> > > priority.
> > >
> > > The OOM Killed message is the one message that we have go to
> > > the console and or is sent as SNMP alert to the Admin to let the
> > > Admin know that a server or switch has suffered a low memory OOM
> > > event.
> > >
> > > Maybe a few examples would be helpful to show why the few extra
> > > bits of information would be helpful in such an environment.
> > >
> > > For example if we see serverA and serverB are taking oom events
> > > with the fooWidget being killed, something along the lines of
> > > the following you will get message likes this:
> > >
> > > Jul 21 20:07:48 serverA kernel: Out of memory: Killed process 2826
> > >  (fooWidget) total-vm:10493400kB, anon-rss:10492996kB, file-rss:128kB,
> > >  shmem-rss:0kB memory-usage:32.0% oom_score: 320 oom_score_adj:0
> > >  total-pages: 32791748kB
> > >
> > > Jul 21 20:13:51 serverB kernel: Out of memory: Killed process 2911
> > >  (fooWidget) total-vm:11149196kB, anon-rss:11148508kB, file-rss:128kB,
> > >  shmem-rss:0kB memory-usage:34.0% oom_score: 340 oom_score_adj:0
> > >  total-pages: 32791748kB
> > >
> > > It is often possible to recognize that fooWidget is using more memory than
> > > expected on those systems and you can act on that possibly without ever
> > > having to hunt down the log and run a script or otherwise analyze the
> > > log. The % of memory and memory size can often be helpful to understand
> > > if the numbers look reasonable or not. Maybe the application was updated
> > > on just the those systems which explains why we don't see issues on the
> > > other servers running that application, possible application memory leak.
> >
> > This is all quite vague and requires a lot of guessing. Also your
> > trained guess eye might easily get confused for constrained OOMs (e.g.
> > due to NUMA or memcg). So I am not really sold to the percentage idea.
> > And likewise the oom_score.
> >
> > [...]
> >
> 
> Actually totalpages is used by oom control and is set to the appropriate
> value for a memcg OOM event or to totalram_pages + totalswap if it is
> a system wide OOM event.
> 
> The percentage coupled with the totalpages is how we know what we're
> looking at and for our environments. Seems to work fine, but maybe there are
> some environments where that is not the case.
> 
> I must be missing something here so I need to go back and study this.

total pages is the amount of memory (limit for memcg) in the OOM domain
(e.g. a subset of numa nodes) while the oom victim might span more numa
nodes resp. have memory charged to a different memcg (e.g. when the task
has been moved between memcgs). And that is why the percentage might be
misleading for anything but the whole system or static memcgs oom and
likely why it works in your case.
-- 
Michal Hocko
SUSE Labs
