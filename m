Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF891787DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfG2I7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 04:59:31 -0400
Received: from foss.arm.com ([217.140.110.172]:40234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbfG2I7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:59:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09400337;
        Mon, 29 Jul 2019 01:59:31 -0700 (PDT)
Received: from [10.1.32.39] (unknown [10.1.32.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEC823F575;
        Mon, 29 Jul 2019 01:59:29 -0700 (PDT)
Subject: Re: [PATCH 1/5] sched/deadline: Fix double accounting of rq/running
 bw in push_dl_task()
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-2-dietmar.eggemann@arm.com>
 <20190726121159.10fd1138@sweethome>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <531f753a-57ba-408f-42e0-15252d7b1c32@arm.com>
Date:   Mon, 29 Jul 2019 09:59:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726121159.10fd1138@sweethome>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 11:11 AM, luca abeni wrote:
> Hi Dietmar,
> 
> On Fri, 26 Jul 2019 09:27:52 +0100
> Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> 
>> push_dl_task() always calls deactivate_task() with flags=0 which sets
>> p->on_rq=TASK_ON_RQ_MIGRATING.
> 
> Uhm... This is a recent change in the deactivate_task() behaviour,
> right? Because I tested SCHED_DEADLINE a lot, but I've never seen this
> issue :)

Looks like it was v5.2 commit 7dd778841164 ("sched/core: Unify p->on_rq
updates").

> Anyway, looking at the current code the change looks OK. Thanks for
> fixing this issue!

[...]
