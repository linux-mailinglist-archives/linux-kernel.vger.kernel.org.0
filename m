Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 245C24F012
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 22:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfFUUl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 16:41:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40748 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfFUUl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 16:41:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so3896575pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qWTzX9MzfA/u/Gk1JqbnxD3tgG+hmJryjHkJZCkg4lo=;
        b=i8wirE+YGtYSRJmDmz8NIGPbUbZZ6wAIROs728P47J0H9VjwSXA/3ZaK1kHUfvim2g
         Pl/Ngf6h6PtfVhN4xm/uXfyB8VVE77ARKZjsW08DzeSjU8WMA4Rjl98IijSoo6l05l88
         0w8pIcHaXP3YfbGwN4BeR6z1e0aKeC0KdQpgckdWOkfDYoOwT1F0+RRCmOP5jmiC5y22
         ko3yZSOy8WzY6nzCVR87nDMUwl4qQKMY8i+5ujYLw1V55cxSXCygR9qt2WsUvr0Umtja
         osAdTZ4eWgntYxLCo4Bg4vr3uRtnGlusW6RYE9BWN70NSoCdWZW4yrp/piccIgRmkauO
         EXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qWTzX9MzfA/u/Gk1JqbnxD3tgG+hmJryjHkJZCkg4lo=;
        b=lM7nmqP5EX+Zo+Gd26F/R+jLwnjwkKb6UwZNAdR2SEP9VSnXy3PgK7Nvric/m/QOzA
         6rGwVGBbFtwMnchA2q93th63mj2BkwjyEhYGWmJZx7AT8rNR9k05K7QiwtWYASsapfko
         l8jgS20/wUyU2zhhH3z1bJ/G/epaItdnctpHoaYrQx87rDo/jggswJL25CYoYlk7ZVm9
         jSdWwNukOpz09kBvoK4IfDuX4T3TeGtfPvdQ1z7b3JwKDNsEhaCdE5BBylHyAo9c+y3G
         E0uZoTrA54QVy6+vzAUeg3UbQLayn6Y2EKxcnVtVFE40SWx7UpkZKunSZe/pOOuPOlz0
         Pe3A==
X-Gm-Message-State: APjAAAX7re/LOSvps6atcWGEL8vFTSMQPcU/OnBuyB4i1v4dZpMCbZe5
        VGMQJWtCiuCuTZpdg6WgQ91yd7+xPkMwXJ5fofSlfQ==
X-Google-Smtp-Source: APXvYqyq342BLmVtOIG4HSACeRf6++pMT1eaBYTIF0JERgZ6y5GX/QPX/sXUFSF3ypMufH5vBQuKkqpCHhihV8Twza4=
X-Received: by 2002:a17:90a:bf02:: with SMTP id c2mr9075257pjs.73.1561149688206;
 Fri, 21 Jun 2019 13:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190621202043.95967-1-natechancellor@gmail.com>
In-Reply-To: <20190621202043.95967-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Jun 2019 13:41:17 -0700
Message-ID: <CAKwvOdnP+XMn4BMHRcFeO=TCLxjhKk5NBrpmSyZnsAtwFj+gTw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sdm845: Fix CONFIG preprocessor guard
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 1:21 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns when CONFIG_ACPI is unset:
>
>  drivers/pinctrl/qcom/pinctrl-sdm845.c:1320:5: warning: 'CONFIG_ACPI' is
>  not defined, evaluates to 0 [-Wundef]
>  #if CONFIG_ACPI
>      ^
>  1 warning generated.
>
> Use ifdef instead of if to resolve this.
>
> Fixes: a229105d7a1e ("pinctrl: qcom: sdm845: Provide ACPI support")
> Link: https://github.com/ClangBuiltLinux/linux/issues/569
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/pinctrl/qcom/pinctrl-sdm845.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> index 06790e5ece6c..39f498c09906 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> @@ -1317,7 +1317,7 @@ static int sdm845_pinctrl_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> -#if CONFIG_ACPI
> +#ifdef CONFIG_ACPI

Thanks,
~Nick Desaulniers
