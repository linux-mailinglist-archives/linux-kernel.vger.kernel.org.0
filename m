Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 113BB108038
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 21:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKWUFS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 23 Nov 2019 15:05:18 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:56563 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726620AbfKWUFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 15:05:18 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19314250-1500050 
        for multiple; Sat, 23 Nov 2019 20:05:12 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20191123195321.41305-1-natechancellor@gmail.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
References: <20191123195321.41305-1-natechancellor@gmail.com>
Message-ID: <157453950786.2524.16955749910067219709@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: Remove tautological compare in eb_relocate_vma
Date:   Sat, 23 Nov 2019 20:05:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Chancellor (2019-11-23 19:53:22)
> -Wtautological-compare was recently added to -Wall in LLVM, which
> exposed an if statement in i915 that is always false:
> 
> ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
> result of comparison of constant 576460752303423487 with expression of
> type 'unsigned int' is always false
> [-Wtautological-constant-out-of-range-compare]
>         if (unlikely(remain > N_RELOC(ULONG_MAX)))
>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
> 
> Since remain is an unsigned int, it can never be larger than UINT_MAX,
> which is less than ULONG_MAX / sizeof(struct drm_i915_gem_relocation_entry).
> Remove this statement to fix the warning.

The check should remain as we do want to document the overflow
calculation, and it should represent the types used -- it's much easier
to review a stub than trying to find a missing overflow check. If the
overflow cannot happen as the types are wide enough, no problem, the
compiler can remove the known false branch.

Tautology here has a purpose for conveying information to the reader.
-Chris
