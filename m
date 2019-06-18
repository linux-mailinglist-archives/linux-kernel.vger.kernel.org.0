Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B47549AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 09:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbfFRHl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 03:41:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfFRHl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:41:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62B243091797;
        Tue, 18 Jun 2019 07:41:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com [10.36.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D7E49839;
        Tue, 18 Jun 2019 07:41:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DE78B16E18; Tue, 18 Jun 2019 09:41:53 +0200 (CEST)
Date:   Tue, 18 Jun 2019 09:41:53 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] drm/virtio: simplify cursor updates
Message-ID: <20190618074153.355np63i76ee24c7@sirius.home.kraxel.org>
References: <20190617111406.14765-1-kraxel@redhat.com>
 <20190617111406.14765-4-kraxel@redhat.com>
 <20190617141806.GG12905@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617141806.GG12905@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 18 Jun 2019 07:41:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Even nicer would be to add the fence using
> drm_atomic_set_fence_for_plane() in the prepare_fb hook. Assuming this
> isn't necessary for correctness (but then I kinda have questions about
> races and stuff).

I'll have a look.  Maybe this way I can drop struct
virtio_gpu_framebuffer (where the fence is the only
thing beside struct drm_framebuffer).

cheers,
  Gerd

