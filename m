Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7465A41F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2019 10:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfFLIoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jun 2019 04:44:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41260 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfFLIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:44:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id s21so14372406lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXPy6kD2gFwlUuId8WEznhJ1Poa05ZMGVOTjoPChSP8=;
        b=PvWCd5zJz+0mVVuAXjRL/ND/2lhYSSE9llh3OtEzsQ0B61njuSUX9TrFg106OnDYXv
         7MJTusmyWZAvT3tTcp6Y6hcTDZ30ekWrycGxhiG+s3YnCnBc6TXMenolVMwNjtThWRwn
         8QdZRgK1OLDdg0GEMsCK2G498LR8XVOSs20TuFYCiBb4fNzLZgh7AswQFGS5fQD6gkfb
         fFqAY+B0v+cIxSZt0wQMb9c422nvUSpo36CRYOvLf4Xy4l8fl8BOoZkLDnyzgoCWqwuZ
         8/VR0udQEUJdd/3r91eIImhpxBe68w83hYEQj6dOdA0kbG8WbihXERC5SUy/Vu9Ja7YD
         EQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXPy6kD2gFwlUuId8WEznhJ1Poa05ZMGVOTjoPChSP8=;
        b=cOrgHFzEovT9O7gOJvr1c2bLujOsZ85qO/S+Ii0GuK1LYUanUwIhDtoJZP7pcOU70i
         zjGK0w1AoFH+8P8FTRLnbe8Z45ddyS9qor8OiIj4QTfItZ4jak0ieqLhrkY7+zToZBtE
         JI1tS/Ae9tU326OS7ieE2lAIfxtHCCKtv3Sbyp3bs/ArHvmYRkO9TRtP9/nE3JhMi4lS
         X0W2I2mjVHJh62uys+CWlZYVMnKx8rYaadSjdBlwINI07n+HzKy7xNPdpVe+i0gJHqIb
         Zvwzg2eFUM8uVfTkgsi3xt2XlfktlkdkzQ1KJUccNTLN/hsu/B2emdzzb6cu7Lp6maU7
         diuw==
X-Gm-Message-State: APjAAAWhq7eVgnK0NEtGB49wZoVaA55ZjgGs4t5gPwA767MNDcqz5CxZ
        3WjwtCd/iVcdNpC/uUOk1thWO7ZM8jnNEOz68jtptQ==
X-Google-Smtp-Source: APXvYqwrPS8OsyBoY3vc54Mb2hWKOCvV7geC2RBav5pSRb1SLrflF9VirpQvaiOeoFCp8vBJ26VImCHonoZpxJ8bzlM=
X-Received: by 2002:a2e:2f12:: with SMTP id v18mr42060237ljv.196.1560329040984;
 Wed, 12 Jun 2019 01:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-7-grygorii.strashko@ti.com>
In-Reply-To: <20190610171103.30903-7-grygorii.strashko@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 12 Jun 2019 10:43:49 +0200
Message-ID: <CACRpkdZy+j4bBV-0HPu4cdS3YppDxE6OAmqq9iTgcKOM1G9zSw@mail.gmail.com>
Subject: Re: [PATCH-next 06/20] gpio: gpio-omap: move omap_gpio_request() and omap_gpio_free()
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Russell King <rmk@arm.linux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 7:12 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Move these two functions to live beside the rest of the gpio chip
> implementation, rather than in the middle of the irq chip
> implementation.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
