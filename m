Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0324924882
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 08:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfEUG5Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 May 2019 02:57:25 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:57086 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbfEUG5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:57:24 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16623319-1500050 
        for multiple; Tue, 21 May 2019 07:56:58 +0100
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
Message-ID: <155842181579.23981.15462387194555705539@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 1/1] drm/i915: remove unused IO_TLB_SEGPAGES which should be
 defined by swiotlb
Date:   Tue, 21 May 2019 07:56:55 +0100
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

It would be wise to refer to

commit 5584f1b1d73e9cc95092734c316e467c6c4468f9
Author: Juergen Gross <jgross@suse.com>
Date:   Thu Feb 2 10:47:11 2017 +0100

    drm/i915: fix i915 running as dom0 under Xen

so the reader can have the history to trawl through.

References: 5584f1b1d73e ("drm/i915: fix i915 running as dom0 under Xen")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
