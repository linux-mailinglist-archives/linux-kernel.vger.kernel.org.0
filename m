Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34D6DC4B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 08:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfD2Gz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 02:55:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33173 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfD2Gzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:55:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id j11so7112129lfm.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2mNSQUENRd+OO6kAsaQU21E0sDqHovQn3FQJZCp3E+A=;
        b=mEFOogOl2hAZA5U6qZswSy9bfFJpI90PxH1cpXR1UpBJyOp6XbDilE792dohqNmTTR
         mq6Op4CtXDVFlbW1QRQIfScqFRhrm1tyWDgTY07BUo48fAk/Rdv5j1/bV2SUmQGRYYTO
         RN7mhqU9U6vfKr1O8y/yFcDCxbPA5smdXUOx8ggXK2Ws9+TpVfAac/8KO2UCLthXcfTR
         x3LXTDblsWnBsiUXaXMl6obvF3PPRMU8fMO/Tjh9QKwm2pkbzATFO6OeoFuNgogKxZio
         1UptDlDkO5Wy2/fX/tCZ/J0BuijcsImXGEJn0/ZBKXlvZB9smx1N6IvI8yP/UfmBHujT
         yRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2mNSQUENRd+OO6kAsaQU21E0sDqHovQn3FQJZCp3E+A=;
        b=TquRYIGilfm0ecQKgXapnKBmAWYIOyTBhBNYGcABHNZ471OUlnjiVIPayYA2oPJQdh
         tRYZaSgnXMY/5XUybAu0/WoVRdJpO5PHxg/uH939CX2RDItlUTWyL4Ma1Ljt3/iohU4p
         J4hTKq2Skr1oSH56ipFDf68aXaM4osAdnjWbGdLIFJx6/pUCjP5sY9ONxrPRrfYE2eqo
         a9/XTYohpDNLsn7/NIeDKRdnpBZEV/wxIzXmIA8VaPkbk/pJbQSARh1jAK506P71dJnL
         ZHbKYQQhOQGGrjelj5kacfB8EJ8MSsVxwyYzmBp/ODV6WUFGXOHjLW1/oGOmcOJ+rsqD
         cHmg==
X-Gm-Message-State: APjAAAWnrLzAN6w84HuOQtKEVfI2935do0sqiAhQ2aiaZDTJ5tBbOXho
        rXavglMyrg+Q7KyGkIoYmCqr6g==
X-Google-Smtp-Source: APXvYqzAsEv+tsNtdhETsmAqFPGgw59ipUzfw+huHzINrHvdFCO5LOLVYXjCq71QDeNmiOoiNAQNVQ==
X-Received: by 2002:ac2:51da:: with SMTP id u26mr31416674lfm.32.1556520951858;
        Sun, 28 Apr 2019 23:55:51 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id b20sm6721906lfi.78.2019.04.28.23.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 23:55:49 -0700 (PDT)
Date:   Sun, 28 Apr 2019 23:21:39 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] tee subsys for v5.2
Message-ID: <20190429062139.6bycwzbes6wk43ea@localhost>
References: <20190417160120.GA19526@jax.urgonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417160120.GA19526@jax.urgonet>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 06:01:20PM +0200, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull this OP-TEE driver patch. It allows the OP-TEE driver to work
> without a static carved out shared memory area.
> 
> Thanks,
> Jens
> 
> The following changes since commit 1c163f4c7b3f621efff9b28a47abb36f7378d783:
> 
>   Linux 5.0 (2019-03-03 15:21:29 -0800)
> 
> are available in the Git repository at:
> 
>   http://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-optee-for-5.2
> 
> for you to fetch changes up to 9733b072a12a422e2bf17bc7ba8b39769853d4a2:
> 
>   optee: allow to work without static shared memory (2019-04-17 17:26:33 +0200)
> 
> ----------------------------------------------------------------
> Allow OP-TEE driver to work without static shared memory

Merged, thanks!


-Olof
