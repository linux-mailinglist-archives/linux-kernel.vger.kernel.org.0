Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303C01265C9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 16:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfLSPbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 10:31:17 -0500
Received: from relay.sw.ru ([185.231.240.75]:56494 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbfLSPbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:31:15 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ihxlV-00078I-67; Thu, 19 Dec 2019 18:31:01 +0300
Subject: Re: [Q] ld: Does LTO reorder ro variables in two files?
To:     law@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        gcc-help@gcc.gnu.org
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
 <20191219131242.GK2827@hirez.programming.kicks-ass.net>
 <3db1b1c8-0228-56e4-a04f-e8d24cd1dd51@virtuozzo.com>
 <db7acdee9a85ce5b74332b3869efa6c9e18bad9e.camel@redhat.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <15d40d09-3258-9b78-7120-bc708a429855@virtuozzo.com>
Date:   Thu, 19 Dec 2019 18:30:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <db7acdee9a85ce5b74332b3869efa6c9e18bad9e.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.12.2019 18:21, Jeff Law wrote:
> On Thu, 2019-12-19 at 17:04 +0300, Kirill Tkhai wrote:
>> CC: gcc-help@gcc.gnu.org
>>
>> Hi, gcc guys,
>>
>> this thread starts here: https://lkml.org/lkml/2019/12/19/403
>>
>> There are two const variables:
>>
>>    struct sched_class idle_sched_class
>> and
>>    struct sched_class fair_sched_class,
>>
>> which are declared in two files idle.c and fair.c.
>>
>> 1)In Makefile the order is: idle.o fair.o
>> 2)the variables go to the same ro section
>> 3)there is no SORT(.*) keyword in linker script.
>>
>> Is it always true, that after linkage &idle_sched_class < &fair_sched_class?
> I certainly wouldn't depend on it.   The first and most obvious problem
> is symbol sorting by the linker.  Longer term I'd be worried about LTO
> reordering things.
> 
> In the end I'm pretty sure it'd be well outside what I'd be comfortable
> depending on.

Ok, I'd be comfortable too :) Thanks for the clarification, Jeff.
