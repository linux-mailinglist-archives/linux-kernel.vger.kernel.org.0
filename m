Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5125855115
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 16:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbfFYOHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 10:07:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34323 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfFYOHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:07:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so16452517ljg.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24XJTrHa0Yc4s3sKxxyNRNMHk8lPxt030dDP8xPw5N4=;
        b=dBTA9gXzvS9VHnSTxJ5VXq8BgDgH6lEyEC2arXbYVK3n3XqvVQxKWCN0aZsPBo7dNb
         NDF6mOHe5LhwpJp06hWsnvYcL6kDXe7UOikKtHyR3zJr6c8uDR3bW9CEJjbwSMqB9Mt5
         LuXHubjT/cdVNrbJHgjGvpV1HB82R5cvlHQ60TwKD77obG/HNRbkSByaGpwJFz5TnINr
         HLEK0cRLiOvK/8pvjvW2zGYDslsRXV0MmQkXndzpPlAtDceFvMD/dgrEU5rDSMLVAgXy
         g0Q6tT5nnF/hsp1ONNrpUiYScx47fPgEFw4n7+oMQkHkQAnPt3kpMz6KIU3p8M6g7xHZ
         /LIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24XJTrHa0Yc4s3sKxxyNRNMHk8lPxt030dDP8xPw5N4=;
        b=Gm4guZOlRQ/s/W3pAZBt1VmUCxGQbKEtXL7SsS2lf3kDvbaPqm63RemqFlxFw1DDFU
         W5qXYvOb/YGKLe9rCspZhQ54Pd6A3ucKMcwmKgJ9gQLcc/zPDlpIWmRsfB9FnNAICIlN
         vCE9vn8aZOpS8soL9PSHhGB54NgK5QXDiYi64zeDRFQoz4yPpeJJvwKZVBHqmU4AlGfb
         dCeBw4MNGvUck0+RKMYcWT7reKFxEE0legqfBhOXIbQhfZOQEdTsDjP0RRhNQ3GUpgiC
         USbdodMxdvmQbAOv1bk2OegC7Re+v8oErEjviCEiD8T+YGWhMj7JaS7sDHatcCh5Cb7S
         ylbA==
X-Gm-Message-State: APjAAAXMSTQEaOD88o7j2Bsl+14OdwxcKsdGj71g5HO+Y/40RxQbIY6E
        TweBYceYC5RL6mcTKKt6WNwU6E8UPjFpyvhjWFR6oQ==
X-Google-Smtp-Source: APXvYqyjrDxpNXoWoBRzWyreU6t0oFZefNmzaDjlnTXV6ya4jhyfq+7zm2Vv8USOB8y4emzxmQG1awzZwLIh1cr2/8E=
X-Received: by 2002:a2e:a0d5:: with SMTP id f21mr52627090ljm.69.1561471662514;
 Tue, 25 Jun 2019 07:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190621202043.95967-1-natechancellor@gmail.com>
In-Reply-To: <20190621202043.95967-1-natechancellor@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 16:07:30 +0200
Message-ID: <CACRpkdZFvNNodNas2hQ-4iuS-UgHapMR-Y8f715Hbj_PH04iRQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: sdm845: Fix CONFIG preprocessor guard
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 10:21 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:

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

Patch applied with the ACKs.
I'm sure Bjorn doesn't mind.

Yours,
Linus Walleij
