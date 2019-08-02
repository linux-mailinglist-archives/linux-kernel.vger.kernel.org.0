Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2E57F7AD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 14:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392926AbfHBM6l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Aug 2019 08:58:41 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:55533 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726535AbfHBM6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:58:41 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17817131-1500050 
        for multiple; Fri, 02 Aug 2019 13:58:38 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190802123956.2450-2-sergey.senozhatsky@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20190802123956.2450-1-sergey.senozhatsky@gmail.com>
 <20190802123956.2450-2-sergey.senozhatsky@gmail.com>
Message-ID: <156475071634.6598.8668583907388398632@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 2/2] i915: do not leak module ref counter
Date:   Fri, 02 Aug 2019 13:58:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergey Senozhatsky (2019-08-02 13:39:56)
> put_filesystem() before i915_gemfs_init() deals with
> kern_mount() error.
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gemfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gemfs.c b/drivers/gpu/drm/i915/gem/i915_gemfs.c
> index cf05ba72df9d..d437188d1736 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
> @@ -24,8 +24,10 @@ int i915_gemfs_init(struct drm_i915_private *i915)
>                 return -ENODEV;
>  
>         gemfs = kern_mount(type);

Looking around, it looks like we always need to drop type after
mounting. Should the
	put_filesystem(type);
be here instead?

Anyway, nice catch.

> -       if (IS_ERR(gemfs))
> +       if (IS_ERR(gemfs)) {
> +               put_filesystem(type);
>                 return PTR_ERR(gemfs);
> +       }
>  
>         /*
>          * Enable huge-pages for objects that are at least HPAGE_PMD_SIZE, most
> -- 
> 2.22.0
> 
