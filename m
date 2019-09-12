Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 419ABB0EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 14:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbfILMiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 08:38:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731283AbfILMiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:38:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4BD710C092C;
        Thu, 12 Sep 2019 12:38:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EE9360872;
        Thu, 12 Sep 2019 12:38:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B502E16E05; Thu, 12 Sep 2019 14:38:21 +0200 (CEST)
Date:   Thu, 12 Sep 2019 14:38:21 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stevensd@chromium.org,
        marcheu@chromium.org, zachr@chromium.org, keiichiw@chromium.org,
        posciak@chromium.org
Subject: Re: [RFC PATCH] drm/virtio: Export resource handles via DMA-buf API
Message-ID: <20190912123821.rraib5entkcxt5p5@sirius.home.kraxel.org>
References: <20190912094121.228435-1-tfiga@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912094121.228435-1-tfiga@chromium.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Thu, 12 Sep 2019 12:38:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> To seamlessly enable buffer sharing with drivers using such frameworks,
> make the virtio-gpu driver expose the resource handle as the DMA address
> of the buffer returned from the DMA-buf mapping operation.  Arguably, the
> resource handle is a kind of DMA address already, as it is the buffer
> identifier that the device needs to access the backing memory, which is
> exactly the same role a DMA address provides for native devices.

No.  A scatter list has guest dma addresses, period.  Stuffing something
else into a scatterlist is asking for trouble, things will go seriously
wrong when someone tries to use such a fake scatterlist as real scatterlist.

Also note that "the DMA address of the buffer" is bonkers in virtio-gpu
context.  virtio-gpu resources are not required to be physically
contigous in memory, so typically you actually need a scatter list to
describe them.

cheers,
  Gerd

