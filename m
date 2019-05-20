Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECF123F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 19:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404007AbfETRi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 13:38:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38389 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389971AbfETRiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:38:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id s19so13772976otq.5;
        Mon, 20 May 2019 10:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6+CTVKBQs3Qj1KZuVZhRpvI2ElGfiLdvO9SBHsRRR4=;
        b=Emn9AT328NF3cmC1iuXJyjI8jhIp44Nr/nGjaQMHzXGLQcs0C4w6xX8XhMyD9tex9I
         PKmw0Ew3y6qIX/Kzs1pYJf5uhYmA39g3WMr31pBc72PX/YdWDEGUwysxyWFzIklVGtl5
         RKHCHFuT0DaY4mwTZry6Gn5A+orMbXaNTSzVxz5euJhu9NFvuPWLHdh+wlotMqARc4sK
         ZhOGLwQ/deEbN6rkGellDZMXxbSEVme4RbKb/JvzEgvDhQibsDwuxrcwkPUBHeoWBXjJ
         bD3KWbZdiRGrBk2qPIi0ff02XN8hEG0Ak499Kxue0UX7XyzsnwChk9Hz31MCY2F3Smdi
         sW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6+CTVKBQs3Qj1KZuVZhRpvI2ElGfiLdvO9SBHsRRR4=;
        b=CJ3YsLjGpi/lPNLnV9+niDz2M/aYz3KryuDVvcXWqNmAYXjRGUfHL3nNz/AYETlkbA
         O42jG7EJcLby5GJBxlN4fIFOBG47f1gHKvrwrN3Djf4ExHe3t6UnGy1W3c4v5gmWhKrI
         wHCgGxnU+WraIE8ip1NSjXaSVuXcSpkVTFPlqCoortJjD74CtlAO7cPrHMimfXcZbMAq
         E3l421MLwOntoNF0so+F2LNRUGdvGUXskVJyNny8F7MAtmniIJI4lqmtLg+zAN+0lxlC
         KX+wKdmCR1dTjrNdiJo/Fq5I1wTvY0ed9+3GfqE+7CRB7qzSX4TryBazqRd/fdWhlBaY
         R7QQ==
X-Gm-Message-State: APjAAAV+uEEjGdmBUN2vr2zaMh7nydd8togbRWRU6uiVgPF7R9hMCLbW
        6UEFO+UFgdO4chq57e6Ilu0ypsHq+piOlv/JOys=
X-Google-Smtp-Source: APXvYqw7JjFH8JiPg4NhlniBsb8s7dSni3Mu/yHYGMyoIAluZi0RPsU9K4l+vLYJWVRWaMSaLhvc5u6eu4whddsx070=
X-Received: by 2002:a9d:69c8:: with SMTP id v8mr46402547oto.6.1558373935100;
 Mon, 20 May 2019 10:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190520131401.11804-1-jbrunet@baylibre.com> <20190520131401.11804-6-jbrunet@baylibre.com>
In-Reply-To: <20190520131401.11804-6-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 19:38:44 +0200
Message-ID: <CAFBinCBGEoWxvpNhy+uehEmP9c-0OW4DFR8_iGPZ7ggjdz5aWw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: meson: sei510: add network support
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 3:14 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Enable the network interface of the SEI510 which use the internal PHY.
>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
I don't have this board but it looks sane so:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
