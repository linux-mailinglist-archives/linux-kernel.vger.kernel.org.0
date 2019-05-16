Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECD220CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 18:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfEPQP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 12:15:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43455 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfEPQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:15:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id u27so3076966lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LBNDRhhKywXBp2MSuZfngBTVHWR97SCmvRB6eI8uLbE=;
        b=YGLG2XRTx2rzAnfC7U7Pt27EAxYtRFVsHIL2F6MDo4Eb18nu45zjdjHrwS1A9kdPGe
         7AIr1yDi9FrkAOD910N+/Gftjemk6VQpdwLEb6WWejY5+Cn6CS2NDKVPjnz4IQ92cu0t
         0s8PelXOgvWB0aAfwdmg6nSu5jdC5BtNCXpg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LBNDRhhKywXBp2MSuZfngBTVHWR97SCmvRB6eI8uLbE=;
        b=qj35NGwLwOrp1zQy3eupsxr3au+BBB1oFmVwYnL9HLmG9iTaMNwhIrRwEiALuq/0lh
         5gNG3AwWElgHotceS8dnQJJI/SfMxsOm8ml5K9uSrWW5f8Zk4wxMr2irekFhk1SH+6jC
         pzUt+iAhpfrt/oOcJr3ulk17Z8i99oBqQlGWLOwGc61+kNneSk6Wr0nH4m+yTNEVS+sd
         3SHaoPT2qCyKxB2NneqkhHxi9xL23O8uzx0L6tGdjQ3EU5A7nnlC5P4PCHBUT1Ty2C6D
         Oqb+fOIpIZ/mj8G7wSBqIs2xhZK4S73QeJ+MPe/UBj5ZZD2N3qvWuFQyWMewXOMGdleW
         vlVA==
X-Gm-Message-State: APjAAAWcL5EiAz6pp3zLTm9F8gM+Kyo/GauhWyIcRehL/0ZCmbiSUNYh
        zAIE14m/o5E5KirHEdoS2GqUpZK9cjOcZZXpcIpuNOW9
X-Google-Smtp-Source: APXvYqzDx21IaIaK95EwYZHZnuKZ60WB8qRKmhPS4eJD5UoIunNxJ5iVpBl+vhmkGydAw0xGLL0IfTX7yIdjwsn9BZs=
X-Received: by 2002:a19:2791:: with SMTP id n139mr16901324lfn.67.1558023326364;
 Thu, 16 May 2019 09:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <1558022399-24863-1-git-send-email-kdasu.kdev@gmail.com> <1558022399-24863-2-git-send-email-kdasu.kdev@gmail.com>
In-Reply-To: <1558022399-24863-2-git-send-email-kdasu.kdev@gmail.com>
From:   Kamal Dasu <kamal.dasu@broadcom.com>
Date:   Thu, 16 May 2019 12:14:49 -0400
Message-ID: <CAKekbes5XOU81ANJGeSsn_Ww59Fx1kymBt8fscv-fsSJdvaVeA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mtd: nand: raw: brcmnand: When oops in progress
 use pio and interrupt polling
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list@broadcom.com,
        open list <linux-kernel@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore v2 patch 1/2 and 2/2. The commit ordering is not right.
v3 patch on the way



Kamal

On Thu, May 16, 2019 at 12:01 PM Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> If mtd_oops is in progress switch to polling for nand command completion
> interrupts and use PIO mode wihtout DMA so that the mtd_oops buffer can
> be completely written in the assinged nand partition.
>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index a30a7f0..dca8eb8 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -835,7 +835,6 @@ static inline void disable_ctrl_irqs(struct brcmnand_controller *ctrl)
>         }
>
>         disable_irq(ctrl->irq);
> -
>         ctrl->pio_poll_mode = true;
>  }
>
> --
> 1.9.0.138.g2de3478
>
