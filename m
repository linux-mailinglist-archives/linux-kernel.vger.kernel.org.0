Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D48E7132379
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 11:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgAGKW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 05:22:29 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3185 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAGKW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 05:22:29 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e145bd30000>; Tue, 07 Jan 2020 02:22:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 02:22:28 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 02:22:28 -0800
Received: from [10.26.11.139] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jan
 2020 10:22:25 +0000
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
To:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20191211232345.24810-1-robh@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5386e959-f9c4-2748-ed08-34ab361aee2c@nvidia.com>
Date:   Tue, 7 Jan 2020 10:22:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211232345.24810-1-robh@kernel.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578392531; bh=pZOwoicuGzDQd1U0YBhLFXjqBk3xDuq3KIS9DJuzeqg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Fu1t6kd5QjIX/WAqo0zfZpkiKHVDQsWBSLW12yIzT+3dZgyqI7cYdWggegRclRGdK
         bYQBG4sm8FyNerWG6eQxY/LSjBvxOt7rrl1l6ImSBM+dOWaIgvi5KNCjwARzFZAU3D
         e4+8fCWkfTYP9xidERQWD6tcefnOf/XpaRoT0UAjTi1OcsZfv+98cOftVo5TWRik08
         bp2JgaPord3mO02jH/rs6pM0yYkbWmlxc4G/xFDCoL6UTQJIhG/v0IN4gH9mYG8cWU
         gFWXzzCvFkxiYlidP1IVYUB3uCoDr6oZzAP4pamADOxehnm5o4105sqLlA5a/PAXtp
         52IwzbO3Yn1ww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 11/12/2019 23:23, Rob Herring wrote:
> The phandle cache was added to speed up of_find_node_by_phandle() by
> avoiding walking the whole DT to find a matching phandle. The
> implementation has several shortcomings:
> 
>   - The cache is designed to work on a linear set of phandle values.
>     This is true for dtc generated DTs, but not for other cases such as
>     Power.
>   - The cache isn't enabled until of_core_init() and a typical system
>     may see hundreds of calls to of_find_node_by_phandle() before that
>     point.
>   - The cache is freed and re-allocated when the number of phandles
>     changes.
>   - It takes a raw spinlock around a memory allocation which breaks on
>     RT.
> 
> Change the implementation to a fixed size and use hash_32() as the
> cache index. This greatly simplifies the implementation. It avoids
> the need for any re-alloc of the cache and taking a reference on nodes
> in the cache. We only have a single source of removing cache entries
> which is of_detach_node().
> 
> Using hash_32() removes any assumption on phandle values improving
> the hit rate for non-linear phandle values. The effect on linear values
> using hash_32() is about a 10% collision. The chances of thrashing on
> colliding values seems to be low.
> 
> To compare performance, I used a RK3399 board which is a pretty typical
> system. I found that just measuring boot time as done previously is
> noisy and may be impacted by other things. Also bringing up secondary
> cores causes some issues with measuring, so I booted with 'nr_cpus=1'.
> With no caching, calls to of_find_node_by_phandle() take about 20124 us
> for 1248 calls. There's an additional 288 calls before time keeping is
> up. Using the average time per hit/miss with the cache, we can calculate
> these calls to take 690 us (277 hit / 11 miss) with a 128 entry cache
> and 13319 us with no cache or an uninitialized cache.
> 
> Comparing the 3 implementations the time spent in
> of_find_node_by_phandle() is:
> 
> no cache:        20124 us (+ 13319 us)
> 128 entry cache:  5134 us (+ 690 us)
> current cache:     819 us (+ 13319 us)
> 
> We could move the allocation of the cache earlier to improve the
> current cache, but that just further complicates the situation as it
> needs to be after slab is up, so we can't do it when unflattening (which
> uses memblock).
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

With next-20200106 I have noticed a regression on Tegra210 where it
appears that only one of the eMMC devices is being registered. Bisect is
pointing to this patch and reverting on top of next fixes the problem.
That is as far as I have got so far, so if you have any ideas, please
let me know. Unfortunately, there do not appear to be any obvious errors
from the bootlog.

Thanks
Jon

-- 
nvpublic
