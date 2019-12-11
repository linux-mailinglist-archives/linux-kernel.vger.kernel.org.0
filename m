Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0616111ABDC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 14:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfLKNSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 08:18:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20082 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729260AbfLKNSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576070314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2N/bBwWcHDSxRKQdSq6NZCU6mWtdHnd96mKLJxL2OHM=;
        b=PmekdAsd9zND+nddEutLQJV+7driDUcFW8mSx8kgwhTVPFVIld+PCzkU7CuM5LZnqJ6T23
        IpIuOZOp4kfJIhdSfk0LWNb45v79vi1T/IZLlKFqsGqgaPNNu0TUVC0JJXMbCphBbl+LFP
        a0a+YD8RVOWG2575pxN2OdVZMiiPf0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-pjXuj2LDO8GVkc_Sq06EOg-1; Wed, 11 Dec 2019 08:18:33 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEF3F18044A7;
        Wed, 11 Dec 2019 13:18:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9286D19756;
        Wed, 11 Dec 2019 13:18:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7F97716E05; Wed, 11 Dec 2019 14:18:30 +0100 (CET)
Date:   Wed, 11 Dec 2019 14:18:30 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        gurchetansingh@chromium.org
Subject: Re: [PATCH v2 1/2] drm/shmem: add support for per object caching
 attributes
Message-ID: <20191211131830.iz3a2o4xzmmkjsp7@sirius.home.kraxel.org>
References: <20191211081810.20079-1-kraxel@redhat.com>
 <20191211081810.20079-2-kraxel@redhat.com>
 <0b64e917-48f7-487e-9335-2838b6c62808@suse.de>
 <ed9142da-ce10-7df2-8a85-ba9ad0c26551@suse.de>
 <20191211123635.GY624164@phenom.ffwll.local>
MIME-Version: 1.0
In-Reply-To: <20191211123635.GY624164@phenom.ffwll.local>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: pjXuj2LDO8GVkc_Sq06EOg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> btw on why udl does this: Imported bo are usually rendered by real hw, an=
d
> reading it uncached/wc is the more defensive setting. It would be kinda
> nice if dma-buf would expose this, but I fear dma-api maintainers would
> murder us if we even just propose that ... so it's a mess right now.

I suspect for imported dma-bufs we should leave the mmap() to the
exporter instead of pulling the pages out of the sgt and map them
ourself.

> btw the issue extends to dma access by devices too, e.g. both i915 and
> amdgpu can select the coherency mode at runtime (using e.g. the pcie
> no-snoop transaction mode), and we have similar uncoordinated hacks in
> there too, like in udl.

Hmm.  Ok.  I guess I'm not going to try solve all that properly just for
the little virtio fix.

Just curious:  How do you tell your hardware?  Are there bits for that
in the gtt, simliar to the caching bits in the x86 page tables?

cheers,
  Gerd

