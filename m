Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DECDE648CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 17:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfGJPBU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Jul 2019 11:01:20 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51238 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725956AbfGJPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:01:17 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17201029-1500050 
        for multiple; Wed, 10 Jul 2019 16:01:06 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190710145239.12844-1-janusz.krzysztofik@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?Micha=C5=82_Wajdeczko?= <michal.wajdeczko@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
References: <20190710145239.12844-1-janusz.krzysztofik@linux.intel.com>
Message-ID: <156277086449.4055.15655120452619911756@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [RFC PATCH] drm/i915: Drop extern qualifiers from header function
 prototypes
Date:   Wed, 10 Jul 2019 16:01:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Janusz Krzysztofik (2019-07-10 15:52:39)
> Follow dim checkpatch recommendation so it doesn't complain on that now
> and again on header file modifications.
> 
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -2388,19 +2388,18 @@ __i915_printk(struct drm_i915_private *dev_priv, const char *level,
>         __i915_printk(dev_priv, KERN_ERR, fmt, ##__VA_ARGS__)
>  
>  #ifdef CONFIG_COMPAT
> -extern long i915_compat_ioctl(struct file *filp, unsigned int cmd,
> -                             unsigned long arg);
> +long i915_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>  #else
>  #define i915_compat_ioctl NULL
>  #endif
>  extern const struct dev_pm_ops i915_pm_ops;
> +extern const struct dev_pm_ops i915_pm_ops_1;

That's novel.
-Chris
