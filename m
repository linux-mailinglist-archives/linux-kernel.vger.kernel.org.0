Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C844E157F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 11:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403769AbfJWJOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 05:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732361AbfJWJOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:14:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3396A2084B;
        Wed, 23 Oct 2019 09:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571822062;
        bh=J/0NYI9vPeRWmzOPUYf2ExKt6m2NpJRlNiOPTe8xGOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuZs8gJo5L4/OdewVJj5asGrwjUdbbjQ8tuc/NvvVifrv/GI7BKGvIID8GfYU6mZZ
         DSuwL1Twcouv29gCbCEqeGrfbZMSNnJJNAnCfBpfcYwzfbKlPcu6xf5Fxcsmx/WSNM
         vLXAIFlJV8dOjIO7N5rD978d/PYKBeGArlzLl2lg=
Date:   Wed, 23 Oct 2019 10:14:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests: Fix a typo
Message-ID: <20191023091416.GB25798@willie-the-truck>
References: <20191023083324.12093-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023083324.12093-1-leo.yan@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 04:33:24PM +0800, Leo Yan wrote:
> Correct typo in comment: s/suck/stuck.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/bp_signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> index 166f411568a5..415903b48578 100644
> --- a/tools/perf/tests/bp_signal.c
> +++ b/tools/perf/tests/bp_signal.c
> @@ -295,7 +295,7 @@ bool test__bp_signal_is_supported(void)
>  	 * breakpointed instruction.
>  	 *
>  	 * Since arm64 has the same issue with arm for the single-step
> -	 * handling, this case also gets suck on the breakpointed
> +	 * handling, this case also gets stuck on the breakpointed
>  	 * instruction.
>  	 *
>  	 * Just disable the test for these architectures until these

Thanks, and sorry for only spotting this after the offending patch was
merged.

Will
