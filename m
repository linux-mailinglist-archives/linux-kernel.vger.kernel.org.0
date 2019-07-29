Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8164C791D6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 19:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfG2RMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 13:12:54 -0400
Received: from foss.arm.com ([217.140.110.172]:48146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfG2RMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:12:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5BDE337;
        Mon, 29 Jul 2019 10:12:53 -0700 (PDT)
Received: from [10.1.32.39] (unknown [10.1.32.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B40623F694;
        Mon, 29 Jul 2019 10:12:52 -0700 (PDT)
Subject: Re: [PATCH 2/5] sched/deadline: Remove unused int flags from
 __dequeue_task_dl()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-3-dietmar.eggemann@arm.com>
 <20190729163552.GL31398@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <024c56a2-e6cd-948f-4b1b-ebca65a87ee0@arm.com>
Date:   Mon, 29 Jul 2019 18:12:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729163552.GL31398@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 5:35 PM, Peter Zijlstra wrote:
> On Fri, Jul 26, 2019 at 09:27:53AM +0100, Dietmar Eggemann wrote:
>> The int flags parameter is not used in __dequeue_task_dl(). Remove it.
> 
> I just posted a patch(es) that will actually make use of it and extends
> the flags argument into dequeue_dl_entity().
> 
>   https://lkml.kernel.org/r/20190726161357.999133690@infradead.org

I see, I will skip this one then.


