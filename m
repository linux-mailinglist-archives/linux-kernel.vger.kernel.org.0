Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5470EA280
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 18:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfJ3R0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 13:26:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45514 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfJ3R0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:26:04 -0400
Received: by mail-lf1-f67.google.com with SMTP id v8so2170142lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9bh0nQwP4YPrcXHPhFD0c1NAS6/Khc/MMM0GILVlbOY=;
        b=jfdEPext01qOLLjNvOS2gLRXrGrl929RcfLkd42wNMeBD4FGsUpDME3ICBdo3b+Hbi
         hSBnyD0Jt5U0fvZuUf6CcbbGvOWsX6EODyOtCKViHGrWenBsSO/0vokOYjZROlvaliY5
         zjtaNRhSJjJNHsk3+b312gBJo4xiPIw9MPjVVpIlNqPGB1GzUvqgnAolwBHcWnwDJMdQ
         NnRQlQ/s0mo3vHnijwEuJdcAVTL8EGx8O8rtjGmz3YsJWW0TTbNlbkbdkF//ldTJUqAB
         hKEeFWrtxS1YM1IFdWgoSNQ8/ZhmY4Dm0liH+YYo72BlAA87ChZZUgV/1AGXNiM/FOsZ
         U6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bh0nQwP4YPrcXHPhFD0c1NAS6/Khc/MMM0GILVlbOY=;
        b=M/4z0uKPFLEjUXKbITeQ4ovncHmd5SSTDS1z+MH5jbYi0HCfTNiJPi3LMWGn0krtVZ
         YLTxP1zjCLnlYR+NXZnSXPMChbwP99jAX2re1R+6j0zAQBTlaXSFKjI5jmQUcNBRrncN
         tGw/vC5vo5VQ3od51aHUtLA1Q5VadsCD8hb+wJFQ7IaY7VyyNijwdvSEyhBFg0g0oRvu
         E/X7AjlO8pXfL5RCuBLvuFiLfZYMvHXBlJa3hZpS1CUeZxG+7UMbYXUpdLhPcXDdf1mh
         hAOprin+KpXgwmiqU8ndXAm7VM84PnhDHuk4Fp1w9ayLGBBdAbgK9xysfJKDYZszVT1x
         o66w==
X-Gm-Message-State: APjAAAWxvo+uI7zHmPQ0FmZZ/ikOEUuVSB+3E4zV4Cxnw4y9KTmWjlIJ
        iX/1q/xN0N8onmNbodtS0rrr7EuiMPv55mTxogtGPA==
X-Google-Smtp-Source: APXvYqx2t5/8PJjhD25LViYfu6682nSFTGzISd7uS4GePhLewjaEPlHYFPQCzMQCrPtBRswSD6uBr7TFiN3H3ie7ZSE=
X-Received: by 2002:a19:ca13:: with SMTP id a19mr141612lfg.133.1572456360719;
 Wed, 30 Oct 2019 10:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <1571405198-27570-1-git-send-email-vincent.guittot@linaro.org>
 <20191021075038.GA27361@gmail.com> <CAKfTPtCcvKuf1Gt0W-BeEbQxFP_co14jdv_L5zEpS==Ecibabg@mail.gmail.com>
 <20191024123844.GB2708@pauld.bos.csb> <20191024134650.GD2708@pauld.bos.csb>
 <CAKfTPtB0VruWXq+wGgvNOMFJvvZQiZyi2AgBoJP3Uaeduu2Lqg@mail.gmail.com>
 <20191025133325.GA2421@pauld.bos.csb> <CAKfTPtDWV7AkzMNuJtkN-pLmDcK41LwNiX0Wr8UT+vMFHAx6Qg@mail.gmail.com>
 <20191030143937.GC1686@pauld.bos.csb>
