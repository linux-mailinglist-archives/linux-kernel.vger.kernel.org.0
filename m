Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32084F01A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 22:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfFUUqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 16:46:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36982 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUUqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 16:46:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so5445029qkl.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 13:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPwHH9vLN+yMXRKG+Du01w5rWkCMrkRaPopR7Z68UlA=;
        b=DjvN3MoTmLfKa5S7Ia2S02w+/vl+gasS5yoSFx0bsLhD/jfcmMbHlRtWZGcllTbfZf
         OFQOHPimgqOD4BOnKB9HFvHR+XFEHHoOw/TFIkUsDZy7F9kUPI4vl/B5D26LklrOqY5c
         zalK9wLRkDDu4ANU139dj3FJkTnF2tECMy2FMyfAh3PCBTtUXt4GLDx6Tcl4QBcdvLZL
         FIBpKQz9aqcw5WY6V2FU451hqpwp8qsE3SgHfQbnuaVwhkpPqsvZ9Whc3/TEqDvOD/ys
         AaoS5AAu8bIYoIrRwy8BWpjN/0j6K5+Q5X6TtrKfkWlj0LpciMX0DCT9iAmzX0tDzmJg
         w1Ag==
X-Gm-Message-State: APjAAAWXBX8PIA6bKmv1WFLqqTTnp08Nc9xm3wp2DvGlRzk3Yw5Rio2o
        V/c2nNZ7mSLautrmSBqi3TX4nfHre6I+laNx7YG6O6HDlHM=
X-Google-Smtp-Source: APXvYqxcnv6CWu4UjNYEb3oWeZusRP8i+9GXV2W99bcGzrhLZjdzghgVuysDDFq4degshvJzqs1Zmt9qxP5RMh8Kn+Q=
X-Received: by 2002:a37:76c5:: with SMTP id r188mr7304134qkc.394.1561149966584;
 Fri, 21 Jun 2019 13:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190621203249.3909-1-Jason@zx2c4.com> <20190621203249.3909-3-Jason@zx2c4.com>
In-Reply-To: <20190621203249.3909-3-Jason@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 22:45:48 +0200
Message-ID: <CAK8P3a2mQpC-+iON976gYgyX_tVJMiaVO3rbCx+y_543QhjC7w@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] timekeeping: add missing _ns functions for coarse accessors
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 10:33 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> This further unifies the accessors for the fast and coarse functions, so
> that the same types of functions are available for each. There was also
> a bit of confusion with the documentation, which prior advertised a
> function that has never existed. Finally, the vanilla ktime_get_coarse()
> was omitted from the API originally, so this fills this oversight.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Arnd Bergmann <arnd@arndb.de>


All three patches

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the cleanup and your patience.

        Arnd
