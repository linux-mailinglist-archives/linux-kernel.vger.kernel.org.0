Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2868F09B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 18:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfHOQ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 12:29:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51126 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbfHOQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:29:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FGDTSg011948;
        Thu, 15 Aug 2019 16:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=vkKETXjPD+eKdpGgSZfhHFVvadthPMbdraOIfxesJXE=;
 b=XGBROI7fYHPACvVD46f8e6VYaBS5Vomhm5+4NdWDXCqJQmZfcQfDHxGzqdvM+o5YSmno
 EW3ARtQqEyDgDumY84t1evbPb+mUYTJa/rLCbzybGAZoT1iqLBW7qTT2nlmMIAoukG+1
 JI/LXVo4Bm84AFfrdkoiZmtLQMMST78GMLkkF5ZjnN/nvP3YL12khNVDZihCcPPbxAAn
 oX5353AQZErU4o/5tQTylV00+dfA6H4FqhTRixH0ZOJJGUWTz3LUebyzeIrmDS2YdSU3
 +fw3Wzm0Pz07Qd6Be3dnFytY1GdE6Rlk5S62pSQ8ORg0hGScQ8W/lVFVtb14RKDUyykI YQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u9nvpkssg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 16:27:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7FGCmn6093844;
        Thu, 15 Aug 2019 16:27:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ucpysh0qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 16:27:39 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7FGRXaM000421;
        Thu, 15 Aug 2019 16:27:33 GMT
Received: from [192.168.1.16] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 09:27:33 -0700
Subject: Re: [RFC PATCH 0/2] Add predictive memory reclamation and compaction
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz,
        mgorman@techsingularity.net, dan.j.williams@intel.com,
        osalvador@suse.de, richard.weiyang@gmail.com, hannes@cmpxchg.org,
        arunks@codeaurora.org, rppt@linux.vnet.ibm.com, jgg@ziepe.ca,
        amir73il@gmail.com, alexander.h.duyck@linux.intel.com,
        linux-mm@kvack.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20190813014012.30232-1-khalid.aziz@oracle.com>
 <20190813140553.GK17933@dhcp22.suse.cz>
 <3cb0af00-f091-2f3e-d6cc-73a5171e6eda@oracle.com>
 <20190814085831.GS17933@dhcp22.suse.cz>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <d3895804-7340-a7ae-d611-62913303e9c5@oracle.com>
Date:   Thu, 15 Aug 2019 10:27:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814085831.GS17933@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9350 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/19 2:58 AM, Michal Hocko wrote:
> On Tue 13-08-19 09:20:51, Khalid Aziz wrote:
>> On 8/13/19 8:05 AM, Michal Hocko wrote:
>>> On Mon 12-08-19 19:40:10, Khalid Aziz wrote:
>>> [...]
>>>> Patch 1 adds code to maintain a sliding lookback window of (time, nu=
mber
>>>> of free pages) points which can be updated continuously and adds cod=
e to
>>>> compute best fit line across these points. It also adds code to use =
the
>>>> best fit lines to determine if kernel must start reclamation or
>>>> compaction.
>>>>
>>>> Patch 2 adds code to collect data points on free pages of various or=
ders
>>>> at different points in time, uses code in patch 1 to update sliding
>>>> lookback window with these points and kicks off reclamation or
>>>> compaction based upon the results it gets.
>>>
>>> An important piece of information missing in your description is why
>>> do we need to keep that logic in the kernel. In other words, we have
>>> the background reclaim that acts on a wmark range and those are tunab=
le
>>> from the userspace. The primary point of this background reclaim is t=
o
>>> keep balance and prevent from direct reclaim. Why cannot you implemen=
t
>>> this or any other dynamic trend watching watchdog and tune watermarks=

>>> accordingly? Something similar applies to kcompactd although we might=
 be
>>> lacking a good interface.
>>>
>>
>> Hi Michal,
>>
>> That is a very good question. As a matter of fact the initial prototyp=
e
>> to assess the feasibility of this approach was written in userspace fo=
r
>> a very limited application. We wrote the initial prototype to monitor
>> fragmentation and used /sys/devices/system/node/node*/compact to trigg=
er
>> compaction. The prototype demonstrated this approach has merits.
>>
>> The primary reason to implement this logic in the kernel is to make th=
e
>> kernel self-tuning.
>=20
> What makes this particular self-tuning an universal win? In other words=

> there are many ways to analyze the memory pressure and feedback it back=

> that I can think of. It is quite likely that very specific workloads
> would have very specific demands there. I have seen cases where are
> trivial increase of min_free_kbytes to normally insane value worked
> really great for a DB workload because the wasted memory didn't matter
> for example.

Hi Michal,

The problem is not so much as do we have enough knobs available, rather
how do we tweak them dynamically to avoid allocation stalls. Knobs like
watermarks and min_free_kbytes are set once typically and left alone.
Allocation stalls show up even on much smaller scale than large DB or
cloud platforms. I have seen it on a desktop class machine running a few
services in the background. Desktop is running gnome3, I would lock the
screen and come back to unlock it a day or two later. In that time most
of memory has been consumed by buffer/page cache. Just unlocking the
screen can take 30+ seconds while system reclaims pages to be able swap
back in all the processes that were inactive so far.

It is true different workloads will have different requirements and that
is what I am attempting to address here. Instead of tweaking the knobs
statically based upon one workload requirements, I am looking at the
trend of memory consumption instead. A best fit line showing recent
trend can be quite indicative of what the workload is doing in terms of
memory. For instance, a cloud server might be running a certain number
of instances for a few days and it can end up using any memory not used
up by tasks, for buffer/page cache. Now the sys admin gets a request to
launch another instance and when they try to to do that, system starts
to allocate pages and soon runs out of free pages. We are now in direct
reclaim path and it can take significant amount of time to find all free
pages the new task needs. If the kernel were watching the memory
consumption trend instead, it could see that the trend line shows a
complete exhaustion of free pages or 100% fragmentation in near future,
irrespective of what the workload is. This allows kernel to start
reclamation/compaction before we actually hit the point of complete free
page exhaustion or fragmentation. This could avoid direct
reclamation/compaction or at least cut down its severity enough. That is
what makes it a win in large number of cases. Least square algorithm is
lightweight enough to not add to system load or complexity. If you have
come across a better algorithm, I certainly would look into using that.

>=20
>> The more knobs we have externally, the more complex
>> it becomes to tune the kernel externally.
>=20
> I agree on this point. Is the current set of tunning sufficient? What
> would be missing if not?
>=20

We have knob available to force compaction immediately. That is helpful
and in some case, sys admins have resorted to forcing compaction on all
zones before launching a new cloud instance or loading a new database.
Some admins have resorted to using /proc/sys/vm/drop_caches to force
buffer/page cache pages to be freed up. Either of these solutions causes
system load to go up immediately while kswapd/kcompactd run to free up
and compact pages. This is far from ideal. Other knobs available seem to
be hard to set correctly especially on servers that run mixed workloads
which results in a regular stream of customer complaints coming in about
system stalling at most inopportune times.

I appreciate this discussion. This is how we can get to a solution that
actually works.

Thanks,
Khalid


