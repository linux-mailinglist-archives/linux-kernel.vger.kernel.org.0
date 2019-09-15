Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1885B3089
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 16:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbfIOOdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 10:33:41 -0400
Received: from foss.arm.com ([217.140.110.172]:35204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731707AbfIOOdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 10:33:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C08528;
        Sun, 15 Sep 2019 07:33:40 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 983603F575;
        Sun, 15 Sep 2019 07:33:39 -0700 (PDT)
Subject: Re: [PATCH] sched: fix migration to invalid cpu in
 __set_cpus_allowed_ptr
To:     shikemeng <shikemeng@huawei.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <979d57f8-802b-57e5-632a-f94ad0f9d6a1@arm.com>
 <1568535662-14956-1-git-send-email-shikemeng@huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <5dfd4844-6c36-3b8d-203b-564d7ad7103d@arm.com>
Date:   Sun, 15 Sep 2019 15:33:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568535662-14956-1-git-send-email-shikemeng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2019 09:21, shikemeng wrote:
>> It's more thoughtful to add check in cpumask_test_cpu.It can solve this problem and can prevent other potential bugs.I will test it and resend
>> a new patch.
>>
> 
> Think again and again. As cpumask_check will fire a warning if cpu >= nr_cpu_ids, it seems that cpumask_check only expects cpu < nr_cpu_ids and it's
> caller's responsibility to very cpu is in valid range. Interfaces like cpumask_test_and_set_cpu, cpumask_test_and_clear_cpu and so on are not checking
> cpu < nr_cpu_ids either and may cause demage if cpu is out of range.
> 

cpumask operations clearly should never be fed CPU numbers > nr_cpu_ids,
but we can get some sneaky mishaps like the one you're fixing. The answer
might just be to have more folks turn on DEBUG_PER_CPU_MAPS in their test
runs (I don't for instance - will do from now on), since I get the feeling
people like to be able to disable these checks for producty kernels.

In any case, don't feel like you have to fix this globally - your fix is
fine on its own.
