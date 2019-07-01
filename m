Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C07121CE0D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 19:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfENRck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 13:32:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36864 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfENRcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:32:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EHO0rR149319;
        Tue, 14 May 2019 17:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=FtQCQKb34QOnKlLmREI+FcnpJx4AfZzwX5b5qv0IeYI=;
 b=cujkGyaEZ7wc59g7btd4CZOh+JxJgqteL5fHwDOjAMoNuLV5VKOP67PcvR6N5ghcvkKn
 jm3mQG/XklOnNHn03oj9ZIf5GIsD3NeZczGNEJcpGSscG9cr49WleRWajc3oOM4yBch7
 DXoCfILpXTAJHC+uMCy6A3wkby3VIhK0s3ug9piCe6bKH9QU1rHnQ/HP9s47cfeb6BCx
 TWEETPFGIC8rVsEPzmyAsyyZeoydAVzu/f0J6g6ty9PfXjMvUMB3XTNYMYlOk4ccL9Sx
 8FMpg2HpNG79zwjSeKgQbu9Ni+EXnn3rTK5LxTYbM1rL40XBPZoUYLI8JbXLo6Qt4U8V jQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2sdnttqrrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 17:31:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EHVLVM066018;
        Tue, 14 May 2019 17:31:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2se0tw9nv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 17:31:54 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4EHVpag002689;
        Tue, 14 May 2019 17:31:53 GMT
Received: from [10.132.91.213] (/10.132.91.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 May 2019 17:31:51 +0000
Subject: Re: [RFC V2 2/2] sched/fair: Fallback to sched-idle CPU if idle CPU
 isn't found
To:     Steven Sistare <steven.sistare@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     songliubraving@fb.com, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com, linux-kernel@vger.kernel.org
References: <cover.1556182964.git.viresh.kumar@linaro.org>
 <59b37c56b8fcb834f7d3234e776eaeff74ad117f.1556182965.git.viresh.kumar@linaro.org>
 <20190510072125.GG2623@hirez.programming.kicks-ass.net>
 <20190513093418.altqhlhu4zsu75t4@vireshk-i7>
 <20190513113518.GQ2623@hirez.programming.kicks-ass.net>
 <05ffe5f4-4324-2977-e46e-155e1aef57fa@oracle.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <b5f84cce-8000-d9c9-26ae-e34c9ca53ed5@oracle.com>
Date:   Tue, 14 May 2019 10:27:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <05ffe5f4-4324-2977-e46e-155e1aef57fa@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905140120
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905140120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/14/19 9:03 AM, Steven Sistare wrote:
> On 5/13/2019 7:35 AM, Peter Zijlstra wrote:
>> On Mon, May 13, 2019 at 03:04:18PM +0530, Viresh Kumar wrote:
>>> On 10-05-19, 09:21, Peter Zijlstra wrote:
>>>> I don't hate his per se; but the whole select_idle_sibling() thing is
>>>> something that needs looking at.
>>>>
>>>> There was the task stealing thing from Steve that looked interesting and
>>>> that would render your apporach unfeasible.
>>> I am surely missing something as I don't see how that patchset will
>>> make this patchset perform badly, than what it already does.
>> Nah; I just misremembered. I know Oracle has a patch set poking at
>> select_idle_siblings() _somewhere_ (as do I), and I just found the wrong
>> one.
>>
>> Basically everybody is complaining select_idle_sibling() is too
>> expensive for checking the entire LLC domain, except for FB (and thus
>> likely some other workloads too) that depend on it to kill their tail
>> latency.
>>
>> But I suppose we could still do this, even if we scan only a subset of
>> the LLC, just keep track of the last !idle CPU running only SCHED_IDLE
>> tasks and pick that if you do not (in your limited scan) find a better
>> candidate.
> Subhra posted a patch that incrementally searches for an idle CPU in the LLC,
> remembering the last CPU examined, and searching a fixed number of CPUs from there.
> That technique is compatible with the one that Viresh suggests; the incremental
> search would stop if a SCHED_IDLE cpu was found.
This was the last version of patchset I sent:
https://lkml.org/lkml/2018/6/28/810

Also select_idle_core is a net -ve for certain workloads like OLTP. So I
had put a SCHED_FEAT to be able to disable it.

Thanks,
Subhra
>
> I also fiddled with select_idle_sibling, maintaining a per-LLC bitmap of idle CPUs,
> updated with atomic operations.  Performance was basically unchanged for the
> workloads I tested, and I inserted timers around the idle search showing it was
> a very small fraction of time both before and after my changes.  That led me to
> ignore the push side and optimize the pull side with task stealing.
>
> I would be very interested in hearing from folks that have workloads that demonstrate
> that select_idle_sibling is too expensive.
>
> - Steve
