Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C80298B01
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 07:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbfHVFz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 01:55:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58364 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfHVFz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 01:55:29 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1i0g4A-0002vT-4S; Thu, 22 Aug 2019 15:55:22 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1i0g47-000117-Op; Thu, 22 Aug 2019 15:55:19 +1000
Date:   Thu, 22 Aug 2019 15:55:19 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-crypto@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH] random: Support freezable kthreads in
 add_hwgenerator_randomness()
Message-ID: <20190822055519.GB3860@gondor.apana.org.au>
References: <20190819150245.176587-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819150245.176587-1-swboyd@chromium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:02:45AM -0700, Stephen Boyd wrote:
> The kthread calling this function is freezable after commit 03a3bb7ae631
> ("hwrng: core - Freeze khwrng thread during suspend") is applied.
> Unfortunately, this function uses wait_event_interruptible() but doesn't
> check for the kthread being woken up by the fake freezer signal. When a
> user suspends the system, this kthread will wake up and if it fails the
> entropy size check it will immediately go back to sleep and not go into
> the freezer. Eventually, suspend will fail because the task never froze
> and a warning message like this may appear:
> 
>  PM: suspend entry (deep)
>  Filesystems sync: 0.000 seconds
>  Freezing user space processes ... (elapsed 0.001 seconds) done.
>  OOM killer disabled.
>  Freezing remaining freezable tasks ...
>  Freezing of tasks failed after 20.003 seconds (1 tasks refusing to freeze, wq_busy=0):
>  hwrng           R  running task        0   289      2 0x00000020
>  [<c08c64c4>] (__schedule) from [<c08c6a10>] (schedule+0x3c/0xc0)
>  [<c08c6a10>] (schedule) from [<c05dbd8c>] (add_hwgenerator_randomness+0xb0/0x100)
>  [<c05dbd8c>] (add_hwgenerator_randomness) from [<bf1803c8>] (hwrng_fillfn+0xc0/0x14c [rng_core])
>  [<bf1803c8>] (hwrng_fillfn [rng_core]) from [<c015abec>] (kthread+0x134/0x148)
>  [<c015abec>] (kthread) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> 
> Check for a freezer signal here and skip adding any randomness if the
> task wakes up because it was frozen. This should make the kthread freeze
> properly and suspend work again.
> 
> Fixes: 03a3bb7ae631 ("hwrng: core - Freeze khwrng thread during suspend")
> Reported-by: Keerthy <j-keerthy@ti.com>
> Tested-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Probably needs to go via Herbert who routed the patch this is fixing.
> 
>  drivers/char/random.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
