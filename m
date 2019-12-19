Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42CB0126E21
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 20:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLSTnO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Dec 2019 14:43:14 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:57660 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727120AbfLSTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:43:13 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 19638651-1500050 
        for multiple; Thu, 19 Dec 2019 19:43:08 +0000
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
In-Reply-To: <20191219190916.24693-1-colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191219190916.24693-1-colin.king@canonical.com>
Message-ID: <157678458608.6469.7303602517496484124@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH][next] drm/i915: fix uninitialized pointer reads on pointers to
 and from
Date:   Thu, 19 Dec 2019 19:43:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2019-12-19 19:09:16)
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently pointers to and from are not initialized and may contain
> garbage values. This will cause uninitialized pointer reads in the
> call to intel_frontbuffer_track and later checks to see if to and from
> are null.  Fix this by ensuring to and from are initialized to NULL.
> 
> Addresses-Coverity: ("Uninitialised pointer read)"
> Fixes: da42104f589d ("drm/i915: Hold reference to intel_frontbuffer as we track activity")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

"D'oh"
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
