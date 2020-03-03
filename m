Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 186C4176AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 03:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCCCmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 21:42:35 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38400 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgCCCme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:42:34 -0500
Received: by mail-qk1-f195.google.com with SMTP id h22so1992695qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 18:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxaU6jH+BrctxPkuy+TtnDFu4GnDn0I+fDbnzM1efjY=;
        b=lPebr/apS3a3XvJ4XcWg2p+1jVRErhkCzaWWg6wU7yc5QNOeEvIf5BudVhVxW66Euf
         /6ylI3gzJxuJK7fsCbK7mC/7V5Yx8ND0/jBwvSFydsUmqZf6y1sr7BGOQvcFetjCcXwO
         arVONmL2HlRo7X9WIG9l6bIYjr03Nc0Y4hlBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxaU6jH+BrctxPkuy+TtnDFu4GnDn0I+fDbnzM1efjY=;
        b=N1XURS2vO6O6WtrnSMPj3KYoTMXrUUz8IfNZjNPOutrE18j04w7eT767kc2mOD+sjE
         Z3/7zGGcM9KIs7ehAkKPva9LxXIxM68qw+txvZw3KDrdVkti3LqAT1PFI4OCYFLecg+G
         EufTfiJO/NgXdTOovwKywlHt7dW1Oeo62npn1EEKX21s6oUD9iAibj/6Icpe/rJ6VFco
         eilz38ea/MmeFwPUjsbzqE8kPycBAy+Woo9EoreydJw48d+NtmtYN0mapQnbyyTF7qMZ
         k4EtrtqW//0KP5v0XSGTpBK7JIGn1DdzaF/o0B5zImrzJ7e3fn1KTumtx2ajjuxxmQRr
         89HA==
X-Gm-Message-State: ANhLgQ28X2yuYmCkaq6eaaHiMqh/6jb3uAuwObtc76eH+Ex797+LWsj7
        E+10G+8ER02fHaPcqgsl6h5xJRLvjKEOAAndIcTwtQ==
X-Google-Smtp-Source: ADFU+vv4vCMIfBV1h9ntADBFoWjuRnbldiM2bxqn1DU2ahDSFshoqIRAbcIuxA4EMjtDxDlwrF99sqmXWP5yAgEJ6LA=
X-Received: by 2002:a37:9c01:: with SMTP id f1mr2223210qke.194.1583203352379;
 Mon, 02 Mar 2020 18:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20200302121524.7543-1-stevensd@chromium.org> <20200302121524.7543-5-stevensd@chromium.org>
 <CAAfnVBk46vsP77hx3kUHqVCPG8Eakh7Kgi0kEHZtrHD-0bHzqQ@mail.gmail.com>
In-Reply-To: <CAAfnVBk46vsP77hx3kUHqVCPG8Eakh7Kgi0kEHZtrHD-0bHzqQ@mail.gmail.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Tue, 3 Mar 2020 11:42:22 +0900
Message-ID: <CAD=HUj5-0CE-tm4meQ_Y7KB4Df41v=kBH2GTStYJptTOSp1yVw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v2 4/4] drm/virtio: Support virtgpu exported resources
To:     Gurchetan Singh <gurchetansingh@chromium.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> cmd_p->hdr.ctx_id =
>
> Before this completion of this hypercall, this resource can be
> considered context local, while afterward it can be considered
> "exported".

Maybe I'm misunderstanding render contexts, but exporting a resource
doesn't seem related to render contexts. The other resource management
operations (e.g. creation, attaching a backing) don't take render
contexts, and exporting a resource seems like the same sort of
operation. It's not clear to me why exporting a resource would affect
what render contexts a resource has been attached to, nor why the
render contexts a resource has been attached to would affect exporting
the resource. Also, from an implementation perspective, I don't see
any struct virtio_gpu_fpriv to get the ctx_id from.

-David
