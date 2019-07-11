Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0035E65918
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbfGKOdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 10:33:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2255 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728045AbfGKOdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:33:18 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2283CA73C648BEC2DA7B;
        Thu, 11 Jul 2019 22:33:15 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 11 Jul 2019
 22:33:10 +0800
Subject: Re: [PATCH v2 0/2] minor fixes for perf cs-etm
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <arnaldo.melo@gmail.com>
References: <20190321023122.21332-1-yuehaibing@huawei.com>
 <b5d842f9-3475-2560-2933-9a1984c1641a@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <d178fc8c-7e6c-0272-4ead-9b4ee15d1e7d@huawei.com>
Date:   Thu, 11 Jul 2019 22:33:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <b5d842f9-3475-2560-2933-9a1984c1641a@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnaldo, can you pick this?

On 2019/6/4 16:50, Yuehaibing wrote:
> Hi,
> 
> Friendly ping:
> 
> Arnaldo, will you take this serial?
> 
> On 2019/3/21 10:31, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> v2:
>> - patch 1 fix commilt log
>> - patch 2 use correct Fixes tag
>>
>> This patch series fixes two issue:
>> 1. fix pass-zero-to-ERR_PTR warning
>> 2. return correct errcode to upstream callers
>>
>> YueHaibing (2):
>>   perf cs-etm: Remove errnoeous ERR_PTR() usage in in
>>     cs_etm__process_auxtrace_info
>>   perf cs-etm: return errcode in cs_etm__process_auxtrace_info()
>>
>>  tools/perf/util/cs-etm.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
> 
> 
> .
> 

