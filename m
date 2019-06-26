Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85065725C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFZUMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 16:12:23 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40144 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZUMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:12:23 -0400
Received: by mail-yw1-f68.google.com with SMTP id b143so25506ywb.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0ag//sSTBXe5XwvoTeu79SND79oGWRbV/V2H0jwuDc=;
        b=eMmJVSWFTXgd+rzN4EgYIz43VtVe7SHefB84LydsW1hd//DXNDpVKyAiRfV8sOy1RB
         oy/AON7b+WlP5prltaZG69S0gGnapYL+SNAzCbXOucIC+pfvg2C9SQhDeNqFQfTqTA5w
         U13vpROZ6fNJWE7FdsP7mByucPksx+KUqhUJyaVXtkc0+U1Xe2ZtHZ4ClVK9F5WyZGDd
         eu1cH22XJTVtSRt+y5TTpFaAtth8jGWDh/kbx2qjGi9lj+MYcKKlKpALSEOoC8pHf+U4
         3XLdBD1Yleo2WXcDrTaQBftfS6T7Acwuo+//1x2XB4BHhPOT4w8/aNDkNPVwrisK5bGs
         4t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0ag//sSTBXe5XwvoTeu79SND79oGWRbV/V2H0jwuDc=;
        b=XcKOBPNieSRrc1SVC735sz8ailT8lQsp7NftKSzWt3p+VR+g6UCdY9rXpB7Q9iBanx
         HsXCKWiNxD3N7Ye8PETjWMopp0Nf0fjuQ1leEM+sO/6G+Cs0C0tBe3DheDToR1KDSXTS
         oHLG7prcmOK07irXx0G3YLHJyUHKe0mNp7oTjVAOCj1v9xcb6vZMisFcatCyPo8lTbRV
         RR1lOGxJNAQYv2oc+cMNU7qeJ8aLd1lwEOBK/EEvS4oBbtlHGAjiMiujdcLk4TmN3IRi
         lwhZJpJC1m6A2G/8mNXwFCP/3nNzKVbiwVShYVA198laKToaSeypAZQRi37sqi0uPgK0
         II6Q==
X-Gm-Message-State: APjAAAWJ6mDoPwJh8KVZgwkhT+628V4tMwb28XP3WgB7MH3K0ELLMS63
        72K/Jr5VBprxRgimC4mS6ClsoxIFpEue6nBCMLXFCg==
X-Google-Smtp-Source: APXvYqyXgfBznM5WvMnMY1IBu6vtv0FfLfZ6WnZ1HnfaUfpy8CQptRkzmR+1cowaTM3vodbQT6bKM9UpbY2fNHUsi/U=
X-Received: by 2002:a81:a909:: with SMTP id g9mr4063332ywh.233.1561579941805;
 Wed, 26 Jun 2019 13:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190626195919.107425-1-dianders@chromium.org>
In-Reply-To: <20190626195919.107425-1-dianders@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 26 Jun 2019 13:12:10 -0700
Message-ID: <CABXOdTcKo=r9Yxj9KQEAdqgO5ok_4udak9x3ae7WEe_B7r5fZg@mail.gmail.com>
Subject: Re: [PATCH] block, bfq: Init saved_wr_start_at_switch_to_srt in
 unlikely case
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 1:00 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Some debug code suggested by Paolo was tripping when I did reboot
> stress tests.  Specifically in bfq_bfqq_resume_state()
> "bic->saved_wr_start_at_switch_to_srt" was later than the current
> value of "jiffies".  A bit of debugging showed that
> "bic->saved_wr_start_at_switch_to_srt" was actually 0 and a bit more
> debugging showed that was because we had run through the "unlikely"
> case in the bfq_bfqq_save_state() function.
>
> Let's init "saved_wr_start_at_switch_to_srt" in the unlikely case to
> something sane.
>
> NOTE: this fixes no known real-world errors.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Paolo Valente <paolo.valente@linaro.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

>
> ---
> Paolo said to add his Reviewed-by in https://crrev.com/c/1678756.
>
>  block/bfq-iosched.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 72840ebf953e..008c93d6b8d7 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2678,6 +2678,7 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>                  * to enjoy weight raising if split soon.
>                  */
>                 bic->saved_wr_coeff = bfqq->bfqd->bfq_wr_coeff;
> +               bic->saved_wr_start_at_switch_to_srt = bfq_smallest_from_now();
>                 bic->saved_wr_cur_max_time = bfq_wr_duration(bfqq->bfqd);
>                 bic->saved_last_wr_start_finish = jiffies;
>         } else {
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
