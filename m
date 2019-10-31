Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8237EB0A8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 13:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfJaM5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 08:57:25 -0400
Received: from foss.arm.com ([217.140.110.172]:48146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfJaM5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:57:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A16541FB;
        Thu, 31 Oct 2019 05:57:24 -0700 (PDT)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 416C13F71E;
        Thu, 31 Oct 2019 05:57:24 -0700 (PDT)
Date:   Thu, 31 Oct 2019 12:57:22 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org
Subject: Re: [Patch v4 0/6] Introduce Thermal Pressure
Message-ID: <20191031125536.GA9817@e108754-lin>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <c6169634-ab1d-6bda-183f-bdd06048736a@linaro.org>
 <20191031100631.GC19197@e108754-lin>
 <2009bac3-405a-c60e-a1dd-191625ff3fc5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2009bac3-405a-c60e-a1dd-191625ff3fc5@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 Oct 2019 at 12:54:03 (+0100), Daniel Lezcano wrote:
> Hi Ionela,
> 
> On 31/10/2019 11:07, Ionela Voinescu wrote:
> > Hi Daniel,
> > 
> > On Tuesday 29 Oct 2019 at 16:34:11 (+0100), Daniel Lezcano wrote:
> >> Hi Thara,
> >>
> >> On 22/10/2019 22:34, Thara Gopinath wrote:
> >>> Thermal governors can respond to an overheat event of a cpu by
> >>> capping the cpu's maximum possible frequency. This in turn
> >>> means that the maximum available compute capacity of the
> >>> cpu is restricted. But today in the kernel, task scheduler is 
> >>> not notified of capping of maximum frequency of a cpu.
> >>> In other words, scheduler is unware of maximum capacity
> >>> restrictions placed on a cpu due to thermal activity.
> >>> This patch series attempts to address this issue.
> >>> The benefits identified are better task placement among available
> >>> cpus in event of overheating which in turn leads to better
> >>> performance numbers.
> >>>
> >>> The reduction in the maximum possible capacity of a cpu due to a 
> >>> thermal event can be considered as thermal pressure. Instantaneous
> >>> thermal pressure is hard to record and can sometime be erroneous
> >>> as there can be mismatch between the actual capping of capacity
> >>> and scheduler recording it. Thus solution is to have a weighted
> >>> average per cpu value for thermal pressure over time.
> >>> The weight reflects the amount of time the cpu has spent at a
> >>> capped maximum frequency. Since thermal pressure is recorded as
> >>> an average, it must be decayed periodically. Exisiting algorithm
> >>> in the kernel scheduler pelt framework is re-used to calculate
> >>> the weighted average. This patch series also defines a sysctl
> >>> inerface to allow for a configurable decay period.
> >>>
> >>> Regarding testing, basic build, boot and sanity testing have been
> >>> performed on db845c platform with debian file system.
> >>> Further, dhrystone and hackbench tests have been
> >>> run with the thermal pressure algorithm. During testing, due to
> >>> constraints of step wise governor in dealing with big little systems,
> >>> trip point 0 temperature was made assymetric between cpus in little
> >>> cluster and big cluster; the idea being that
> >>> big core will heat up and cpu cooling device will throttle the
> >>> frequency of the big cores faster, there by limiting the maximum available
> >>> capacity and the scheduler will spread out tasks to little cores as well.
> >>>
> >>> Test Results
> >>>
> >>> Hackbench: 1 group , 30000 loops, 10 runs       
> >>>                                                Result         SD             
> >>>                                                (Secs)     (% of mean)     
> >>>  No Thermal Pressure                            14.03       2.69%           
> >>>  Thermal Pressure PELT Algo. Decay : 32 ms      13.29       0.56%         
> >>>  Thermal Pressure PELT Algo. Decay : 64 ms      12.57       1.56%           
> >>>  Thermal Pressure PELT Algo. Decay : 128 ms     12.71       1.04%         
> >>>  Thermal Pressure PELT Algo. Decay : 256 ms     12.29       1.42%           
> >>>  Thermal Pressure PELT Algo. Decay : 512 ms     12.42       1.15%  
> >>>
> >>> Dhrystone Run Time  : 20 threads, 3000 MLOOPS
> >>>                                                  Result      SD             
> >>>                                                  (Secs)    (% of mean)     
> >>>  No Thermal Pressure                              9.452      4.49%
> >>>  Thermal Pressure PELT Algo. Decay : 32 ms        8.793      5.30%
> >>>  Thermal Pressure PELT Algo. Decay : 64 ms        8.981      5.29%
> >>>  Thermal Pressure PELT Algo. Decay : 128 ms       8.647      6.62%
> >>>  Thermal Pressure PELT Algo. Decay : 256 ms       8.774      6.45%
> >>>  Thermal Pressure PELT Algo. Decay : 512 ms       8.603      5.41%  
> >>
> >> I took the opportunity to try glmark2 on the db845c platform with the
> >> default decay and got the following glmark2 scores:
> >>
> >> Without thermal pressure:
> >>
> >> # NumSamples = 9; Min = 790.00; Max = 805.00
> >> # Mean = 794.888889; Variance = 19.209877; SD = 4.382907; Median 794.000000
> >> # each ∎ represents a count of 1
> >>   790.0000 -   791.5000 [     2]: ∎∎
> >>   791.5000 -   793.0000 [     2]: ∎∎
> >>   793.0000 -   794.5000 [     2]: ∎∎
> >>   794.5000 -   796.0000 [     1]: ∎
> >>   796.0000 -   797.5000 [     0]:
> >>   797.5000 -   799.0000 [     1]: ∎
> >>   799.0000 -   800.5000 [     0]:
> >>   800.5000 -   802.0000 [     0]:
> >>   802.0000 -   803.5000 [     0]:
> >>   803.5000 -   805.0000 [     1]: ∎
> >>
> >>
> >> With thermal pressure:
> >>
> >> # NumSamples = 9; Min = 933.00; Max = 960.00
> >> # Mean = 940.777778; Variance = 64.172840; SD = 8.010795; Median 937.000000
> >> # each ∎ represents a count of 1
> >>   933.0000 -   935.7000 [     3]: ∎∎∎
> >>   935.7000 -   938.4000 [     2]: ∎∎
> >>   938.4000 -   941.1000 [     2]: ∎∎
> >>   941.1000 -   943.8000 [     0]:
> >>   943.8000 -   946.5000 [     0]:
> >>   946.5000 -   949.2000 [     1]: ∎
> >>   949.2000 -   951.9000 [     0]:
> >>   951.9000 -   954.6000 [     0]:
> >>   954.6000 -   957.3000 [     0]:
> >>   957.3000 -   960.0000 [     1]: ∎
> >>
> > 
> > Interesting! If I'm interpreting these correctly there seems to be
> > significant improvement when applying thermal pressure.
> >
> > I'm not familiar with glmark2, can you tell me more about the process
> > and the work that the benchmark does?
> 
> glmark2 is a 3D benchmark. I ran it without parameters, so all tests are
> run. At the end, it gives a score which are the values given above.
> 
> > I assume this is a GPU benchmark,
> > but not knowing more about it I fail to see the correlation between
> > applying thermal pressure to CPU capacities and the improvement of GPU
> > performance.
> > Do you happen to know more about the behaviour that resulted in these
> > benchmark scores?
> 
> My hypothesis is glmark2 makes the GPU to contribute a lot to the
> heating effect, thus increasing the temperature to the CPU close to it.
>

Hhmm.. yes, I am assuming that there is some thermal mitigation (CPU
frequency capping) done as a result of the heat inflicted by the work
on the GPU, but these patches do not result in better thermal
management as for the GPU to perform better. They only inform the
scheduler in regards to reduced capacity of CPUs so it can decide to
better use the compute capacity that it has available.

There could be a second hand effect of the more efficient use of the
CPUs which would release thermal headroom for the GPU to use, but I
would not expect the differences to be as high as in the results above.

Another possibility is that work on the CPUs impacts the scores more
than I would expect for such a benchmark but again I would not
expect the work on the CPUs to be significant as to result in such
differences in the scores.

If you have the chance to look more into exactly what is the behaviour,
with and without thermal pressure - cooling states, average frequency,
use of CPUs, use of GPU, etc, it would be very valuable.

Thank you,
Ionela.

> 
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
