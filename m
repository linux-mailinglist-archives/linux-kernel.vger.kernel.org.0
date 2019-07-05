Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B00F602AC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 10:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfGEIxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 04:53:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfGEIxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:53:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AE463079B68;
        Fri,  5 Jul 2019 08:53:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-90.ams2.redhat.com [10.36.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D935C1001B20;
        Fri,  5 Jul 2019 08:53:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 10B3216E32; Fri,  5 Jul 2019 10:53:25 +0200 (CEST)
Date:   Fri, 5 Jul 2019 10:53:25 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 06/18] drm/virtio: remove ttm calls from in
 virtio_gpu_object_{reserve,unreserve}
Message-ID: <20190705085325.am2reucblvxc6qpg@sirius.home.kraxel.org>
References: <20190702141903.1131-1-kraxel@redhat.com>
 <20190702141903.1131-7-kraxel@redhat.com>
 <CAPaKu7RfLoB=K__wQd92=S20Mt0uqsfyU9oigr8CQ-=gH6OUuA@mail.gmail.com>
 <20190704111043.5ubc2yjrjphj2iec@sirius.home.kraxel.org>
 <CAPaKu7S4Og7kda2ZjFtuRv=_W8gpFbD5y7s==0JB5Z34S4Hsjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaKu7S4Og7kda2ZjFtuRv=_W8gpFbD5y7s==0JB5Z34S4Hsjw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 05 Jul 2019 08:53:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 12:17:48PM -0700, Chia-I Wu wrote:
> On Thu, Jul 4, 2019 at 4:10 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > > > -       r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
> > > > +       r = reservation_object_lock_interruptible(bo->gem_base.resv, NULL);
> > > Can you elaborate a bit about how TTM keeps the BOs alive in, for
> > > example, virtio_gpu_transfer_from_host_ioctl?  In that function, only
> > > three TTM functions are called: ttm_bo_reserve, ttm_bo_validate, and
> > > ttm_bo_unreserve.  I am curious how they keep the BO alive.
> >
> > It can't go away between reserve and unreserve, and I think it also
> > can't be evicted then.  Havn't checked how ttm implements that.
> Hm, but the vbuf using the BO outlives the reserve/unreserve section.
> The NO_EVICT flag applies only when the BO is still alive.  Someone
> needs to hold a reference to the BO to keep it alive, otherwise the BO
> can go away before the vbuf is retired.

Note that patches 14+15 rework virtio_gpu_transfer_*_ioctl to keep
gem reference until the command is finished and patch 17 drops
virtio_gpu_object_{reserve,unreserve} altogether.

Maybe I should try to reorder the series, then squash 6+17 to reduce
confusion.  I suspect that'll cause quite a few conflicts though ...

cheers,
  Gerd

