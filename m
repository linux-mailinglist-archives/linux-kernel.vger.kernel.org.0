Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254BF2067A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfEPLz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 07:55:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42870 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfEPLz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:55:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id y13so2390731lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 04:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hO177V5YstoHgCwjJTd6QkNHj63uQ+DjBf4IdD4xe9U=;
        b=CUsyorl2ruAim6PW7M+EDIOkom4xJQXASAd8/umQpC24MPSnfKP1z/6sQVViheAjF0
         5EF6lw9qAc4E/11MOWdtZ2lMTogd4pz+rY65IAbvn5hJKCxL+SiUDPTXK282GvCmqoI2
         a+kpWjK+OlweLcp2FOnLoidRq0bCigIVTWoEXSiQCceK1hoY3IjV2kvY8FS2763FKYOx
         mmYRyQFEUN5P1zjdQKTaqL8RPcrTsLQCqiE5d2NcP9FjR/q3Qg+hsPXIOx8QdjBN+7uz
         t98bs17n0trMpRKcS3QNHg3KgD1RrGZIoEeGHYD36OZfMEBNLCuJ/AEhMCzHStHnMDah
         2jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hO177V5YstoHgCwjJTd6QkNHj63uQ+DjBf4IdD4xe9U=;
        b=JZbEiMdDPEt8HuBahh8JHS8XXZFDeOlCAcrWGTwJoB0+ojVtv5nzko8fu9Dxww3wSg
         XIo3Ydw10iNsOK/mvJPi5ogNifkA1+3FwyUKvt6Wu9g3viS+N/SUHfbeiyw0dTgB3b+9
         KXFqY3jLgh8NGBElmNG1XR8iTwEeu8vLA67CBtzIEc8+hDqh+GLw0Oq6IClw5w4j4wW9
         LLuCrLyoDWgmrtkxLA2NzSVDeoP15yKoV37Tv9M8lTXTh0GK1nZKpcMovE1fjKaxuGJG
         7GmlrZ3QAxbxG2lIKQfwXSRWfgILnRH/o/sNE2cXqm/tMCu4+9B9YAVNtGIOjQvy9xjm
         0Lbg==
X-Gm-Message-State: APjAAAVA7FXuHGq5mCVQhYMXJwvmda1uruC+xvzosheMnMov/3szJGjk
        np2ANBOh8ZBRERN9atcj8NVvNBEejCnyiINH5AkIgg==
X-Google-Smtp-Source: APXvYqyZ8YtOPeMszJlq1lN+VhvgOvRHSsqzsCTDLezRY/k3Tb/Z9ZQ2wRmo8YDVATi18dFWIID2WHYRpAKSQEcvW8I=
X-Received: by 2002:a19:cd82:: with SMTP id d124mr11861237lfg.8.1558007757283;
 Thu, 16 May 2019 04:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190508073331.27475-1-drinkcat@chromium.org>
In-Reply-To: <20190508073331.27475-1-drinkcat@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 May 2019 13:55:46 +0200
Message-ID: <CACRpkdZb73vNyepcfjzEGAopc7BBxde_N1wxn7PSJ3aGC0=Gig@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] pinctrl: mediatek: mt8183: Add support for wake sources
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 9:33 AM Nicolas Boichat <drinkcat@chromium.org> wrote:

> This adds support for wake sources in pinctrl-mtk-common-v2, and
> pinctrl-mt8183. Without this patch, all interrupts that are left
> enabled on suspend act as wake sources (and wake sources without
> interrupt enabled do not).
>
> Changes since v1:
>  - Move changes from mtk-common-v2 to mtk-pinctrl-paris, as
>    recommended by Sean, to keep better separation between eint
>    and pinctrl-common features.
>
> Nicolas Boichat (2):
>   pinctrl: mediatek: Add pm_ops to pinctrl-paris
>   pinctrl: mediatek: mt8183: Add mtk_pinctrl_paris_pm_ops

All seems to look fair to me, but I need some official ACK from
Sean on these.

I see there is some discussion on a related patch set which
also has two patches so I am a but confused how mature the
two patch sets are? Are they at all related?

Yours,
Linus Walleij
