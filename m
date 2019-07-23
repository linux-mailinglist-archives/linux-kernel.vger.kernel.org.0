Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EF371402
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 10:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbfGWIaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 04:30:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39124 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfGWIaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:30:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id v85so28683979lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 01:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=syBlnIr3lotOltOc/vZkYQKICHGTlfmAJxr6rc/TPFI=;
        b=IDHd3BlllDzmuMywX3W/Mwaxf9SUAC1ITQAYxVe3EdpVLn9P7ox/KvicZW0H2rn0VZ
         XYMuUIDtUmUgSakwnZqRD1wQNi33jFkVfQ++7gqN+S1bYzcoiZEpYsIYDg+s8PtPW9+K
         MSur3qtEyMptDyPfThqGYsTkPwZI82uma6RJmI3Z3uNyWTSnvQnDub5P482J9AI4exHZ
         MibyDiZFASkBdczzlG82BC7XX9iF5uOdeBkbJ8eNZKBp1/DlcJfWf8owTiKuBkS9Gdhk
         9wVcvG5Pfqbu1AVShyl1gXG5TMkTM9JLUFH0Wfp9eDgJ8oepkWepG/LEbP9vk/XxLltc
         Gs+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=syBlnIr3lotOltOc/vZkYQKICHGTlfmAJxr6rc/TPFI=;
        b=Yd61V/mj0iFCZf6qc1FLaQU/OHMXFB82/rlrLwIWOpXA9QBmE8ihuFZAGdQL5XhM79
         Z+tLg6AP2pQGoCq6qiI+b4wp2bUKbWnPg/anC5z6QyYV6qXNki821Yj2DnG/ZyxHg3SM
         rHFw4CQYYhpgD60gZI9Vp7DzNR4tgRfCHo7DdzfOLaqa+2Y6ejEvYR2YtGR1zGw0KMuP
         WQy18OZVU7rEB51fwZQBclWCLgsu8pJ/2EzMiIEZNQiWL/LTk7jjqTMKXCrg7UTCatXL
         M7MKrQEJO3XEvaxsgNsaC5xrv6uA6wA/3LzrN1VgD0KuIc6ZXJNf4ZnAziW1oJTkbRHF
         cUaw==
X-Gm-Message-State: APjAAAWXpWHDzejkstwZ/UhiwZ2ngWQLdQxr6G1VlGJX8mVSseoA5hKH
        739gmqzOo1X63RDoirLZybBUlp5Mma5uo2X5SOB47w==
X-Google-Smtp-Source: APXvYqwWGxao/28Kz2zbNijiOv5Hz8uDmZYEJmaa8ZR+sLnSu5xitdAQqA8b5w1+jLpRJZce7gmX18s/KwwTbJI3EQI=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr35514625lfc.60.1563870614049;
 Tue, 23 Jul 2019 01:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com> <20190722172623.4166-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190722172623.4166-4-wsa+renesas@sang-engineering.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Jul 2019 10:30:02 +0200
Message-ID: <CACRpkdb4CtiiYbSwHEcC4godbRBA3DmABCHpx5_OKUCfxgcUSg@mail.gmail.com>
Subject: Re: [PATCH 03/14] mfd: ab3100-core: convert to i2c_new_dummy_device
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 7:26 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
