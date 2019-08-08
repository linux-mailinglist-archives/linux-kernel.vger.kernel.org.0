Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B048385BA4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388830AbfHHHck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 03:32:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38523 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731481AbfHHHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:32:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id s15so1342343wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 00:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rwsTN4PYWZDSBim2xfgbKTZBPcn1iO8XAT+A7X4RpJo=;
        b=Be3yljt2cUiFHhsA46esH7ke5SsW+gtpmpgBh4WrM0SnU0MsEG7+m40YcUB0Q8wFSc
         I5Zr6JDEfBUk8/vAZP19J2+MirRs3cbd1sIv9k1YXqYegmF+2Ft1JyJLxCRbQV2tH4n+
         VOvX3ohX4cogwB4NqpaGDG68gM17zp4kcnxtVfdZXLyoOycYq8PPp0s7vR0UET0PoVD4
         4y3q34HOeAWLzsx87yl6GHk4PXy5zBLXtQl53i3I4YmCZE50bKuZb0qjrAL/7R/aOFq/
         i04NBEE1lRBSM8f6uXk2KOdTqBr3wd5RHZj7CqLEekAzHDoVrTeR6vtcALmPVFaDXpnw
         f3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rwsTN4PYWZDSBim2xfgbKTZBPcn1iO8XAT+A7X4RpJo=;
        b=nw8o9ZxFQFWE2wHknGG+CvsLZf+RaE5PpG58kvwXvkr3jINKPpLQE0q9gJlegEDp6d
         8Pq7crmkB7urc20yythyTHRh6GqGhAegckg6lbQkKkTyJnnEPtpR7TeLa0oc7RPI6eqP
         djHWlxD2YnQHaa3OgNr3zZtFmtYitVD/N+S350L4W/noXao1NGzYpwWzTccNEm08cadL
         JaZA9wqhYFe5rNs4MOkmeXYdu4bRV6rrwXAerdzvCg9gZTmo9PTYUZ+1tiXZrPS9FSNr
         JdeVO85SDE4cZ59L+/mmdrVXZfV4NyzvNgreFmU0ktH6hQhVrcKyZd4o0SVV8SAeAItq
         6sEg==
X-Gm-Message-State: APjAAAW2rdR/OwpY1GIBmqwd4cTgLydt3drVjV2tw/2Ez49hrK636LQW
        XGpHDwbWGw3XEtLlPMvmxP4Hn7gvvyY=
X-Google-Smtp-Source: APXvYqzPnEJf3wzVF1oCKQHzErCA0BUxeZXArLH/0A2RVb7eYUOfGySo/SZcBJyarxcfrQhrzxrvFg==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr2697473wmj.116.1565249557789;
        Thu, 08 Aug 2019 00:32:37 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id k63sm1840106wmb.2.2019.08.08.00.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 00:32:37 -0700 (PDT)
Date:   Thu, 8 Aug 2019 08:32:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] mfd: ab8500: no need to check return value of
 debugfs_create functions
Message-ID: <20190808073235.GL4739@dell>
References: <20190706164722.18766-1-gregkh@linuxfoundation.org>
 <20190706164722.18766-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190706164722.18766-2-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jul 2019, Greg Kroah-Hartman wrote:

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/mfd/ab8500-debugfs.c | 324 +++++++++++------------------------
>  1 file changed, 98 insertions(+), 226 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
