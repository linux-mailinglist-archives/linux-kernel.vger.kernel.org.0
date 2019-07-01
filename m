Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93AE5A369
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 20:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfF1SXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 14:23:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44924 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1SXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:23:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIJMn3017152;
        Fri, 28 Jun 2019 18:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=lc3OI8QfKibL21v6cTP/3xd9sh8KexW4QRlrEctAsqc=;
 b=eDYJem0eS4CQmZrC8shtxKv0HIxFR58yfhYDr2qrtgB64vTbE/K7CFUnz3UG/wwUwUSz
 dRj7lenowWBIj5m8hNdt/idQqU0pv2c7zQq895OrvRIUKK3spmfKTHLjsBo0M1MnPg2X
 4kIawOTN2pEiVRrqCO3tDM6uDrx/JZpZCAy9L94d/v4YC+pGShhsBqkxCKYBwZdEBcbr
 y3gFGSDB++yBUlrv0VboSiTbA6WNtI5VzT1rjROUJaiP3JCsHI0RvmwhZrrTFCHTHJ5F
 rc1rsm5LHX0roXZx6xVbNyarMeDnfsURXKw6YsHxI4ML3svP2sWDsvnhJIqj0bGcxPLU Sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t9c9q71ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:22:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIKqbp123993;
        Fri, 28 Jun 2019 18:20:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t9p6w1x0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:20:52 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5SIKi58018231;
        Fri, 28 Jun 2019 18:20:44 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 11:20:43 -0700
Subject: Re: [Question] Should direct reclaim time be bounded?
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <d38a095e-dc39-7e82-bb76-2c9247929f07@oracle.com>
 <20190423071953.GC25106@dhcp22.suse.cz>
 <eac582cf-2f76-4da1-1127-6bb5c8c959e4@oracle.com>
 <04329fea-cd34-4107-d1d4-b2098ebab0ec@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <dede2f84-90bf-347a-2a17-fb6b521bf573@oracle.com>
