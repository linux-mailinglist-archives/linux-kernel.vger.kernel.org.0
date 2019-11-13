Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2501BFB1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 14:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfKMNtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 08:49:51 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35934 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfKMNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:49:49 -0500
Received: by mail-lf1-f66.google.com with SMTP id m6so2020469lfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 05:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vy52t4FQzUJl7MVUo8BlNINCjNunGWRfRGrKR4TBf7s=;
        b=H/fmVXpHY/Bz3Zm3tJMqNv+AwRbpI/Zdj1npokpo1y0SxsWgZjJZnvJrrRC8kmjyF/
         Ipmvra71qU83rRRC6Zf68jUmOzBcSx9OE4TbXtwGoWuGsNNRcFSmls8L4Ikb9DQ0gbVa
         bIERJQIfZQrW26RWuowHjLM1w7GcY1aEehUkrnKgOPc0mQmyCxtJxKMuz8ugn6lSgiSO
         Hv4IN4Sd8TJjiufkEb0EReSwfMXDqhEP6nhCXcfAgql/5dFvrnHc+J1zyyWc0Ky1+fCQ
         +noraUwssI0RFzdcPnNsMRe6cGAgYpAKJ/w8HgkkkHSaNPT+qtFoEaIeh3t945mNFQay
         vyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vy52t4FQzUJl7MVUo8BlNINCjNunGWRfRGrKR4TBf7s=;
        b=HbxzxeyPBJ9SlNYkBysCKHB5733qYhhNmDzMzvValbPBc6AlgUcs6d03e3jWH/LCzI
         vt5nk4LoG/XBlc6Yv6nXn0lzcul9KGboF36RreThgxEvKzvnos1dAsd9vOQwv/FpI+FA
         BAw25qM7jhS70l8btaKMtlj0K1f116mLRnjx1tCV/5V7iF2VYjD7EZMl/rgyKjrTxjCU
         leX9WOPClpYb7jweoAJelgqRM7hIrlIp/DGFtTH94tRgVAVRxeX8IeejhndIGYAS/TyU
         6f59qoKSftFSsvuE8HBMemdWoPUE+j/8QTu5q8ILrAZjX2hfqkjdvSCzjRRE8qiA85Wv
         ggeQ==
X-Gm-Message-State: APjAAAUCgEJtOvCtqjxnDvvv9yEvkPubSw3uMu2RMQdY0Mh1rWRopYMR
        MjkBl2zPXakyWBhGmQ5RIXmYJo4rUOwQiVFzk+Ch8g==
X-Google-Smtp-Source: APXvYqxTHXdzhopP2ypRF0d0fSJw9rDupVGAE6bShbQVd9KMnkQr9bDucRfPSMwvlJeNx+bIQwFND5x8xx9CugRiZao=
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr2668883lfn.86.1573652987493;
 Wed, 13 Nov 2019 05:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20191014184320.GA161094@dtor-ws>
In-Reply-To: <20191014184320.GA161094@dtor-ws>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Nov 2019 14:49:36 +0100
Message-ID: <CACRpkdYwinMT71se1WqmGii=qHH1s-JUOigs37EV+ywZ4aiYSA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-tfp410: switch to using fwnode_gpiod_get_index()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 8:43 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Instead of fwnode_get_named_gpiod() that I plan to hide away, let's use
> the new fwnode_gpiod_get_index() that mimics gpiod_get_index(), but
> works with arbitrary firmware node.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I applied this with some ACKs to the GPIO devel branch for v5.5.

Yours,
Linus Walleij
