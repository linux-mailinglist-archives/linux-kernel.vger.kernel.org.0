Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA1C5F716
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 13:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfGDLKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 07:10:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfGDLKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:10:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D1B53082200;
        Thu,  4 Jul 2019 11:10:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-222.ams2.redhat.com [10.36.116.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3397917B97;
        Thu,  4 Jul 2019 11:10:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2264311AB5; Thu,  4 Jul 2019 13:10:43 +0200 (CEST)
Date:   Thu, 4 Jul 2019 13:10:43 +0200
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
Message-ID: <20190704111043.5ubc2yjrjphj2iec@sirius.home.kraxel.org>
References: <20190702141903.1131-1-kraxel@redhat.com>
 <20190702141903.1131-7-kraxel@redhat.com>
 <CAPaKu7RfLoB=K__wQd92=S20Mt0uqsfyU9oigr8CQ-=gH6OUuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaKu7RfLoB=K__wQd92=S20Mt0uqsfyU9oigr8CQ-=gH6OUuA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 04 Jul 2019 11:10:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > -       r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
> > +       r = reservation_object_lock_interruptible(bo->gem_base.resv, NULL);
> Can you elaborate a bit about how TTM keeps the BOs alive in, for
> example, virtio_gpu_transfer_from_host_ioctl?  In that function, only
> three TTM functions are called: ttm_bo_reserve, ttm_bo_validate, and
> ttm_bo_unreserve.  I am curious how they keep the BO alive.

It can't go away between reserve and unreserve, and I think it also
can't be evicted then.  Havn't checked how ttm implements that.

cheers,
  Gerd

