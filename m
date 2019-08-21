Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE29197FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 18:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfHUQYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 12:24:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbfHUQYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:24:07 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBAA32339E;
        Wed, 21 Aug 2019 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566404646;
        bh=6vn5oS8HMSG7JMJf365FjEEzES/Bh/6N4hGyDrDNZn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WNTHVH0obfAHqho0ZQCiPxVlUvoCcLkMmqX2sT240VqcVX7tZBoHJOKqXnS+WaEJM
         DLeJFLdKciGAvKI9KVzs94AyUMnSTFNuOFvYp01DM3MgSt7PVo/ICvD9lbPO8Oydkm
         WMp7LoOXwuPPxk4qG1IFtvFdhtua71JjuTRpM7WI=
Received: by mail-qk1-f170.google.com with SMTP id u190so2354319qkh.5;
        Wed, 21 Aug 2019 09:24:06 -0700 (PDT)
X-Gm-Message-State: APjAAAUvdrFuJwJuAxS5YaPMSDlDhobcdhhydDiucaiwM0JmZdGG+Lva
        Wjbdoiutc6FPLnrsx0XXISkBSwruQDHFDmVlxg==
X-Google-Smtp-Source: APXvYqzQe60WO0Pk/hkQrXQ0DanP3ksbv6OcTJaNcrDWlHGnm64JYtW9XJ7EAZi/FJz1FSt53V60vbg804R7yTHVWfE=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr33011507qke.223.1566404645998;
 Wed, 21 Aug 2019 09:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190821031124.17806-1-kever.yang@rock-chips.com> <20190821031124.17806-2-kever.yang@rock-chips.com>
In-Reply-To: <20190821031124.17806-2-kever.yang@rock-chips.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 21 Aug 2019 11:23:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJW0WG_cs3Y+Rt+DgO=uJg-ccf64qGXCfURviS5fdvHsw@mail.gmail.com>
Message-ID: <CAL_JsqJW0WG_cs3Y+Rt+DgO=uJg-ccf64qGXCfURviS5fdvHsw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: rockchip: remove reference to
 fennec board
To:     Kever Yang <kever.yang@rock-chips.com>
Cc:     "heiko@sntech.de" <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:11 PM Kever Yang <kever.yang@rock-chips.com> wrote:
>
> The rk3288 fennec board has been removed, remove the binding document at
> the same time.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
> Changes in v2: None
>
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 -----
>  1 file changed, 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
