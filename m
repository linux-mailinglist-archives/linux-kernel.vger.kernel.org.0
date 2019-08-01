Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 492F47D446
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 06:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfHAEGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 00:06:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38048 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHAEGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 00:06:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so71950344wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 21:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0mB42y3xmrJWhBLWeWzKTdkVYurhG+q5hPYefS8udCw=;
        b=Rqy1b9wgnbO9iiiBCq0yAP3hGF9q5tLtF+rAKGfMKigKhec6hrRDE2gbAmGB6vil2r
         3lcZJ1qyK34AcYzj1Pc4F5LaFctVd17q/tHL6sMpyVAhjhlkvj+6WFudBTwwiM77jJg2
         1pvNRrRsnFSe3u9RLO+v1a/eLfrm+Ons2lnZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0mB42y3xmrJWhBLWeWzKTdkVYurhG+q5hPYefS8udCw=;
        b=tXFjfHyjqoNVvUELdRw0mvsbXnzFHe+/PwXPHqcnlmasNviNYTLADEyDBjM34wAimZ
         kLk885BO4ZV5dnEBDKZEx0SK18dgMhecqjVq7znjeI4P/K70cxUusXveKfRXwhou550J
         PnBIYYcOJk2ut4LwOJhJHVVPnWpkd7I8WDwdav43ClfEq1TeAAE0i7j6GsC9Zoszl65g
         olQN6vby1bcD3cb2d4M6P6T0tqELVAgcptxakv4mlYwROcaWD9izXE086nHNwSS4VkFG
         K2lasew9QttfqMDeLJe9gonXAgvruNqKRybTNXi9FYLB9Y3YpNKChasgOWN1cOPsJiRh
         Bf2Q==
X-Gm-Message-State: APjAAAVz/t3x809Ts/i5/VtKYrgR4ceCMQsEmCAcSRXAGcLf3SlqQsAZ
        in8N5vH7uZkE0v5MyVhkzpdqdXm5R0doekVYGrjNxQ==
X-Google-Smtp-Source: APXvYqycKy7N26liWehbx4OB6WFB2ks3ASboEt4UcIJYI8SMe0JfZCnvhCeu+F7MPJNgeMKOB0gT4IRbMod1SEgn704=
X-Received: by 2002:adf:f08f:: with SMTP id n15mr52081058wro.213.1564632382431;
 Wed, 31 Jul 2019 21:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190619121540.29320-1-boris.brezillon@collabora.com> <20190619121540.29320-8-boris.brezillon@collabora.com>
In-Reply-To: <20190619121540.29320-8-boris.brezillon@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 1 Aug 2019 13:06:10 +0900
Message-ID: <CAHD77HksotqFBTE84rRM=DuNFX=YJPs=YnsuFkaN-pWUNCtoxA@mail.gmail.com>
Subject: Re: [PATCH 7/9] media: hantro: Add core bits to support H264 decoding
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hertz Wong <hertz.wong@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Wed, Jun 19, 2019 at 9:15 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
[snip]
> @@ -533,10 +535,21 @@ hantro_queue_setup(struct vb2_queue *vq, unsigned int *num_buffers,
>                 return -EINVAL;
>         }
>
> +       /* The H264 decoder needs extra size on the output buffer. */
> +       if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_H264_SLICE_RAW)
> +               extra_size0 = 128 * DIV_ROUND_UP(pixfmt->width, 16) *
> +                             DIV_ROUND_UP(pixfmt->height, 16);
> +

I wonder if this shouldn't be accounted for already in the sizeimage
returned by TRY_/S_FMT, so that the application can know the required
buffer size if it uses some external allocator and DMABUF memory type.
I know we had it like this in our downstream code, but it wasn't the
problem because we use minigbm, where we explicitly add the same
padding in the rockchip backend. Any thoughts?

Best regards,
Tomasz
