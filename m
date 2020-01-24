Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234F5148658
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 14:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390087AbgAXNq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 08:46:59 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46934 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388433AbgAXNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 08:46:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id x14so172977ljd.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 05:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jXUp4mGdVJz8O7y1nR2ub/02JSvmbPGS4k4ix4nOyI=;
        b=BTqj7Wep31MBR/7KdEP5/j7hBWGxSlcnPMnTIIzfscRY4Qn70CHNsSv+m0gYfPES6L
         jP3trk/vDGwvxXeF31Yv4cQZRegiHDHzKMXcywQew/qYFKx7XYBmyJyekqefGA681YlI
         MDhbD6RSVkXZqIcviaM3SZQXhq2cPwjvHgEmdMI//ZjRKRjtJ+ViPpCe7gF3fsZYjHh7
         +opc7c0hBuZglBPGKxpOfHPPGpTH3ph1tuEQWPIjcAEgmVVbksny23F/LN/0P2aIbCKY
         O6u+adJ3Mvs0Q1O4TBfHrJu+jmUwD2WMRCAeu9BQn/8jXESSQiTmqVUz2CGBYhQxSWzf
         3lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jXUp4mGdVJz8O7y1nR2ub/02JSvmbPGS4k4ix4nOyI=;
        b=FYk62NT8/p2vJ91c1vi3eoZpIrtaGU3pMQnlud25GfHHbXNtLSAoTFyWQ4ERLykZ4O
         XcXO2nNOqvcgPPC0ZIGiKUSxVVB+Bla5Llthke4Ip7S2zNfm90tr8TdxsY231kt9NiVm
         SS1HfNQvzMe2cLPPlSJaKF8jFidQNiSmXD4vHfp43XRSPAEaMgcXN/BPAer1etDaRvOr
         l5heWDtEIWUwuwOBmGaNATZLusYYYXBHYpdpZ43eB+BvwiAPshlM/SeIoZsPea+rKoKX
         hZj3TjWnI37XsPNAaY1Ij7uM61GlW9bUwe4HBHPP3nWCQqBrcf5x1P0KG2hRcpTFOnhK
         L6tQ==
X-Gm-Message-State: APjAAAVaTvdpIHkftQCxhctE8/ooah0KMoPGUWWOGYDmTqB5bAc8Vg6m
        J69ZO/C/5bgDXXf5mxH4pzLMGVXMllhYa/fIbt0Pkg==
X-Google-Smtp-Source: APXvYqz476KmoaXM9u7iGRdhIDXrImMMdbbJW6V/alqJW1Yifzjhpcd4NptKaOobOP1WP6JQ/nh8po7UuLXjW1VQ02Y=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr2317476ljg.168.1579873616930;
 Fri, 24 Jan 2020 05:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20200124092919.490687572@linuxfoundation.org> <20200124092921.766134559@linuxfoundation.org>
In-Reply-To: <20200124092921.766134559@linuxfoundation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Jan 2020 14:46:45 +0100
Message-ID: <CACRpkdYJZoQpTCdTikQTu62EuxbUG5A=h3CV2xfHfra=TbD+eQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 016/343] regulator: fixed: Default enable high on DT regulators
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:44 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Linus Walleij <linus.walleij@linaro.org>
>
> [ Upstream commit 28be5f15df2ee6882b0a122693159c96a28203c7 ]

This exploded on v4.19 so please drop this one.

Yours,
Linus Walleij
