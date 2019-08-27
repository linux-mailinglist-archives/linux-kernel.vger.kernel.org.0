Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B709B9DD3A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 07:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfH0Fkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 01:40:41 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45091 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfH0Fkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:40:40 -0400
Received: by mail-oi1-f196.google.com with SMTP id v12so14015961oic.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 22:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPIVNL57PP+Nf8p6Kp3uQdhTH38JJW4Kftqg1AMoBV0=;
        b=BmL0Q/rXa+SE59AS2UvXWjSGV+FMJrqcCnqJPuBWJ3ZSW/echijI0VOVWecqgbt7Qz
         2nxWzeojo2p2JD/l/SpAm3aUdyeCKIsCoHY7wHPnWugeUWKZpKcEHfYwC6+XsoehJOFY
         LVrBGjofWFxGqj+Zgw8ey9V+OaVtPnOA1ChR8eIwnxXCPVojr4UWtAMWer4NJL/3Ni5U
         ySTcrvjd6roSYqltfeRB8v5P5UEcYg2K3edHIHHpM+dl2I+ugSy1zc7Xo2wr03Z8gLa0
         Rnwmk66QOHpSORcjCIGeoBhsHOfGW/tTYflZlRaippNifQqAueryoLXa6YojF2h3XW6p
         YETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPIVNL57PP+Nf8p6Kp3uQdhTH38JJW4Kftqg1AMoBV0=;
        b=rfRq8PKlKH+8MtYRi1i7UX3e08t56vTj5NxAnhhpNCqAcuWy4auzFBtuWrQyAhXAn8
         rm86cywz61wKNoxn/EmKQ0aLprJ78/i0nlt0m2Ro03rm/9Uwq47NieWEJQWykNz6f/OO
         bjbRb28i/irMtghuNE0McBCiRRdlA2zf6OUzlvPHwQWX8rouLt90P7rsuz69zED1c6on
         +ZAXs83xU1ZG0rmQFWdRqFz1kOKAZanh4jdVUKwDsomjfcu/nluDMekLpICflsd/v6ho
         zfYcLx1oyBbWysCiuVcOJHpqLHY8RDmbYKb9TqP9j5kBBW+LPG1g3Qm240OGzIelLvnz
         UQ1w==
X-Gm-Message-State: APjAAAWLNQs/uzkX8AiwgABhR7N7bFon0Dxe27k9qAQVSRmwY3xbLHj7
        +5GmtcLfCCBPknuzYtPHYFHVCUA++7b/bnh4gXYoUA==
X-Google-Smtp-Source: APXvYqzzdF+CZBcadDQQ7FgxQnP/o6XEYbYqavRhDmjtnbu3qIY6iSxJZ19yy0h3us/UdTfoQ3DfXKzq9CSpnzx5c8Y=
X-Received: by 2002:a05:6808:b14:: with SMTP id s20mr1881239oij.15.1566884439743;
 Mon, 26 Aug 2019 22:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190826144647.17302-1-narmstrong@baylibre.com>
In-Reply-To: <20190826144647.17302-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 27 Aug 2019 07:40:28 +0200
Message-ID: <CAFBinCBdxLnHsqvLT863cUkZ3Cf_2FhzOMQVTvLbxNCsQBi1WQ@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: vclk: use the correct G12A frac max value
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 4:47 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> When calculating the HDMI PLL settings for a DMT mode PHY frequency,
> use the correct max fractional PLL value for G12A VPU.
>
> With this fix, we can finally setup the 1024x76-60 mode.
nit-pick: is this really 1024x76 or 1024x768?
