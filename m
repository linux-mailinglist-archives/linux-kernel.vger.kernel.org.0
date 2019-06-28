Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA859823
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfF1KFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 06:05:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfF1KFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:05:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F123307D840;
        Fri, 28 Jun 2019 10:05:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC68F5C21A;
        Fri, 28 Jun 2019 10:05:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BBA7A11AA3; Fri, 28 Jun 2019 12:05:16 +0200 (CEST)
Date:   Fri, 28 Jun 2019 12:05:16 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v4 02/12] drm/virtio: switch virtio_gpu_wait_ioctl() to
 gem helper.
Message-ID: <20190628100516.yrtiuxemyt4hvyra@sirius.home.kraxel.org>
References: <20190620060726.926-1-kraxel@redhat.com>
 <20190620060726.926-3-kraxel@redhat.com>
 <CAPaKu7RWpoRkTkoatdYHz6itHZFvUYgaBcQAXnSC2gDc+dFZxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaKu7RWpoRkTkoatdYHz6itHZFvUYgaBcQAXnSC2gDc+dFZxQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 28 Jun 2019 10:05:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 04:55:20PM -0700, Chia-I Wu wrote:
> On Wed, Jun 19, 2019 at 11:07 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Use drm_gem_reservation_object_wait() in virtio_gpu_wait_ioctl().
> > This also makes the ioctl run lockless.
> The userspace has a BO cache to avoid freeing BOs immediately but to
> reuse them on next allocations.  The BO cache checks if a BO is busy
> before reuse, and I am seeing a big negative perf impact because of
> slow virtio_gpu_wait_ioctl.  I wonder if this helps.

Could help indeed (assuming it checks with NOWAIT).

How many objects does userspace check in one go typically?  Maybe it
makes sense to add an ioctl which checks a list, to reduce the system
call overhead.

> > +       if (args->flags & VIRTGPU_WAIT_NOWAIT) {
> > +               obj = drm_gem_object_lookup(file, args->handle);
> Don't we need a NULL check here?

Yes, we do.  Will fix.

thanks,
  Gerd

