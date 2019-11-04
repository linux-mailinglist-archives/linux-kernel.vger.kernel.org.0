Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A96EEE3E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 16:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfKDPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 10:33:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41674 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:33:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id m9so18083344ljh.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DBMbcScUQGQZVNBdTsiLXor9xyXQU7D+1E9hPAM9ZKA=;
        b=Y17/dQyIIuBV7qFVbf3hljdrzyzDXMH3+Q7l6qUsJpgq4TKcHmzgXg3WqeQuOs/Ofr
         mt2X8W/YV22xCxDSI7shE92hjOUSTvROnDYbTxNm1xYEndn+xp9O/ei1MZbUJxV6NJoN
         xZausHHAo7VcDDwOsRj9NvgnwvXaFD92HMPjiSmUcBMYtj9mw0nxOc+p3cXXndAcjDnk
         aGaq3jsRxA2dLzVTii61YjV/gf2b54iJ3BhoYJ/OCVyMlTmGJ9i0FMaiTKNYRj5YNy61
         u2YAwqRk7R6fyPzl2R98OqG+hOyGHDz1J36kBp1LS+6gSTEBnwLs13XR2sHVIs/RcOiK
         davQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBMbcScUQGQZVNBdTsiLXor9xyXQU7D+1E9hPAM9ZKA=;
        b=NShIRjuE3US9+LProsJeYWbY7wxcCygdGoa66BZZCRSFtocgu5NvxY4AD0K3EZyaZp
         6NVH2m+sYRfHo9edTHTq0sWDJxf+of9X3d+JxP2XmK7LEiodXsmzp83s6EtbKnkdQL8F
         UwcQxVCCdSFbfu3rRwXNkkRXuK4AyJlSfTIDKPVwvdwmEcrI93tQDUGBDBlU1OCHkta5
         XLZzp1vsl5l9bkDRw83al3Ko5pz9lQM6XONE3PQ8j9Re+DhOYWBVU0qz08qGaSnoqkNv
         KnneQ//yk5dRb4V4Z6AY1d/2VKTpZTz9epjkKGdaWcjDWzvJTdiIeqEN1MFz/zau3TA5
         OdXw==
X-Gm-Message-State: APjAAAWzQMoG/K8DlKq/YPBhJRbMOifnR0uZbBCOjvmqRzgol/6lXV7P
        h/ov9Gp+EYXW/bVgi61zQxHxOPOvL2l2GlskovHDVw==
X-Google-Smtp-Source: APXvYqzeyNb16dPEjCkVmBtMh5caBJBGKo91VcHGLZKHPNSD5nRiCk1pJcF4RPBtbEVrq+xcQYHHZlXiwcUyrN8+Ke8=
X-Received: by 2002:a2e:9a12:: with SMTP id o18mr11818095lji.191.1572881630658;
 Mon, 04 Nov 2019 07:33:50 -0800 (PST)
MIME-Version: 1.0
References: <1572004167-24150-1-git-send-email-qianggui.song@amlogic.com>
 <1572004167-24150-2-git-send-email-qianggui.song@amlogic.com> <CACRpkdZZpc0yrewfseG3PUXgvV3H9XED25Ej21VeMYn8cUxasg@mail.gmail.com>
In-Reply-To: <CACRpkdZZpc0yrewfseG3PUXgvV3H9XED25Ej21VeMYn8cUxasg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Nov 2019 16:33:39 +0100
Message-ID: <CACRpkdZbvdVfLAmfPRXrrZCvyNCJWHkJCE_SBCb9W=O2UpMxrQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] pinctrl: add compatible for Amlogic Meson A1 pin controller
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Rob Herring <robh+dt@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 4:31 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Oct 25, 2019 at 1:49 PM Qianggui Song <qianggui.song@amlogic.com> wrote:
>
> > Add new compatible name for Amlogic's Meson-A1 pin controller
> > add a dt-binding header file which document the detail pin names.
> > Note that A1 doesn't need DS bank reg any more, use gpio reg as
> > base.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
>
> Patch applied.

I see there are still comments on the code patches but that is
fine, we can merge these bindings anyway. Just resend the
remaining 3 patches when you repost.

Yours,
Linus Walleij
