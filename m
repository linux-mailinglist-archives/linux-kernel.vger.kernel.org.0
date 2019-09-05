Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E938A9BC8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 09:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfIEHa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 03:30:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35252 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731390AbfIEHa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:30:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id n10so1576727wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HFlZwq0qxXTjPrcrj7B+tpd00WpauS+YbjV3gpTHZ3Q=;
        b=tjHmqDOv9YI9TmvdR+u5Vb9kn9GFHdw8cHJ9H/9JAbro7in1falYEmg02iMAG8Enm8
         qE55Q53zFDJKHdu6LvhJUIH5cbbzsSd/Oo8lKaAQ5QajB+NPccVu7Aaf5L6fB5e00gM9
         twb8h6FS2WzlMt+z5ZVv6/ahUp1mWrLTKUvPLGI+ZoBRaVza4fP9CdemlH0kwAB/QzAZ
         uHg1cfy6FBisXzVAf/igV6C4WLg1rJd3RIqXwY9BZAQ0KnhiiEvQ79E0dHBT/jQo7z6q
         wcJC/SOwldpyKNNRpOAcC1A5lzQEyzlonWx6MYXTmPUy/hhImJNgx30n1+Zxkyfd6y5p
         1sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HFlZwq0qxXTjPrcrj7B+tpd00WpauS+YbjV3gpTHZ3Q=;
        b=LTFfuSr4BhZZhpK5kPLZg8+bSEnLCmlD18EQzL96EUmgW0srCmXctbBwvzg0kfXi3u
         TFHiYf7aRpWsSs7RUvo9zMmqe9rZ5MpEEl+/WQ2cRKJOJJlVMoVnQ6+5lAw1pt3Nn1s/
         hi8wxyK1f2QlvVr3PmSjggwE/njdvDZPlym8nfqO8kVthwS/WWfU1UjF+QyDKrAyKwlO
         j0Nt8hqOOR1LXUbQNyk7nfQyinxzBC3RNZP6Yr2jOXkDjal5bKro5i1p+YgmQi1ioUV3
         woI+aSA1E0lkFrX30XItEoc8JiuFvqtwrYwWjJkBGT073KE3YgCEL/fGCnQxd/T6GIqr
         4LHQ==
X-Gm-Message-State: APjAAAVc/LsdqjrBQvF9KCj3Cjk19aY0eSYP1/YLJ6pHjgxStQ3A3BH3
        KLHi3tU9PlGqWhBPtdWa8io4SA==
X-Google-Smtp-Source: APXvYqx9hIKtXo2fKrV6NCZnQd9e6GpfPm9KrsYcmzaMgYNsj4Y9AZC4Dki6vbgrkFd5YqH8pvr6aA==
X-Received: by 2002:a1c:c012:: with SMTP id q18mr1787427wmf.116.1567668624199;
        Thu, 05 Sep 2019 00:30:24 -0700 (PDT)
Received: from dell ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id 74sm1500110wma.15.2019.09.05.00.30.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Sep 2019 00:30:23 -0700 (PDT)
Date:   Thu, 5 Sep 2019 08:30:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/1] soc: qcom: geni: Provide parameter error checking
Message-ID: <20190905073022.GY26880@dell>
References: <20190903135052.13827-1-lee.jones@linaro.org>
 <20190904031922.GC574@tuxbook-pro>
 <20190904084554.GF26880@dell>
 <20190904182732.GE574@tuxbook-pro>
 <5d704c9f.1c69fb81.a1686.0eb3@mx.google.com>
 <20190905064253.GU26880@dell>
 <5d70b193.1c69fb81.f9ce7.3447@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d70b193.1c69fb81.f9ce7.3447@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Sep 2019, Stephen Boyd wrote:

> Quoting Lee Jones (2019-09-04 23:42:53)
> > > > But if this is the one whack left to get the thing to boot then I think
> > > > we should merge it.
> > > 
> > > Agreed.
> > 
> > Thanks Stephen.
> > 
> > Unless you guys scream loudly, I'm going to convert these to Acks.
> > 
> > If you scream softly, I can convert the to Reviewed-bys.
> > 
> 
> <in a soft scream>
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Done. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
