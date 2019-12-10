Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE14118B00
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 15:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLJOe6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Dec 2019 09:34:58 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:56928 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727407AbfLJOe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:34:57 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19527916-1500050 
        for multiple; Tue, 10 Dec 2019 14:34:48 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Colin King <colin.king@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20191210143205.338308-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191210143205.338308-1-colin.king@canonical.com>
Message-ID: <157598848809.15362.74032135864302866@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH][next] drm/i915/selftests: fix uninitialized variable sum when
 summing up values
Date:   Tue, 10 Dec 2019 14:34:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2019-12-10 14:32:05)
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the variable sum is not uninitialized and hence will cause an
> incorrect result in the summation values.  Fix this by initializing
> sum to the first item in the summation.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 3c7a44bbbfa7 ("drm/i915/selftests: Perform some basic cycle counting of MI ops")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/i915/gt/selftest_engine_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
> index 761d81f4bd68..f88e445a1cae 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
> @@ -108,7 +108,7 @@ static u32 trifilter(u32 *a)
>  
>         sort(a, COUNT, sizeof(*a), cmp_u32, NULL);
>  
> -       sum += mul_u32_u32(a[2], 2);
> +       sum = mul_u32_u32(a[2], 2);

/o\
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
