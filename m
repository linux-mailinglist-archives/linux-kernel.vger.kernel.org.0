Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC0146C90
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 16:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAWPYu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Jan 2020 10:24:50 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:50517 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbgAWPYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:24:50 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19984240-1500050 
        for multiple; Thu, 23 Jan 2020 15:24:46 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "Michael J . Ruhl" <michael.j.ruhl@intel.com>,
        Colin King <colin.king@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20200123151406.51679-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200123151406.51679-1-colin.king@canonical.com>
Message-ID: <157979308341.19995.6106728840274572701@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH][next] drm/i915/gem: fix null pointer dereference on vm
Date:   Thu, 23 Jan 2020 15:24:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2020-01-23 15:14:06)
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if the call to function context_get_vm_rcu returns
> a null pointer for vm then the error exit path via label err_put
> will call i915_vm_put on the null vm, causing a null pointer
> dereference.  Fix this by adding a null check on vm and returning
> without calling the i915_vm_put.
> 
> Fixes: 5dbd2b7be61e ("drm/i915/gem: Convert vm idr to xarray")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Hmm. Actually, we can drop the rcu_read_lock as soon as we've acquire
the local ref to ctx->vm. So something like,

        if (!rcu_access_pointer(ctx->vm))
                return -ENODEV;

-       err = -ENODEV;
        rcu_read_lock();
        vm = context_get_vm_rcu(ctx);
-       if (vm)
-               err = xa_alloc(&file_priv->vm_xa, &id, vm,
-                              xa_limit_32b, GFP_KERNEL);
        rcu_read_unlock();
+       if (!vm)
+               return -ENODEV;
+
+       err = xa_alloc(&file_priv->vm_xa, &id, vm,
+                      xa_limit_32b, GFP_KERNEL);
        if (err)
                goto err_put;

would work.
-Chris
