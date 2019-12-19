Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D7B126436
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 15:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfLSOFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 09:05:00 -0500
Received: from relay.sw.ru ([185.231.240.75]:53412 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfLSOFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:05:00 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ihwQ6-0006RQ-DH; Thu, 19 Dec 2019 17:04:50 +0300
Subject: [Q] ld: Does LTO reorder ro variables in two files?
To:     Peter Zijlstra <peterz@infradead.org>, gcc-help@gcc.gnu.org
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
References: <157675913272.349305.8936736338884044103.stgit@localhost.localdomain>
 <20191219131242.GK2827@hirez.programming.kicks-ass.net>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3db1b1c8-0228-56e4-a04f-e8d24cd1dd51@virtuozzo.com>
Date:   Thu, 19 Dec 2019 17:04:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191219131242.GK2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: gcc-help@gcc.gnu.org

Hi, gcc guys,

this thread starts here: https://lkml.org/lkml/2019/12/19/403

There are two const variables:

   struct sched_class idle_sched_class
and
   struct sched_class fair_sched_class,

which are declared in two files idle.c and fair.c.

1)In Makefile the order is: idle.o fair.o
2)the variables go to the same ro section
3)there is no SORT(.*) keyword in linker script.

Is it always true, that after linkage &idle_sched_class < &fair_sched_class?

Thanks!
Kirill

On 19.12.2019 16:12, Peter Zijlstra wrote:
> On Thu, Dec 19, 2019 at 03:39:14PM +0300, Kirill Tkhai wrote:
>> In kernel/sched/Makefile files, describing different sched classes, already
>> go in the order from the lowest priority class to the highest priority class:
>>
>> idle.o fair.o rt.o deadline.o stop_task.o
>>
>> The documentation of GNU linker says, that section appears in the order
>> they are seen during link time (see [1]):
>>
>>> Normally, the linker will place files and sections matched by wildcards
>>> in the order in which they are seen during the link. You can change this
>>> by using the SORT keyword, which appears before a wildcard pattern
>>> in parentheses (e.g., SORT(.text*)).
>>
>> So, we may expect const variables from idle.o will go before ro variables
>> from fair.o in RO_DATA section, while ro variables from fair.o will go
>> before ro variables from rt.o, etc.
>>
>> (Also, it looks like the linking order is already used in kernel, e.g.
>>  in drivers/md/Makefile)
>>
>> Thus, we may introduce an optimization based on xxx_sched_class addresses
>> in these two hot scheduler functions: pick_next_task() and check_preempt_curr().
>>
>> One more result of the patch is that size of object file becomes a little
>> less (excluding added BUG_ON(), which goes in __init section):
>>
>> $size kernel/sched/core.o
>>          text     data      bss	    dec	    hex	filename
>> before:  66446    18957	    676	  86079	  1503f	kernel/sched/core.o
>> after:   66398    18957	    676	  86031	  1500f	kernel/sched/core.o
> 
> Does LTO preserve this behaviour? I've never quite dared do this exact
> optimization.