Date:   Fri, 28 Jun 2019 11:20:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <04329fea-cd34-4107-d1d4-b2098ebab0ec@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280206
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 7:35 AM, Vlastimil Babka wrote:
> On 4/23/19 6:39 PM, Mike Kravetz wrote:
>>> That being said, I do not think __GFP_RETRY_MAYFAIL is wrong here. It
>>> looks like there is something wrong in the reclaim going on.
>>
>> Ok, I will start digging into that.  Just wanted to make sure before I got
>> into it too deep.
>>
>> BTW - This is very easy to reproduce.  Just try to allocate more huge pages
>> than will fit into memory.  I see this 'reclaim taking forever' behavior on
>> v5.1-rc5-mmotm-2019-04-19-14-53.  Looks like it was there in v5.0 as well.
> 
> I'd suspect this in should_continue_reclaim():
> 
>         /* Consider stopping depending on scan and reclaim activity */
>         if (sc->gfp_mask & __GFP_RETRY_MAYFAIL) {
>                 /*
>                  * For __GFP_RETRY_MAYFAIL allocations, stop reclaiming if the
>                  * full LRU list has been scanned and we are still failing
>                  * to reclaim pages. This full LRU scan is potentially
>                  * expensive but a __GFP_RETRY_MAYFAIL caller really wants to succeed
>                  */
>                 if (!nr_reclaimed && !nr_scanned)
>                         return false;
> 
> And that for some reason, nr_scanned never becomes zero. But it's hard
> to figure out through all the layers of functions :/

I got back to looking into the direct reclaim/compaction stalls when
trying to allocate huge pages.  As previously mentioned, the code is
looping for a long time in shrink_node().  The routine
should_continue_reclaim() returns true perhaps more often than it should.

As Vlastmil guessed, my debug code output below shows nr_scanned is remaining
non-zero for quite a while.  This was on v5.2-rc6.

To help determine what is happening, I added a counter to determine how many
times should_continue_reclaim was returning true within one calling context
from shrink_node.  Every 1,000,000 calls, I set a 'debug flag' to get a little
more information about what is happening before the next call.  Here is output
from debug code with some comments about what the debug code is showing.

[ 1477.583859] ***should_continue_reclaim: setting debug_nr_scanned call 1000000
[ 1477.584698] shrink_inactive_list: nr_taken 1 =  isolate_lru_pages(1, ...

shrink_node calls shrink_node_memcg which calls shrink_list.  shrink_list
can increment sc->nr_scanned which is used to compute the value of nr_scanned
passed to should_continue_reclaim.  Here, we see that only one page is
isolated for potential reclaim.

[ 1477.585465] shrink_page_list: goto activate_locked 4

shrink_page_list determines that the page can not be reclaimed.  The following
code in shrink_page_list determines this.

                if (page_has_private(page)) {
                        if (!try_to_release_page(page, sc->gfp_mask))
{
/* Obviously, my debug code. */
if (sc->debug_nr_scanned)
  printk("shrink_page_list: goto activate_locked 4\n");
                                goto activate_locked;
}

[ 1477.586044] shrink_inactive_list: nr_reclaimed = 0

The bottom line is that page is not reclaimed.  But, it was 'scanned' so ..

[ 1477.586627] ***should_continue_reclaim: sc->nr_reclaimed 9 pages_for_compaction  1024
[ 1477.587546]            nr_reclaimed 0, nr_scanned 1

should_continue_reclaim is called with nr_reclaimed 0, nr_scanned 1

[ 1477.588124]            inactive_lru_pages 1 sc->nr_scanned 1000001

Since sc->nr_scanned is 1000001 for 1000001 calls, it looks like we scanned
one page each time.

Additional similar output without comments.

[ 1511.200515] ***should_continue_reclaim: setting debug_nr_scanned call 2000000
[ 1511.201581] shrink_inactive_list: nr_taken 1 =  isolate_lru_pages(1, ...
[ 1511.202615] shrink_page_list: goto activate_locked 4
[ 1511.203561] shrink_inactive_list: nr_reclaimed = 0
[ 1511.204422] ***should_continue_reclaim: sc->nr_reclaimed 10 pages_for_compaction  1024
[ 1511.205785]            nr_reclaimed 0, nr_scanned 1
[ 1511.206569]            inactive_lru_pages 1 sc->nr_scanned 2000001
[ 1543.982310] ***should_continue_reclaim: setting debug_nr_scanned call 3000000
[ 1543.983692] shrink_inactive_list: nr_taken 1 =  isolate_lru_pages(1, ...
[ 1543.984645] shrink_page_list: goto activate_locked 4
[ 1543.985405] shrink_inactive_list: nr_reclaimed = 0
[ 1543.986386] ***should_continue_reclaim: sc->nr_reclaimed 11 pages_for_compaction  1024
[ 1543.987662]            nr_reclaimed 0, nr_scanned 1
[ 1543.988423]            inactive_lru_pages 1 sc->nr_scanned 3000001
[ 1577.104923] ***should_continue_reclaim: setting debug_nr_scanned call 4000000
[ 1577.105857] shrink_inactive_list: nr_taken 1 =  isolate_lru_pages(1, ...
[ 1577.106752] shrink_page_list: goto activate_locked 4
[ 1577.107454] shrink_inactive_list: nr_reclaimed = 0
[ 1577.108163] ***should_continue_reclaim: sc->nr_reclaimed 11 pages_for_compaction  1024
[ 1577.109423]            nr_reclaimed 0, nr_scanned 1
[ 1577.110205]            inactive_lru_pages 1 sc->nr_scanned 4000001
[ 1614.075236] ***should_continue_reclaim: setting debug_nr_scanned call 5000000
[ 1614.076375] shrink_inactive_list: nr_taken 1 =  isolate_lru_pages(1, ...
[ 1614.077410] shrink_page_list: goto activate_locked 4
[ 1614.078210] shrink_inactive_list: nr_reclaimed = 0
[ 1614.078913] ***should_continue_reclaim: sc->nr_reclaimed 13 pages_for_compaction  1024
[ 1614.079907]            nr_reclaimed 0, nr_scanned 1
[ 1614.080496]            inactive_lru_pages 1 sc->nr_scanned 5000001
[ 1650.360466] ***should_continue_reclaim: setting debug_nr_scanned call 6000000
[ 1650.361342] shrink_inactive_list: nr_taken 1 =  isolate_lru_pages(1, ...
[ 1650.362147] shrink_page_list: goto activate_locked 4
[ 1650.362759] shrink_inactive_list: nr_reclaimed = 0
[ 1650.363685] ***should_continue_reclaim: sc->nr_reclaimed 13 pages_for_compaction  1024
[ 1650.364648]            nr_reclaimed 0, nr_scanned 1
[ 1650.365222]            inactive_lru_pages 0 sc->nr_scanned 6000001
[ 1685.061380] ***should_continue_reclaim: setting debug_nr_scanned call 7000000
[ 1685.062529] shrink_inactive_list: nr_taken 1 =  isolate_lru_pages(1, ...
[ 1685.063615] shrink_page_list: goto activate_locked 4
[ 1685.064439] shrink_inactive_list: nr_reclaimed = 0
[ 1685.065244] ***should_continue_reclaim: sc->nr_reclaimed 14 pages_for_compaction  1024
[ 1685.066536]            nr_reclaimed 0, nr_scanned 1
[ 1685.067356]            inactive_lru_pages 1 sc->nr_scanned 7000001
[ 1719.103176] ***should_continue_reclaim: setting debug_nr_scanned call 8000000
[ 1719.104206] shrink_inactive_list: nr_taken 1 =  isolate_lru_pages(1, ...
[ 1719.105117] shrink_page_list: goto activate_locked 4
[ 1719.105781] shrink_inactive_list: nr_reclaimed = 0
[ 1719.106475] ***should_continue_reclaim: sc->nr_reclaimed 15 pages_for_compaction  1024
[ 1719.107499]            nr_reclaimed 0, nr_scanned 1
[ 1719.108129]            inactive_lru_pages 1 sc->nr_scanned 8000001
[ 1743.911025] ***should_continue_reclaim: false after 8711717 calls !nr_reclaimed && !nr_scanned

Note that we do reclaim a 'few' pages along the way.  After 8711717 calls
should_continue_reclaim finally hits the condition where (!nr_reclaimed &&
!nr_scanned) and returns false.  We were stuck looping in shrink node for
about 5 minutes.

Any additional insight, suggestions for additional debug, etc. would be
appreciated.
-- 
Mike Kravetz
