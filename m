Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F90D18AEE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 15:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEINqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 May 2019 09:46:32 -0400
Received: from foss.arm.com ([217.140.101.70]:41876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfEINqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 09:46:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B169374;
        Thu,  9 May 2019 06:46:31 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF8C73F738;
        Thu,  9 May 2019 06:46:28 -0700 (PDT)
Date:   Thu, 9 May 2019 14:46:27 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 6/6] sched/dl: Try not to select a too fast core
Message-ID: <20190509134626.toay67p6ky2i5pju@queper01-lin>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
 <20190506044836.2914-7-luca.abeni@santannapisa.it>
 <20190507155732.7ravrnld54rb6k5a@queper01-lin>
 <20190508082605.623ed4d5@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508082605.623ed4d5@nowhere>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Wednesday 08 May 2019 at 08:26:05 (+0200), luca abeni wrote:
> Mainly two reasons: the first one is to try to reduce frequency
> switches (I did not perform measurements on the hikey960, I remember
> that on other CPUs a frequency switch can take a considerable amount of
> time).

Right, though if you want to use DL and scale frequency on these systems
the only 'safe' thing to do is probably to account for the frequency
switch delay in the runtime parameter of your DL tasks ...

> Then, I wanted to have a mechanism that can work with all the possible
> cpufreq governors... So, I did not assume that the frequency can change
> (for example, I remember that without considering the current
> frequency I had issues when using the "userspace" governor).

But this is a problem I agree. OTOH it is also true that 'userspace' has
a much weaker use-case than sugov for asymmetric systems where we
typically care about energy and do 'proper' DVFS. So, I'd say we really
shouldn't assume the frequencies won't change.

DL is already sub-optimal on SMP if the user sets arbitrary frequencies
for the CPUs no ? So perhaps this problem could be solved in different
patch series ?

> Maybe I just do not know this kernel subsystem well enough, but I did
> not find any way to know the maximum frequency that the current
> governor can set (I mean, I found a "maximum frequency" field that
> tells me the maximum frequency that the cpufreq driver can set, but I
> do not know if the governor will be able to set it --- again, consider
> the "userspace" governor).

Right, we'd probably need more infrastructure to do this, but I'm not
sure how deep we'll need to go ...

Thanks,
Quentin