In-Reply-To: <20191030143937.GC1686@pauld.bos.csb>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 30 Oct 2019 18:25:49 +0100
Message-ID: <CAKfTPtCR93MBPjKhMSyMZJTqVS7YWBPCnk3DmSEq2Q0MVxm1ug@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] sched/fair: rework the CFS load balance
To:     Phil Auld <pauld@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019 at 15:39, Phil Auld <pauld@redhat.com> wrote:
>
> Hi Vincent,
>
> On Mon, Oct 28, 2019 at 02:03:15PM +0100 Vincent Guittot wrote:
> > Hi Phil,
> >
>
> ...
>
> >
> > The input could mean that this system reaches a particular level of
> > utilization and load that is close to the threshold between 2
> > different behavior like spare capacity and fully_busy/overloaded case.
> > But at the opposite, there is less threads that CPUs in your UCs so
> > one group at least at NUMA level should be tagged as
> > has_spare_capacity and should pull tasks.
>
> Yes. Maybe we don't hit that and rely on "load" since things look
> busy. There are only 2 spare cpus in the 156 + 2 case. Is it possible
> that information is getting lost with the extra NUMA levels?

It should not but i have to look more deeply your topology
If we have less tasks than CPUs, one group should always be tagged
"has_spare_capacity"

>
> >
> > >
> > > >
> > > > The fix favors the local group so your UC seems to prefer spreading
> > > > tasks at wake up
> > > > If you have any traces that you can share, this could help to
> > > > understand what's going on. I will try to reproduce the problem on my
> > > > system
> > >
> > > I'm not actually sure the fix here is causing this. Looking at the data
> > > more closely I see similar imbalances on v4, v4a and v3.
> > >
> > > When you say slow versus fast wakeup paths what do you mean? I'm still
> > > learning my way around all this code.
> >
> > When task wakes up, we can decide to
> > - speedup the wakeup and shorten the list of cpus and compare only
> > prev_cpu vs this_cpu (in fact the group of cpu that share their
> > respective LLC). That's the fast wakeup path that is used most of the
> > time during a wakeup
> > - or start to find the idlest CPU of the system and scan all domains.
> > That's the slow path that is used for new tasks or when a task wakes
> > up a lot of other tasks at the same time
> >
>
> Thanks.
>
> >
> > >
> > > This particular test is specifically designed to highlight the imbalance
> > > cause by the use of group scheduler defined load and averages. The threads
> > > are mostly CPU bound but will join up every time step. So if each thread
> >
> > ok the fact that they join up might be the root cause of your problem.
> > They will wake up at the same time by the same task and CPU.
> >
>
> If that was the problem I'd expect issues on other high node count systems.

yes probably

>
> >
> > That fact that the 4 nodes works well but not the 8 nodes is a bit
> > surprising except if this means more NUMA level in the sched_domain
> > topology
> > Could you give us more details about the sched domain topology ?
> >
>
> The 8-node system has 5 sched domain levels.  The 4-node system only
> has 3.

That's an interesting difference. and your additional tests on a 8
nodes with 3 level tends to confirm that the number of level make a
difference
I need to study a bit more how this can impact the spread of tasks

