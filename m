Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96813106725
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 08:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKVHie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 02:38:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34734 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfKVHid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 02:38:33 -0500
Received: by mail-lf1-f68.google.com with SMTP id l28so4775270lfj.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 23:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M73k0z7olr1IHrpftsQ3B7KfGCsjFAsCvNuWEozTB74=;
        b=pl1h98jg8j3mIJIWsfoGSLKK0LpyPFxOe4GjytdLoia19qqtoINC62IkV9XQzCvd6A
         iZSWTHwhfQOyeGhaskq6c6nTMrRRtr3kCaBElwtwfB6iCElo2DMoa3GivOSfgbhGdnpH
         A0HQIS/MV1UgpciecPdzcKw234QiaN6kxttZhbNID13MqWfxq/JP0jBNQ3wyGCvB5piu
         2Codjpz98ua+8kpwIwopE5MW5FSovaVeB4FARLlyEVp7Ziwm3zCXyvQmBFMBfUJjtE70
         mTaw7pL1Duz7o7cpa3eEZtqGpIK/KvR0ou4fSP9OwsjmDSgXejaivfu0zX5Rz7tkmJl1
         kH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M73k0z7olr1IHrpftsQ3B7KfGCsjFAsCvNuWEozTB74=;
        b=dCiKuzqpsByQeny+wBPGWbia4w2AYgoSqG/HJFkVqf1yg9b9Xqhmy0uDQXL+EZH1TT
         MS4YY6Y7OQFfy9RdeTj9fNgtpoprF+VOgmMCpgNosFXiiITIlFR/4BDboy8KYzV4HmPF
         ZN66OXM8s5ggau+6BdvNZ6LfLtjO5EiF8pQY93kkY8Q85xnUKlD/S8xiMzQ3O7y/CU8P
         z4velm2Zfs7suP9TqnSEPdP6lMmil2PjqwPoQToEDORmE9cTv1P3Sr/H5ohQlBk85zOA
         vwnUYxYXpyOiFHafSwpEc+CrJHWtHvI49JHfyEdKwuFplBEUOycAsqy6Xyb/A0I8scdc
         vRzw==
X-Gm-Message-State: APjAAAXuKc7QFeMWowSvO3EscG1i+snRjeeQhDaWLfGrUt118JqVOL+n
        gSXNR4aOj5NC35zr/FeeLtsrL5lkI0V4rRyr2HQxfBCbFRE=
X-Google-Smtp-Source: APXvYqzMwCH/8/vy4szi4eTRh89ioCf9vV4Bs7jjblxQccv58GQ1TGH3HybDuIKRrqhlMjtxMZ95MNChFl4Y6uofITc=
X-Received: by 2002:a19:645b:: with SMTP id b27mr850294lfj.117.1574408310889;
 Thu, 21 Nov 2019 23:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20191120071302.227777-1-saravanak@google.com>
In-Reply-To: <20191120071302.227777-1-saravanak@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Nov 2019 08:38:19 +0100
Message-ID: <CACRpkdY-cQGK-Q+LLboa3E+0G=251PhMR5xDX2ZUY5-hPVL-9g@mail.gmail.com>
Subject: Re: [PATCH] of: property: Add device link support for
 interrupt-parent, dmas and -gpio(s)
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vinod Koul <vkoul@kernel.org>, kernel-team@android.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 8:13 AM Saravana Kannan <saravanak@google.com> wrote:

> Add support for creating device links out of more DT properties.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

This looks to me like doing the right thing and making sure that
the GPIO drivers get probed before their consumers and thus
speed up boot.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I guess I should get on with adding device links at runtime
as well, both for GPIO and pin control so that things work
with runtime-added devices and boardfiles and ACPI, if I
understand correctly it's fine to add the same link twice, it
will just be ignored?

Yours,
Linus Walleij
