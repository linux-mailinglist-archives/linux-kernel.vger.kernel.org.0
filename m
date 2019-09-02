Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7173BA5CC5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2019 21:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfIBThx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 15:37:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36763 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfIBThw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 15:37:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id u15so13808205ljl.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFBZbglnhDy4wm5KdZCDkbStrJH9o3uKwcmY8dacc3U=;
        b=AevTDV+wfZYm4W85EBlJwOhCTN+owzObRyYtnPAQFD9/ZgMrEnTKiGX58KaVOPa13I
         11thWv5CuiaFG67Jnn/Nq9bD6NUm6apCyTlNAYKrvxt82lJbbf5ayGtiXHKhT4drocDv
         w+3YtZf7XvMMhfHpEMaAJuG8GUVBo69b2HEGXLW9A1NYB+CWg83i3mAV2Xk2rTaJfu6f
         7TC/yrOfrM9VRLm3fO7Xpls5a0IjzKa1pCL3bGf3xd5HuqIGVlj3dXwMDtTaOqieVFHm
         O/cjl4xsqVeluMXLAc4Gd6xl6EVowBMyiNDCzVmGqpGegsL94u3akkN279Ml0VhzZc80
         8sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFBZbglnhDy4wm5KdZCDkbStrJH9o3uKwcmY8dacc3U=;
        b=CGMCjAPRbAolCmAfx3vEfobKitQqQuOOP/MyT0yOIvgvxvjseG1c/vc/26G6n56CDh
         6/ewHwevJhkTomfhNeD452B5UqBYFKOno5Gole6jjWhbPzs3l9Mos6Eagn6ZNZLxEmMo
         ZDfxchISvRbhYgxrd+8C3+s70kT2IiqhokCiJptBSZ9j2i9UJ1/UnM8Svo0tWBPeKy1u
         9kXL0IF23X3bmdPtisD7oXOPzCeQILPVxXdNWnfMV9NFxDQHtmYRz8VQfp5xEGn+7huL
         RTulbiMwdE1qPBJ7g0RYY5xFNFJ+J3wJPa2Griy7IX0hRcFvnmpLJhE5AIqroPN9RQxh
         a0Wg==
X-Gm-Message-State: APjAAAXrwk1wIKkpRg9dM9ASZ+rVrFy0fiWka226IN0LJ4EnicEB/BcQ
        UZZfQcy6MQxzbP33E4/smD9vYx1NQKuhZ8MCIu0LiA==
X-Google-Smtp-Source: APXvYqxbBRxUy282JBaawD5vQL/kXq0ZGive67XU+QMHi+fOK/RZkHJV2tjtlXbDP9XgKqI+yMTqKPPHKZ3O1jw4hjA=
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr10752018lja.50.1567453070510;
 Mon, 02 Sep 2019 12:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190828103229.191853-1-maco@android.com> <20190830155024.GA23882@infradead.org>
In-Reply-To: <20190830155024.GA23882@infradead.org>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 2 Sep 2019 21:37:39 +0200
Message-ID: <CAB0TPYELq72hjHvyFVmaAFZPCaSSxV-j6znM8peezqtep6i-1A@mail.gmail.com>
Subject: Re: [PATCH] loop: change queue block size to match when using DIO.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com,
        Narayan Kamath <narayan@google.com>,
        Dario Freni <dariofreni@google.com>,
        Nikita Ioffe <ioffe@google.com>,
        Jiyong Park <jiyong@google.com>,
        Martijn Coenen <maco@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 5:50 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Aug 28, 2019 at 12:32:29PM +0200, Martijn Coenen wrote:
> > The loop driver assumes that if the passed in fd is opened with
> > O_DIRECT, the caller wants to use direct I/O on the loop device.
> > However, if the underlying filesystem has a different block size than
> > the loop block queue, direct I/O can't be enabled. Instead of requiring
> > userspace to manually change the blocksize and re-enable direct I/O,
> > just change the queue block size to match.
>
> Why can't we enable the block device in that case?  All the usual
> block filesystems support 512 byte aligned direct I/O with a 4k
> file system block size (as long as the underlying block device
> sector size is also 512 bytes).

Sorry, I didn't word that correctly: it's not the logical block size
of the filesystem, but the logical block size of the underlying block
device that loop's queue must match (or exceed). With the current loop
code, if the backing file is opened with O_DIRECT and resides on a
block device with a 512 bytes logical block size, the loop device will
correctly use direct I/O. If instead the backing file happened to
reside on a block device with a 4k logical block size, the loop device
would silently fall back to cached mode. I think there's a benefit in
the behavior being consistent independent of the block size of the
backing device, and I don't see a good reason for not automatically
switching loop's logical/physical queue sizes to match the backing
device in this specific case.

Will send a v2.

Thanks,
Martijn
