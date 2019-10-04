Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7950ECBD3A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 16:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389112AbfJDOaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 10:30:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389076AbfJDOaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:30:23 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C620B9D31335E60E74F4;
        Fri,  4 Oct 2019 22:30:21 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 4 Oct 2019
 22:30:14 +0800
Subject: Re: [PATCH 0/4] HiSilicon hip08 uncore PMU events additions
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
References: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <zhangshaokun@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <27e693fd-124e-1aa8-3b8a-62301a5a1d10@huawei.com>
Date:   Fri, 4 Oct 2019 15:30:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2019 16:54, John Garry wrote:
> This patchset adds some missing uncore PMU events for the hip08 arm64
> platform.
>
> The missing events were originally mentioned in
> https://lkml.org/lkml/2019/6/14/645, when upstreaming the JSONs initially.
>
> It also includes a fix for a DDRC eventname.

Hi guys,

Could I get these JSON updates picked up please? Maybe they were missed 
earlier. Let me know if I should re-post.

Thanks in advance,
John

>
> John Garry (4):
>   perf jevents: Fix Hisi hip08 DDRC PMU eventname
>   perf jevents: Add some missing events for Hisi hip08 DDRC PMU
>   perf jevents: Add some missing events for Hisi hip08 L3C PMU
>   perf jevents: Add some missing events for Hisi hip08 HHA PMU
>
>  .../arm64/hisilicon/hip08/uncore-ddrc.json    | 16 +++++-
>  .../arm64/hisilicon/hip08/uncore-hha.json     | 23 +++++++-
>  .../arm64/hisilicon/hip08/uncore-l3c.json     | 56 +++++++++++++++++++
>  3 files changed, 93 insertions(+), 2 deletions(-)
>


