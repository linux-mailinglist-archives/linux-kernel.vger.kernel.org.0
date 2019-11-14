Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2C2FD189
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 00:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKNX0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 18:26:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37869 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKNX0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 18:26:32 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so6507248lfp.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 15:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dh355UxLWVUsAWtwLkdueim4hUviJNMSeVlOVRSiyyU=;
        b=fsPJNeng02AwnnNHtwtXoe3riey1s/OJrERM+5JLecji6GA9zq4JM5sHWvCJyNKnWC
         6xvVpy3wgwf6hGgp3N3H+WuDv2r8poG8kCEbS5fXQkeIZ3eugGRcYDmTu6nCr9g/hqW8
         GyeJopyeU9cHUKn7On5e4xnwapZTvRaUCO9Xq533CLFKtNyceG8bg2DwwTb7FPPgzTJ8
         wVKTtqRx7FUrs9cUbhUP/RwggYxF5sy0lwWOeRytpjajYFmsTO+KX+VqTQf6LJFkpIp3
         aNoAjxE448K3Tj09rXpE55JYCFFKXJlCLZd2+sVubjWjTJ1odWk3FpoPjoDu7D52yTqh
         gZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dh355UxLWVUsAWtwLkdueim4hUviJNMSeVlOVRSiyyU=;
        b=pnXK6JMeY3FNirEkhdjmfR886HxjFjkCVzUbsvQIJE/j1el0U79K8Fjm0CaynwoISX
         m7vSyvXl+IHL5+L0LW7w1DZXg+cYMpuOiPJ7v69wYhE3ipspu+2xcKocjxJYoyIIYp7x
         EgFKHFNqBrakdxSTQzg6GkqjgsVIrZJQ6ZcGsmlPAhpA3bM+lX2frVamz6HXZkFzlp53
         kCv2qQdT7BOZIYDkP68omazJzpWAV83v/zrbdsUNK+czl5LTcYXg7RK/ARqbAq/wRZcO
         tHV+6rxdAtREFQLxwuVq2Mvm7kfqXbB3LHdS6TGjaSSnPsPrc4WHksyaCETCTBl+5T6k
         skzg==
X-Gm-Message-State: APjAAAXnp4AQD/MM8NvOYLUdnSc2IYYHSb1kb1g1ZdRbWDMfNTv5ppvi
        vgCnCEQJ2ThlP3bgWgEyfhTmKe4BbqZfVb/o67SrWjNccaE=
X-Google-Smtp-Source: APXvYqzLk+KhD3Sj2zIb1agtuRx8FqBh+eeYu3cNtIavQb53WVkpwyRNOE71sOo8/sYqRoHw9clCFk4qt3Trn3pUKVk=
X-Received: by 2002:a19:651b:: with SMTP id z27mr8714521lfb.117.1573773990709;
 Thu, 14 Nov 2019 15:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20191114185152.101059-1-robdclark@gmail.com>
In-Reply-To: <20191114185152.101059-1-robdclark@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Nov 2019 00:26:18 +0100
Message-ID: <CACRpkdYwBp59wGPbs4+4rNmYPJMXDF0g8qbmhf3_XDHAmFkjcQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: ignore NULL clocks
To:     Rob Clark <robdclark@gmail.com>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 7:54 PM Rob Clark <robdclark@gmail.com> wrote:

> From: Rob Clark <robdclark@chromium.org>
>
> This isn't an error.  Also the clk APIs handle the NULL case, so we can
> just delete the check.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
