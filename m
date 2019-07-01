Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF7142691
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 14:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439268AbfFLMtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 08:49:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:32840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439257AbfFLMtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:49:16 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D58236C600BA13826720;
        Wed, 12 Jun 2019 20:49:11 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Jun 2019
 20:49:07 +0800
Subject: Re: [PATCH v11 0/3] remain and optimize memblock_next_valid_pfn on
 arm and arm64
To:     Jia He <hejianet@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Petr Tesarik <ptesarik@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "AKASHI Takahiro" <takahiro.akashi@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>,
        Laura Abbott <labbott@redhat.com>,
        "Daniel Vacek" <neelx@redhat.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        "Kees Cook" <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        "Jia He" <jia.he@hxt-semitech.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Steve Capper <steve.capper@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        "Philip Derrin" <philip@cog.systems>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
 <CAKv+Gu9u8RcrzSHdgXiqHS9HK1aSrjbPxVUSCP0DT4erAhx0pw@mail.gmail.com>
 <20180907144447.GD12788@arm.com>
 <84b8e874-2a52-274c-4806-968470e66a08@huawei.com>
 <CAKv+Gu9fd2Y7USDYnQdUuYd9L2OD99kU4A1x1JSF442KN96TTA@mail.gmail.com>
 <2de74de9-35b0-5e62-d822-1be59f0ef605@huawei.com>
 <8fdf5545-21b7-354c-4c4b-e1e92048864f@gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <ed84966f-81ed-3be9-5b21-1fd92deea3cc@huawei.com>
Date:   Wed, 12 Jun 2019 20:48:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <8fdf5545-21b7-354c-4c4b-e1e92048864f@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/12 9:05, Jia He wrote:
>>
>>> So what I would like to see is the patch set being proposed again,
>>> with the new data points added for documentation. Also, the commit
>>> logs need to crystal clear about how the meaning of PFN validity
>>> differs between ARM and other architectures, and why the assumptions
>>> that the optimization is based on are guaranteed to hold.
>> I think Jia He no longer works for HXT, if don't mind, I can repost
>> this patch set with Jia He's authority unchanged.
> Ok, I don't mind that, thanks for your followup :)

That's great, I will prepare a new version with Ard's comments addressed
then repost.

Thanks
Hanjun

