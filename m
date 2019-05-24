Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBE172A09B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 23:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404371AbfEXVpQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 May 2019 17:45:16 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:50350 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404237AbfEXVpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:45:16 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16674029-1500050 
        for multiple; Fri, 24 May 2019 22:45:08 +0100
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
In-Reply-To: <20190524212627.24256-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190524212627.24256-1-colin.king@canonical.com>
Message-ID: <155873430650.6190.1054401334708975483@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH][next] drm/i915/gtt: set err to -ENOMEM on memory allocation
 failure
Date:   Fri, 24 May 2019 22:45:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2019-05-24 22:26:27)
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently when the allocation of ppgtt->work fails the error return
> path via err_free returns an uninitialized value in err. Fix this
> by setting err to the appropriate error return of -ENOMEM.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: d3622099c76f ("drm/i915/gtt: Always acquire struct_mutex for gen6_ppgtt_cleanup")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Saw that last night but got distracted by the panic-on-boot...
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
