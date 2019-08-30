Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE4BA2F66
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 08:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfH3GJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 02:09:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbfH3GI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:08:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BB4E030832C6;
        Fri, 30 Aug 2019 06:08:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com [10.36.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BB755C1D6;
        Fri, 30 Aug 2019 06:08:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A32B317536; Fri, 30 Aug 2019 08:08:57 +0200 (CEST)
Date:   Fri, 30 Aug 2019 08:08:57 +0200
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
Message-ID: <20190830060857.tzrzgoi2hrmchdi5@sirius.home.kraxel.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829212417.257397-1-davidriley@chromium.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 30 Aug 2019 06:08:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

>  {
>  	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
>  		kfree(vbuf->resp_buf);
> -	kfree(vbuf->data_buf);
> +	kvfree(vbuf->data_buf);

if (is_vmalloc_addr(vbuf->data_buf)) ...

needed here I gues?

> +/* Create sg_table from a vmalloc'd buffer. */
> +static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size)

Hmm, isn't there an existing function for that?
I'd be surprised if virtio-gpu is the first driver needing this ...

And it case there really isn't one this should probably added to the
vmalloc or scatterlist code, not the virtio-gpu driver.

cheers,
  Gerd

