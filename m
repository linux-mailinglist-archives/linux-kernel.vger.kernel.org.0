Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E996F1935
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 15:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbfKFO4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 09:56:38 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50284 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731744AbfKFO4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:56:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id 11so3837471wmk.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 06:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgS6oa1hjOz0a7sAMRli19rgC0t4E8eWcY2r+LGoSt8=;
        b=IuqpNvHBanfnYSVZ5j7jiuo4VXzu5iZGHocJHHl8+scedrnAiNU/1x+nnfkvr354bq
         LCIFfBRZoPQO8KAY60Zuahuo5tN7x90xhlxL3qAf2dTATPqvAdyvgTbxzzENXVhpch9q
         UPl+etXZLHBXjGPJrUxr7aj77UnrG83m/y3wrGG/3bdVKdrPd42g5Ib0osdA67mt2LPu
         1LKtR2Wn9mxnBp3wnbfC7EYobt6ax/v208MuqwpzNqyIeIJI3oIQV9ULm4GpDPsRXRf0
         rpSYn87UXS5+FtjWLRGpDNs5Q161eIXrcGy25JQdDpj+nTRL5lRFc61v3q3NjMabSYfR
         wQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgS6oa1hjOz0a7sAMRli19rgC0t4E8eWcY2r+LGoSt8=;
        b=azqIl01fwGm36gFFoAwrkrLlRqloNH+hSAethbmnKLw1925uQ6gEOIUkP1XJGz9huV
         BbFnNqRQWZrUdDZ0DpWwcPoOoj88ugSEOumUcILy4rZEhpE4NG6gekLlEQju1HW/qGr4
         W0uyDb0VnXCcAsIiOSnP5TRD6Zu7f5ylzWelWDOn3z5qCy8Nw7Z4U38rkFOryr9crErd
         L71xFouEWs3gpHRa3H1jeCh0D32ZSUEHQZgG6oGWegtrMUdTy4sWDNm3Yiy/4lTWXrGu
         D2fQhB+PvayyrUsJ4EKn+8U4MF7D99g23Q94j/GVTuoZZsob+9ItwnXqIT+oug1czCGX
         urMg==
X-Gm-Message-State: APjAAAVed9IUntmJtiJ6uYm04flxL0NW3tsGUiK/24WSvzT8+as+uifG
        bVRp1P5jrCD8iexz399b1WpSAdcFIs54X6Qiu+dUXA==
X-Google-Smtp-Source: APXvYqxmXzKi49Zf+xLdM5Jzs8pOEpAJfdpTpoto4tyX7iZn6isYp1BT2fFrRj2/dOtBgcr/5FTfdkiedzAHC4bJSPI=
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr2732012wma.119.1573052195053;
 Wed, 06 Nov 2019 06:56:35 -0800 (PST)
MIME-Version: 1.0
References: <20191105082924.289-1-kong.kongxinwei@hisilicon.com>
In-Reply-To: <20191105082924.289-1-kong.kongxinwei@hisilicon.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 6 Nov 2019 15:56:23 +0100
Message-ID: <CAKv+Gu-V0S9EZeCjna5+P6v53evV-6uuG0rAShUA+uWb=NgH4g@mail.gmail.com>
Subject: Re: [PATCH] EFI/stub: tpm: enable tpm eventlog function for ARM64 platform
To:     Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Capper <steve.capper@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, zoucao@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2019 at 09:29, Xinwei Kong <kong.kongxinwei@hisilicon.com> wrote:
>
> this patch gets tpm eventlog information such as device boot status,event guid
> and so on, which will be from bios stage. it use "efi_retrieve_tpm2_eventlog"
> functions to get it for ARM64 platorm.
>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Signed-off-by: Zou Cao <zoucao@linux.alibaba.com>
> ---
>  drivers/firmware/efi/libstub/arm-stub.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> index c382a48..37c8f81 100644
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> @@ -139,6 +139,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
>         if (status != EFI_SUCCESS)
>                 goto fail;
>
> +       efi_retrieve_tpm2_eventlog(sys_table);
> +

This function allocates memory, so calling it should be deferred until
after we relocate the kernel, to prevent these allocations from using
up space that we'd rather use for the kernel.

Does it work for you if we move this call further down, right before
the call to efi_enable_reset_attack_mitigation()? Please confirm.


>         /*
>          * Get a handle to the loaded image protocol.  This is used to get
>          * information about the running image, such as size and the command
> --
> 2.7.4
>
>
