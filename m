Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DDD14D9DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 12:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgA3LdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jan 2020 06:33:25 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34411 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgA3LdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 06:33:25 -0500
Received: by mail-vs1-f66.google.com with SMTP id g15so1859936vsf.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 03:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sachUFQOePxVrLNclWklF0gCfdMb5uCt5/iIiiOjQ6k=;
        b=m1CNO0r97qGHq1nZLkvorYbHCl6n3yiSngEKvS8X15JFdYJBqxFNmht5iX0MecxIOP
         4O6kew+CVKxdg87E9RakdF7ZlSNNkO0O1OoKOxGWLojbtznM9xvA2OxGq3aXJsNzwrDm
         1IYGvi7B54p545j97fkkv04Amo4Hq9RpS2+z+lyNUoF4an8lBtJjS/G4cTjJbQkmX2bc
         h7nNqV39Z5K0/ImATsG6f52N36W+LLu5YT3ohyEgwAbYlPcglHJRq56hKNjEu74wW88j
         EMpyr9P8VkVZQJk6fiw8x7mSXBySOcs1tFJc2COZrCNRnWB+2VDvGZapfDNs+Ksg28iw
         zZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sachUFQOePxVrLNclWklF0gCfdMb5uCt5/iIiiOjQ6k=;
        b=MHMt5WnDOwwboo52lQVFtHuOpow3M4tFhgwJmGNKCKLkdI/ZKk7A6PIxjCRheHS0W4
         k3v+hOAKxsUVjAUDc9mNbt+w7gW+80++kRVNb3UZE3BpofH5SH1gK3sRoD86xrqHbXu3
         EY6joutBjaJjb7+cegWhhbnL+2sX9tP/BqLaQhwb53+aNGqcMYUl8DCEiH4lv8bV8iqa
         wbh2etxRb/cOtQlfaCEVcZ+Di+FIH9dcmjTkSFz3/fPOBvuptzDm0L8CKtnspFf3FbKz
         W7k6M61bZZNLiqq9/x8DaqfPhEy/GAsfeEcr+qjdBiOD0eZg68kleXkTIM25NdGuJxJ/
         dJjQ==
X-Gm-Message-State: APjAAAVRxJIWkuYR0I08msJn6EmPpxc/PBPJgqEfNpkb0Z+gLZqI/xxV
        9q07LugivGyGb0tKMbMlA1k1fXGQ3SOLpdNYmuLYGA==
X-Google-Smtp-Source: APXvYqwRQewNB6JLSsvrZO8yrxek6cyYeBRvAzzDHbobVzvuHWcoLLJAsh/yeAgxIeeiqq8PqEYjkLQByU/8fRohxEg=
X-Received: by 2002:a67:fb14:: with SMTP id d20mr2749866vsr.136.1580384004008;
 Thu, 30 Jan 2020 03:33:24 -0800 (PST)
MIME-Version: 1.0
References: <20200129143757.680-1-gilad@benyossef.com> <20200129143757.680-5-gilad@benyossef.com>
 <CAMuHMdVb_AGa7980fRXaxon=uDojZ1x5d6z-FCJAt5aMEGMcbw@mail.gmail.com>
In-Reply-To: <CAMuHMdVb_AGa7980fRXaxon=uDojZ1x5d6z-FCJAt5aMEGMcbw@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Thu, 30 Jan 2020 13:33:11 +0200
Message-ID: <CAOtvUMdUBMkmZ6nzGVxi1W_Y4yFvcd6rfvz6BA63h4eq2QFUdA@mail.gmail.com>
Subject: Re: [PATCH 4/4] crypto: ccree - fix AEAD blocksize registration
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 5:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Gilad,
>
> On Wed, Jan 29, 2020 at 3:39 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> > Fix an error causing no block sizes to be reported during
> > all AEAD registrations.
> >
> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
> Thanks, this fixes:
>
>     alg: aead: blocksize for authenc-hmac-sha1-cbc-aes-ccree (0)
> doesn't match generic impl (16)
>     alg: aead: blocksize for authenc-hmac-sha256-cbc-aes-ccree (0)
> doesn't match generic impl (16)
>
> which you may want to mention in the commit description, so
> people who search for the error message will find the fix.
>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Note that even after applying this series, the kernel still crashes with
>
> kernel BUG at kernel/dma/swiotlb.c:497!
> ....
> Call trace:
>  swiotlb_tbl_map_single+0x30c/0x380
>  swiotlb_map+0xb0/0x300
>  dma_direct_map_page+0xb8/0x140
>  dma_direct_map_sg+0x78/0xe0
>  cc_map_sg+0xa0/0xd0
>  cc_aead_chain_data.constprop.25+0x17c/0x6a0
>  cc_map_aead_request+0x61c/0x990
>  cc_proc_aead+0x140/0xeb0
>  cc_aead_decrypt+0x48/0x68
>  crypto_aead_decrypt+0x30/0x48
>  test_aead_vec_cfg+0x5a0/0x8d0
>
> but you may be aware of that.
>
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=n
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y


OK, this is a new one yet - we are now crashing in out-of-place decryption.
And again, I am not seeing this in the different test board, even with
DMA debug turned on.

Can you help me out and print the cryptlen and assoclen (I'm guessing
both are zero), authlen and which AEAD/mode this is?

Thanks alot,
Gilad
