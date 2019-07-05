Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6ADC602C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 11:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfGEJBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 05:01:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbfGEJBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:01:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A75A03092661;
        Fri,  5 Jul 2019 09:01:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-90.ams2.redhat.com [10.36.116.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B3E79D8E9;
        Fri,  5 Jul 2019 09:01:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C971E16E32; Fri,  5 Jul 2019 11:01:05 +0200 (CEST)
Date:   Fri, 5 Jul 2019 11:01:05 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 14/18] drm/virtio: rework
 virtio_gpu_transfer_from_host_ioctl fencing
Message-ID: <20190705090105.5ivc4gqgbyczwtpo@sirius.home.kraxel.org>
References: <20190702141903.1131-1-kraxel@redhat.com>
 <20190702141903.1131-15-kraxel@redhat.com>
 <CAPaKu7T3GvYVMueYgJFhADFSFEVbHEdaupw8=mq_+i150a1mLA@mail.gmail.com>
 <20190704114756.eavkszsgsyymns3m@sirius.home.kraxel.org>
 <CAPaKu7SXJwDg1uE0qDOYNS6J44UuQUh6m5rpJ3hBtW2tqYmMKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaKu7SXJwDg1uE0qDOYNS6J44UuQUh6m5rpJ3hBtW2tqYmMKA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 05 Jul 2019 09:01:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 11:55:59AM -0700, Chia-I Wu wrote:
> On Thu, Jul 4, 2019 at 4:48 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Wed, Jul 03, 2019 at 01:05:12PM -0700, Chia-I Wu wrote:
> > > On Tue, Jul 2, 2019 at 7:19 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > >
> > > > Switch to the virtio_gpu_array_* helper workflow.
> > > (just repeating my question on patch 6)
> > >
> > > Does this fix the obj refcount issue?  When was the issue introduced?
> >
> > obj refcount should be fine in both old and new code.
> >
> > old code:
> >   drm_gem_object_lookup
> >   drm_gem_object_put_unlocked
> >
> > new code:
> >   virtio_gpu_array_from_handles
> >   virtio_gpu_array_put_free (in virtio_gpu_dequeue_ctrl_func).
> >
> > Or did I miss something?
> In the old code, drm_gem_object_put_unlocked is called before the vbuf
> using the object is retired.  Isn't that what object array wants to
> fix?

I think the fence keeps the bo alive.

cheers,
  Gerd

