Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5D5D5C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 09:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfJNH1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 03:27:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38180 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbfJNH13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 03:27:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id y18so8898024wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 00:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TWp5GZfXAuJiSjhN3OBoDFjXnsSknmpXMaB8oSLy2/g=;
        b=djTw1yvqaE4roQjMnJd2pe7/Kqo55OxZfnKi7PrNRYJCR3cP8VIuQ+Ac9RIOVFyZFp
         y8DgO8aeG3E0jLWMJirbmkXHnp+22ZU5W1/4Sle4LVjo00mv6/tkZp48vg8MI5G9bIk0
         TCoQCvmiECFLPfeKKhGJp28J0iY48QU45qXb4pB/QNZPE6U9DnhZfKU6CxHO6JjKO3rl
         JU/dDVqgr4+2HcxH+cdizMhUCpJDhKygiK7bLOk4voo6GA//n/Ao9fvlWyra5pv/itdG
         zhv6DyuGCQs0uuzCLvO64pnitnLClO7bcHr2MJBC6baxfXkXaLZ0LOS2hBpoz1e103jy
         EHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TWp5GZfXAuJiSjhN3OBoDFjXnsSknmpXMaB8oSLy2/g=;
        b=Wo7rSWrqj2g4/IfBWAJnIFgB82Qmbt+X/G6llMi8qlUCqoNlo8X/NlkDiFcVlkbDnD
         XQd26dq0QCWhu6YdRJMzSTs/83DJAyvo+Ftj95YOadPKTyNcDOiKDoC/xICNYKNA8Ujs
         6bDnhl3aWLr6K5p+j70a4WP7fLSd/211VmaQdzYTtAtgUn6f4XqmD++E3HP7qj+iKiPQ
         Y3mEs7M14ItdovEDUnnolpyZQSsL/swy0AjXK9eNzYgESwEO7SLM2SQGH6WFAADh3vC/
         lnUS4SwFlzcWNhQTzStZ0hEFIamgyX6GuQIhCK3pRDjo2IfdEPoBz+jR50SaNuotRKRk
         7V5A==
X-Gm-Message-State: APjAAAVTbJ95f9vMQQSbeSrFVZrAx+TDnSqZ8rNlZ9E+6hc01WP5SMgk
        +Rtxjc/ITsTvjUtPY5a5L2lNsw==
X-Google-Smtp-Source: APXvYqySNhmt9GNRmDIkVlWJrnjisv4DE3+x++TMdbO6SLMmNeMmkEEhShnSGMTeiIYd/7/Hcsc+JA==
X-Received: by 2002:adf:dbd2:: with SMTP id e18mr11305190wrj.268.1571038047490;
        Mon, 14 Oct 2019 00:27:27 -0700 (PDT)
Received: from dell ([2.27.167.11])
        by smtp.gmail.com with ESMTPSA id e3sm16653686wme.39.2019.10.14.00.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 00:27:26 -0700 (PDT)
Date:   Mon, 14 Oct 2019 08:27:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] backlight: pwm_bl: eliminate a 64/32 division
Message-ID: <20191014072725.GF4545@dell>
References: <20191008120327.24208-1-linux@rasmusvillemoes.dk>
 <20191008120327.24208-3-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191008120327.24208-3-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Oct 2019, Rasmus Villemoes wrote:

> lightness*1000 is nowhere near overflowing 32 bits, so we can just use
> an ordinary 32/32 division, which is much cheaper than the 64/32 done
> via do_div().
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
