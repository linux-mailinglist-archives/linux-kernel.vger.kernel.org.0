Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1054E0010
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbfJVIzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 04:55:06 -0400
Received: from mail.jv-coder.de ([5.9.79.73]:52278 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388006AbfJVIzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:55:05 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Oct 2019 04:55:03 EDT
Received: from [10.61.40.7] (unknown [37.156.92.209])
        by mail.jv-coder.de (Postfix) with ESMTPSA id 4448F9F6BD;
        Tue, 22 Oct 2019 08:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1571734070; bh=B5UzEcZgqD9vIy/43EpvWvtJjrmFm6+a9SNT6O+SI/g=;
        h=Subject:To:From:Message-ID:Date:MIME-Version;
        b=Y+dTwcYA9wru1V2q4847F2606ey5b+BfmUaKp2SYkY0Fdlf9gXLQLyscO0ZI/oPC0
         NZD+LfDdoazTpJexwHemi5AnoP3O9X/+vGnLnlXQmdL3o4Yo7wifvmRzQbN5Nk3/JI
         IxmcUxNm97t2yPQx87GRY6gIZphjwgEy/YSr9iec=
Subject: Re: [LTP] sched_football: Validity of testcase
To:     Cyril Hrubis <chrubis@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     ltp@lists.linux.it, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <015a01d56486$6c905050$45b0f0f0$@jv-coder.de>
 <20190913135121.GB7939@rei>
From:   Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <51ded182-023d-da52-9784-f2705cd89026@jv-coder.de>
Date:   Tue, 22 Oct 2019 10:47:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20190913135121.GB7939@rei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,HELO_MISC_IP,RDNS_NONE autolearn=no
        autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.jv-coder.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is no one interested in this?

> Hi,
> 
> I was looking thoroughly at the realtime testcase sched_football,
> because it sometimes fails and like to know your opinion on the test case.
> 
> A short introduction to how the test works:
> It creates nThreads threads called offense and n threads called defense
> (all fifo scheduled). The offense threads run at a lower priority than
> the defense threads and the main thread has the highest priority. After
> all threads are created (validated using an atomic counter). The test
> verifies, that the offense threads are never executed by incrementing
> a counter in the offense threads, that is zeroed in the main thread.
> During the test the main threads sleeps to regularly.
> 
> While the test is totally fine on a single core system, you can
> immediately see, that it will fail on a system with nCores > nThreads,
> because there will be a core were only an offense thread an no defense
> thread is scheduled. In its default setup nThreads = nCores. This should
> theoretically work, because there is a defense thread for every score with
> 
> a higher priority than the offense threads and they should be scheduled
> onto  every core. This is indeed what happens. The problem seems to be
> the  initialization phase. When the threads are created, they are not
> evenly scheduled. After pthread_create was called, the threads are
> scheduled
> 
> too cores where nothing is running. If there is no idle core anymore, they
> are
> scheduled to any core (the first?, the one with the shortest wait queue?).
> At
> some point after all threads are created, they are rescheduled to every
> core.
> It looks like the test fails, when there is initially a core with only an
> offense thread scheduled onto it. In perf sched traces I saw, that a
> defense
> thread was migrated to this core, but still the offense thread was
> executed
> for
> a short time, until the offense thread runs. From this point onwards only
> defense threads are running.
> 
> I tested adding a sleep to the main function, after all threads are
> created,
> to give the system some time for rescheduling. A sleep of around 50ms
> works
> quite well and supports my theory about the migration time being the
> problem.
> 
> Now I am not sure if the test case is even valid or if the scheduler is
> not
> working as it is supposed to. Looking at the commits of sched_football it
> looks like it was running stable at least at some point, at least it es
> reported to have run 15k iterations in e6432e45.
> What do you think about the test case? Is it even valid?
> Should the cpu affinity be set fixed?
> 
> A note about my testing methodology:
> After I realized, that the execution often failed due to the offense
> thread
> running after referee set the_ball to 0, I replaced the loop with just
> usleep(10000), for faster iteration.
> I tested on ubuntu 19.04 with linux 5.0.0-27 running in vmware and
> a custom yocto distribution running linux 4.19.59 (with and without rt
> patches)
> 
> Jörg

