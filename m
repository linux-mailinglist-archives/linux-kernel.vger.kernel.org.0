Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4933A3580
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 13:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfH3LQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 07:16:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfH3LQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:16:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A3353CA0C;
        Fri, 30 Aug 2019 11:16:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com [10.36.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA4755C207;
        Fri, 30 Aug 2019 11:16:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1CE2217536; Fri, 30 Aug 2019 13:16:05 +0200 (CEST)
Date:   Fri, 30 Aug 2019 13:16:05 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     David Riley <davidriley@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: Use vmalloc for command buffer allocations.
Message-ID: <20190830111605.twzssycagmjhfa45@sirius.home.kraxel.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
 <20190830060857.tzrzgoi2hrmchdi5@sirius.home.kraxel.org>
 <CAASgrz2v0DYb_5A3MnaWFM4Csx1DKkZe546v7DG7R+UyLOA8og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAASgrz2v0DYb_5A3MnaWFM4Csx1DKkZe546v7DG7R+UyLOA8og@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 30 Aug 2019 11:16:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > > -     kfree(vbuf->data_buf);
> > > +     kvfree(vbuf->data_buf);
> >
> > if (is_vmalloc_addr(vbuf->data_buf)) ...
> >
> > needed here I gues?
> >
> 
> kvfree() handles vmalloc/kmalloc/kvmalloc internally by doing that check.

Ok.

> - videobuf_vmalloc_to_sg in drivers/media/v4l2-core/videobuf-dma-sg.c,
> assumes contiguous array of scatterlist and that the buffer being converted
> is page aligned

Well, vmalloc memory _is_ page aligned.

sg_alloc_table_from_pages() does alot of what you need, you just need a
small loop around vmalloc_to_page() create a struct page array
beforehand.

Completely different approach: use get_user_pages() and don't copy the
execbuffer at all.

cheers,
  Gerd

