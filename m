Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD2D8EBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 14:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfHOMjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 08:39:48 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:44877 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfHOMjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:39:48 -0400
Received: by mail-qk1-f172.google.com with SMTP id d79so1623304qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 05:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sz8iMwRtA16rKBM+y1xtqsr2FT3ggqC7wXEVqNU80Y=;
        b=DnWkHHPSpWWgaGgdv2K1qOgUXogZ3si0TK/CZZdydz3z6l0bum3/rHNHHARC8o5TwP
         dhvrM6uV2x5pjIh4CHCMSMYoty5zoDlq2xbR+S6SKiH15ew9+4uERXDBl840EyohTh1v
         4pdZbqTmilkk+TaxtviXnDlEzDRFWMgLT6ZFg0zmkuKK0PNjKOZotkQEnm87MvAkU1h7
         5DKt8LHDZsfTUyjLJhcMoqZQAe29CvLUHjmt0ib90fYtd6qjQc9n6luCKWMJ4n00KKgb
         JP2JZzvCbqBz3iI85UR1FqU9nC4bTKbospT7+jc27fzdyK/BzyanOjktoXsd2lUWiqk3
         QUqQ==
X-Gm-Message-State: APjAAAXa74AuaEivM/XvsTtN/j6hoYXrM24ZwZQ9MYxsiCzEZjBNhVul
        dxWBwh3Ya+dpx9DKP4iCnnHXYCeKXtSN1aTxFbM=
X-Google-Smtp-Source: APXvYqyLvIyU6AnKUG0hHT8aa7Za+z6fbHp4ioldVGfk9TXm4wyKocAOhU2KdR8M1elDp43RaX0KruXrHyHMX8Jtyjk=
X-Received: by 2002:a37:bd44:: with SMTP id n65mr1261997qkf.286.1565872786986;
 Thu, 15 Aug 2019 05:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190815065659.GA13498@jax>
In-Reply-To: <20190815065659.GA13498@jax>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Aug 2019 14:39:30 +0200
Message-ID: <CAK8P3a09pJ+ZHHEDoc6=znB5Ycsy1nPMf2QS=dssktN3mv591w@mail.gmail.com>
Subject: Re: [GIT PULL] tee subsys for v5.4
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 8:57 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hello arm-soc maintainers,
>
> Please pull this OP-TEE driver patch. It adds a call to might_sleep()
> during RPC in the OP-TEE driver in order to be more friendly with
> CONFIG_PREEMPT_VOLUNTARY.
>

Pulled into arm/drivers, thanks!

      Arnd
