Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1E5159E93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 02:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgBLBaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 20:30:08 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37913 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727330AbgBLBaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:30:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TpjeQz9_1581471003;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TpjeQz9_1581471003)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Feb 2020 09:30:04 +0800
Subject: Re: [RFC] why can't dynamic isolation just like the static way
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <fed10a26-7423-23b5-316c-c74d354870dd@linux.alibaba.com>
 <20200211114350.GJ14914@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <4800c9fd-2fbd-df35-cfa9-c048f9fe8b11@linux.alibaba.com>
Date:   Wed, 12 Feb 2020 09:30:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211114350.GJ14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/2/11 下午7:43, Peter Zijlstra wrote:
> On Tue, Feb 11, 2020 at 04:17:34PM +0800, 王贇 wrote:
>> Hi, folks
>>
>> We are dealing with isolcpus these days and try to do the isolation
>> dynamically.
>>
>> The kernel doc lead us into the cpuset.sched_load_balance, it's fine
>> to achieve the dynamic isolation with it, however we got problem with
>> the systemd stuff.
> 
> Then don't use systemd :-) Also, if systemd is the problem, why are you
> bugging us?

Well, that's... fair enough :-P

What we try to understand is why dynamic isolation is so different with
the way of static isolation, is it not good to have a simple way instead?

Regards,
Michael Wang

> 
