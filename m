Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 421C2731EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 16:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfGXOmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 10:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbfGXOlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:41:46 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5BF922BF3;
        Wed, 24 Jul 2019 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563979305;
        bh=TRtWU5E1r37i55jKNYc0TCw2JQ3luL6jpXOG+dX2+IU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lgy8s5xgg8fDhdv+/4WKp00AmtS2aQqp8aRxNZ+sxzVYDjUUmAwoArGG5xWnRJKP/
         ednK+UnVAtUIJm5PM11Qy/aaKnUrgfEu44ZyeLTzAvcocH1cyVRXhrQQK3/mfOCp6O
         8AANZqpxu8TsStU5SVHqBvnC62QWpFyfRlzIm4dQ=
Received: by mail-qk1-f177.google.com with SMTP id 201so33897184qkm.9;
        Wed, 24 Jul 2019 07:41:45 -0700 (PDT)
X-Gm-Message-State: APjAAAXM8smKn5nqXuaKdFBTj4wCKucIoyBwL6NHv2O84w2w+cNAn40u
        MpIJzENAH6dQXKcImqoubV4BP9Q2eQtm7CUIVg==
X-Google-Smtp-Source: APXvYqz/M912Dd6lOG1yOuf5yMiMHoEfa2RwVPeNyv1O7z5gz0FAig6V3+V0bVh11Zso2nw1+rCP0tnwMr914vN60fg=
X-Received: by 2002:a37:a010:: with SMTP id j16mr55849178qke.152.1563979304746;
 Wed, 24 Jul 2019 07:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190619055247.35771-1-Anson.Huang@nxp.com> <20190722015043.GP3738@dragon>
In-Reply-To: <20190722015043.GP3738@dragon>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 24 Jul 2019 08:41:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKv39XdFABuRvxwiXg6qQpHSuykwgqTwsGw1g+D2wA1+w@mail.gmail.com>
Message-ID: <CAL_JsqKv39XdFABuRvxwiXg6qQpHSuykwgqTwsGw1g+D2wA1+w@mail.gmail.com>
Subject: Re: [PATCH V5 1/5] dt-bindings: imx: Add clock binding doc for i.MX8MN
To:     Shawn Guo <shawnguo@kernel.org>, Anson Huang <Anson.Huang@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Bai Ping <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 7:51 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Wed, Jun 19, 2019 at 01:52:43PM +0800, Anson.Huang@nxp.com wrote:
> > From: Anson Huang <Anson.Huang@nxp.com>
> >
> > Add the clock binding doc for i.MX8MN.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Applied all, thanks.

This breaks building of 'dt_binding_check'. Looks like there are tabs
in the file which doesn't mix with YAML. Please fix.

Rob