>
>
> cpu159 0 0 0 0 0 0 4361694551702 124316659623 94736
> domain0 80000000,00000000,00008000,00000000,00000000 0 0
> domain1 ffc00000,00000000,0000ffc0,00000000,00000000 0 0
> domain2 fffff000,00000000,0000ffff,f0000000,00000000 0 0
> domain3 ffffffff,ff000000,0000ffff,ffffff00,00000000 0 0
> domain4 ffffffff,ffffffff,ffffffff,ffffffff,ffffffff 0 0
>
> numactl --hardware
> available: 8 nodes (0-7)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 80 81 82 83 84 85 86 87 88 89
> node 0 size: 126928 MB
> node 0 free: 126452 MB
> node 1 cpus: 10 11 12 13 14 15 16 17 18 19 90 91 92 93 94 95 96 97 98 99
> node 1 size: 129019 MB
> node 1 free: 128813 MB
> node 2 cpus: 20 21 22 23 24 25 26 27 28 29 100 101 102 103 104 105 106 107 108 109
> node 2 size: 129019 MB
> node 2 free: 128875 MB
> node 3 cpus: 30 31 32 33 34 35 36 37 38 39 110 111 112 113 114 115 116 117 118 119
> node 3 size: 129019 MB
> node 3 free: 128850 MB
> node 4 cpus: 40 41 42 43 44 45 46 47 48 49 120 121 122 123 124 125 126 127 128 129
> node 4 size: 128993 MB
> node 4 free: 128862 MB
> node 5 cpus: 50 51 52 53 54 55 56 57 58 59 130 131 132 133 134 135 136 137 138 139
> node 5 size: 129019 MB
> node 5 free: 128872 MB
> node 6 cpus: 60 61 62 63 64 65 66 67 68 69 140 141 142 143 144 145 146 147 148 149
> node 6 size: 129019 MB
> node 6 free: 128852 MB
> node 7 cpus: 70 71 72 73 74 75 76 77 78 79 150 151 152 153 154 155 156 157 158 159
> node 7 size: 112889 MB
> node 7 free: 112720 MB
> node distances:
> node   0   1   2   3   4   5   6   7
>   0:  10  12  17  17  19  19  19  19
>   1:  12  10  17  17  19  19  19  19
>   2:  17  17  10  12  19  19  19  19
>   3:  17  17  12  10  19  19  19  19
>   4:  19  19  19  19  10  12  17  17
>   5:  19  19  19  19  12  10  17  17
>   6:  19  19  19  19  17  17  10  12
>   7:  19  19  19  19  17  17  12  10
>
>
>
> available: 4 nodes (0-3)
> node 0 cpus: 0 1 2 3 4 5 6 7 8 9 40 41 42 43 44 45 46 47 48 49
> node 0 size: 257943 MB
> node 0 free: 257602 MB
> node 1 cpus: 10 11 12 13 14 15 16 17 18 19 50 51 52 53 54 55 56 57 58 59
> node 1 size: 258043 MB
> node 1 free: 257619 MB
> node 2 cpus: 20 21 22 23 24 25 26 27 28 29 60 61 62 63 64 65 66 67 68 69
> node 2 size: 258043 MB
> node 2 free: 257879 MB
> node 3 cpus: 30 31 32 33 34 35 36 37 38 39 70 71 72 73 74 75 76 77 78 79
> node 3 size: 258043 MB
> node 3 free: 257823 MB
> node distances:
> node   0   1   2   3
>   0:  10  20  20  20
>   1:  20  10  20  20
>   2:  20  20  10  20
>   3:  20  20  20  10
>
>
>
>
> An 8-node system (albeit with sub-numa) has node distances
>
> node distances:
> node   0   1   2   3   4   5   6   7
>   0:  10  11  21  21  21  21  21  21
>   1:  11  10  21  21  21  21  21  21
>   2:  21  21  10  11  21  21  21  21
>   3:  21  21  11  10  21  21  21  21
>   4:  21  21  21  21  10  11  21  21
>   5:  21  21  21  21  11  10  21  21
>   6:  21  21  21  21  21  21  10  11
>   7:  21  21  21  21  21  21  11  10
>
> This one does not exhibit the problem with the latest (v4a). But also
> only has 3 levels.
>
>
> > >
> > > There's still something between v1 and v4 on that 8-node system that is
> > > still illustrating the original problem.  On our other test systems this
> > > series really works nicely to solve this problem. And even if we can't get
> > > to the bottom if this it's a significant improvement.
> > >
> > >
> > > Here is v3 for the 8-node system
> > > lu.C.x_152_GROUP_1  Average    17.52  16.86  17.90  18.52  20.00  19.00  22.00  20.19
> > > lu.C.x_152_GROUP_2  Average    15.70  15.04  15.65  15.72  23.30  28.98  20.09  17.52
> > > lu.C.x_152_GROUP_3  Average    27.72  32.79  22.89  22.62  11.01  12.90  12.14  9.93
> > > lu.C.x_152_GROUP_4  Average    18.13  18.87  18.40  17.87  18.80  19.93  20.40  19.60
> > > lu.C.x_152_GROUP_5  Average    24.14  26.46  20.92  21.43  14.70  16.05  15.14  13.16
> > > lu.C.x_152_NORMAL_1 Average    21.03  22.43  20.27  19.97  18.37  18.80  16.27  14.87
> > > lu.C.x_152_NORMAL_2 Average    19.24  18.29  18.41  17.41  19.71  19.00  20.29  19.65
> > > lu.C.x_152_NORMAL_3 Average    19.43  20.00  19.05  20.24  18.76  17.38  18.52  18.62
> > > lu.C.x_152_NORMAL_4 Average    17.19  18.25  17.81  18.69  20.44  19.75  20.12  19.75
> > > lu.C.x_152_NORMAL_5 Average    19.25  19.56  19.12  19.56  19.38  19.38  18.12  17.62
> > >
> > > lu.C.x_156_GROUP_1  Average    18.62  19.31  18.38  18.77  19.88  21.35  19.35  20.35
> > > lu.C.x_156_GROUP_2  Average    15.58  12.72  14.96  14.83  20.59  19.35  29.75  28.22
> > > lu.C.x_156_GROUP_3  Average    20.05  18.74  19.63  18.32  20.26  20.89  19.53  18.58
> > > lu.C.x_156_GROUP_4  Average    14.77  11.42  13.01  10.09  27.05  33.52  23.16  22.98
> > > lu.C.x_156_GROUP_5  Average    14.94  11.45  12.77  10.52  28.01  33.88  22.37  22.05
> > > lu.C.x_156_NORMAL_1 Average    20.00  20.58  18.47  18.68  19.47  19.74  19.42  19.63
> > > lu.C.x_156_NORMAL_2 Average    18.52  18.48  18.83  18.43  20.57  20.48  20.61  20.09
> > > lu.C.x_156_NORMAL_3 Average    20.27  20.00  20.05  21.18  19.55  19.00  18.59  17.36
> > > lu.C.x_156_NORMAL_4 Average    19.65  19.60  20.25  20.75  19.35  20.10  19.00  17.30
> > > lu.C.x_156_NORMAL_5 Average    19.79  19.67  20.62  22.42  18.42  18.00  17.67  19.42
> > >
> > >
> > > I'll try to find pre-patched results for this 8 node system.  Just to keep things
> > > together for reference here is the 4-node system before this re-work series.
> > >
> > > lu.C.x_76_GROUP_1  Average    15.84  24.06  23.37  12.73
> > > lu.C.x_76_GROUP_2  Average    15.29  22.78  22.49  15.45
> > > lu.C.x_76_GROUP_3  Average    13.45  23.90  22.97  15.68
> > > lu.C.x_76_NORMAL_1 Average    18.31  19.54  19.54  18.62
> > > lu.C.x_76_NORMAL_2 Average    19.73  19.18  19.45  17.64
> > >
> > > This produced a 4.5x slowdown for the group runs versus the nicely balance
> > > normal runs.
> > >
>
> Here is the base 5.4.0-rc3+ kernel on the 8-node system:
>
> lu.C.x_156_GROUP_1  Average    10.87  0.00   0.00   11.49  36.69  34.26  30.59  32.10
> lu.C.x_156_GROUP_2  Average    20.15  16.32  9.49   24.91  21.07  20.93  21.63  21.50
> lu.C.x_156_GROUP_3  Average    21.27  17.23  11.84  21.80  20.91  20.68  21.11  21.16
> lu.C.x_156_GROUP_4  Average    19.44  6.53   8.71   19.72  22.95  23.16  28.85  26.64
> lu.C.x_156_GROUP_5  Average    20.59  6.20   11.32  14.63  28.73  30.36  22.20  21.98
> lu.C.x_156_NORMAL_1 Average    20.50  19.95  20.40  20.45  18.75  19.35  18.25  18.35
> lu.C.x_156_NORMAL_2 Average    17.15  19.04  18.42  18.69  21.35  21.42  20.00  19.92
> lu.C.x_156_NORMAL_3 Average    18.00  18.15  17.55  17.60  18.90  18.40  19.90  19.75
> lu.C.x_156_NORMAL_4 Average    20.53  20.05  20.21  19.11  19.00  19.47  19.37  18.26
> lu.C.x_156_NORMAL_5 Average    18.72  18.78  19.72  18.50  19.67  19.72  21.11  19.78
>
> Including the actual benchmark results.
> ============156_GROUP========Mop/s===================================
> min     q1      median  q3      max
> 1564.63 3003.87 3928.23 5411.13 8386.66
> ============156_GROUP========time====================================
> min     q1      median  q3      max
> 243.12  376.82  519.06  678.79  1303.18
> ============156_NORMAL========Mop/s===================================
> min     q1      median  q3      max
> 13845.6 18013.8 18545.5 19359.9 19647.4
> ============156_NORMAL========time====================================
> min     q1      median  q3      max
> 103.78  105.32  109.95  113.19  147.27
>
> You can see the ~5x slowdown of the pre-rework issue. v4a is much improved over
> mainline.
>
> I'll try to find some other machines as well.
>
>
> > >
> > >
> > > I can try to get traces but this is not my system so it may take a little
> > > while. I've found that the existing trace points don't give enough information
> > > to see what is happening in this problem. But the visualization in kernelshark
> > > does show the problem pretty well. Do you want just the existing sched tracepoints
> > > or should I update some of the traceprintks I used in the earlier traces?
> >
> > The standard tracepoint is a good starting point but tracing the
> > statistings for find_busiest_group and find_idlest_group should help a
> > lot.
> >
>
> I have some traces which I'll send you directly since they're large.

