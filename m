Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F520252D6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 16:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfEUOw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 10:52:29 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:37466 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfEUOwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:52:19 -0400
Received: by mail-io1-f45.google.com with SMTP id u2so14163487ioc.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VEBQT5hPNY+WmxZoXIy8e/pcweb5kfeZeD0sBTptdRA=;
        b=rMcvSaT2NO+jmP8g6QeQrSTTPSv/OllfHnw4LphrinwMsbbuwCDWJdphYEBhZvg2X5
         7rRoVkFnX9ZhbtxvhW+DiPHkO7Dv1a5hLPI5KOK2msqNVGlJL3ZQ2m6hcgvu/nc2ksK0
         +mv3obz7DDPx+LQxEqQB9uIQTu4iLnp26+osEXmGI8Pos2TdAxbLGdiGCf6RsbAiJbZ8
         /yQRrcifSQ0F0WRNxOwb0rYDY1RJNtPAaIgh1YsskS6ZjoYG62pQjWBDgs01Qwkx9Z12
         qcqa6RO8hDt1BUrfcRyqXImJ8U+RpPJapFxQqszg/GCqAhEwe7ZawBaQ9LvVd4w7RaLG
         pRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VEBQT5hPNY+WmxZoXIy8e/pcweb5kfeZeD0sBTptdRA=;
        b=AM+4K/kIA5AoHE4vG2kP62kkMKgdFiou7NrTYF92Uh08JymXI85lzScK824zUnhLBu
         8jeC7ot9BCm+u+bW7YpH/sJdIXXy83YHUtU+CuPkWirA6SA40wOx5/cb73eVdvb1Ae6j
         hwVyCKKsXMKrZXirItPjg2tN6eMWxzNJreh1EfmzgxGJXCOhx+NckshzZptYSEAuNvHC
         sMx7rOjWo38Spc3UlVE/4guOvafJrysFB+Jd9rKwUt/x73oY9/oztQoEdkyYIG3BkcUn
         D75zxqTdUloSZpKORW7MrCaR+9bMu11otL73+DrjZTI9WD9HRsl3y8RnvB5VGaOqqEJr
         f0cw==
X-Gm-Message-State: APjAAAWaDD3/t+8l2y8ei8nV1Wp2+/MKGwDdRRkkEgR8wba53BGko3k+
        FU+FfHPKSw1Vv3DnFcdZ/RuYwbvQSukucGOj118=
X-Google-Smtp-Source: APXvYqw1FQrNhSL/UOS0iNSoSsah/qfUsbU8ohoRfTN+LWooDGMyeqRDC7CCfWjpG2/i4o6DwpRDUFhZGUzRDYT3P3A=
X-Received: by 2002:a6b:790a:: with SMTP id i10mr4425841iop.2.1558450338532;
 Tue, 21 May 2019 07:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <1558115396-3244-1-git-send-email-oscargomezf@gmail.com>
 <CAGngYiVNQrr2nKfGCdi8FzS5UnmGaDj_Gu_F0ZeOTMKX6_1Zuw@mail.gmail.com>
 <20190521141715.GA25603@kroah.com> <CAGngYiUxd15xVkcbFm4cC+0a+UU+VODTKC0z4p=NoW+pTXoYzA@mail.gmail.com>
In-Reply-To: <CAGngYiUxd15xVkcbFm4cC+0a+UU+VODTKC0z4p=NoW+pTXoYzA@mail.gmail.com>
From:   Oscar Gomez Fuente <oscargomezf@gmail.com>
Date:   Tue, 21 May 2019 16:51:43 +0200
Message-ID: <CALtfCQaiT0p_cWgKS66ExS0_Uqe2Ltv7v-dV7sLarBgZNUGzHQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: solve warning incorrect type dev_core.c
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, perfect!

Oscar Gomez Fuente
