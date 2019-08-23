Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3EA9A7D4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 08:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404575AbfHWGwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 02:52:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38238 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732321AbfHWGwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 02:52:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id x3so7852640lji.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 23:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G5vut+/7GfWn6npImvF9Rc3EcWl6Bwqxpc3Tm/7byaQ=;
        b=MVIXR6k8i6ZWuPASEFHHR9F0nPCzK0eVjc8PYz7FptLy2OJujuacqW6lgWGhwQySFz
         3QAySOWoE9nAwQwl1xLEODlrOsAyBMu2u04vibbBBVpvxgU2d/d9lFgSf123gf2E114D
         /jPW1MjyPfCGwgmewUy7qWtuRuFl0ZdoBgJUXWuNSSUvkanykJHAMib9ZE1FHuoQnZgx
         XzaapAMFiJGaBP/N7hmC43ow43jjVG9Li0erAVdh6tyQNjy9HmQDLOQfs/eqEiCTGeze
         cBBi02p/e6U/e0HvajIHRSQG3k6yQHhDjihSPwrKZVq8gfHYtJswFQUJzcr833qCT5/D
         N/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5vut+/7GfWn6npImvF9Rc3EcWl6Bwqxpc3Tm/7byaQ=;
        b=LWIErfarRSOpmgJrN1KVx/FZjuZHWI3LzWqAqX+rCIkvrCeiG8UvLWEJF+C/pk5Bns
         GVEcSlAp4ZCzpIAar1gQI3/yHNtjpV0q2A8CTQJPZ+BAYi6yKwhRX5yNNDUYZOjMj/sb
         F/9Z/i8c/UKWHBuDXkDRA9YozR8t2f3sG0amHJMDnpznKqbxjMtzquicvGSQ6oH5SyGA
         pkpoQrlM/Iioh3WLxJuM8J992hXxFOxp/5Lp2MVTyZLj70/u/bphJSy9cKTHaVM2Ao01
         psh0awH/A6w8LAYwil344ihXtlCXYReZrv1hSftQKvYXWe9T4v/ybhQfk8khfFZK4tRk
         FWzQ==
X-Gm-Message-State: APjAAAWuv9h8StnYWNEGYjFjpoPABzuA1GfybyWQxjQ4UpRQXlHPwzOa
        8eXntRhWkB4g/ZJL/9/osSc2/H2xrsNKj+l4sKDfHg==
X-Google-Smtp-Source: APXvYqyEKzwPdx0ZjJjocJJunKwmjsRZdIowtZKK6Batd8JU0Y56aba6StNeDVmOZui0Y27K+B6WJCN6um5Z3JBIC5I=
X-Received: by 2002:a2e:80da:: with SMTP id r26mr1814316ljg.62.1566543135677;
 Thu, 22 Aug 2019 23:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <1565707585-5359-1-git-send-email-jcrouse@codeaurora.org> <1565707585-5359-2-git-send-email-jcrouse@codeaurora.org>
In-Reply-To: <1565707585-5359-2-git-send-email-jcrouse@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 08:52:04 +0200
Message-ID: <CACRpkdbtPo9dr7E2hZ4=fEWTXappWTaypKJyd9M2jz0tYu7HXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm: Add DRM_MSM to defconfigs with ARCH_QCOM
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Olof Johansson <olof@lixom.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?Q?Yannick_Fertr=C3=A9?= <yannick.fertre@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Tony Lindgren <tony@atomide.com>,
        Anson Huang <Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 4:46 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:

> Now that CONFIG_DRM_MSM is no longer default 'y' add it as a module to all
> ARCH_QCOM enabled defconfigs to restore the previous expected build
> behavior.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suppose Andy will pick this up?

Yours,
Linus Walleij
