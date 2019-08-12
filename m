Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2437D8981B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 09:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfHLHqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 03:46:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36506 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfHLHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:46:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so9961800wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pF4284ljIpOIN4c9ccgmnPIqD9kFvCl5hZxDK0Wkthk=;
        b=BrsNzy1KZefPJTH3mpVu7jgmCf4KUcGGiMgdGEsrNl4LeQbEtCEBrm7vIZDRApgXRO
         7sqIA+3G0KS7fzdoqt7yTtO7beSe8pwqmQdq+OcYtPxAHaWCvJmZpFn6xNCk2hRjC4NK
         qLxJHrXVgyi8YAywOEV06C/kGEnwthd2bkZ+egENDbUq/sesYm2Mi+T3tUVcz+m+02Lk
         tlQM4bTUrIvSrYuloUuaLM5cCSscdBfFSV/jSjhPHzSYKoIUbY+MMv4O4TIo/101ghQW
         r0NTOxNCtUjYmXaDQ+IksgMCLBYh8tvPER8Vx+nymcl7X4OJNvADz5gbSnuj5itR0Bpk
         Ja9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pF4284ljIpOIN4c9ccgmnPIqD9kFvCl5hZxDK0Wkthk=;
        b=H3Lc1HueCJUihYVSQ89YtZd9U+TZ1bsdnD8nbmC/VOW7wNSCWQIQ2UOT43w5NhWW5p
         ZH0JHr7+X78yqZSdYn/Ncm5zXvdLc01mr7iL3P1i3wv6ka+zJkbCqfDuMXpGyrxWTOpi
         GGZbuzso5FYZYJzEc9ERhA/svjH3yHiLUcKpnQJuFRZpK1/AGIAFd8u3Ksmqq6Gy7t3V
         SFDmRphB9YHN9RXSlxlPhrPbdpZTyOjor6M8IAMjtPzdHGBiPRxQhRP/6mWks1cEYq93
         Ev7yktYBbudCOt5/x1GRrAcEYCLNPoQ/QvoznVdO3ffDHL0oDWp3uHJ0vxMzyY59XXxy
         +mYQ==
X-Gm-Message-State: APjAAAXaTFqQ4tV20vvt850fiQBFeLSSDwzGtklqTVwtLISRBC+hdtDb
        /OzNnqt9uceK/L5KGfJvrxd8Dg==
X-Google-Smtp-Source: APXvYqzQRCtrNfzLc5YRiY6nl1YVaDaXWjUXk+X2aze9RrH51BJIP0Tq2x0MEoVal6soUT9WY5Rxqg==
X-Received: by 2002:adf:a1de:: with SMTP id v30mr3913854wrv.138.1565596000190;
        Mon, 12 Aug 2019 00:46:40 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id u186sm24144588wmu.26.2019.08.12.00.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:46:39 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:46:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] mfd: 88pm800: convert to i2c_new_dummy_device
Message-ID: <20190812074638.GS4594@dell>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722172623.4166-2-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019, Wolfram Sang wrote:

> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.
> 
>  drivers/mfd/88pm800.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
