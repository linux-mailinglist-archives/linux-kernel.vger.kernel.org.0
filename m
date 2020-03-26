Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3A0194627
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 19:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCZSLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 14:11:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41091 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 14:11:43 -0400
Received: by mail-ot1-f67.google.com with SMTP id f52so6868482otf.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 11:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YhlPOmXcGnG8hY5/n4Rc4Ud1PlJc6DCiH3w8bH9jgA=;
        b=juuAq0BVbd9bZbja9OFkt7uNZXVWqyGIDfbiA3QRhbibaBlkPutZInslij8oo0cC0t
         ywFcJzot4Q3vZj5qBfeu58YWsGT/mzOPj8rSzcOfv6vvSMJqh22XMu96Zmo0WkQvHDG6
         TqdSLzSm9UmHL0hJB6GxoatccMY3Ds5gvfmFdXRhl7ZGW+W5ZVSGv2zNSHYok8x8hZfw
         Tmv/MBNch+h93NadU3AF4FafTacqqnVsgNj762ZXGc3xXvk8I7hwMvPK8Hr8KZy+x1/V
         jSx3HBBtEPwU7QEGj70SpMHfqO6rsFKFuDuUvYJXSwfSjkmiRJmBHAdMNMbH3etGoyLM
         VWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YhlPOmXcGnG8hY5/n4Rc4Ud1PlJc6DCiH3w8bH9jgA=;
        b=qbutjE9FAplAONe8zxxtM5EOFMsWsdbXNLFCrQO2yx2W2n9Lb7UFeRY21QjVTG1glI
         RLK+HBUGUpjyGF7sJS/4E5WlfGCyo+QOU5xfUEN+5e3KWQMrGLQ+NFqFVFTxl3t/PnS1
         JnpmlEeFw9+B5X8DisiLInNSm/a5Mm+3Jz3XhIxMUxWV1iPYiKdozWqYkhOsW738GavE
         Ey4RdXRcNzbM9J6xOCzo+T4AEtLXWKqv9QtT3sqHEqmxog8YlaIYfEd60KKwggftrWEa
         hDo4LuyvkJ+PLnL4arMd3DK5ky1vVxNm/ywgWjlAqs12KlpXpraTKK+OvSdYxIrtkxSA
         yWOg==
X-Gm-Message-State: ANhLgQ3Sb7yvV0d7QzVh9RWh3c/8SNpHEryNa/6LzZ4Cm3VlFTP4z6lH
        g6rvnzCt+CKjtczbCqDO7H44hCVvvVBu/HpE1R65xQ==
X-Google-Smtp-Source: ADFU+vtnsrY0SvGGuyhyEDxG4HlKNc11UYt2YYt5XneIx9ZfoBUvmFOwrbpnjLWdDdtsGrZaES/vzsQyDppgAcomc0E=
X-Received: by 2002:a4a:e217:: with SMTP id b23mr5959513oot.91.1585246302559;
 Thu, 26 Mar 2020 11:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200326172457.205493-1-saravanak@google.com>
In-Reply-To: <20200326172457.205493-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 26 Mar 2020 11:11:06 -0700
Message-ID: <CAGETcx8YWthXcUrs8ii=O_MO8pepjpwcqzCshe0Dd8uhUUL79A@mail.gmail.com>
Subject: Re: [PATCH v2] slimbus: core: Set fwnode for a device when setting of_node
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:25 AM Saravana Kannan <saravanak@google.com> wrote:
>
> When setting the of_node for a newly created device, also set the
> fwnode. This allows fw_devlink feature to work for slimbus devices.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/slimbus/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index 526e3215d8fe..44228a5b246d 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -163,8 +163,10 @@ static int slim_add_device(struct slim_controller *ctrl,
>         INIT_LIST_HEAD(&sbdev->stream_list);
>         spin_lock_init(&sbdev->stream_list_lock);
>
> -       if (node)
> +       if (node) {
>                 sbdev->dev.of_node = of_node_get(node);
> +               sbdev->dev.fwnode = of_fwnode_handle(node);
> +       }
>
>         dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
>                                   sbdev->e_addr.manf_id,
> --

Hi Srinivas,

Btw, I sent another patch that's on top of this patch.
https://lore.kernel.org/lkml/20200326173457.29233-1-saravanak@google.com/T/#u

That fixes of_node_get() handling. Didn't notice it before I sent this
patch. Otherwise would have made it a series. Sorry about the trouble.

Thanks,
Saravana
