Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F310C880
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 13:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfK1MS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 07:18:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44056 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfK1MS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:18:28 -0500
Received: by mail-lf1-f68.google.com with SMTP id v201so18858941lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 04:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9HaPIwDGWIORg/ZtcvZAIKmu4aZIOqFrtCVzv15Uo8=;
        b=P9He/jdZelhAF63c66JOtESkD9SWLHGoK4fcKXecnAKf5ycE/xInVMP5Id/tMj3hH6
         Eot7YcHkj6OIenHQPCoyPdDUMMGen9pcS+VlrkT4DTKC4AybqCnhpzdjooSoRj7PVtHV
         ECHxDrBKPIoRWVvwdJu+FH9TbmcBCA7YyDG2L2Rcfld6g7X6DH1nXRnyvIXtipPtyGu0
         OIJUACG6vpMSL4VRwwpCnhSEGh97UwtAOzcrV90ler+nsjpdHlOmdo40cQk2SkGDsGG4
         D5C017GmYOZtYttdL71Ygqefe9MCirKwDf1Htcj8o/01X5bZAL7OZv4XkVAUxYzWfgqa
         Z9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9HaPIwDGWIORg/ZtcvZAIKmu4aZIOqFrtCVzv15Uo8=;
        b=k9ahunAGZnOfktCt4DkAnN5oGJD8NtgL0lHe039soUWD3G1B71w9n2kT+IZmn2HtYU
         0B0ug7WlE7BG9rs42qtwZ0q/yFVBNVBKo7pGmBSOzSvz+8OHsjLzE1aR81iJhu1uya9l
         yJOQFMlGAsfvGu0Kx6XHVwlYwaUU8aUTYealjT34cjPkIF32Z5j183BjfxKyll2jR7bL
         F1gqcMxwyJfHNQlWXm/Nvn91FTscjww7aiqgdFysa2amsgC/q9JELGg1TgLfF8EbNtDk
         sA16qkh/HpWziKnyv6QsUY57igGj68klL+1+g34BdATPHdaMnGuERbU3U9ZsSQgUJBkI
         Zvlw==
X-Gm-Message-State: APjAAAX1mEcPohde9kBeefqeGSMww74Mb9jpCHafIFJ3tn5WMqZ72Fb5
        YNMv2M1Q63A/K0DJ4+san24anH4VEptGAVo21ZL7QA==
X-Google-Smtp-Source: APXvYqwfcdHhm4gyrSY0PXoqGz1WH61ou574arqZCBcFKymILHOQyJwQZjM0A1Ke/HyiK4TldEM2Asch76SNuXwaHnE=
X-Received: by 2002:a19:645b:: with SMTP id b27mr21863272lfj.117.1574943505250;
 Thu, 28 Nov 2019 04:18:25 -0800 (PST)
MIME-Version: 1.0
References: <1574661437-28486-1-git-send-email-yash.shah@sifive.com> <1574661437-28486-5-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1574661437-28486-5-git-send-email-yash.shah@sifive.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 13:18:13 +0100
Message-ID: <CACRpkdZt53578c3tWFodq6-HwNzc+gp6mc-n-8-GKkGyy61JKQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] gpio: sifive: Add DT documentation for SiFive GPIO
To:     Yash Shah <yash.shah@sifive.com>
Cc:     "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
        "atish.patra@wdc.com" <atish.patra@wdc.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 6:58 AM Yash Shah <yash.shah@sifive.com> wrote:

> DT json-schema for GPIO controller added.
>
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Compatible string update]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
