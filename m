Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DDA83D51
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 00:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfHFWZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 18:25:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33493 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfHFWZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:25:55 -0400
Received: by mail-qt1-f196.google.com with SMTP id r6so82087741qtt.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pH32zVB3+F/ChCdyTdMtG2lcokUsbDzNKurXgdNw+eM=;
        b=Bhd2VyLMdxTR0bfXCtkRvd/jZJ3GdIXDjv7Lpc7m8AFZoIU4VXg1rM3+cV8QSDHHAE
         jI7EEOQc7t6BSuBu77eQ4KrQRp0uvWLZcliRsoraFn9OyWAiRwUOap2E/hyp/Un+/XQH
         5IHq5uDq79aLlRW6yvBzdaHLhAiKoagFPR8r/GFpl2GMz4eRR1RX023k9y63+D5chIbu
         dVVjwOYijQgfNhgIATTG8YgsgB+oJsHbQSmvmfc7HI7Vy3v7EVkcC6I08Ixv7W338IEn
         Sqgjj2VZaAkk0laEWkYSMlwx/qhPKukdcDMTOLmch/dhXZcS9ICe9eLQLQbKO36ATU2M
         oKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pH32zVB3+F/ChCdyTdMtG2lcokUsbDzNKurXgdNw+eM=;
        b=rkk/+/q88L5QoE7A8qPbdDgPZrL+eRIdOVawanvwvVkULrXlFVPaTtZPbZwVuDHmW7
         +T8eBDUce8jkQadXhIv/oN5RUxo692xx33zjdI83xjJMGIjulKfS8ZfQxJUbqgJwrUg4
         OZhGmAN814JNor6Sbc1ejqsxRZrj5duh9czWgdDyq3G1fAJNacDuqMNmEILtUQMBSfwL
         Amp+xY8opwrUlk/FCAeVy+xNY3kYn7hsxjdl1NPddOwyrDmYH3MVgt9OdszOX1PCHAl0
         6xIj1i6pK4u0BITKumRjVk2FWfeVIwCpLjiLuPmn+Ls11yDMCoUVHLlMBSzfs7V4JNSb
         GqyQ==
X-Gm-Message-State: APjAAAWFWm/GDpiUjdoVMOQ74kxdmdbOHYoX1V/uF5WT6+czYyQMbBmg
        Xwp9AKnA57DhSEZPR/xJlOKWZNnbcBEQ76bWSFYpjQ==
X-Google-Smtp-Source: APXvYqzJQr3foOGESFYZIVGlvM44L1FSZXdFrXmixWF5WlF/FxcaVOiqBJzHmh2GvCKvL3JpQTLTIaJxKFW95cmt03I=
X-Received: by 2002:a0c:ad07:: with SMTP id u7mr5187740qvc.2.1565130354260;
 Tue, 06 Aug 2019 15:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190806220524.251404-1-balsini@android.com>
In-Reply-To: <20190806220524.251404-1-balsini@android.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 6 Aug 2019 18:25:42 -0400
Message-ID: <CAJWu+oq9JLnbGdqy+362JZUzjv6PvuRTNwiarTQiEfizsY32hQ@mail.gmail.com>
Subject: Re: [PATCH] loop: Add LOOP_SET_DIRECT_IO in compat ioctl
To:     Alessio Balsini <balsini@android.com>
Cc:     "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, dvander@gmail.com,
        Yifan Hong <elsk@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alessio,

On Tue, Aug 6, 2019 at 6:05 PM Alessio Balsini <balsini@android.com> wrote:
>
> Export LOOP_SET_DIRECT_IO as additional lo_compat_ioctl.
> The input argument for this ioctl is a single long, in the end converted
> to a 1-bit boolean. Compatibility is then preserved.
>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Alessio Balsini <balsini@android.com>

This looks Ok to me, but I believe the commit message should also
explain what was this patch "fixing", how was this lack of an "export"
noticed, why does it matter, etc as well.

thanks,

 - Joel


> ---
>  drivers/block/loop.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 3036883fc9f8..a7461f482467 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1755,6 +1755,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
>         case LOOP_SET_FD:
>         case LOOP_CHANGE_FD:
>         case LOOP_SET_BLOCK_SIZE:
> +       case LOOP_SET_DIRECT_IO:
>                 err = lo_ioctl(bdev, mode, cmd, arg);
>                 break;
>         default:
> --
> 2.22.0.770.g0f2c4a37fd-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
