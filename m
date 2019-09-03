Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 283B1A7178
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfICRPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 13:15:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35876 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729602AbfICRPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:15:24 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BFE543C919
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 17:15:23 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id b9so19649351qti.20
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 10:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t6tGfYo/dTj24n3kyKLuufR3DdwgMhB7RVSFb+mWOVs=;
        b=B8fqPY1dFDCXnlKLHefS+kCTRYWc3EeK2cQRRdOR6n+bCbTdq5JDdSnBMwCvbiihB2
         ksafcW727ZCCEtJblBlZssy0DHsvFSJfVywlFuWst+OMN8NpsPeFRWS4Puce6o3rZq9o
         g/h56iNX4e0zSSR+rIJElIJo2zpsx/nN4scIt9NHc3+LupTCOJ0v6tDlZifUbUwwTfzL
         X4mBVZhFMZxGBdgtkZlX0xJzgfBI+rTgtyDrET99AvXPckVQDAt9QBXsazVRNRXMGiNl
         UWNvy0U7Ju0rzM+jstkeIaB5CQTrS8fooLVso+JFdWxcuquK+Bl6YcP8DG734vp6W6KL
         jc9A==
X-Gm-Message-State: APjAAAValTZT3zWVfgDNfS0gBvisVlPbnlIXmaQl7CHfpumV1B97/uD/
        M/oEm3ECb1xy3aFqMTrX+fQQC0RieoP884BpuICI+Jwr7MiJleK7QyapWzWFrDRLf2SlfyFSK9C
        jFBLO3AnptHGu20os3ZYaFIM+
X-Received: by 2002:a05:620a:15cc:: with SMTP id o12mr12890167qkm.140.1567530923144;
        Tue, 03 Sep 2019 10:15:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwTXnMlZHpGHJ4mdlNJD+IRREku2Hx5W9v7Fh85/S/pmi7c/BEoxrqFXUQUyWjzlWCWQwErAg==
X-Received: by 2002:a05:620a:15cc:: with SMTP id o12mr12890124qkm.140.1567530922908;
        Tue, 03 Sep 2019 10:15:22 -0700 (PDT)
Received: from redhat.com (bzq-79-180-62-110.red.bezeqint.net. [79.180.62.110])
        by smtp.gmail.com with ESMTPSA id t2sm8561495qkm.34.2019.09.03.10.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 10:15:21 -0700 (PDT)
Date:   Tue, 3 Sep 2019 13:15:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual
 machines
Message-ID: <20190903111628-mutt-send-email-mst@kernel.org>
References: <20190821173742.24574-1-vgoyal@redhat.com>
 <CAJfpegvPTxkaNhXWhiQSprSJqyW1cLXeZEz6x_f0PxCd-yzHQg@mail.gmail.com>
 <20190903041507-mutt-send-email-mst@kernel.org>
 <20190903140752.GA10983@redhat.com>
 <20190903101001-mutt-send-email-mst@kernel.org>
 <20190903141851.GC10983@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903141851.GC10983@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:18:51AM -0400, Vivek Goyal wrote:
> On Tue, Sep 03, 2019 at 10:12:16AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Sep 03, 2019 at 10:07:52AM -0400, Vivek Goyal wrote:
> > > On Tue, Sep 03, 2019 at 04:31:38AM -0400, Michael S. Tsirkin wrote:
> > > 
> > > [..]
> > > > +	/* TODO lock */
> > > > give me pause.
> > > > 
> > > > Cleanup generally seems broken to me - what pauses the FS
> > > 
> > > I am looking into device removal aspect of it now. Thinking of adding
> > > a reference count to virtiofs device and possibly also a bit flag to
> > > indicate if device is still alive. That way, we should be able to cleanup
> > > device more gracefully.
> > 
> > Generally, the way to cleanup things is to first disconnect device from
> > linux so linux won't send new requests, wait for old ones to finish.
> 
> I was thinking of following.
> 
> - Set a flag on device to indicate device is dead and not queue new
>   requests. Device removal call can set this flag.
> 
> - Return errors when fs code tries to queue new request.
> 
> - Drop device creation reference in device removal path. If device is
>   mounted at the time of removal, that reference will still be active
>   and device state will not be cleaned up in kernel yet.
> 
> - User unmounts the fs, and that will drop last reference to device and
>   will lead to cleanup of in kernel state of the device.
> 
> Does that sound reasonable.
> 
> Vivek

Just we aware of the fact that virtio device, all vqs etc
will be gone by the time remove returns.


-- 
MST
