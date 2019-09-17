Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DECC5B4B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 11:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfIQJyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 05:54:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbfIQJyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 05:54:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5ED8A307D90E;
        Tue, 17 Sep 2019 09:54:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 103925C21A;
        Tue, 17 Sep 2019 09:54:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5865C16E05; Tue, 17 Sep 2019 11:54:35 +0200 (CEST)
Date:   Tue, 17 Sep 2019 11:54:35 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, Huang Rui <ray.huang@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH 4/8] drm/ttm: factor out ttm_bo_mmap_vma_setup
Message-ID: <20190917095435.oenv4a6ryhvkfmtv@sirius.home.kraxel.org>
References: <20190913122908.784-1-kraxel@redhat.com>
 <20190913122908.784-5-kraxel@redhat.com>
 <88d5a253-ef9e-c998-6353-5ba8680129f2@suse.de>
 <20190917083425.kwwqyn463gn3mghf@sirius.home.kraxel.org>
 <8b8ce387-1b3c-0a9c-3aaf-6294b3b81018@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b8ce387-1b3c-0a9c-3aaf-6294b3b81018@suse.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 17 Sep 2019 09:54:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> It may not be worth blocking on this, so
> 
>   Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> But I still think it's not a good interface because it exposes internal
> details.
> 
> Please consider another idea: how about splitting off the ttm_bo_get()
> and vma-flags setup of ttm_fbdev_mmap() into a separate function, like this:
> 
> void ttm_bo_mmap_refed(vma, bo)
> {
> 	ttm_bo_get(bo)
> 	ttm_bo_mmap_vma_setup(vma);
> }
> EXPORT_SYMBOL(ttm_bo_mmap_refed)

ttm_bo_mmap_refed and ttm_bo_mmap_vma_setup are almost identical ...

But, yes, moving the ttm_bo_get call to ttm_bo_mmap_vma_setup probably
makes sense and hides this little detail to the outside.

> ttm_fbdev_mmap() sounds like it is only for fbdev and the only user is
> amdgpu. Can it be moved out of ttm entirely?

Exporting ttm_bo_mmap_vma_setup() allows to do that ;)

cheers,
  Gerd

