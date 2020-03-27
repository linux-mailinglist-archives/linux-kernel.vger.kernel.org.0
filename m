Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8936119603C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 22:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgC0VMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 17:12:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42745 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbgC0VMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:12:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id t21so9032092lfe.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7JZ1QFI9+FtgdXcyl77TJuQPCE3U91hu8/wkfGn1LbU=;
        b=SRwOWlJ2qXCpTZZFjHvFl3mL29jKoQFgfoZHcDLjwHGukw8P6wFh3FGGu+AXRlrn2y
         +OdH52BNXFEn6p21ublMsHoo6lqqaR+4jkUuy0C0oxdqcNpHWuMML4QuXlQK52Xi+cso
         P9XGUT437lc4964eA+xTTH8kDtY9o4BnYb1rFY5a30twe5eC4YRrQXN/btg62B3pxDkh
         HXXHUtMfsNtvDuAouVXCvgAkN72fIINSfeFKG5y5yXYMzPei7uug/fBLL5YbI5qtX6Ux
         4C5Oe9PQJNvG3Wiki1kOgmgOOWDnVzu5ULOG0vZs+hIZMfXismb1HNHAe0M6BiWDMbIu
         oFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JZ1QFI9+FtgdXcyl77TJuQPCE3U91hu8/wkfGn1LbU=;
        b=dMHWUO/FKTd/oy2h9O+/gbX0rodANXUO/jV+cpXWQKohnIWU+2h4vzH6lqhzB/+uYa
         X1FZYs+kmiGU/MdW+QyIXuoiAl/2wZXB1Bbizsmp2o5Pi68ZgyWw+IFPiSMhuaLN5Ex4
         irh81NF8ffXmE5iKoRGUro9mlJjDN1nCBZ9UjYEQeFk3GNHOWiosdTHpfoj/q+fUh7Oo
         +SrJNRevDmt1MI9ki5dGKR1VJSP1ShFbFOCezkUE3N0fLg1BDaUXKvalSfIs83b7PE8w
         BEMvUEtpj4mXOW4FX+lyk+VHr25DIGub1kglg/nW01yaxyTrpQ7uLZrARcm0TlV4RBUl
         W9OA==
X-Gm-Message-State: AGi0Pub4MAK+z8zGVeNheyjV8x62RWEm8ncEN67EswEZeUiePxoHWepP
        981WNVXQNMLDdPhulK/LzhcZa5bPv+XSx6xTKFIJ3Q==
X-Google-Smtp-Source: APiQypJLzv1jR04mjd+jD35S7idB5qw5grrozbcEYe5adOdvJDvuj9PH5V5xlh1OkmHnheg5tdSKwvBMWIQrB/u7tNk=
X-Received: by 2002:a19:ac8:: with SMTP id 191mr745752lfk.77.1585343520022;
 Fri, 27 Mar 2020 14:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <8a6f91b49c17beb218e46b23084f59a7c7260f86.1585124562.git.baolin.wang7@gmail.com>
 <3bdac4c2673b54c940e511f3fa569ee33b87b8d5.1585124562.git.baolin.wang7@gmail.com>
In-Reply-To: <3bdac4c2673b54c940e511f3fa569ee33b87b8d5.1585124562.git.baolin.wang7@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Mar 2020 22:11:48 +0100
Message-ID: <CACRpkdZ9VwZdexCm+WsDT3c3ScTSMDCTii2fOphH-CrKqf6TMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: sprd: Add pin high impedance mode support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     linhua.xu@unisoc.com, Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 9:25 AM Baolin Wang <baolin.wang7@gmail.com> wrote:

> From: Linhua Xu <linhua.xu@unisoc.com>
>
> For Spreadtrum pin controller, it will be the high impedance
> mode if disable input and output mode for a pin. Thus add
> PIN_CONFIG_BIAS_HIGH_IMPEDANCE configuration to support it.
>
> Signed-off-by: Linhua Xu <linhua.xu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Patch applied! Nice engineering here, figuring out the right
fit for pin control configs, thanks folks!

Yours,
Linus Walleij
