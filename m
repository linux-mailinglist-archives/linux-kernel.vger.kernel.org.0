Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA4B12CEB3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Dec 2019 11:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfL3KYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Dec 2019 05:24:47 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34515 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfL3KYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 05:24:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so16671517lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 02:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzDoRC4MHhm3h5pF1afVY20HHsvL3mkKYh/fXUPc0Uw=;
        b=WtMjvql2lt33WePTaTxAejV/6Ql6c3RMJxp4Y23AMXse9xix5gI1Q4NnDK5ae02N6m
         4LtduhmLFWqoU6P/2rplRTaKlUsF0ikMpjkvKNNj2NKqjcX0mFsgf/ofOq+dh6zumofR
         ZzBhRH3AAJhP80OMBTcdN+h5hJzrTXMdhj76bVcdCdHGVeRdhtXrCGQfS/pEuYDHR4jq
         /UZxFPsGjWGR6EBmiKNn4GWLFNxlSxBsGz4FaHVb19XG9bwEaRsCmcJsMSALj1i6SiBP
         5T6ZpJtH98PU82kKunQ7kzRF3LI8JlXeqm6uwYciDhqUYhqU2oh/NhQKCPLwEMvDxxZb
         11qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzDoRC4MHhm3h5pF1afVY20HHsvL3mkKYh/fXUPc0Uw=;
        b=iCgVAWCYfY9td7D8eZck+1fir34GL0M0xdFExM8rIVo+VllEp6m9y0avkR5cYAxxY8
         ZeoEA8z4fMPhap3l2HTmK6DPv3DrmMpN/BNjHQtojMQgTZGia4peRp1mmGDYUnWHIG9o
         /7OuQdKGvKDMv5uYqKWt/WWFQTBgxpSbM6m4b7ZrWjRS8oQkbnAdjFyAKSIleHOjqidE
         laVQccnXu2uz4JDuJYcNIwTdUnxTwd34YQ9XOq3z5+esuCTCI0CyrSMk+XOyp8BXgBaa
         XI2nvgM2WAjaUKP+0WhOCxSkD+7/P1xWBzqCU/psylacTXcbGm7Z9aGV/ZfW2qMmGHKz
         4fzA==
X-Gm-Message-State: APjAAAW9Oxq/7nWNqerM514emr998GwDkULSy4gtgU5m645Twnl9NGDb
        4XNvz8UAdwFSqQ48J66vfUOQ3lw57MT5V+TuWMxJZngT
X-Google-Smtp-Source: APXvYqxRvkQxLspnMmrMM3h3Sj/dlWYZvO08GqnBkR25i7gWRKC/2+sgwKwkjkNbniEpGN7uNEbSVnL5aW6wlZVmlto=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr39891977lfn.126.1577701485459;
 Mon, 30 Dec 2019 02:24:45 -0800 (PST)
MIME-Version: 1.0
References: <1577495680-28766-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1577495680-28766-1-git-send-email-tiantao6@hisilicon.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Mon, 30 Dec 2019 10:23:40 +0000
Message-ID: <CAPj87rO-ZrCCJCza0Eeyp-JAJ6Qp8RdhJQh_1Yh_QSeK2o8_hw@mail.gmail.com>
Subject: Re: [PATCH] drm/hisilicon: Added three new resolutions and changed
 the alignment to 128 Bytes
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, tzimmermann@suse.de,
        Gerd Hoffmann <kraxel@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>, tglx@linutronix.de,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tian,

On Sat, 28 Dec 2019 at 01:14, Tian Tao <tiantao6@hisilicon.com> wrote:
> @@ -118,11 +119,9 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
>         writel(gpu_addr, priv->mmio + HIBMC_CRT_FB_ADDRESS);
>
>         reg = state->fb->width * (state->fb->format->cpp[0]);
> -       /* now line_pad is 16 */
> -       reg = PADDING(16, reg);
>
>         line_l = state->fb->width * state->fb->format->cpp[0];
> -       line_l = PADDING(16, line_l);
> +       line_l = PADDING(128, line_l);

The 'line length' here is the 'stride' field of the FB. Stride is set
by userspace when allocating the buffer, and the kernel must not
attempt to guess what userspace set.

You should use state->fb->strides[0] directly here, and in your
atomic_check() function, make sure that the framebuffer stride is
correctly aligned.

Please split this into a separate change. Your commit has three
changes in it, which should all be separate commits:
  * enforce 128-byte stride alignment (is this a hardware limit?)
  * get the BO from drm_fb rather than hibmc_fb (can hibmc_fb->obj
just be removed now?)
  * add new clock/resolution configurations

Cheers,
Daniel
