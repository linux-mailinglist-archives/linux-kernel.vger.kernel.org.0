Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14ED5CE909
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 18:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfJGQXB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Oct 2019 12:23:01 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:57648 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727801AbfJGQXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:23:01 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18754431-1500050 
        for multiple; Mon, 07 Oct 2019 17:22:55 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Colin King <colin.king@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20191007154151.23245-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191007154151.23245-1-colin.king@canonical.com>
Message-ID: <157046537209.5063.10118308844290609426@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/i915: make array hw_engine_mask static, makes object smaller
Date:   Mon, 07 Oct 2019 17:22:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2019-10-07 16:41:51)
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array hw_engine_mask on the stack but instead make it
> static. Makes the object code smaller by 316 bytes.
> 
> Before:
>    text    data     bss     dec     hex filename
>   34004    4388     320   38712    9738 gpu/drm/i915/gt/intel_reset.o
> 
> After:
>    text    data     bss     dec     hex filename
>   33528    4548     320   38396    95fc gpu/drm/i915/gt/intel_reset.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