Thanks

>
>
> Cheers,
> Phil
>
>
>
> > Cheers,
> > Vincent
> >
> > >
> > >
> > >
> > > Cheers,
> > > Phil
> > >
> > >
> > > >
> > > > >
> > > > > We're re-running the test to get more samples.
> > > >
> > > > Thanks
> > > > Vincent
> > > >
> > > > >
> > > > >
> > > > > Other tests and systems were still fine.
> > > > >
> > > > >
> > > > > Cheers,
> > > > > Phil
> > > > >
> > > > >
> > > > > > Numbers for my specific testcase (the cgroup imbalance) are basically
> > > > > > the same as I posted for v3 (plus the better 8-node numbers). I.e. this
> > > > > > series solves that issue.
> > > > > >
> > > > > >
> > > > > > Cheers,
> > > > > > Phil
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Also, we seem to have grown a fair amount of these TODO entries:
> > > > > > > >
> > > > > > > >   kernel/sched/fair.c: * XXX borrowed from update_sg_lb_stats
> > > > > > > >   kernel/sched/fair.c: * XXX: only do this for the part of runnable > running ?
> > > > > > > >   kernel/sched/fair.c:     * XXX illustrate
> > > > > > > >   kernel/sched/fair.c:    } else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
> > > > > > > >   kernel/sched/fair.c: * can also include other factors [XXX].
> > > > > > > >   kernel/sched/fair.c: * [XXX expand on:
> > > > > > > >   kernel/sched/fair.c: * [XXX more?]
> > > > > > > >   kernel/sched/fair.c: * [XXX write more on how we solve this.. _after_ merging pjt's patches that
> > > > > > > >   kernel/sched/fair.c:             * XXX for now avg_load is not computed and always 0 so we
> > > > > > > >   kernel/sched/fair.c:            /* XXX broken for overlapping NUMA groups */
> > > > > > > >
> > > > > > >
> > > > > > > I will have a look :-)
> > > > > > >
> > > > > > > > :-)
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > >         Ingo
> > > > > >
> > > > > > --
> > > > > >
> > > > >
> > > > > --
> > > > >
> > >
> > > --
> > >
>
> --
>
