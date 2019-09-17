Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60F17B4870
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 09:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392702AbfIQHnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 03:43:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47038 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfIQHnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:43:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4572360364; Tue, 17 Sep 2019 07:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568706182;
        bh=vflV/8MMUN3Fj/OMShwNHZxsSTZi/do+H3s3t7BdeP8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q4OW6MDHpew+SuW/p6UDqocnDIkVaaXrUo0gQDSaMUhVsKhusa1ztu5olN50QPt+s
         JpUQrGLrHIEkEU9Ou5MB78rTkLpspUr0FpBX3WPNoKUxcSMj43HK/DmbKjj2b2P3tb
         NnBG+xZPsGTIqBbreD3l4ihFR3FI/5elStoVS8YI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E95DB60364;
        Tue, 17 Sep 2019 07:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568706179;
        bh=vflV/8MMUN3Fj/OMShwNHZxsSTZi/do+H3s3t7BdeP8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gJdYUhqH0FxSW6fKZD91RDWB/hEsuQx9H7JJThCDB6Y5T6Iaabs3bdGHBJgTY//nL
         il0UEn0O+1pdQ5u6eSZp4V2b9AFaNxlc5d2tgEZ98B48lMSo1v4JKu8mTIzbs22YdE
         dXz+4AZqtO7pbCV2hsjfDqBINvyQJHOQ32tyqy4I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E95DB60364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] perf test: fix spelling mistake "allos" -> "allocate"
To:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190911152148.17031-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2b525705-317a-29a7-9fda-ca7896c8c038@codeaurora.org>
Date:   Tue, 17 Sep 2019 13:12:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190911152148.17031-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/11/2019 8:51 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a TEST_ASSERT_VAL message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Thanks,
Mukesh

> ---
>   tools/perf/tests/event_update.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
> index cac4290e233a..7f0868a31a7f 100644
> --- a/tools/perf/tests/event_update.c
> +++ b/tools/perf/tests/event_update.c
> @@ -92,7 +92,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
>   
>   	evsel = perf_evlist__first(evlist);
>   
> -	TEST_ASSERT_VAL("failed to allos ids",
> +	TEST_ASSERT_VAL("failed to allocate ids",
>   			!perf_evsel__alloc_id(evsel, 1, 1));
>   
>   	perf_evlist__id_add(evlist, evsel, 0, 0, 123);
