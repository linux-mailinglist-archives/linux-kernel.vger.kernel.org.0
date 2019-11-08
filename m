Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55FAAF4406
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 10:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbfKHJ4G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Nov 2019 04:56:06 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:64497 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731522AbfKHJ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:56:04 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19125519-1500050 
        for multiple; Fri, 08 Nov 2019 09:55:58 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20191108094142.25942-1-yamada.masahiro@socionext.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Abdiel Janulgue <abdiel.janulgue@linux.intel.com>,
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
        dri-devel@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20191108094142.25942-1-yamada.masahiro@socionext.com>
Message-ID: <157320695719.9461.4158455736119200291@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v2] drm/i915: make more headers self-contained
Date:   Fri, 08 Nov 2019 09:55:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Masahiro Yamada (2019-11-08 09:41:42)
> The headers in the gem/selftests/, gt/selftests, gvt/, selftests/
> directories have never been compile-tested, but it would be possible
> to make them self-contained.
> 
> This commit only addresses missing <linux/types.h> and forward
> struct declarations.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks a lot for doing this,
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
