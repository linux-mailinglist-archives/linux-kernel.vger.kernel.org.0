Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B885139F92
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 03:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgANCmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 21:42:55 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46671 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgANCmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 21:42:55 -0500
Received: by mail-qk1-f196.google.com with SMTP id r14so10765147qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 18:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQsUXhIb0stSpaIAXM/Rz7YomnESLO0a6sqlm0fG6t8=;
        b=Vn8ng5GVdXoUi3xPP32UGXxb/Wbz1HzYSU+Gkhe8zgtAhU2Dg/Vw+7TUp/9LBKGdzI
         YiPF2Y85Rjg0dsMu4CiFLsIbS5Dp7p6MbqcwcMc3ll6Sdgqz0QCwvauMBqkzZXrs9m9/
         fMu8bqnZY4/i/V/Wd+GscJlkYRUOYDvd8CttI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQsUXhIb0stSpaIAXM/Rz7YomnESLO0a6sqlm0fG6t8=;
        b=K+RXNDSS1CvZE37cqOYzEJPXxF3AaSNiJlAfacdjwj4ifzQSTyFU0za5AczXnlTVXs
         ujNTyuJMx+ChJj71gGrIIjSBPqkuY4I598SzJiDMgIo/M68jXXDP7XVvRCp4MGg1HGHl
         LyK9WwuG8BG+0Rlp7zoSX6mfuscc2kPBHHYhyhO4+6qRNcEoY9MMjp74oA8dsUScJmaH
         L/HhRnmWNZUaLON5ZZ6jmtzWjD+C7/pevR4bmlJx25ZmSJqRC+K4pUHJIfnRAUhtnkrV
         WPTGFodVBXXgGiV1rClIBG7VIJjmlP24yRu3qZUJ00yiXCylBeKQ3tHSuMP40oQL0EsD
         /KPA==
X-Gm-Message-State: APjAAAW1+Y/4qVeAPUQfzuz26AHuRD6unXDzZALajiFXD1BhkMvaNjlq
        2dTnHt1JZRbYvjr4EsMRIfoAaHEjOOOuhCu6aKZnPg==
X-Google-Smtp-Source: APXvYqwZRtkHmMGsgaGbjy817bSe7F4opYhIC5Gwn078bWpMzUNlUw+H8Zw+eunWVX9Au+bWZ6pyl8udPJQarGygGq4=
X-Received: by 2002:a37:9186:: with SMTP id t128mr18398522qkd.180.1578969773907;
 Mon, 13 Jan 2020 18:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20191220193843.47182-1-pmalani@chromium.org> <9bcb4671-f421-c639-f8c8-a02f62bfc7ee@collabora.com>
 <a632243b-92b0-20a3-3eff-9c7347e0e5bf@collabora.com> <CACeCKadvhhARxSWeb88Ny4BoRiy8opp+o0Zrzc-fQiRH6dH==A@mail.gmail.com>
 <ab68d3e3-c33b-a0d1-6707-d1baafca1da7@collabora.com>
In-Reply-To: <ab68d3e3-c33b-a0d1-6707-d1baafca1da7@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 13 Jan 2020 18:42:42 -0800
Message-ID: <CACeCKad0ee4ASEFwonaZ=VyfwdmSGuArN4s0cjcoEgJtQEyycw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] platform: chrome: Add cros-usbpd-notify driver
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jon Flatley <jflat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

> > Perhaps we should just make them two separate ifdef blocks, i.e #ifdef
> > CONFIG_OF, and then #ifdef CONFIG_ACPI? Would be great to hear your
> > recommendation here.
> >
>
> If understand correctly what you want is on some devices (usually the ones that
> use ACPI to instantiate the devices) use the notify ACPI callback, otherwise, on
> devices using OF to instantiate the devices, create a notifier. The driver
> should work on both cases. The problem is that CONFIG_OF and CONFIG_ACPI are not
>  exclusive and select one does not imply not select the other. So yes I'm fine
> on have both ifdef blocks, but in the cros_ec_dev (patch 2/2) you should
> register the notifier only if IS_ENABLED(CONFIG_OF)
>
Thanks. Will upload the updated patches soon.

Best regards,
> Cheers,
>  Enric
>
> > Thanks again!
> >
