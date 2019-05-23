Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB4D28C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 23:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbfEWVTO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 May 2019 17:19:14 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:62941 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387785AbfEWVTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:19:13 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16660927-1500050 
        for multiple; Thu, 23 May 2019 22:18:45 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <1558413639-22568-1-git-send-email-dongli.zhang@oracle.com>
Cc:     linux-kernel@vger.kernel.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, dongli.zhang@oracle.com
References: <1558413639-22568-1-git-send-email-dongli.zhang@oracle.com>
Message-ID: <155864632459.28319.2321714891490375205@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 1/1] drm/i915: remove unused IO_TLB_SEGPAGES which should be
 defined by swiotlb
Date:   Thu, 23 May 2019 22:18:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dongli Zhang (2019-05-21 05:40:39)
> This patch removes IO_TLB_SEGPAGES which is no longer used since
> commit 5584f1b1d73e ("drm/i915: fix i915 running as dom0 under Xen").
> 
> As the define of both IO_TLB_SEGSIZE and IO_TLB_SHIFT are from swiotlb,
> IO_TLB_SEGPAGES should be defined on swiotlb side if it is required in the
> future.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Pushed, thanks for the patch.
-Chris
