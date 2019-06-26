Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAE356A11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 15:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfFZNLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jun 2019 09:11:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37074 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfFZNLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:11:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so2057734wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=y3z8Sun4edo2/lb2VL2yIetLBziApp/FodnCsCfNo1o=;
        b=n5WIsJoakAGTvpglAGJn0eiTq+QX9yzBmjXZYb0ehaaQ6tums/pGqTv+SkBMCwt+9h
         E6yjsiwiIAJnuc3gNXCKZlH5qQXTcIz7M5GajgDt8Gks4qQlllrDfNLpanaJHgxePd2f
         J35WeJSesn0ZzLgEqV6WD+yFjuSzV5CTJxMH1DbAyGGtmOEmdFpZ2bVedaQ023r2jBB8
         bdHDXB4n+/onylo4QaQz4fb62RWoyLv2g/SV6YqhmJHpurKzh8v0I7LQULVF4OH6zFNA
         9Da0fng3SDtDwXDzX82GUs4YWO6Vbo3GGdWB3cTPK2e73zpAcWnya5t3ZV0Wdyq4VsEh
         e2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=y3z8Sun4edo2/lb2VL2yIetLBziApp/FodnCsCfNo1o=;
        b=CJnQDgJu6u2Vhme+gLmURJ6q6SnuE/ja7g2mavT+sC55/4H7oCTFYwL2ZsYP+7RQWI
         +hUt3IpW/IyN6/wEme69x/HTDz+xLtMFbjnjjDtPJAPS7EwUT3H1pwNtqSuEqMsDeGWr
         9JFeXskLWBg7PrNBlMwETf/c4gVo4nhmd7HBZX+zH41sW4n1A9MAXSsEm6qN8Z2ks0Pb
         MvlB813XV6zBtwdXdtc4bYalstYG8Yg/0r/JVfUM5jC1mRPXG+Odi78WNAZ3srk9Kbid
         AR21XQDP+913tpc49P2Throjo/XsjRPZA3HZKShtIvI8sIQ85TJsKEJflnt23Ihg+ap+
         hv0g==
X-Gm-Message-State: APjAAAXnuxKpSl/qclfgvBhuscvrx66i+dptNkHjUYWqEhJ78XafqNRU
        yvUgZcKrFWtrp/mR+9SBGCg4dKmicco=
X-Google-Smtp-Source: APXvYqycdW3BSZTSYAkmY8IN605qSS/KQG8i11x0cU/5+mleMqirsmyzT/6IQuJ7/jkcsnFLre45og==
X-Received: by 2002:a1c:d107:: with SMTP id i7mr2905792wmg.92.1561554682600;
        Wed, 26 Jun 2019 06:11:22 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id a7sm18318673wrs.94.2019.06.26.06.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 06:11:22 -0700 (PDT)
Date:   Wed, 26 Jun 2019 14:11:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: release ida resources
Message-ID: <20190626131120.GV21119@dell>
References: <20190621125631.36872-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190621125631.36872-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019, Andy Shevchenko wrote:

> ida instances allocate some internal memory for ->free_bitmap
> in addition to the base 'struct ida'. Use ida_destroy() to release
> that memory at module_exit().
> 
> Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
