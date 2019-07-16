Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD616AD48
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 19:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388006AbfGPQ71 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Jul 2019 12:59:27 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:60625 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728124AbfGPQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:59:27 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17347807-1500050 
        for multiple; Tue, 16 Jul 2019 17:59:19 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190716164221.15436-2-robdclark@gmail.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emil Velikov <emil.velikov@collabora.com>
References: <20190716164221.15436-1-robdclark@gmail.com>
 <20190716164221.15436-2-robdclark@gmail.com>
Message-ID: <156329635647.9436.7142001798245279241@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 2/2] drm/vgem: use normal cached mmap'ings
Date:   Tue, 16 Jul 2019 17:59:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Clark (2019-07-16 17:42:15)
> From: Rob Clark <robdclark@chromium.org>
> 
> Since there is no real device associated with vgem, it is impossible to
> end up with appropriate dev->dma_ops, meaning that we have no way to
> invalidate the shmem pages allocated by vgem.  So, at least on platforms
> without drm_cflush_pages(), we end up with corruption when cache lines
> from previous usage of vgem bo pages get evicted to memory.
> 
> The only sane option is to use cached mappings.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
> Possibly we could dma_sync_*_for_{device,cpu}() on dmabuf attach/detach,
> although the ->gem_prime_{pin,unpin}() API isn't quite ideal for that as
> it is.  And that doesn't really help for drivers that don't attach/
> detach for each use.
> 
> But AFAICT vgem is mainly used for dmabuf testing, so maybe we don't
> need to care too much about use of cached mmap'ings.

Sadly this regresses with i915 interop.

Starting subtest: 4KiB-tiny-vgem-blt-early-read-child
(gem_concurrent_blit:8309) CRITICAL: Test assertion failure function dmabuf_cmp_bo, file ../tests/i915/gem_concurrent_all.c:408:
(gem_concurrent_blit:8309) CRITICAL: Failed assertion: v[((y)*(b->width) + (((y) + pass)%(b->width)))] == val
(gem_concurrent_blit:8309) CRITICAL: error: 0 != 0xdeadbeef

and igt/prime_vgem

Can you please cc intel-gfx so CI can pick up these changes?
-Chris
