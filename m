Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799B6109191
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 17:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfKYQGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 11:06:18 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37106 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbfKYQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:06:18 -0500
Received: by mail-vk1-f196.google.com with SMTP id l5so3581113vkb.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 08:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Avttk0P5txS2q04zBlAty7rtXiGTPj5hhaK38ammByQ=;
        b=e4Es4BNR8tv0qRFadBAbvVXURnUbZZXWCMCs/wpwjIdMh4Jy89Fb9xnhqIRsvSh68a
         XJsKQJopD1tCEgGI9pChnGtQ7DahHVJ9gq9TKnNNNBulwFYjG+CblUqYW/vtQFu8vJxl
         w1v1hYKDkFVHLQgwvtj6is/1xKjCpjQYMwvgLrchL+5ApRlQiLDVacv0DmtKybbB8N50
         CRksIpAlofCr3r2qSaxGOBs8aeFN60Ook6Z7X/RkgjLJ1NolLOSSXCFHCnk9LpFB0T42
         IwuG9sVc4vmuofxHdOc58LsoGlJYDg+KXcNHmcNmwLbz5Jq0N8EXxOIEHDU1Ew05iA6S
         Tb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Avttk0P5txS2q04zBlAty7rtXiGTPj5hhaK38ammByQ=;
        b=Avlwog2uc/p7rZ4dRIIxU4U0whFTA5Mrgcr1vbpp5zH4WNWOWsS4jYMKJ4VxUzGn86
         OTORP15HcPQRmZfKmneyql1AwdUprWO9nKju9azZA4F6MxhJI0L+YgJ6LzTgKysJ8T1o
         tHAmKHC8r+5ubZ7cHz0xrSLiiRLFT84DlhFpRKPqFxA6JbVq307OlXKl36NO2GIvyP3g
         D2p0yxTr0EvFy9cwgGWF3hNZ2xHcgI6HnkKu/XIAit7wWd2kC6SLq28JNtK/Uth1/vwe
         F050k6N4MdAC1MfWzro1h1yBpYtCC23HBaS/wBZTzZHK5fLXEP35qFu3Hh0VQLjQlctT
         cxMw==
X-Gm-Message-State: APjAAAUZx7/fxf7dpwawnpCXiMgx+Ek4KFm/MYXxcpd7oPlICH8/cXJa
        oOM8XBQW7Egi3XLg3D5cefOyBxK1HRL/HM2DqTmF8g==
X-Google-Smtp-Source: APXvYqxNasVkK7MWNtHslDqEaSeS5Uo2U4dtls0PYrqWky4egoEbLjLpsDhsWSjOifL4RHlo/J6b+Vdm7rhS/WEKCJ4=
X-Received: by 2002:ac5:ce8c:: with SMTP id 12mr17656856vke.34.1574697977355;
 Mon, 25 Nov 2019 08:06:17 -0800 (PST)
MIME-Version: 1.0
References: <1574442222-19759-1-git-send-email-christophe.kerello@st.com>
In-Reply-To: <1574442222-19759-1-git-send-email-christophe.kerello@st.com>
From:   Steve deRosier <derosier@gmail.com>
Date:   Mon, 25 Nov 2019 08:05:40 -0800
Message-ID: <CALLGbRJ00TeZKPfhkqj_mwu9zhMzc_+A8mh4uwaPnFBUatrwTw@mail.gmail.com>
Subject: Re: mtd: Use mtd device name instead of mtd->name when registering
 nvmem device
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     miquel.raynal@bootlin.com, Richard Weinberger <richard@nod.at>,
        vigneshr@ti.com, linux-mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 9:04 AM Christophe Kerello
<christophe.kerello@st.com> wrote:
>
> MTD currently allows to have same partition name on different devices.
> Since nvmen device registration has been added, it is not more possible
> to have same partition name on different devices. We get following
> logs:
> sysfs: cannot create duplicate filename XXX
> Failed to register NVMEM device
>
> To avoid such issue, the proposed patch uses the mtd device name instead of
> the partition name.
...
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 5fac435..559b693 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -551,7 +551,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>
>         config.id = -1;
>         config.dev = &mtd->dev;
> -       config.name = mtd->name;
> +       config.name = dev_name(&mtd->dev);
>         config.owner = THIS_MODULE;
>         config.reg_read = mtd_nvmem_reg_read;
>         config.size = mtd->size;

This would be a breaking change for anyone that depended on
`config.name = mtd->name` behavior. Obviously, if they were using
multiple devs with the same partition name as you were, they'd have
already been broken, but I suspect if a lot of people were doing that
we'd have heard about that before now.

- Steve
