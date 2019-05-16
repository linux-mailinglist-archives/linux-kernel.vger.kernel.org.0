Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3441FE3E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 05:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfEPDlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 23:41:17 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36434 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfEPDlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 23:41:17 -0400
Received: by mail-vs1-f65.google.com with SMTP id l20so1386685vsp.3;
        Wed, 15 May 2019 20:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCZgvULVS8AZ/nrQ5IWQSDdjVyIlgz7VAXZ7txeuOYA=;
        b=fV3+35gXK5okEn4OXxJ9YOeXyT4wcPqNY5ybD1Kt//ncsebCg0t36rCNc2mpaMkkuw
         9TJtUtKuQNYalztwVz+Og28YUNeY/lJv+InGErLmmDLoYt/qeEcJeeOlxUtQdJIRSIXN
         iQXVb1TootdbBTgp8AHe5pKLzhT7WWpnrT7DlVnRscipCIg8dUxMVpIHjb4KiZ/JpkaK
         MbQTVEIjo1pshF2eYS3LVMY9OLufLuKCzzUMTKM8nMCnZo7xN6fWDZXt4Di8h+gCbYeU
         Dh2efqZkEiDbFYDUfLUdoSVrt9kh9/yQWHeF7PVWZ6iN8Q6VcSlXQpL5PTyGa89FxFfR
         ss2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCZgvULVS8AZ/nrQ5IWQSDdjVyIlgz7VAXZ7txeuOYA=;
        b=te577MyNEd6HIs+8CVmXbcNaG6/UAKaKnxHuEg/pkpESKqIMr4BRWRIle3+Io3X0Dx
         nCw10FisaaY3KPhrybJEiQAWC0YSJI7+yFoup/7KIwevnK0wG4j+lcOA6RbEl0jU/puP
         C8Jb4VBDvuMIR+Ysjq4/cpAt4zT8FjQ+4R+S0g3z+hfxLsx0vVLlGiZc1sm63hTYeU4l
         sGtaAnxaE1i/lihwN4IG7hYzTrh4BD7/nDZKfgkjKKif58vtsyyC46jZuZ2fiK+aS8Wk
         plCxu87jDNzK1Co4BNcfLi4XTLFXuzNrfgCnHszQ7HgwT0bWaSc1OUiK+n+iaaTEv0T7
         1ckA==
X-Gm-Message-State: APjAAAUENnxle0a94h0/yLB41OwpvOMFY6CjAfa5pwnoipVqeAJnMvES
        mD0g7qiybNjvyMw6vN+2/ZyaTOvl8TmG9CaBVMI=
X-Google-Smtp-Source: APXvYqwV5DLsjSb66vr41Axav+yQIX3UjfnYyUcTzWtXWjWxMmGLmYszssWspv2zmkdEXsR5Ijj3aYF7heDmlyxgAI0=
X-Received: by 2002:a67:644:: with SMTP id 65mr20597613vsg.132.1557978076061;
 Wed, 15 May 2019 20:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190514205701.5750-1-colin.king@canonical.com>
In-Reply-To: <20190514205701.5750-1-colin.king@canonical.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Thu, 16 May 2019 13:41:04 +1000
Message-ID: <CACAvsv5qD7LotsmK9Cv3XNH56sp8UmovOU3cxiE158oQwXS=jg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/bios/init: fix spelling mistake "CONDITON" -> "CONDITION"
To:     Colin King <colin.king@canonical.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 at 06:57, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a warning message. Fix it.
Thanks, merged.

>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> index ec0e9f7224b5..3f4f27d191ae 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> @@ -834,7 +834,7 @@ init_generic_condition(struct nvbios_init *init)
>                 init_exec_set(init, false);
>                 break;
>         default:
> -               warn("INIT_GENERIC_CONDITON: unknown 0x%02x\n", cond);
> +               warn("INIT_GENERIC_CONDITION: unknown 0x%02x\n", cond);
>                 init->offset += size;
>                 break;
>         }
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
