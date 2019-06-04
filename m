Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F6F340EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 09:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfFDH6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 03:58:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35465 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfFDH6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:58:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id h11so18776700ljb.2;
        Tue, 04 Jun 2019 00:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvzPUYqH9nK8SbQWAc82SWJDMQ3U5uh7URsnw55J3C4=;
        b=XCfqSX7E47qfh3NPqnaMv3sdIYsvMjhJBMW+800OQocC7pmZSfhmXsVNtQvoSkqS5S
         lIxs0yYnBDHo/UJ48ltoXnMeULl8Um3cUW6LviAg/FFmivIuVjnkVKZ3vwQyaDdmSRqh
         QqjdGLlvfyX/Bsz1hg9BJjsplgHKCMG//yJ0aN7NRxQnUy+izKFYMsKiMEdZesJYb3Y+
         EE/yJsXfyNC/hhOzmtVQNeZvgdgDSupECZITED9+mdm3xcp5hdBQsjlDgBpSHI7SKPaI
         wolIOxdWcnyXpl///pKD+eaXqEos+dSbatMZ83ppZPdBSwlbvBtT/BkYf7IIU69tbgJt
         x3gw==
X-Gm-Message-State: APjAAAWRR9V2pEHcahWTbIKFfvH3umCRK8qs4ffw6vGOTncgLlgXeGJH
        Ftw8qoJekM5aDaiM9ylOGeprWj7eEu6OggktIfY=
X-Google-Smtp-Source: APXvYqzKBinWmJaGzacGbRhOnLvFa8CQvWOwWKrZ6+Cuc2VOa4+eYgk+VggacDzU6eH0s8dlyt2BbGyoYynEOThpl6w=
X-Received: by 2002:a2e:6e01:: with SMTP id j1mr15810116ljc.135.1559635132892;
 Tue, 04 Jun 2019 00:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <1559634942-20369-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559634942-20369-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 09:58:41 +0200
Message-ID: <CAMuHMdUMZ6bf-dj0YtgGqc_smcdYbMs3H82ZjyVtCwnjOiCXgA@mail.gmail.com>
Subject: Re: [PATCH] hexagon: configs: Remove useless UEVENT_HELPER_PATH
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Richard Kuo <rkuo@codeaurora.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 9:55 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
