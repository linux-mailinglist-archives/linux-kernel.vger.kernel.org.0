Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2055F2A6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 10:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbfKGJUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 04:20:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55647 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfKGJUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:20:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so1605716wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 01:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fi6xzuBwDslqMBEvOoSJLgLZ2eKUNykAx5rVCyKwYkY=;
        b=Xo1imTSWH2DPOskwLGJmaXoLtzlHHl5JVfqYQkKmOOa9uDLE5OHcZN7g4m5+oHdq5G
         NwftkH7SGrFIUsp1I+fjikmM/gAy+uLeGZjOgK3VYvPI0EVCMPbwzom8M2Hnw2CdqbKM
         AznMYDsGn3SuvaIA31VakGgLjitGJQgkhqHiEoey7wYyPlcsXyhjF4n1EbyMqem1jfBL
         XqrejqJGde4OQ0Ydw+Omsh0Lq2+QRdMMLypJBfEft2IuI3m7eOWLzUUxP6O5efsqmLaj
         6TvWo+C9Jm+XLS37rdrLO4sGFICqK3Sq2s+s/WWKfAwSiLgGf3PC3PHBanCDeM0ekp9R
         21BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fi6xzuBwDslqMBEvOoSJLgLZ2eKUNykAx5rVCyKwYkY=;
        b=OBmOtuIzs7Wzzrr+N4bIkhiTuEOr8Nf8kji+h1r5GanwKYC2cYsPtodhl1bscS99yQ
         iXJp++hv4wYjh9xvAbU4kvJURkLBaOKIm0UoTWEh9dXkeqMLB3gfAV6f0xnH4a48QKhl
         tB83uas7hQHPG/WVWjNSl/69eiLaFlAjhXnW7xZHAT9huv8UA+jhnS8plg1yQHRgdB6I
         AUu1ajb814lgg9woEaqaR9hgnnN4tnyQk9uuXwqfc7xJgNoeqnmyf+ErMuxI+ZA09Xqx
         KCcKoy1L3kGcEMCG6RjNF1bsxWMxPMKWvcdhSucLWKUUZ5oFHJyfwHj+9ggeZ2XqOkfn
         x8zQ==
X-Gm-Message-State: APjAAAVUa+u6r/VRqV5kOK/yd2QeAUgLjCDvnYsIyXgOxmRSgJBkhzBN
        6MSBvw4u+7d4q48rkQLzTFqB4xcS4GueQr2r0hHE0g==
X-Google-Smtp-Source: APXvYqzviDjzjYdWIBVaJpSRjyKleEqm2u85x/m07Z2DV2q8u5GPTnMR/uRE5Kmk5P/uhgd17AisLoKNThhGARfz6qk=
X-Received: by 2002:a1c:3d08:: with SMTP id k8mr1722499wma.119.1573118430458;
 Thu, 07 Nov 2019 01:20:30 -0800 (PST)
MIME-Version: 1.0
References: <1573115061-34791-1-git-send-email-kong.kongxinwei@hisilicon.com>
In-Reply-To: <1573115061-34791-1-git-send-email-kong.kongxinwei@hisilicon.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 7 Nov 2019 10:20:19 +0100
Message-ID: <CAKv+Gu9vwDGeCrNYFEbQC0f6kLN1oEiKx9AjA9UpvHm1Q-0nSg@mail.gmail.com>
Subject: Re: [PATCH V2] EFI/stub: tpm: enable tpm eventlog function for ARM64 platform
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

On Thu, 7 Nov 2019 at 09:23, Xinwei Kong <kong.kongxinwei@hisilicon.com> wrote:
>
> this patch gets tpm eventlog information such as device boot status,event guid
> and so on, which will be from bios stage. it use "efi_retrieve_tpm2_eventlog"
> functions to get it for ARM64 platorm.
>
> Tested-by: Zou Cao <zoucao@linux.alibaba.com>
> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>

Thanks. I'll queue this up.

> ---
>  drivers/firmware/efi/libstub/arm-stub.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> index c382a48..817237c 100644
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> @@ -189,6 +189,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
>                 goto fail_free_cmdline;
>         }
>
> +       efi_retrieve_tpm2_eventlog(sys_table);
> +
>         /* Ask the firmware to clear memory on unclean shutdown */
>         efi_enable_reset_attack_mitigation(sys_table);
>
> --
> 2.7.4
>
