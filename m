Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E365658A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 11:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfFZJPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 05:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfFZJPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:15:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9111730811C7;
        Wed, 26 Jun 2019 09:15:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04FF55C1A1;
        Wed, 26 Jun 2019 09:15:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1C01316E18; Wed, 26 Jun 2019 11:15:31 +0200 (CEST)
Date:   Wed, 26 Jun 2019 11:15:31 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, jcmvbkbc@gmail.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: move drm_connector_update_edid_property()
 call
Message-ID: <20190626091531.35da5c2dsz6fuz5w@sirius.home.kraxel.org>
References: <20190405044602.2334-1-kraxel@redhat.com>
 <20190626095146.2731a2dc.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626095146.2731a2dc.cohuck@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 26 Jun 2019 09:15:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:51:46AM +0200, Cornelia Huck wrote:
> On Fri,  5 Apr 2019 06:46:02 +0200
> Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > drm_connector_update_edid_property can sleep, we must not
> > call it while holding a spinlock.  Move the callsize.
> 
> s/callsize/callsite/

Fixed on commit.

> This gets rid of the sleeping while atomic traces I've been seeing with
> an s390x guest (both virtio-gpu-pci and virtio-gpu-ccw).
> 
> Tested-by: Cornelia Huck <cohuck@redhat.com>
> 
> I have also looked at the code a bit, but don't feel confident enough
> to give an R-b.
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Thanks.  Pushed to drm-misc-fixes.

cheers,
  Gerd
