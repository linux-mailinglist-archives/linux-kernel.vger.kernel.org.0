Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E77E11E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 19:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfHARbH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Aug 2019 13:31:07 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:52080 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726118AbfHARbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:31:07 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17794926-1500050 
        for multiple; Thu, 01 Aug 2019 18:30:47 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190731164829.GA399@tigerII.localdomain>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190721142930.GA480@tigerII.localdomain>
 <20190731164829.GA399@tigerII.localdomain>
Message-ID: <156468064507.12570.1311173864105235053@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [Intel-gfx] [linux-next] mm/i915: i915_gemfs_init() NULL dereference
Date:   Thu, 01 Aug 2019 18:30:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergey Senozhatsky (2019-07-31 17:48:29)
> @@ -36,19 +38,35 @@ int i915_gemfs_init(struct drm_i915_private *i915)
>                 struct super_block *sb = gemfs->mnt_sb;
>                 /* FIXME: Disabled until we get W/A for read BW issue. */
>                 char options[] = "huge=never";
> -               int flags = 0;
>                 int err;
>  
> -               err = sb->s_op->remount_fs(sb, &flags, options);
> -               if (err) {
> -                       kern_unmount(gemfs);
> -                       return err;
> -               }
> +               fc = fs_context_for_reconfigure(sb->s_root, 0, 0);
> +               if (IS_ERR(fc))
> +                       goto err;
> +
> +               if (!fc->ops->parse_monolithic)
> +                       goto err;
> +
> +               err = fc->ops->parse_monolithic(fc, options);
> +               if (err)
> +                       goto err;
> +
> +               if (!fc->ops->reconfigure)

It would be odd for fs_context_for_reconfigure() to allow creation of a
context if that context couldn't perform a reconfigre, nevertheless that
seems to be the case.

> +                       goto err;
> +
> +               err = fc->ops->reconfigure(fc);
> +               if (err)
> +                       goto err;

Only thing that stands out is that we should put_fs_context() here as
well. I guess it's better than poking at the SB_INFO directly ourselves.

I think though we shouldn't bail if we can't change the thp setting, and
just accept whatever with a warning.

Looks like the API is already available in dinq, so we can apply this
ahead of the next merge window.
-Chris
