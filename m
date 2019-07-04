Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 332735FD61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 21:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfGDTSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 15:18:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43330 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfGDTSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 15:18:00 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so14587154ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCuBLDKrofsuoqhEiEo5+1hJatvhFnFN7oOLzAEnyM4=;
        b=bhvxBO8QMlxGiuh/BsyudtWPQFUjQ5R9CUOpdTYaaqZyQ8vlvu/++aMUwi7JPKLthb
         TUMk35QeF5dolWl0Sim+RKa834/lE/WsTIuTlbDF0ehQm3t97BMJEahLPFrS4EXBmrvQ
         hGtjekw2DVmTrMgyT5cq43Ydrv1tI2BXhhH3cd0rbshvREhTgk+eN0E0HZlra+7rkBII
         JQEe1bSGSfbPaEhX75Miqqh4xtrQ3u9LzWU9zuiHUi3vu+v8zyPfDbrkdvRsfhQjXdI5
         jVqTZNVX15sFR7jJRcTntloFNUV9B9Y1sW8SJF4UfOj7XMQDbr6QIZ47Tbbb+X1jaXSp
         4BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCuBLDKrofsuoqhEiEo5+1hJatvhFnFN7oOLzAEnyM4=;
        b=NHzR21h+h+Tyccb4CWmU+3NKsi6dJqagSzv+6mL0OmHKIg2CXOjlSso88etH1Z7ubW
         zpxxJe6tceriamdp2DjKpsqfWMjHGIfKaAk61RtIn9vA6UtXQVZ3qisZb80Tl/j7U/Os
         mclO1D8q5aHLWn23EN2F48/zUcTcBm3ebEGr5KZxhcJ57mwod6HZjDksimGECJVtroLh
         IHQ60InuBCuOEzr2j4jKedm8lWADpMjDYAuR1ivT+gRWhzHyVvYYZ4w13RuLQpOerDio
         rxCSE0+Rsq5NFuXq6kuhJq3s4QkwROrUNS862cug3Q+Zss6JXdBnVxXxmy1svJx8gubI
         Px3Q==
X-Gm-Message-State: APjAAAU1cvO1tbdd73j+7kIkprKNg6ZzuPYK7gXdpah4S3l3X371KKle
        tMaMwukeLNnaHmokjKTEV661wrmE4ExbqOsi4ko=
X-Google-Smtp-Source: APXvYqwsruAsuCOPhI8PglL1hWlvCc+IVuPwdgdoadncDMpAGwAlFk4w01GWSPGzZlwU1IUEHNzB3abapsoIEw3vMZY=
X-Received: by 2002:a6b:6012:: with SMTP id r18mr5966278iog.241.1562267879466;
 Thu, 04 Jul 2019 12:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190702141903.1131-1-kraxel@redhat.com> <20190702141903.1131-7-kraxel@redhat.com>
 <CAPaKu7RfLoB=K__wQd92=S20Mt0uqsfyU9oigr8CQ-=gH6OUuA@mail.gmail.com> <20190704111043.5ubc2yjrjphj2iec@sirius.home.kraxel.org>
In-Reply-To: <20190704111043.5ubc2yjrjphj2iec@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 4 Jul 2019 12:17:48 -0700
Message-ID: <CAPaKu7S4Og7kda2ZjFtuRv=_W8gpFbD5y7s==0JB5Z34S4Hsjw@mail.gmail.com>
Subject: Re: [PATCH v6 06/18] drm/virtio: remove ttm calls from in virtio_gpu_object_{reserve,unreserve}
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 4:10 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > -       r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
> > > +       r = reservation_object_lock_interruptible(bo->gem_base.resv, NULL);
> > Can you elaborate a bit about how TTM keeps the BOs alive in, for
> > example, virtio_gpu_transfer_from_host_ioctl?  In that function, only
> > three TTM functions are called: ttm_bo_reserve, ttm_bo_validate, and
> > ttm_bo_unreserve.  I am curious how they keep the BO alive.
>
> It can't go away between reserve and unreserve, and I think it also
> can't be evicted then.  Havn't checked how ttm implements that.
Hm, but the vbuf using the BO outlives the reserve/unreserve section.
The NO_EVICT flag applies only when the BO is still alive.  Someone
needs to hold a reference to the BO to keep it alive, otherwise the BO
can go away before the vbuf is retired.

I can be wrong, but on the other hand, it seems fine for a BO to go
away before the vbuf using it is retired.  When that happens, the
driver emits a RESOURCE_UNREF vbuf which is *after* the original vbuf.


>
> cheers,
>   Gerd
>
