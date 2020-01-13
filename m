Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC8A13933E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 15:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgAMONA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 09:13:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33386 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgAMOM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:12:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id z16so4955957pfk.0;
        Mon, 13 Jan 2020 06:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TbDxzBZlkrSTf8Q5Gq/R4NCF+S0om70sRP7YbF9S2BY=;
        b=bVe3mmVXecfEAK2KJOpP0ohHJFJNfxvIfPMOgFdHB3vzCi0k++1ZDibiNa5CN+u5lK
         HgLBwj4b1Kv2+S26Qd9IoMUVUjqSHEBwnBnTCIh+1zYOmyJicxuFNWIB3gdHm2Uqc65X
         E4mEeus0sad/xiAy2ND883zgZNathI9IKoelbJa7JTmZ/UAuO4p21LZlX2QXvWEOXJGz
         7z/bWgWQ76FLtJMhnIwXmprwrccMtLBA1afr0xLyJUkNJjA3DswYenPBUFf7LtyIPVYZ
         hsxrwUDKz3U5K6ieWoHR8dkOzhW9HjwCP13Nuq2CYHAnACgpYjEe7R6DL9mDkBWJabwv
         vonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TbDxzBZlkrSTf8Q5Gq/R4NCF+S0om70sRP7YbF9S2BY=;
        b=jx9mNqUZIx6LNHDdF/R873Axv3HIYN8MDiLCtziz4fTy5dArtai+F+VShQrARt44C1
         0+f5QKWuwISXW6FmwreFyn9W0okRzuMO+K1ntSeCVfdFvvo5A8P6Xfx50X9fLZnwsgMi
         BO5qXedctWGyPYI4b2OdfTWVKRAdXGphTIKZKgp2oj7Zhdhbmoe4P9MpFSNmejJUqCV+
         hTgGl/+Bx16ZEtx913qr6RtkYeNSpDN/GYoT/T5zi7G1c7Y8Rb6YrTEfiH74GwFwOPW+
         bXaABoZAyAIgqIQ7WYKTBSQrX3eS8TxJ45BvhYQhbcKvwCP64m72sOtcGMyHIdy8c5yn
         4EoQ==
X-Gm-Message-State: APjAAAVyEqhI3wS3BqIJ7z8Rdnm2LenGxIGqBYjIKpxWVSwPat5aqHN+
        zE6hsz0+L9h+fMiYGYslbxIhMQhvQ6EeLQfEHto=
X-Google-Smtp-Source: APXvYqzYULl0Hsa/J48+y4HwI789S+2T/iumJXRsZZq+eRIjdJcwzi4sNC28KwSAtriKbEs5VVJjr35tl1BchJr4voo=
X-Received: by 2002:a63:3d8e:: with SMTP id k136mr20749109pga.4.1578924779029;
 Mon, 13 Jan 2020 06:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20200112121849.7056-1-vadimp@mellanox.com> <20200112121849.7056-4-vadimp@mellanox.com>
In-Reply-To: <20200112121849.7056-4-vadimp@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Jan 2020 16:12:50 +0200
Message-ID: <CAHp75VdFV5OZ=U8yiuDLsff8+swET8dtikrQo_8N6ZdvhC9Q=g@mail.gmail.com>
Subject: Re: [PATCH platform-next v2 03/10] Documentation/ABI: Add missed
 attribute for mlxreg-io sysfs interfaces
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2020 at 2:19 PM Vadim Pasternak <vadimp@mellanox.com> wrote:
>
> Add missed "cpld4_version" attribute.
>

Fixes tag?
Also see below.

...

> +What:          /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/cpld4_version

> +

Can we get some consistency here, i.e. drop blank lines between What
and Date everywhere?
(Separate patch)

> +Date:          November 2018
> +KernelVersion: 5.0
> +Contact:       Vadim Pasternak <vadimpmellanox.com>
> +Description:   These files show with which CPLD versions have been burned
> +               on LED board.
> +
> +               The files are read only.
> +

...following by the starting each section with What keyword.

(Separate patch)

>  Date:          June 2019
>  KernelVersion: 5.3
>  Contact:       Vadim Pasternak <vadimpmellanox.com>


-- 
With Best Regards,
Andy Shevchenko
