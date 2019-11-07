Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7049BF3744
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 19:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfKGSbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 13:31:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42370 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKGSbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:31:17 -0500
Received: by mail-qt1-f193.google.com with SMTP id t20so3428501qtn.9;
        Thu, 07 Nov 2019 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSYDMnmqJOFh6IZ4CGQ235+gHG9GCVXoOj7ZeB9lcfw=;
        b=hg4kvqCezRTSJPcky3Aj86tFQ/cL+Tiif2+glF1zmnZqWu83R0SD++6nEA/pLljhqu
         rkayceYejoyiwVppXcfyk22sYy1O/ugw/W8485z89lM2oCy4KnEk1lNIiL4RaogWjpWv
         XGJ245sTHVCNG0msmcJsYJt8nTvRp8oEX9+SXUrC1gyXHHd86N2FIr7uaf7VC20fN1Fb
         Gg8qddaj4/mTbDVzy92vHxAq6MV/6prO8v/lnIwq4b7eWe0aCPD/kqTOgxaJYS2OkJi9
         m4Cu4x4Fsfs5Y4dVsbJt34D7jT+pK6kbLjCVIfd6rf4I2PAKsp9R3sVmMdxLgexSEQHj
         nbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSYDMnmqJOFh6IZ4CGQ235+gHG9GCVXoOj7ZeB9lcfw=;
        b=JcZXgyHPP/VI7LpbQ8a6sjN8u1PvS1iFyVna6r+npjUfU6me0LKhkkIwK/1mgyTxyH
         0vBUifXmXBMMJax2ZL9yM160ibg1+eKNr+2SxyXrDFq7YM7lhfymb2xEGE32WlzFrw/3
         xwDaPRMJouUItv52xtlahoQLSqnKtFkw9N5nO/WKp2AFLZl5J3XPYxRxhdSUN3kL0+yh
         Mtr5PHEOKlkbhui4g40LqStO+9FfCGN0EsmvJF6Sjx5sRgqa/D9NRtZML4jp3J2Bg8al
         IN+h3FAx7I25eOQ4rXiSpt+ScO7uys4F4tB6dcqVC5SubhFwVnlvpL7Xiq23Im2V6jeY
         uJFQ==
X-Gm-Message-State: APjAAAXCC7lP8HNB2gjLPQyWNFCc24G3tqvBvR9LVplj9qr3PuZAcRLJ
        2P40q1cNmdmUBm4hHIvC25BMxLXzCDIvTnmwSrE=
X-Google-Smtp-Source: APXvYqymIJa+7NfDND/fnNu0x+Tziq3SlhVifmGSKeyWkGb7a6h8lksgiWN/J90EAEVa9staM5iya2RkHsiS86izd6A=
X-Received: by 2002:aed:2a75:: with SMTP id k50mr5541242qtf.346.1573151476078;
 Thu, 07 Nov 2019 10:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20191104213417.18036-1-leonmaxx@gmail.com> <20191104213828.18278-1-leonmaxx@gmail.com>
 <CAHp75VfNu_G7zzaCV9JF+Ua9otSTftJgtgr9N4qhQNR0o+QHtA@mail.gmail.com>
In-Reply-To: <CAHp75VfNu_G7zzaCV9JF+Ua9otSTftJgtgr9N4qhQNR0o+QHtA@mail.gmail.com>
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
Date:   Thu, 7 Nov 2019 20:31:04 +0200
Message-ID: <CAPW-Pu17tMrUA7oSf8V7S1y2+3JYO2buq3yY+FO8dZUu6uqMxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] platform/x86: asus_wmi: Support fan boost mode on FX505DY/FX705DY
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Chris Chiu <chiu@endlessm.com>,
        Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Kristian Klausen <kristian@klausen.dk>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review, I will do suggested changes.

> > +       if (err == 0 &&
> > +                       (result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
> > +                       (result & ASUS_FAN_BOOST_MODES_MASK)) {
> > +               asus->fan_boost_mode_available = 1;
> > +               asus->fan_boost_mode_mask = result & ASUS_FAN_BOOST_MODES_MASK;
> > +               return 0;
> >         }
> >
> > -       if ((result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
> > +       err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_BOOST_MODE_2,
> > +                                   &result);
> > +
> > +       if (err == 0 &&
> > +                       (result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
> >                         (result & ASUS_FAN_BOOST_MODES_MASK)) {
> > -               asus->fan_boost_mode_available = true;
> > +               asus->fan_boost_mode_available = 2;
> >                 asus->fan_boost_mode_mask = result & ASUS_FAN_BOOST_MODES_MASK;
> >         }
>
> The above differs only in one value to give and one value to set, I
> suppose you may introduce an additional helper to it

Maybe it's better to add additional argument with index to
fan_boost_mode_check_present and
call it twice?

> > +       if (err == -ENODEV)
> > +               return 0;
>
> This should be explained or even separated to another patch. It
> changes behaviour of the original code, why?
>

Original code also have this check to continue module initialization
when fan_boost_mode device
is not present. It's return value is checked in asus_wmi_add()
function and it'll fail module probing.
