Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B5B7FB58
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 15:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406519AbfHBNlV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Aug 2019 09:41:21 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63430 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726948AbfHBNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:41:21 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17818216-1500050 
        for multiple; Fri, 02 Aug 2019 14:41:17 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190802133503.GA18318@tigerII.localdomain>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20190802123956.2450-1-sergey.senozhatsky@gmail.com>
 <20190802123956.2450-2-sergey.senozhatsky@gmail.com>
 <156475071634.6598.8668583907388398632@skylake-alporthouse-com>
 <156475141863.6598.6809215010139776043@skylake-alporthouse-com>
 <20190802131523.GB466@tigerII.localdomain>
 <20190802133503.GA18318@tigerII.localdomain>
Message-ID: <156475327511.6598.417403815598052974@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 2/2] i915: do not leak module ref counter
Date:   Fri, 02 Aug 2019 14:41:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergey Senozhatsky (2019-08-02 14:35:03)
> On (08/02/19 22:15), Sergey Senozhatsky wrote:
> [..]
> > > > Looking around, it looks like we always need to drop type after
> > > > mounting. Should the
> > > >         put_filesystem(type);
> > > > be here instead?
> > > > 
> > > > Anyway, nice catch.
> > > 
> > > Sigh. put_filesystem() is part of fs internals. I'd be tempted to add
> > 
> > Good catch!
> > 
> > So we can switch to vfs_kern_mount(), I guess, but pass different options,
> > depending on has_transparent_hugepage().
> 
> Hmm. This doesn't look exactly right. It appears that vfs_kern_mount()
> has a slightly different purpose. It's for drivers which register their
> own fstype and fs_context/sb callbacks. A typical usage would be
> 
>         static struct file_system_type nfsd_fs_type = {
>                 .owner→ →       = THIS_MODULE,
>                 .name→  →       = "nfsd",
>                 .init_fs_context = nfsd_init_fs_context,
>                 .kill_sb→       = nfsd_umount,
>         };
>         MODULE_ALIAS_FS("nfsd");
> 
>         vfs_kern_mount(&nfsd_fs_type, SB_KERNMOUNT, "nfsd", NULL);
> 
> i915 is a different beast, it just wants to mount fs and reconfigure
> it, it doesn't want to be an fs. So it seems that current kern_mount()
> is actually right.

struct vfsmount *kern_mount(struct file_system_type *type)
{
        struct vfsmount *mnt;
        mnt = vfs_kern_mount(type, SB_KERNMOUNT, type->name, NULL);
        if (!IS_ERR(mnt)) {
                /*
                 * it is a longterm mount, don't release mnt until
                 * we unmount before file sys is unregistered
                */
                real_mount(mnt)->mnt_ns = MNT_NS_INTERNAL;
        }
        return mnt;
}

With the exception of fiddling with MNT_NS_INTERNAL, it seems
amenable for our needs.
-Chris
