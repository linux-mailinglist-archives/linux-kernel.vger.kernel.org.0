Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138B710ECF7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 17:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLBQUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 11:20:45 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46661 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbfLBQUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:20:44 -0500
Received: by mail-oi1-f196.google.com with SMTP id a124so88721oii.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 08:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9BkVxiLv+pBEYtD5UOWEWCQuzcENfBq8d61a5ql7UVI=;
        b=BBqymoM+p7uOQ5qvkO5cICX7OJOz+9/tpF5VI96m+7u7GQrDTCEIToFN1vqzgNUjCY
         5edEc4BtViGkn8BwD1lm9WB804ozxCDkXtWAjfxY5rKCifjBVhkmfV615FK/z57B0t8b
         YHdizSdbqUcV4V3KNbFowjDEm8RUtmTByzk9d4KdWtY2W/5zeHkOZTXUGkz8pmFKlFrU
         fZPdzp7rx4+hP6LZsDMzvFqGAQluZDFK94ba5AAQVgaY9xBA1HEHDRtLzut5NyNrkcd3
         p/1T+DpZf8lxIPQQsr5zYtvIVXawszGSwJhzC5y5PqlQCO0FOGf8e5mCXkOF8B3jAjxs
         bIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BkVxiLv+pBEYtD5UOWEWCQuzcENfBq8d61a5ql7UVI=;
        b=Gdlh3HyG09swubBMBW2NHmbtgAxK+gF0DJT7ZrfAJmr0FSY14oeqRPXplaVOfDdc4h
         M4+8WyEmdImdAO7jp7JdB55wcfz+5FYd8/fuJPJslLeJT/yyMZIDLitGZheNa2PsvfSY
         G9FrZHezm5hhy/w2BkjLm0go3OTvU7gAmOotpV3LaoGdfIzKmsZit/d/JRtW1/GBYnM6
         OF+NfA9iQuhz1JfMLokM5H76Vuvxe8G5BHQb5qtPu3TnvyGP5t7EwnX4RNkA/zOjvi7H
         SciDU7tzVrH/jrNByroe9teT4bAykxPDDWRAjIaDQNRSQvSpSqMprHn0HkBdlgLYXYkY
         jvXg==
X-Gm-Message-State: APjAAAV4Drfn3352Aiwb16F4kkopvqmwUP6nhKyFe8xd36W2TbpB48QO
        vY4CEt43URWIOkuQMpnJuW6JRsLG6S6bbeu/Zh7ITg==
X-Google-Smtp-Source: APXvYqxcjg2wFW+xR4e69BDFbQU5tYUhWFK+NbehjEsS9aW0D3qarZhcvroGXlhhlrXwyUJbAMgw1skovNDuz305KXc=
X-Received: by 2002:a05:6808:8d5:: with SMTP id k21mr24359oij.121.1575303643663;
 Mon, 02 Dec 2019 08:20:43 -0800 (PST)
MIME-Version: 1.0
References: <20191202135918.566dd377@canb.auug.org.au> <5231d2c0-41d9-6721-e15f-a7eedf3ce69e@infradead.org>
In-Reply-To: <5231d2c0-41d9-6721-e15f-a7eedf3ce69e@infradead.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 2 Dec 2019 17:20:32 +0100
Message-ID: <CANpmjNM2b26Oo6k-4EqfrJf1sBj3WoFf-NQnwsLr3EW9B=G8kw@mail.gmail.com>
Subject: Re: linux-next: Tree for Dec 2 (drivers/crypto/hisilicon/sec2/sec_crypto.o
 +kcsan??)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-crypto@vger.kernel.org, Zaibo Xu <xuzaibo@huawei.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2019 at 16:56, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 12/1/19 6:59 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Please do not add any material for v5.6 to your linux-next included
> > trees until after v5.5-rc1 has been released.
> >
> > Changes since 20191129:
> >
>
> on x86_64:
>
> ld: drivers/crypto/hisilicon/sec2/sec_crypto.o: in function `sec_bd_send':
> sec_crypto.c:(.text+0xae9): undefined reference to `__tsan_atomic64_fetch_add'
> ld: drivers/crypto/hisilicon/sec2/sec_crypto.o: in function `sec_req_cb':
> sec_crypto.c:(.text+0xbf3): undefined reference to `__tsan_atomic64_fetch_add'
> ld: drivers/crypto/hisilicon/sec2/sec_crypto.o: in function `sec_skcipher_callback':
> sec_crypto.c:(.text+0x12d3): undefined reference to `__tsan_atomic32_compare_exchange_strong'
>
>
> Full randconfig file is attached.

Thanks, Randy.

I think uses of __sync compiler builtins are banned in the kernel, so
here compiling with KCSAN is actually acting as a linter showing us
places where they are used in new code. The hisilicon/sec2 code in
question was only recently added.

hisilicon/sec2 maintainers: please use atomic64_t and atomic64_inc()
for send_cnt and recv_cnt.

Thanks,
-- Marco
