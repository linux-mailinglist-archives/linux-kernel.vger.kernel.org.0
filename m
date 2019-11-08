Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEE5F41FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 09:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfKHIRI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Nov 2019 03:17:08 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:57812 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726987AbfKHIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 03:17:08 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19124236-1500050 
        for multiple; Fri, 08 Nov 2019 08:17:01 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CAK7LNAR_gmkpHojSm-3vooqFqJZUan7ut83MHbxp=4bNTrmuig@mail.gmail.com>
Cc:     Abdiel Janulgue <abdiel.janulgue@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@linux.ie>,
        Matthew Auld <matthew.auld@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gvt-dev@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191108051356.29980-1-yamada.masahiro@socionext.com>
 <20191108051356.29980-2-yamada.masahiro@socionext.com>
 <CAK7LNAR_gmkpHojSm-3vooqFqJZUan7ut83MHbxp=4bNTrmuig@mail.gmail.com>
Message-ID: <157320101945.9461.3647299632092094814@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 2/2] drm/i915: make more headers self-contained
Date:   Fri, 08 Nov 2019 08:16:59 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Masahiro Yamada (2019-11-08 05:42:33)
> On Fri, Nov 8, 2019 at 2:15 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > The headers in the gem/selftests/, gt/selftests, gvt/, selftests/
> > directories have never been compile-tested, but it would be possible
> > to make them self-contained.
> >
> > This commit only addresses missing <linux/types.h> and forward
> > struct declarations.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> 
> I confirmed this patch is applicable to next-20191107
> but CI fails to apply it.

CI is ahead of -next, even more so before the merge window when our MR
trees (used for -next) are frozen, but development continues.
 
> Which branch should I base my patch on?

https://cgit.freedesktop.org/drm-tip/ #drm-tip
-Chris
