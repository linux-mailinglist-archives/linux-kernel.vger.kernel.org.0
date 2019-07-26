Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 051F976296
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 11:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfGZJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 05:32:52 -0400
Received: from foss.arm.com ([217.140.110.172]:40232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfGZJcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:32:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CAA3344;
        Fri, 26 Jul 2019 02:32:51 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B89D3F71A;
        Fri, 26 Jul 2019 02:32:50 -0700 (PDT)
Subject: Re: [PATCH 4/5] sched/deadline: Cleanup on_dl_rq() handling
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-5-dietmar.eggemann@arm.com>
 <0f460dba-4677-00de-59a2-5cd31ffe6e4b@arm.com>
 <20190726092005.GO25636@localhost.localdomain>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <d95ffb59-ad54-f775-7a9d-0806051539e0@arm.com>
Date:   Fri, 26 Jul 2019 10:32:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190726092005.GO25636@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2019 10:20, Juri Lelli wrote:
>> Any idea why a similar error leads to a BUG_ON() in the enqueue path but
>> only a silent return on the dequeue path? I would expect the handling to be
>> almost identical.
>>  
> 
> Task could have already been dequeued by update_curr_dl()->throttle
> called by dequeue_task_dl() before calling __dequeue_task_dl().
> 

Got it, thanks.

> Thanks,
> 
> Juri
> 
