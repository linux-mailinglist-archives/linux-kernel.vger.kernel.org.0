Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D722B1540B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 09:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgBFIzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 03:55:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35079 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728016AbgBFIzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580979347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lidKg4bME34cT2lBAp3X3adgq0pupsYNedp4gCMJOiw=;
        b=N0dxLHzvY9Zr5ZiHqEO04dViAcsuRVk3k/yWBaUAX7AeUlFEOoEjoN3GpG/wNPvu5BvOO8
        pSRNK8F6/BkTxxSxGdAFE2C6qrEeaXGc2ZPN7rKuDU67swX7emS/OJjqdbZQEAdWsk9wO3
        mZO7e1I5Dhzt1c4qH2cZY9+7i65HYVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-E5-DoGFDM6CyTIgV6pnwxg-1; Thu, 06 Feb 2020 03:55:43 -0500
X-MC-Unique: E5-DoGFDM6CyTIgV6pnwxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1F7D1937FC4;
        Thu,  6 Feb 2020 08:55:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 672025DA75;
        Thu,  6 Feb 2020 08:55:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8510C1747D; Thu,  6 Feb 2020 09:55:40 +0100 (CET)
Date:   Thu, 6 Feb 2020 09:55:40 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] drm/virtio: move virtio_gpu_mem_entry initialization
 to new function
Message-ID: <20200206085540.pa6py4ieoi242gma@sirius.home.kraxel.org>
References: <20200205105955.28143-1-kraxel@redhat.com>
 <20200205105955.28143-5-kraxel@redhat.com>
 <CAPaKu7RxijC_oS4GPukS9wEe9gn8DPQgaGZKwG6g8M8xwTnsig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaKu7RxijC_oS4GPukS9wEe9gn8DPQgaGZKwG6g8M8xwTnsig@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> >         virtio_gpu_cmd_resource_attach_backing(vgdev, obj->hw_res_handle,
> > -                                              ents, nents,
> > +                                              obj->ents, obj->nents,
> >                                                fence);
> > +       obj->ents = NULL;
> > +       obj->nents = 0;
> Hm, if the entries are temporary, can we allocate and initialize them
> in this function?

Well, the plan for CREATE_RESOURCE_BLOB is to use obj->ents too ...

cheers,
  Gerd

