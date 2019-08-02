Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3417FBA4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 15:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436579AbfHBN7t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Aug 2019 09:59:49 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:64685 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729325AbfHBN7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:59:49 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17818578-1500050 
        for multiple; Fri, 02 Aug 2019 14:59:46 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190802134955.GA23032@tigerII.localdomain>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190802123956.2450-1-sergey.senozhatsky@gmail.com>
 <20190802123956.2450-2-sergey.senozhatsky@gmail.com>
 <156475071634.6598.8668583907388398632@skylake-alporthouse-com>
 <156475141863.6598.6809215010139776043@skylake-alporthouse-com>
 <20190802131523.GB466@tigerII.localdomain>
 <20190802133503.GA18318@tigerII.localdomain>
 <156475327511.6598.417403815598052974@skylake-alporthouse-com>
 <20190802134955.GA23032@tigerII.localdomain>
Message-ID: <156475438424.6598.9088236553657284521@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 2/2] i915: do not leak module ref counter
Date:   Fri, 02 Aug 2019 14:59:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergey Senozhatsky (2019-08-02 14:49:55)
> On (08/02/19 14:41), Chris Wilson wrote:
> [..]
> > struct vfsmount *kern_mount(struct file_system_type *type)
> > {
> >         struct vfsmount *mnt;
> >         mnt = vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL);
> >         if (!IS_ERR(mnt)) {
> >                 /*
> >                  * it is a longterm mount, don't release mnt until
> >                  * we unmount before file sys is unregistered
> >                 */
> >                 real_mount(mnt)->mnt_ns = MNT_NS_INTERNAL;
> >         }
> >         return mnt;
> > }
> > 
> > With the exception of fiddling with MNT_NS_INTERNAL, it seems
> > amenable for our needs.
> 
> Sorry, not sure I understand. i915 use kern_mount() at the moment.
> 
> Since we still need to put_filesystem(), I'd probably add one more
> patch
>         - export put_filesystem()
> 
> so then we can put_filesystem() in i915. Wonder what would happen
> if someone would do
>                 modprobe i915
>                 rmmod i916
> In a loop.
> 
> So something like this (this is against current patch set).

Yes, that's what I in mind. I was thinking of whether we can replace our
kern_mount + fc->ops->reconfigure() into a single vfs_kern_mount(), and
whether or not that works with get_fs_type("tmpfs").
-Chris
