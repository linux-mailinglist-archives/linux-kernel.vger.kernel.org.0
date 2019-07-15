Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1154869B90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 21:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfGOTk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 15:40:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43472 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfGOTk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:40:56 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so36014677ios.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8RepNcMBA34lIipd4aTy/F+kZlm41FUuqckkYbpx70=;
        b=Tt3NTf3AABd1b8nrlASZqZEkaCYO9iSkuwDUefXej4OQzSnylihsL4UZi0wG5PC1iA
         8PVYrNjv5nNFLKaafOELrJ55qrpvArBrE9wukxZ88piEJbA7bNs3hsIfAQjvTRRfdVL8
         Mw75yZ35V1mg1HI2Tpt3kM/gMf8ElRNkM4lRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8RepNcMBA34lIipd4aTy/F+kZlm41FUuqckkYbpx70=;
        b=lOB0V5lkDAk5zD1wXs655HQtwGLPrGktcIGM4p79e5KW1ghUbGCAP+1D9fLL6v94Z6
         8WFhx5fy7jciv8HVv89aowrCBESvCgceU29J7S6e1swPwLx2T1OegPpUf8fP3yG8XXiC
         DpRO+jlQ/Tpx4v2f0XN8pCaspqb02n9X3uNncEDBHNt+ME78+lGjK0zJwlMTe/wob/bS
         Ln4t54c8mjPQgNL7+jYMM0QuLRRfGkox83fC3P61pLKgjLNMLigbGlCRqjT4tchzGLo5
         UxjLfqS7Ct/Pf7/lBKM2GZ5TjmNHjviNB4wByCYOaMQsYrwYnvcuuB9UjFr/7MLCVcyx
         /MYw==
X-Gm-Message-State: APjAAAUiQLS+am8RH3kGVQMOZiaZSd49WTYrJx9ftue8NpkR83a9RL3s
        iZiWI1iNgymhPej4NNkJftZazLROhio=
X-Google-Smtp-Source: APXvYqztcGmK/AwVTClgCvMJ8Wex+CeyLAlZA83A8OP/exWAq5DqCqWmwc/JdmYAWFHheboyEdghVw==
X-Received: by 2002:a5d:8a06:: with SMTP id w6mr8203058iod.267.1563219655961;
        Mon, 15 Jul 2019 12:40:55 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id v13sm16214196ioq.13.2019.07.15.12.40.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 12:40:55 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id q22so36052472iog.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 12:40:55 -0700 (PDT)
X-Received: by 2002:a02:ac03:: with SMTP id a3mr30679998jao.132.1563219654968;
 Mon, 15 Jul 2019 12:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190715191017.98488-1-mka@chromium.org>
In-Reply-To: <20190715191017.98488-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Jul 2019 12:40:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WT6TT+iyGVNUhNcmAsVJip6X4mytuNJPGwMkk4F4i75g@mail.gmail.com>
Message-ID: <CAD=FV=WT6TT+iyGVNUhNcmAsVJip6X4mytuNJPGwMkk4F4i75g@mail.gmail.com>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Always release lock when
 returning from _read()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 15, 2019 at 12:10 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Before doing any actual work cros_ec_accel_legacy_read() acquires
> a mutex, which is released at the end of the function. However for
> 'calibbias' channels the function returns directly, without releasing
> the lock. The next attempt to acquire the lock blocks forever. Instead
> of an explicit return statement use the common return path, which
> releases the lock.
>
> Fixes: 11b86c7004ef1 ("platform/chrome: Add cros_ec_accel_legacy driver")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/iio/accel/cros_ec_accel_legacy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

See also <https://lkml.kernel.org/r/39403a4c-bf7f-6a98-890c-57397fa66493@collabora.com>

Actually, the "Fixes" tag is wrong here, though.  The problem only
exists because we have <https://crrev.com/c/1632659> in our tree, AKA
("FROMLIST: iio: cros_ec : Extend legacy support to ARM device").
Before that there was no mutex.  For upstream purposes this could
probably be squashed into the original patch.

-Doug
