Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8A4C703
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 08:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfFTGBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 02:01:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfFTGBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7461AC18B2DC;
        Thu, 20 Jun 2019 06:01:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-212.ams2.redhat.com [10.36.116.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E81CE1001DDC;
        Thu, 20 Jun 2019 06:01:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3E0AE1750A; Thu, 20 Jun 2019 08:01:07 +0200 (CEST)
Date:   Thu, 20 Jun 2019 08:01:07 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 08/12] drm/virtio: rework virtio_gpu_execbuffer_ioctl
 fencing
Message-ID: <20190620060107.tdz3nrnsczkkv2a6@sirius.home.kraxel.org>
References: <20190619090420.6667-1-kraxel@redhat.com>
 <20190619090420.6667-9-kraxel@redhat.com>
 <20190619110902.GO12905@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619110902.GO12905@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 20 Jun 2019 06:01:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> Also, I strongly recommend you do a very basic igt to exercise this, i.e.
> allocate some buffers, submit them in a dummby op, then close the entire
> drmfd. The old version should at least have tripped over kasan, maybe even
> oopses somewhere.

Hmm, I suspect I have to extend igt for that (adding support for
virtio ioctls), right?

A quick and dirty test (run webgl demo in firefox, then kill -9 both
firefox and Xorg) didn't show any nasty surprises.

cheers,
  Gerd

