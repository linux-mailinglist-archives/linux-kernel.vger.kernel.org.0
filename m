Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACA115D547
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 11:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgBNKNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 05:13:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41426 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbgBNKNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:13:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id h23so10084721ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 02:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3tXYzXJf9WQqBcYnKun85sSjeLfeLQddcA1VRNXGUI=;
        b=rMHSSluMq+/fmj0gS+7HK9GqzPTRS5cIqMuT/aeLUosx/prlamTiybRglZTU0bKEuY
         YY1sy6z+ojZp/+MK41EUCrm3kE69PnzioVp8aKhLBO8T/iEtAaHiGvZUH04C7v7rH28v
         wg4NebM9EA5A4StHuDb3skiiShtBC6j8XVibUJ+kJ21boE6G89RdtSW4Srm8oQdL4XeZ
         L/6ZYyjhBb2NrDeU7dBvAJu2pLvoXntbXuvif3llDyNdWGtFrP1mAM/bwjkT71W5bEc9
         qOs511l7xVxnX8wcitMZMVc6ul6/6yM7Jb1Av2PyUJ/LjS7UK4oJMzoVDQLzlx0ZqF3U
         l/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3tXYzXJf9WQqBcYnKun85sSjeLfeLQddcA1VRNXGUI=;
        b=qiQSqgB/ZclBgmogh6FMtIGS8O+hCRavzOP9Pu46K5KUH28n9phvXyQaqE69lZvJnX
         J8PdYu8vGh9LQ/TDxkQqDLUkWGtC+uPmhPe717vgoAwN+PzVNiqhfHgo9/sQHauqz+LM
         Lrh5to90NsYmvxZUw/OqsT0Mqq6LZkbwa3qC+qLyMtJ+y+sVD63IuUK8NAgPZ3wE+9kC
         lM2xJfVW0bPzyVJJxcAri7O+LT0+cqfMbnlLSMwuEfnjJk32aYf8kzhk4I1eDxUp3SRL
         YGvCPSQVzfT6XL4CtDLWWtF/+Xu5qSzqeeD3Imm1zbJmXQ9zg/+z5wDBnhH1FYyZmag3
         c44A==
X-Gm-Message-State: APjAAAWB5/hK9ZvYW7koeEoTj915kjJspaMOSSBljQ75kqFUHzIHIWhw
        vjjo/1YLgKUvbEVz7pfBaMNven3kBz7DGaMPuQarfA==
X-Google-Smtp-Source: APXvYqx+B23+vB8r/W3uqemgLRaTP5b8JPziVCWplLFBhl6/3Fu3/KIPPm/sHRABNZytc0yt0PBL5NmvIO2i5MJfcjI=
X-Received: by 2002:a05:651c:1bb:: with SMTP id c27mr1675173ljn.277.1581675198245;
 Fri, 14 Feb 2020 02:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be> <20200121103722.1781-18-geert+renesas@glider.be>
In-Reply-To: <20200121103722.1781-18-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Feb 2020 11:13:07 +0100
Message-ID: <CACRpkdZuxONgGJy73j=+LVhMXAnzQQDD5OLOjYGF5UQ-X_PfpQ@mail.gmail.com>
Subject: Re: [PATCH 18/20] ARM: realview: Drop unneeded select of
 multi-platform features
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 11:37 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Support for ARM Ltd. RealView systems depends on ARCH_MULTIPLATFORM,
> which selects USE_OF.
> Support for ARMv6 and ARMv7 variants depends on ARCH_MULTI_V6 or
> ARCH_MULTI_V7, which both select ARCH_MULTI_V6_V7 and thus
> MIGHT_HAVE_CACHE_L2X0.
> Support for ARMv7 variants depends on ARCH_MULTI_V7, which selects
> HAVE_SMP.
> Hence there is no need for the affected RealView-specific symbols to
> select any of them.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Patch applied!

Yours,
Linus Walleij
