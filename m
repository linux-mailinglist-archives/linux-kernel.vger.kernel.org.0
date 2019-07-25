Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32AAC74DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 14:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404431AbfGYMDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 08:03:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50523 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403965AbfGYMDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:03:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so44769378wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=a2+sOsgWrx36qe1x8C9svvY7JaGqNjqNzIEJPL4hVK4=;
        b=xpWn1o7SADbwKU5LwGzofSis8+8DO1l/Pp5j5CZoeN8Ojjuhu0QKt1uQcgnWd/2xPO
         cDjF/8+Fk8Tl3uChkXqC6FRNEIYpw43e7/19uc6VNSSQlkMx6cImC9UFbWAtHyPhtAXo
         cypq0D0VY+4YGz1BeQtSyqpXHnhsKYhHiup9Rvi7bM0LEyiZKBseNZEUKSisBLPEAfHI
         pYgHmG8+618G3kMR0z9pc29pKZgHQTUb8cpWZCMvcPSa8oP6726YdL/yo1XPMLCf+0Dy
         2w7RJnuCO268tAZd0aniBiN30TKqqII6ZUFLof/Rly7RiyqG1XwDVtbqdMwFb//ICMUi
         Tyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=a2+sOsgWrx36qe1x8C9svvY7JaGqNjqNzIEJPL4hVK4=;
        b=dME9uO3SfzghjyujZyCWssjBmvF1WshL5PDnXIOO0tged0/WyWLA1CzoZTtMMNK9qy
         rBwP/DVdJhKj6wrGe5ggTOXclfSPhq0h2spdKdlaLKcrK8j1ZIbhyZmy1rHbM96Y7mv2
         1te6EUvO+4ciQ0yJrPKCSJ6zQ4xJlwlM6jzsSgT1o/6woojuvzOLc1wpBHfp2gZe4tWd
         +TFofF8ptH5khPopOgKVSa/k5FiEP/gVjeUm/S6fAPY9L+Cfk4BZY1Y4Vf+S2d7fSBbj
         uz1wJY4BDMXsEH6qU4bonKnCGkC27DEIuEF3OWfZR92U7oX8PmMqROGixabV434NtDrv
         4cCA==
X-Gm-Message-State: APjAAAXJxFLTDjD67dRB4CYpPxHGvEbw0rRysJe2IehPA3JRfPpt5Zuu
        2p4Ej/ONkdZMWlAtn/LSzdu4fQ==
X-Google-Smtp-Source: APXvYqy06IfEf4ygTt/AioHbUFhn5OgB7G798lBjyZcdLUBXd6JqAfpUBbL703IdUrF3Nx1LmoKfWg==
X-Received: by 2002:a7b:c144:: with SMTP id z4mr82997947wmi.50.1564056180902;
        Thu, 25 Jul 2019 05:03:00 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id b8sm62938474wmh.46.2019.07.25.05.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 05:03:00 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:02:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tony Xie <tony.xie@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: rk808: mark pm functions __maybe_unused
Message-ID: <20190725120247.GC23883@dell>
References: <20190708125308.3778575-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190708125308.3778575-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jul 2019, Arnd Bergmann wrote:

> The newly added suspend/resume functions are only used if CONFIG_PM
> is enabled:
> 
> drivers/mfd/rk808.c:752:12: error: 'rk8xx_resume' defined but not used [-Werror=unused-function]
> drivers/mfd/rk808.c:732:12: error: 'rk8xx_suspend' defined but not used [-Werror=unused-function]
> 
> Mark them as __maybe_unused so the compiler can silently drop them
> when they are not needed.
> 
> Fixes: 586c1b4125b3 ("mfd: rk808: Add RK817 and RK809 support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/rk808.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
