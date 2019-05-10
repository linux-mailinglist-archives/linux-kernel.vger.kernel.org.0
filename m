Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE81A19B31
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 12:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfEJKOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 06:14:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40089 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfEJKOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 06:14:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id w6so5075724otl.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZiHkOP2G2KBbMO/HwvwcUOiTAwVa4lhyxJmh7593C1E=;
        b=ogX/j60kJFhWOj6V0oSFEwlDh/tPi8tp2P8nuLAish7AmQXvhIwXXEvRb8/i5hrTST
         OSOHGtqMnxqRo3fIDJ+kuEsRKt6fzL1/3vA52js8Zv47WChTsY0Hjp53kqfFoY5GProz
         ClRpFI8F9F7655kpqzYEzYb+veI5Ctj6O92ODEfDe1Qf/XP9zj3CRS31zu/7zRgOHxsm
         BhKTPSbIEO43dKNh0sPjqq+gFmRejlvcrTIB/LDYo0kaOZ2TD28Qgf+ue/SOxvOImkt9
         Gb8ayFu9YinSXscDdSLdb5RhcwG0s4HdIoazReYYFC/VKQCHUdx+X4z+ug0pweM5iE5t
         hY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZiHkOP2G2KBbMO/HwvwcUOiTAwVa4lhyxJmh7593C1E=;
        b=HrKiD2tf228pzbCf73Yz/thxsxcVey2Tdza67cwrBGH66VU4+HKh7QJ60Quf81RM4b
         uoymDOVwkCRzQKy1xlakI9vv6EnaEk4hdgNzKclZ9RwTPwfvuOAkHEJqdpfWdI+UM97T
         Frky7ydAS4ifF3Stzh5TKjp77sjrD/a4yJjFdAqzSUWPJe9AvwW1CEJO/URz+EP+YAQh
         37YPiGEp4qaU/ZqqPst3RHLkYM4ovOjfoDnyuTeFfFYdB6oDzGZI8YkXGRfe+67tWI4z
         7OVKARtlDhHN4oQMwGOFWmD5wU3ENjhJYQ+BPLEiweBHhTTWiXwfCQ9qlKy0UbhtXTt9
         cSZQ==
X-Gm-Message-State: APjAAAVykkHXN7ZFQeBA2OUEHIlA32OOE0UtQwE5JlO1YmMGNN7DMVu8
        T/8h4y0aVj/XVnoJkUW1Gx3DwrIfq5BG2xtxNPDN6A==
X-Google-Smtp-Source: APXvYqw28ff46O+4bgP+wWCeMn27ZzW63vnMM0B1jLmjQwiWLVP8lilJV6fg1z45gaxRJ49HxCU9q5yFk/BbDc0Bdq8=
X-Received: by 2002:a9d:12f5:: with SMTP id g108mr6418092otg.56.1557483290159;
 Fri, 10 May 2019 03:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190510095832.28233-1-colin.king@canonical.com>
In-Reply-To: <20190510095832.28233-1-colin.king@canonical.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 10 May 2019 12:14:39 +0200
Message-ID: <CAMpxmJWyVZ2hHE=1tu5NgSzEHZKD2pBo8KUXg1CLUaB-WX4KHQ@mail.gmail.com>
Subject: Re: [PATCH][V2] reset: remove redundant null check on pointer dev
To:     Colin King <colin.king@canonical.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 10 maj 2019 o 11:58 Colin King <colin.king@canonical.com> napisa=C5=82=
(a):
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer dev is being dereferenced when passed to the inlined
> functon dev_name, however, dev is later being null checked
> so at first this seems like a potential null pointer dereference.
>
> In fact, _reset_control_get_from_lookup is only ever called from
> __reset_control_get, right after checking dev->of_node hence
> dev can never be null.  Clean this up by removing the redundant
> null check.
>
> Thanks to Philipp Zabel for spotting that dev can never be null.
>
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 6691dffab0ab ("reset: add support for non-DT systems")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>
> V2: remove null check point, it is redundant.
>
> ---
>  drivers/reset/core.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 81ea77cba123..921f4bbbad8a 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -694,9 +694,6 @@ __reset_control_get_from_lookup(struct device *dev, c=
onst char *con_id,
>         const char *dev_id =3D dev_name(dev);
>         struct reset_control *rstc =3D NULL;
>
> -       if (!dev)
> -               return ERR_PTR(-EINVAL);
> -
>         mutex_lock(&reset_lookup_mutex);
>
>         list_for_each_entry(lookup, &reset_lookup_list, list) {
> --
> 2.20.1
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
