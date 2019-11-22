Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65631072AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 14:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfKVNBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 08:01:51 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42858 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfKVNBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:01:49 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so5438787lfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 05:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dn2Q+lxc2hD365R8dpx/qDcvh0SW6iReRcimhdnvJVs=;
        b=T3iDSlAsyuLG+UJUCmoncxR1Bu/bnkXL+KTq5dtWsOPEk5RpZ8edNc98Onwl6slav+
         /6e8hX+pTkWaSIXGqEuy9X9rZyNwmY4TERtxiAfEDekog4Gkz38xdZQ0RSgGTrgjfXWm
         Owq4J8pZTVADQ/t5uY4imCraJJ2dIrTT2uwE0EY2E3x+Uro8T1zF0BkVxkc8pF0FsqBl
         y6GKP5K6axb8BQ38YAG8H8sPZiX4W7XuFOsvWqrZ1MviJOCm684lRjpNZpMzH8na0jOx
         wqdeYsaHigtxhdjowwJZrUBM8VUa8C/SZB2DM3PbahSmncXpmbcvjBgy4Xy+mo3eR0h4
         1WBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dn2Q+lxc2hD365R8dpx/qDcvh0SW6iReRcimhdnvJVs=;
        b=NplRicZy7XPk1g9wirn7ihefD5yiUuMQFcVUGiiahXnfVnCATW8rRLU4vLh6Pt8r9H
         kisXJ1nkGbqFP1/0AJinLg9DrLxL9dms/fGGUKdXyWKy79OTXSJHolEi8RHrdYJQnClO
         6UhqTCcT4/Bsui7h6xt72EffIy6F/tBr2Y3w11xJE3MnNb22TFVVPlaeayMewgW6hTag
         yPjMfFy+DQaD4SnG0WD3b4BjTRcVpX4iVN5aiumM5r2MRskzKo47QuRTIue75iet5JTS
         lqImpZ3LxnLXQoLV7zhsKANP9L134Ckr1qjWgsMMO7NdceDssliBKBBNyD63Pcci6Nah
         V5XQ==
X-Gm-Message-State: APjAAAVRPUL/crrcKNQ5UikvrANYwqAUZRuJwTkGAMTuz7EU8Ridopsg
        oOtqohgMcKYXLv64bYJSs3SbkwP4cwHDgwr4yl0+8g==
X-Google-Smtp-Source: APXvYqzo/k0rIsJGGL399pE+GzotZ33QW/YQlNt/JpZVm7SU204RwrS3/eFE+xu+DFtDva5eWFhzGzqC/njjDmo3YqM=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr11596350lfi.93.1574427707515;
 Fri, 22 Nov 2019 05:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20191122061839.24904-1-hui.song_1@nxp.com>
In-Reply-To: <20191122061839.24904-1-hui.song_1@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Nov 2019 14:01:35 +0100
Message-ID: <CACRpkdYhLoGdGQt_jzj5aFa-EY_kMimoVShi7QFLG3sZbC436w@mail.gmail.com>
Subject: Re: [PATCH v1] gpio : mpc8xxx : ls1088a/ls1028a edge detection mode
 bug fixs.
To:     Hui Song <hui.song_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 7:18 AM Hui Song <hui.song_1@nxp.com> wrote:

> From: Song Hui <hui.song_1@nxp.com>
>
> On these boards, the irq_set_type must point one valid function pointer
> that can correctly set both edge and falling edge.
>
> Signed-off-by: Song Hui <hui.song_1@nxp.com>

Patch applied!

Yours,
Linus Walleij
