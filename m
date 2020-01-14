Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A3713B2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 20:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgANTN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 14:13:56 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37430 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgANTNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:13:55 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so6306594pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 11:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kh1Ge+Ojyq1Hkaf57+ksFQlpw/tvYEo5VWAEqDe26e0=;
        b=IoV0u8G3OE4qe/OlOUrmQtTvkn0Ck8iGTgGitUdy4pm3zeqyty3RtPcor2vp/ZM5UM
         bh3Y3Dm0Rl8FtYVdIGq1TmyzYHROP92D3Yb8/avJnDjSPv2yCHiRXrJt9rFiOnhFOgfx
         J1uuzsbaA6SZJOUNcD3OseGl4+stFJaViEmj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kh1Ge+Ojyq1Hkaf57+ksFQlpw/tvYEo5VWAEqDe26e0=;
        b=c+XGeaya0IbH4vJPIgHBHNl9D6TCNvOVlwjptqXeVIawaySdxUq0o9HhkeoaysvdCK
         yEL34Vxb5Yo7ZHcP/WXdO8tmExtOLh+UBxSSNVmRyFjzr670+7AHA8xZlWdRhmLDypbT
         d1lT8avAYMFXzUV9aKrZte22ANKJNB8/1ge4e249FAEOxLQpCGQtTqI5VluJLPq03JD1
         8G3PPbUAUMYMPI0h3W4MPlS5IwYbJVONreLnqpe777uexH4l6yeFZP4687AvFroQKts0
         fj7RND2LpW8rGnyYd6Js+z0Ch7nQwXEQse4XwqC7XOyCZhL534iTjLMQIIsWsC5d57rD
         cFeA==
X-Gm-Message-State: APjAAAURALyDrYjyoN+4wJuMoJ4A9ZYUEshbb700e0N85Pys0J8btcX6
        wTNn1AIs2X6k+xoZF/USFUNt8w==
X-Google-Smtp-Source: APXvYqwzRsJ2RVe43UkCslTgq8Oqb8xg0wTDZUJHvubtVap0H3WXcQ3V3xpS5d6YsDXJ15yBA5c0TQ==
X-Received: by 2002:a17:902:8c84:: with SMTP id t4mr21515599plo.101.1579029235167;
        Tue, 14 Jan 2020 11:13:55 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id v4sm18628483pff.174.2020.01.14.11.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 11:13:54 -0800 (PST)
Date:   Tue, 14 Jan 2020 11:13:53 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <chanwoo@kernel.org>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] PM / devfreq: Use exclusively PM QoS to determine
 frequency limits
Message-ID: <20200114191353.GL89495@google.com>
References: <20200110094913.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
 <CGME20200110174932epcas1p345b0e750b48cc9e351dca14e0dd4de86@epcas1p3.samsung.com>
 <20200110094913.2.Ie8eacf976ce7a13e421592f5c1ab8dbdc537da5c@changeid>
 <c793c2e5-dd0e-bff4-9769-26344afe914e@samsung.com>
 <VI1PR04MB702308C23513581F33EFE697EE340@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAGTfZH1YvkSQtVTCrCYyWyBNUvKoTk8Vfrc2hHYsH=3AHr-tqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGTfZH1YvkSQtVTCrCYyWyBNUvKoTk8Vfrc2hHYsH=3AHr-tqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 02:35:48AM +0900, Chanwoo Choi wrote:
> On Wed, Jan 15, 2020 at 1:08 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> >
> > On 13.01.2020 09:24, Chanwoo Choi wrote:
> > > Hi,
> > >
> > > Any device driver except for devfreq_cooling.c might
> > > use dev_pm_opp_enable/disable interface.
> > > So, don't need to remove the devfreq->scaling_max_freq
> > > and devfreq->scaling_min_freq for supporting OPP interface.
> >
> > It seems that devfreq_cooling was the only upstream user of
> > dev_pm_opp_enable and the remaining callers of dev_pm_opp_disable are
> > probe-time checks.
> 
> OPP interface has still dev_pm_opp_enable and dev_pm_opp_disable
> function. As long as remains them, any device driver related to devfreq
> could call them at some time. The devfreq supports the OPP interface,
> not just for only devfreq_cooling.

I would like to remove the disabled OPP handling since no devfreq device
makes use of dev_pm_opp_enable/disable, but I fear you are right that
we have to keep it as long as the API is available.
