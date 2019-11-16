Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DDFFEB9E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 11:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfKPKWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 05:22:02 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44809 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfKPKWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 05:22:02 -0500
Received: by mail-ua1-f65.google.com with SMTP id r22so3785089uam.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 02:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zM1LIB9mEaNWRIyx5CUYi/bUE6U9z8snfaBDf2sH6g=;
        b=bwy5IIi/emtMBlbh0isyZKPqssD/qdGLdDQfqfX8rcD4/uztpQt+6sZkhDQlyOtDnL
         i1f3IiDzNovVtntFXUXXoELhLdQBCzgjt2JjePE5WOILcPtQmKzrKbNI2txjx0Bv/VcP
         ttX6xKdnX6j98hdHHbtkR1ulpR+YZFRsvWXZaJRT1X1J1vRzQaF5vsQzAwoTOvnt037J
         B6oOLez2J1W4In77hjoxH5VTk46WMPbMZ+YKSJp5+NarJDEFju0Et4L+jBBhj26c74Z9
         KgehU969UQkUi+f2FKRaOL231vmuall5mmev2mm9lxHJs8kUf7102xF/lkZzDVhVe0qB
         8nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zM1LIB9mEaNWRIyx5CUYi/bUE6U9z8snfaBDf2sH6g=;
        b=Fg5Iy3xjaOYzA8in1qwOvcWAeCmw0ANNuB/9iALCDJ4J/7rxNnczRUndB6W9wPw09G
         XKhkQ2Qdw4TEWgUTsXDcO7G6MQ4TVyYkr7h2PiyNGunIPpL1ObJk4kJikW0Xn0rADXRR
         IlIPrQfMkm5xjFpwV2Zjq/M//BenCp0KIBSK2Pnn93kxD2t0RGhTnnBANgKTzO40XE9q
         aUGWVKlgEgmU8pXXNxcPKMn0vnXoRW5dBxrgl18/iTYVnLpOutuOX/RjsCWNliUGafJo
         SI+GC0UvWsJD1JMlzeK+0jM6mH/rn0m8LkglGmECkfudhXombADZNS6DfxRT7XKSMDTV
         kKlQ==
X-Gm-Message-State: APjAAAWDgTJXybNM8lUpREKQgPccNLGG0h7oYfC0Am3W7eyRn5dT9JDM
        BYRUMZCTljAQSI9k0KfRZrv3IpnfbvEoAE9tzW/9uron
X-Google-Smtp-Source: APXvYqwgUP1DSPg7dEiOzDNWgUvay2NuWodBFJo972YhV16CKuOwCOKOZ2+AyavTofud4aGnRCs4zL6EGRzJ88ViqNU=
X-Received: by 2002:ab0:252:: with SMTP id 76mr11360818uas.32.1573899720585;
 Sat, 16 Nov 2019 02:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20191114182346.22675-1-oshpigelman@habana.ai> <20191114182346.22675-8-oshpigelman@habana.ai>
In-Reply-To: <20191114182346.22675-8-oshpigelman@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 16 Nov 2019 12:21:34 +0200
Message-ID: <CAFCwf102yW=5e=3t+ho5Hxboa2LkqrjtZTZ6KAP7v+TT=82KZw@mail.gmail.com>
Subject: Re: [PATCH 8/8] habanalabs: remove unnecessary checks
To:     Omer Shpigelman <oshpigelman@habana.ai>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 8:24 PM Omer Shpigelman <oshpigelman@habana.ai> wrote:
>
> Now that the VA block free list is not updated on context close in order
> to optimize this flow, no need in the sanity checks of the list contents
> as these will fail for sure.
> In addition, remove the "context closing with VA in use" print during hard
> reset as this situation is a side effect of the failure that caused the
> hard reset.
>
> Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
> ---
>  drivers/misc/habanalabs/memory.c | 40 +++++++-------------------------
>  1 file changed, 9 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> index fa9462ee9d6f..b009ac4c62c0 100644
> --- a/drivers/misc/habanalabs/memory.c
> +++ b/drivers/misc/habanalabs/memory.c
> @@ -544,7 +544,6 @@ static u64 get_va_block(struct hl_device *hdev,
>                 /* calc the first possible aligned addr */
>                 valid_start = va_block->start;
>
> -
>                 if (valid_start & (page_size - 1)) {
>                         valid_start &= page_mask;
>                         valid_start += page_size;
> @@ -1589,43 +1588,16 @@ int hl_vm_ctx_init(struct hl_ctx *ctx)
>   * @hdev                : pointer to the habanalabs structure
>   * va_range             : pointer to virtual addresses range
>   *
> - * This function initializes the following:
> - * - Checks that the given range contains the whole initial range
> + * This function does the following:
>   * - Frees the virtual addresses block list and its lock
>   */
>  static void hl_va_range_fini(struct hl_device *hdev,
>                 struct hl_va_range *va_range)
>  {
> -       struct hl_vm_va_block *va_block;
> -
> -       if (list_empty(&va_range->list)) {
> -               dev_warn(hdev->dev,
> -                               "va list should not be empty on cleanup!\n");
> -               goto out;
> -       }
> -
> -       if (!list_is_singular(&va_range->list)) {
> -               dev_warn(hdev->dev,
> -                       "va list should not contain multiple blocks on cleanup!\n");
> -               goto free_va_list;
> -       }
> -
> -       va_block = list_first_entry(&va_range->list, typeof(*va_block), node);
> -
> -       if (va_block->start != va_range->start_addr ||
> -               va_block->end != va_range->end_addr) {
> -               dev_warn(hdev->dev,
> -                       "wrong va block on cleanup, from 0x%llx to 0x%llx\n",
> -                               va_block->start, va_block->end);
> -               goto free_va_list;
> -       }
> -
> -free_va_list:
>         mutex_lock(&va_range->lock);
>         clear_va_list_locked(hdev, &va_range->list);
>         mutex_unlock(&va_range->lock);
>
> -out:
>         mutex_destroy(&va_range->lock);
>  }
>
> @@ -1660,8 +1632,14 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
>
>         hl_debugfs_remove_ctx_mem_hash(hdev, ctx);
>
> -       if (!hash_empty(ctx->mem_hash))
> -               dev_notice(hdev->dev, "ctx is freed while it has va in use\n");
> +       /*
> +        * Clearly something went wrong on hard reset so no point in printing
> +        * another side effect error
> +        */
> +       if (!hdev->hard_reset_pending && !hash_empty(ctx->mem_hash))
> +               dev_notice(hdev->dev,
> +                               "ctx %d is freed while it has va in use\n",
> +                               ctx->asid);
>
>         hash_for_each_safe(ctx->mem_hash, i, tmp_node, hnode, node) {
>                 dev_dbg(hdev->dev,
> --
> 2.17.1
>
This patch-set is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
