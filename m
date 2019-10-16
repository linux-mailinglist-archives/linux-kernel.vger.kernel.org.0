Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC6DD8B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 10:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390055AbfJPId0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 04:33:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39292 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388676AbfJPId0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:33:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id 195so3764550lfj.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKOYOlw144swLoW1bASjxt+2YuF19IE2PHXVrwsgFxI=;
        b=r/HUFUT2hHS1cmWHIYJbEY9FE8fC8Ukn4uYCeAkUEGRVmlhy+ASdQddcDde/8K7taB
         LRB793fgb5pYk/lMH74TNXCvhVmTmm3sV9ww9tYtgdGoxRsu0kNCiba+hwdyaWD1CR8X
         LGmf2ZZ0QrX3ZIkR52njFsp/wTNEJfQlxKJ2LY2WGGwM/FGGrYZHgTKohN9KoVrGiLAW
         FU3IaLUNMAyW624zTk//zndh38HwJ8vaAVhtqYPITabahQmCw9ILH5q7qQfbhri1mD1x
         h5+Kn+46MPImZ6j4sJzf67MFIp2WyhnuY/PlD8YPPhESNI0z9bbTzAK17NCsMaKSytzG
         53ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKOYOlw144swLoW1bASjxt+2YuF19IE2PHXVrwsgFxI=;
        b=MX1cnfIPGVNHMn8aBC8HrzGQWTwmYHbJywZVtuxkqhYGDC3eFGO1uCwlUJMuYe2RBW
         GIEXE1Jtwui1aLTqS7IjSewdgniA6BdER/AQKfT/4kHw1h9D9T/4+vKCrwVh9oKbqbW5
         hfFzvJdJafvKTuqd49n5o9i3xF7YNrqFBV2V+Dh9dBPBqNjQwIttxJxZQN+fjq+C7iAc
         7LC5BgabgFC34s5MGak7vNdNHvzOfE7GnUUwT83RbhcZIb8DEw7BKQhM5GoDG2thBo+f
         Lmdb+9+4Y08mLFvockoL+pLFcK9WZoPWwX6vPkY2InPUEq+ZRQVgvytxKdqj6EzaOb7Y
         vWFw==
X-Gm-Message-State: APjAAAXdcWqejRg4wzAwchL1u+z6S4HyhTQUmlEjdKc+n0GmTE33Pdca
        rMx0+JxgcXTdM9HgExlbmOipTJeiwsFzfaOTKpQYThv3Kv8=
X-Google-Smtp-Source: APXvYqwE179jhrx68mdrGilTO9EwoaHUFNX6nGOxdvUMNXsKDUhHA6fr4aqNzUdV3wN7yf8HZ2tJuwJ0+7mxh/vy7a8=
X-Received: by 2002:a19:ae05:: with SMTP id f5mr23355878lfc.165.1571214804829;
 Wed, 16 Oct 2019 01:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191004150738.6542-1-krzk@kernel.org>
In-Reply-To: <20191004150738.6542-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 10:33:12 +0200
Message-ID: <CACRpkdYSnnOJomJi=Db2nkrrdNQmBnNKny1c7ZpDj6KdmKD9Mg@mail.gmail.com>
Subject: Re: [RFT 1/3] power: supply: ab8500: Cleanup probe in reverse order
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 5:07 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> It is logical to cleanup in probe's error path in reverse order to
> previous actions.  It also makes easier to add additional goto labels
> within this error path.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

For all 3 patches:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

The battery charging code is currently disabled on ux500 simply
because no platforms with batteries were available for testing
or supported by any device trees.

This is getting fix: PostmarketOS is brewing patches for enabling
all Ux500-based Samsung phones, all with batteries. So we will
soon be able to test and turn this on.

The patches are fine to merge, however notice that we are
refactoring all drivers using ADC through the IIO tree:
https://lore.kernel.org/linux-iio/20191011071805.5554-4-linus.walleij@linaro.org/
https://lore.kernel.org/linux-iio/20191011071805.5554-2-linus.walleij@linaro.org/
https://lore.kernel.org/linux-iio/20191011071805.5554-3-linus.walleij@linaro.org/

It would be nice if we could avoid colissions.

Yours,
Linus Walleij
