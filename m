Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4C42A392
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2019 11:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfEYJCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 May 2019 05:02:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17566 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726376AbfEYJCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 05:02:33 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5CA1D8ED1F0315A48D92;
        Sat, 25 May 2019 17:02:29 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.180) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Sat, 25 May 2019
 17:02:25 +0800
Subject: Re: [PATCH] kernel: sysctl: change ipfrag_high/low_thresh to
 CTL_ULONG
To:     Eric Dumazet <edumazet@google.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20190524143827.43301-1-wangkefeng.wang@huawei.com>
 <CANn89i+rSEJ3Rqd5JW-w7aLzETMX89Qgg3wne9Ae7WWDBe3yZg@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <049648ab-0e51-c079-b7c8-c9022cae20b4@huawei.com>
Date:   Sat, 25 May 2019 17:00:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CANn89i+rSEJ3Rqd5JW-w7aLzETMX89Qgg3wne9Ae7WWDBe3yZg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.19.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/5/24 23:00, Eric Dumazet wrote:
> On Fri, May 24, 2019 at 7:30 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> 3e67f106f619 ("inet: frags: break the 2GB limit for frags storage"),
>> changes ipfrag_high/low_thread 'type' from int to long, using CTL_ULONG
>> instead of CTL_INT to keep consistent.
>
> What about  compatibility with existing applications ?
> Will there sysctl() fail if they provide 32bit variable ?
>
> /proc/sys/net  files are text files, but sysctl() system call has been
> discouraged for more than a decade.

The sysctl() system call is deprecated, so the main purpose of this patch is to keep consistent,

but it does set wrong value(eg, set 16000000000 to ipfrag_high_thresh) when use sysctl().


>
>

