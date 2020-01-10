Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE73113711A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 16:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgAJPZL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Jan 2020 10:25:11 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:52146 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728135AbgAJPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:25:11 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19836001-1500050 
        for multiple; Fri, 10 Jan 2020 15:25:05 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20200110151807.2863347-1-arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200110151807.2863347-1-arnd@arndb.de>
Message-ID: <157866990449.10140.9828490570954762660@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] i915: ggtt: include asm/smp.h
Date:   Fri, 10 Jan 2020 15:25:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2020-01-10 15:17:54)
> Splitting up the i915_gem_gtt caused a build failure in some configurations:
> 
> drivers/gpu/drm/i915/gt/intel_ggtt.c: In function 'ggtt_restore_mappings':
> drivers/gpu/drm/i915/gt/intel_ggtt.c:1239:3: error: implicit declaration of function 'wbinvd_on_all_cpus'; did you mean 'wrmsr_on_cpus'? [-Werror=implicit-function-declaration]
>    wbinvd_on_all_cpus();
>    ^~~~~~~~~~~~~~~~~~
>    wrmsr_on_cpus
> 
> Add the missing header file.
> 
> Fixes: 2c86e55d2ab5 ("drm/i915/gtt: split up i915_gem_gtt")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I ran into this bug a few days ago on linux-next. Please just ignore
> if it's already fixed in the meantime.

Fixed applied this morning, thanks for the fixup anyway.
-Chris
