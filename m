Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713B716F9F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 09:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBZIuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 03:50:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40351 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgBZIuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:50:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so2039758wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 00:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MKIikjrWAh3ZaV9e3QCweJwY98iejyVof89XU+edArg=;
        b=LJ2xH127sLByQfhY8qMhzSJKbksxahprKmbpdqbGXuyF2vLbOLko8jIkVSDtmk1YdO
         ziJzMdASMxG92+V0rrM7ujqymd+ESwXcm9tL1/h4PkQn8MalTwPEYjkQUXC3XsAIospc
         R7ectLOaxHMnGvvIZClfsA5wFhDFZWhCf7FAino9V7frY8G6Gldxay72X8pBNaHqNujv
         yVtvhNDy+lWlC7btU1HOXWxelk4p4nVwkctO9zELLr9HUektZFhSNt24FtzCNhKvfIPN
         QmyFUJrvFrYw0FMScekIzWgRTpO+JTM+/panRDL/JfMVdHdOphJjV6+Y2g6PdaNqvYXn
         D1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MKIikjrWAh3ZaV9e3QCweJwY98iejyVof89XU+edArg=;
        b=QDztAt4uA6+YTvC1j0g0rJ5MWjK/gf98TsUQ3OaW3RLdtZ8kte5hickmEehotbJjoP
         LhLIJTWpD23KA/5gxZ0mVPQjB15iHxtR1NXDR38BDHYEpL+xjQ+Lm/bXqJUAlM6jAmlO
         mahI/0hemVwwMKcn+gKeT7VLnY32LvK67qeLee2lEKCPt98on5agssey8ntJpIHnxvNr
         w6n9Q01fvoboqi+ipLLto/FO+UPFqKfbnpuqeB4az9jMLPGOEPYXk3vT+DBQp0+1aGYm
         3oYxafWiveoCGPC8L6BndtOMzfJwDYqld2TGF1TZFXHsOP0/noOJKE9jL0nopxgCHSi9
         fMtw==
X-Gm-Message-State: APjAAAUzOAxTMtyOA90RWJ20/d6cidRX+WSXr2mr4I8+h5vWUYJAeyGL
        To4c3OQn+DLrzBjRa1TqSmzm5kVUooU=
X-Google-Smtp-Source: APXvYqwCMu9qr2wKXq3e691TQhkDU5ouUWhrZXDRHQ0q4u5BCo8qYjvw+H3G8dgzdD919pA3Cuv0ow==
X-Received: by 2002:a1c:e388:: with SMTP id a130mr4137687wmh.176.1582707037240;
        Wed, 26 Feb 2020 00:50:37 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id b11sm2428996wrx.89.2020.02.26.00.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:50:36 -0800 (PST)
Date:   Wed, 26 Feb 2020 08:51:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     tony@atomide.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] mfd: omap: remove useless cast for driver.name
Message-ID: <20200226085108.GC3494@dell>
References: <1582056541-16973-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582056541-16973-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020, Corentin Labbe wrote:

> device_driver name is const char pointer, so it not useful to cast
> xx_driver_name (which is already const char).
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  drivers/mfd/omap-usb-host.c | 2 +-
>  drivers/mfd/omap-usb-tll.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
