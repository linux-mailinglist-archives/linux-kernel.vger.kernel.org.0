Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC7BE7D9F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 13:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfHALEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 07:04:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39025 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbfHALEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 07:04:10 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so143389143ioh.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 04:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyrfV0ny/M1GUXVGlI7pscWcaouugm2uzojk14HjJq4=;
        b=pBf5a9/HF3Ba2nixtYKmrI9S00Abz8qmn+rwqM5HkxJuPU0ACP24eD00PBTmh0uoN8
         dI5ZEVUJK2Ptnqw3her+XYipQzGbdst02HFFuIU3ByrKbQ1B3GTajX7UXycbd8bZ4now
         ZSasGAlJx2OnXxyjIzF1DM1WoatXe13rkbczY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyrfV0ny/M1GUXVGlI7pscWcaouugm2uzojk14HjJq4=;
        b=sxfUkIej2wwsfG7pD7OSBAv30hB+8xmF5LqBfpn0tzbpgzUXu+IuywGdEzgK3qjcSW
         t+kmquMsr/QIoNtDngWQVLLiSMg42gn7Jv+9O/TMqqWMkwVppcPsjK9FfIPbDYbwhWDh
         2fD4dwWJ6rbmS/qugUmQ9VKJt8043+mYm/GZyybJ+jPF5gzAaqr3MGSHG7jqSNBkmvTd
         4EUBlNr59ACinoX6Jrk7o2s49NCckegPCyiOoWHSnDWWtU7RJgXy4xrki5XekV7fxXNi
         cQoo09TGBQhckuv7Fagxqx2VgP1Mb0LqEYNW1nMRZV3CrA169BKSbcCP3EevsU8u4uhV
         nOeg==
X-Gm-Message-State: APjAAAU9A+BY3IbNCJHdpxl6gAmVbqxRIiTFmHf78Hj04tsmhSQAk0f3
        jCwDeVry8VrajFivwCf83EVxPm5YTxPmWpdwDyI=
X-Google-Smtp-Source: APXvYqxyyNOG+gV1/kk4ACfnBxdI8w2ALmoEmcfZE8+IM7h3QDdX57asj+Mg7KXkeYl2xZmYN1SqgRcy79BlWmWyUlU=
X-Received: by 2002:a02:aa8f:: with SMTP id u15mr41761993jai.39.1564657449712;
 Thu, 01 Aug 2019 04:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <64e2db3a-cf58-0158-e097-1a504a8bb496@virtuozzo.com>
In-Reply-To: <64e2db3a-cf58-0158-e097-1a504a8bb496@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 1 Aug 2019 13:03:58 +0200
Message-ID: <CAJfpegtr3-7q0VafdV-mTRyXb1Tbk5tUhgUTwK4RFGgj-Q=9dA@mail.gmail.com>
Subject: Re: [PATCH] fuse: cleanup fuse_wait_on_page_writeback
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 9:17 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> From: Maxim Patlasov <mpatlasov@virtuozzo.com>
> fuse_wait_on_page_writeback() always returns zero and nobody cares.
> Let's make it void.

Applied.

Thanks,
Miklos
