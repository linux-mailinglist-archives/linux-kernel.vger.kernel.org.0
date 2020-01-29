Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D899F14C4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 04:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgA2DBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 22:01:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgA2DBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 22:01:41 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42704214D8;
        Wed, 29 Jan 2020 03:01:40 +0000 (UTC)
Date:   Tue, 28 Jan 2020 22:01:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Using matched variables in trace actions
Message-ID: <20200128220138.50b203d3@rorschach.local.home>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

I was debugging a histogram that wasn't working.

I had the following:

 # cd /sys/kernel/tracing/
 # echo 'first u64 start_time u64 end_time pid_t pid u64 delta' > synthetic_events
 # echo 'hist:keys=pid:start_time=common_timestamp' > events/sched/sched_waking/trigger
 # echo 'hist:keys=next_pid:delta=common_timestamp-$start_time:onmatch(sched.sched_waking).first($start_time,common_timestamp,next_pid,$delta)' > events/sched/sched_switch/trigger

Which produced:

 # echo 1 > synthetic/enable
 # cat trace
[..]
          <idle>-0     [005] d..4   342.980379: first: start_time=342980373002 end_time=197 pid=43140 delta=18446744072217752717
          <idle>-0     [000] d..4   342.980439: first: start_time=342980434369 end_time=1598 pid=44526 delta=18446744072239552512
          <idle>-0     [005] d..4   342.980495: first: start_time=342980489992 end_time=197 pid=44739 delta=18446744072217752717
          <idle>-0     [000] d..4   342.980528: first: start_time=342980525307 end_time=1598 pid=15317 delta=18446744072239552512
          <idle>-0     [003] d..4   342.981176: first: start_time=342981170950 end_time=10 pid=42697 delta=18446744072217752717
          <idle>-0     [003] d..4   342.985178: first: start_time=342985174789 end_time=10 pid=31097 delta=18446744072217752717
          <idle>-0     [003] d..4   342.989172: first: start_time=342989168085 end_time=10 pid=30487 delta=18446744072217752717
          <idle>-0     [001] d..4   343.044173: first: start_time=343044169712 end_time=593 pid=30677 delta=18446744072217752717
          <idle>-0     [003] d..4   343.358828: first: start_time=343358824790 end_time=713 pid=24892 delta=18446744072217752717
          <idle>-0     [003] d..4   343.533459: first: start_time=343533455001 end_time=1466 pid=24272 delta=18446744072217752717

Now, this is strange, because the end_time should not ever be 10!

I added debugging and found that everything is shifted off by one.

That is for 

          <idle>-0     [003] d..4   343.533459: first: start_time=343533455001 end_time=1466 pid=24272 delta=18446744072217752717 


end_time is actually 343533455001
pid is actually 1466
and delta is 24272

Which also means that that delta that is printed is reading some random
variable, and if you look at it in hex it's ffffffffa714f48d which
looks to be some random pointer.

Playing with this, I found that the issue is that I have $start_time in
my parameter list for the synthetic event. But $start_time was a
variable defined by sched_waking and not sched_switch. Although the
references can read that variable, the synthetic parameters fail on
that, and basically ignore it.

That is, if I add start=$start_time and use $start as a parameter it
works fine.

 # echo 'hist:keys=next_pid:start=$start_time,delta=common_timestamp-$start_time:onmatch(sched.sched_waking).first($start,common_timestamp,next_pid,$delta)' > events/sched/sched_switch/trigger


 # cat trace
[...]
          <idle>-0     [001] d..4   679.668272: first: start_time=679668221531 end_time=679668266756 pid=1598 delta=45225
          <idle>-0     [006] d..4   679.668425: first: start_time=679668406777 end_time=679668420837 pid=10 delta=14060
          <idle>-0     [006] d..4   679.672431: first: start_time=679672407062 end_time=679672426696 pid=10 delta=19634
          <idle>-0     [006] d..4   679.676443: first: start_time=679676408260 end_time=679676438476 pid=10 delta=30216
          <idle>-0     [003] d..4   679.715562: first: start_time=679715533636 end_time=679715558490 pid=713 delta=24854
          <idle>-0     [003] d..4   679.865699: first: start_time=679865670612 end_time=679865695333 pid=1466 delta=24721
          <idle>-0     [003] d..4   679.865775: first: start_time=679865764528 end_time=679865773007 pid=1466 delta=8479
          <idle>-0     [003] d..4   679.865842: first: start_time=679865833406 end_time=679865840063 pid=1466 delta=6657
          <idle>-0     [003] d..4   679.865906: first: start_time=679865898302 end_time=679865904792 pid=1466 delta=6490
          <idle>-0     [003] d..4   679.865970: first: start_time=679865962239 end_time=679865968686 pid=1466 delta=6447
          <idle>-0     [003] d..4   679.866034: first: start_time=679866026284 end_time=679866032651 pid=1466 delta=6367
          <idle>-0     [003] d..4   679.866098: first: start_time=679866090264 end_time=679866096593 pid=1466 delta=6329
          <idle>-0     [003] d..4   679.866162: first: start_time=679866154251 end_time=679866160656 pid=1466 delta=6405
          <idle>-0     [003] d..4   679.866226: first: start_time=679866218281 end_time=679866224500 pid=1466 delta=6219
          <idle>-0     [003] d..4   679.866290: first: start_time=679866282296 end_time=679866288558 pid=1466 delta=6262

But this is a bug. We either should fail the creation of the trigger,
or we should allow it and handle it properly.

-- Steve
