Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87F1139EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 02:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgANBYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 20:24:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49151 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729213AbgANBYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578965061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fHEMm2SsTYZoIki8jbB8+WC5Q2vGKFdNsQ1V1gkRMy8=;
        b=OI4sHU7dzmfbaOWQeTbdLBNwueBXqdgY3LpzNSax2J0KCab+CHTAIA35/WFBLtDW3xS0Ie
        JIz1beCjplmQKvPRLX9lCE25viQEzgB45PFXmTrzxQtYtikX0qhuRX3ijZQATgqmVyd2qn
        dy1DDAVTIHbKbYKfTSMQviZwiCfGMP8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-SnJpvwK9OIuBjtU8Op-qJw-1; Mon, 13 Jan 2020 20:24:20 -0500
X-MC-Unique: SnJpvwK9OIuBjtU8Op-qJw-1
Received: by mail-qk1-f200.google.com with SMTP id w64so7312070qka.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 17:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fHEMm2SsTYZoIki8jbB8+WC5Q2vGKFdNsQ1V1gkRMy8=;
        b=FWlICp0HB8R2cZwuBmaSzWAK73boslYekUEn6fdvXqxsq3Czhnzp4rFJd/Mo/ad6OG
         4BYkhlczSTH4Cl5H9Cn4H+BPFpuhZqZA7HwNHV5YI+gslBeZiB1nJEYHdlrP3WeHApJm
         vuM4WkcamgMsp1X/JQ7u8qrWMppRY/438IxoUWmhXiWQ30dup9ZQracPkEtXLM/iTcSE
         2C0AgRc0UIOAcfqwC3L0/HL6xhnx4JzazznlZqnORL+htQXB4+d3tuJaStfAlp+Rjznf
         XtRKtX+GEfXZYnM/3UE0os9hJ9WyflaU3WdJd2dLlPrUQtFBN0e2N1dkL/pwCAaFO2PS
         AWhQ==
X-Gm-Message-State: APjAAAUfT2+2WFAlxguoODyapXFXQcQRBGh2xz9QZtWSKKGmyNR0SGa6
        QnTw55IPYdmXM8jkgJH/oWqkajhHHJpxNkm72aoOkOIh6IMBzWjruaSvJdH6Y/Jd60/5p3sAwOV
        K1Oe4xP0kgdgMW6UiMk5rB8vhyshy/CiXh9DvTL5H
X-Received: by 2002:a0c:fac7:: with SMTP id p7mr18867681qvo.46.1578965059690;
        Mon, 13 Jan 2020 17:24:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8rp2tVJG8FFSrMqEEhMSegO/Ch9+dAU7aqOjlvhAWdChQ9jSPgjRB76ehlY2C/JNhnmNpbdLe0UeQ6dG9z0g=
X-Received: by 2002:a0c:fac7:: with SMTP id p7mr18867665qvo.46.1578965059435;
 Mon, 13 Jan 2020 17:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20200113192300.2482096-1-lains@archlinux.org>
In-Reply-To: <20200113192300.2482096-1-lains@archlinux.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 14 Jan 2020 11:24:08 +1000
Message-ID: <CAO-hwJKkMv7T0e11XoYKh9GtsnNCfOztFsoU7JXgmxCvfROeZw@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-dj: add debug msg when exporting a HID++
 report descriptors
To:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Filipe,

On Tue, Jan 14, 2020 at 5:23 AM Filipe La=C3=ADns <lains@archlinux.org> wro=
te:
>
> When exporting all other types of report descriptors we print a debug
> message. Not doing so for HID++ descriptors makes unaware users think
> that no HID++ descriptor was exported.

Unless I am mistaken, those dbg_hid() calls are not displayed by
default on any distribution. So I am not sure what is the benefit to
add this one here when we are already not showing the rest to the
users by default. There is a tiny improvement to have some code
symmetry, but here, honestly, it doesn't feel that required.

Cheers,
Benjamin

>
> Signed-off-by: Filipe La=C3=ADns <lains@archlinux.org>
> ---
>  drivers/hid/hid-logitech-dj.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.=
c
> index cc7fc71d8b05..8f17a29b5a94 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -1368,6 +1368,8 @@ static int logi_dj_ll_parse(struct hid_device *hid)
>         }
>
>         if (djdev->reports_supported & HIDPP) {
> +               dbg_hid("%s: sending a HID++ descriptor, reports_supporte=
d: %llx\n",
> +                       __func__, djdev->reports_supported);
>                 rdcat(rdesc, &rsize, hidpp_descriptor,
>                       sizeof(hidpp_descriptor));
>         }
> --
> 2.24.1
>

