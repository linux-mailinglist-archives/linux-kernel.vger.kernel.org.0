Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9959DAFA35
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 12:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfIKKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 06:19:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43749 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKKTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:19:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id d5so19435690lja.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3147zBZhw/UX51VlglkVVRHJRKcmU6+Mh2CpbRNH1Q=;
        b=Gbl/3eu/vRbHPX5XNV0bq9/xamdbVPSy6srUKEYj9dLP0KlXQermQi/0BhYAMKVK7D
         FwgtjLbYFvTB8hOlFy9jp5ewb8DxvFcq0yCsfUb1lkbDFhkNrZ7s0gG6xY+dPT/avqnk
         JUQLntIlCF0fyPJUnyZGFpKXEH93uEKlGdEIXxUZPhVEEUI7frf2VgPkX8NK7YlfNlnF
         n212L19y0FiO12PVM/Lba/WgNePOhgz9m0dD2X/TkPlLYtR1qo1N2TPWq61wdn9LJAzR
         ip83lhH+KsS3/Mkt+AxXfhqt4Eayu16KARqRVKfChpoGPHxIpFIqswRIErt6af19j/LZ
         aaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3147zBZhw/UX51VlglkVVRHJRKcmU6+Mh2CpbRNH1Q=;
        b=ZS+FdSbeO19NcaF0kthThJEuEBPKpGgbfwoWUdrKezf8WjuMGnvm87T9hLnIlFcCCk
         P5vXuXjTN5y/9RbWl1/LiEuctKxslmkFJGLcJXT9G12BjCMLvYcCjJ77VJT+YC2Djge2
         h5TEslBvFH6G45Z4Hy+ZBYfJKzpAycYBXfonuzmBqFUMwJCrxzBBfiyxMDdyi+Lxcijo
         lWXwoIN/ClJzAPFyBqwidwVJwilALS9ycTDVBRNjG13r65hR5Dqraja2ITHPeQLZgm4f
         fuKHTVaR3CGNbvvIv0R1R98qi7k5m25Ue2QDZj19si1xeABKedxEkjy6yl5RwqzpT1ik
         ldNQ==
X-Gm-Message-State: APjAAAXKh4W81ZzJc7ilfd7VPP3DSy1+0xLvgoIlMSchFzxN6aqayu+o
        KWLq+JI+nhrrnmXS+y4b8/ea+1psdnQBsmUGHG7iow==
X-Google-Smtp-Source: APXvYqzB5BVgv6AQnPfWAutofN/bDoNRjMTME5RBOuMqvBevxj/0paBL/L/Gw6RJVZRAhcMdHPv5ejElCDlE9+NqdtA=
X-Received: by 2002:a2e:654a:: with SMTP id z71mr22927335ljb.37.1568197178805;
 Wed, 11 Sep 2019 03:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190829181203.2660-1-ilina@codeaurora.org> <20190829181203.2660-10-ilina@codeaurora.org>
In-Reply-To: <20190829181203.2660-10-ilina@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 11:19:27 +0100
Message-ID: <CACRpkdbhNY8N=LMG6wwYw9bAnL4HmAqj8WMpsLsqvh8PvaQ52A@mail.gmail.com>
Subject: Re: [PATCH RFC 09/14] drivers: pinctrl: msm: fix use of deprecated
 gpiolib APIs
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        mkshah@codeaurora.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 7:35 PM Lina Iyer <ilina@codeaurora.org> wrote:

> Replace gpiochip_irqchip_add() and gpiochip_set_chained_irqchip() calls
> by populating the gpio_irq_chip data structures instead.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>

This is mostly fixed upstream I think, but:

> +       chip->irq.fwnode = pctrl->dev->fwnode;

This fwnode assignment is missing though.

Sorry for the constant churn and required rebasing...

Yours,
Linus Walleij
