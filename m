Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A677034226
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 10:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfFDIu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 04:50:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbfFDIu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:50:27 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A3F2418011D589A9DC9A;
        Tue,  4 Jun 2019 16:50:23 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Jun 2019
 16:50:18 +0800
Subject: Re: [PATCH v2 0/2] minor fixes for perf cs-etm
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <arnaldo.melo@gmail.com>
References: <20190321023122.21332-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <b5d842f9-3475-2560-2933-9a1984c1641a@huawei.com>
Date:   Tue, 4 Jun 2019 16:50:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190321023122.21332-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Friendly ping:

Arnaldo, will you take this serial?

On 2019/3/21 10:31, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> v2:
> - patch 1 fix commilt log
> - patch 2 use correct Fixes tag
> 
> This patch series fixes two issue:
> 1. fix pass-zero-to-ERR_PTR warning
> 2. return correct errcode to upstream callers
> 
> YueHaibing (2):
>   perf cs-etm: Remove errnoeous ERR_PTR() usage in in
>     cs_etm__process_auxtrace_info
>   perf cs-etm: return errcode in cs_etm__process_auxtrace_info()
> 
>  tools/perf/util/cs-etm.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

