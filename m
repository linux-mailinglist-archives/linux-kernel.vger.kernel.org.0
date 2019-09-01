Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 407DBA4C6C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 00:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfIAWCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 18:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728942AbfIAWCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 18:02:04 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1A821897;
        Sun,  1 Sep 2019 22:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567375323;
        bh=5Jemhp2lj9/ZQGI4LXDaoA+GALLU78MTTZMQS0wCH3M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XmwJkLPBgjplyzLEch8BUQyWULZn07GtOYgNWmh1hH+lNMEPiv1+aHCod3XdVT9k5
         gVrR0Rr9BwZR+VOTzOGrl/Jx/XRzv+ioAQdTGs0BGCbyoWZaHKeqiP9V4viOq7BAhX
         HZxZZz5Wksm6qHOX+gyVdt3Fg/28Au+cIKoLEAOY=
Message-ID: <1567375321.5282.12.camel@kernel.org>
Subject: Re: [PATCH] tracing: Fix histogram referencing a variable
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Sun, 01 Sep 2019 17:02:01 -0500
In-Reply-To: <20190826224434.385bc6b5@gandalf.local.home>
References: <20190826224434.385bc6b5@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 2019-08-26 at 22:44 -0400, Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> I performed a three way histogram with the following commands:
> 
> echo 'irq_lat u64 lat pid_t pid' > synthetic_events
> echo 'wake_lat u64 lat u64 irqlat pid_t pid' >> synthetic_events
> echo 'hist:keys=common_pid:irqts=common_timestamp.usecs if function == 0xffffffff81200580' > events/timer/hrtimer_start/trigger
> echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$irqts:onmatch(timer.hrtimer_start).irq_lat($lat,pid) if common_flags & 1' > events/sched/sched_waking/trigger
> echo 'hist:keys=pid:wakets=common_timestamp.usecs,irqlat=lat' > events/synthetic/irq_lat/trigger
> echo 'hist:keys=next_pid:lat=common_timestamp.usecs-$wakets,irqlat=$irqlat:onmatch(synthetic.irq_lat).wake_lat($lat,$irqlat,next_pid)' > events/sched/sched_switch/trigger 
> echo 1 > events/synthetic/wake_lat/enable 
> 

Thanks for digging into this and providing a patch.  Looking into it
myself, I think the problem is actually in the alias-creation code
(which gets invoked for where you do irqlat=$irqlat).  In that code,
the alias's var_ref_idx is always 0, so you get whatever's there rather
than the correct value if it should be something other than 0.

The patch below fixes that - I used your original commit message but
changed the last sentence and the offending commit that introduced the
problem, and of course the one-line code change is different too.  Let
me know if that works for you.

Thanks,

Tom


[PATCH] tracing: Make sure variable reference alias has correct var_ref_idx

Original changelog from Steve Rostedt (except last sentence which
explains the problem, and the Fixes: tag):

I performed a three way histogram with the following commands:

echo 'irq_lat u64 lat pid_t pid' > synthetic_events
echo 'wake_lat u64 lat u64 irqlat pid_t pid' >> synthetic_events
echo 'hist:keys=common_pid:irqts=common_timestamp.usecs if function == 0xffffffff81200580' > events/timer/hrtimer_start/trigger
echo 'hist:keys=common_pid:lat=common_timestamp.usecs-$irqts:onmatch(timer.hrtimer_start).irq_lat($lat,pid) if common_flags & 1' > events/sched/sched_waking/trigger
echo 'hist:keys=pid:wakets=common_timestamp.usecs,irqlat=lat' > events/synthetic/irq_lat/trigger
echo 'hist:keys=next_pid:lat=common_timestamp.usecs-$wakets,irqlat=$irqlat:onmatch(synthetic.irq_lat).wake_lat($lat,$irqlat,next_pid)' > events/sched/sched_switch/trigger
echo 1 > events/synthetic/wake_lat/enable

Basically I wanted to see:

 hrtimer_start (calling function tick_sched_timer)

Note:

  # grep tick_sched_timer /proc/kallsyms
ffffffff81200580 t tick_sched_timer

And save the time of that, and then record sched_waking if it is called
in interrupt context and with the same pid as the hrtimer_start, it
will record the latency between that and the waking event.

I then look at when the task that is woken is scheduled in, and record
the latency between the wakeup and the task running.

At the end, the wake_lat synthetic event will show the wakeup to
scheduled latency, as well as the irq latency in from hritmer_start to
the wakeup. The problem is that I found this:

          <idle>-0     [007] d...   190.485261: wake_lat: lat=27 irqlat=190485230 pid=698
          <idle>-0     [005] d...   190.485283: wake_lat: lat=40 irqlat=190485239 pid=10
          <idle>-0     [002] d...   190.488327: wake_lat: lat=56 irqlat=190488266 pid=335
          <idle>-0     [005] d...   190.489330: wake_lat: lat=64 irqlat=190489262 pid=10
          <idle>-0     [003] d...   190.490312: wake_lat: lat=43 irqlat=190490265 pid=77
          <idle>-0     [005] d...   190.493322: wake_lat: lat=54 irqlat=190493262 pid=10
          <idle>-0     [005] d...   190.497305: wake_lat: lat=35 irqlat=190497267 pid=10
          <idle>-0     [005] d...   190.501319: wake_lat: lat=50 irqlat=190501264 pid=10

The irqlat seemed quite large! Investigating this further, if I had
enabled the irq_lat synthetic event, I noticed this:

          <idle>-0     [002] d.s.   249.429308: irq_lat: lat=164968 pid=335
          <idle>-0     [002] d...   249.429369: wake_lat: lat=55 irqlat=249429308 pid=335

Notice that the timestamp of the irq_lat "249.429308" is awfully
similar to the reported irqlat variable. In fact, all instances were
like this. It appeared that:

  irqlat=$irqlat

Wasn't assigning the old $irqlat to the new irqlat variable, but
instead was assigning the $irqts to it.

The issue is that assigning the old $irqlat to the new irqlat variable
creates a variable reference alias, but the alias creation code
forgets to make sure the alias uses the same var_ref_idx to access the
reference.

Cc: stable@vger.kernel.org
Fixes: 7e8b88a30b085 ("tracing: Add hist trigger support for variable reference aliases")
Reported-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 65e7d071ed28..dbefd59ba944 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2785,6 +2785,8 @@ static struct hist_field *create_alias(struct hist_trigger_data *hist_data,
 		return NULL;
 	}
 
+	alias->var_ref_idx = var_ref->var_ref_idx;
+
 	return alias;
 }
 
-- 
2.14.1


