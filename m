Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE1C1B8F9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 16:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbfEMOri convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 May 2019 10:47:38 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:64365 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728916AbfEMOri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:47:38 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16541986-1500050 
        for multiple; Mon, 13 May 2019 15:47:23 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Vetter <daniel@ffwll.ch>,
        Steven Price <steven.price@arm.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190513143921.GP17751@phenom.ffwll.local>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20190513143244.16478-1-steven.price@arm.com>
 <20190513143921.GP17751@phenom.ffwll.local>
Message-ID: <155775884217.2165.11223399053598674062@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/panfrost: Use drm_gem_dump_map_offset()
Date:   Mon, 13 May 2019 15:47:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Vetter (2019-05-13 15:39:21)
> On Mon, May 13, 2019 at 03:32:44PM +0100, Steven Price wrote:
> > panfrost_ioctl_mmap_bo() contains a reimplementation of
> > drm_gem_dump_map_offset() but with a bug - it allows mapping imported
> > objects (without going through the exporter). Fix this by switching to
> > use the generic drm_gem_dump_map_offset() function instead which has the
> > bonus of simplifying the code.
> 
> gem_dumb stuff is for kms drivers, panfrost is a render driver. We're
> generally trying to separate these two worlds somewhat cleanly.
> 
> I think it'd be good to have a non-dumb version of this in the core, and
> use that. Or upgrade the dumb version to be that helper for everyone (and
> drop the _dumb).

More specifically, since panfrost is using the drm_gem_shmem helper and
vm_ops, it too can provide the wrapper as it is the drm_gem_shmem layer
that implies that trying to mmap an imported object is an issue as that
is not a universal problem.
-Chris
