Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79680AF9FD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 12:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfIKKKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 06:10:16 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44143 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfIKKKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:10:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id q11so1027975lfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 03:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fd44UJ2qp7SxlmPH92Hh2fZtRoYOa2yVKq8dtzIHoUY=;
        b=weAyWjo4quJcwmENKcNerNmyN+gz/QJ9hYm8rmn0/rQ4AF+hN9LftSYTgS3KxWM9dR
         tlgY+fTeAXsDs4FJRXwaCuDUUcOv2DWlkbSIIiob2peEB4Hnw81+IpJetrTGCEbx7O2I
         9Yl6U/Lfnxb4U4Jv1lwMercoCINucwno4J2A0Jf/rYQ26oAWmb4i8bR8Zl986fCF3crW
         ZNeQ+TUh0b9lN4q6SdlSC5UDgTPgH3z1QVTZQtYPrJHV4hgeFpDRZQD1+vDtcmyzoI6N
         2fCBXQEVf8qcPbNDTCxRpJQyxaAo2YjTtrJxGC033lysc/91IdDBTbwvU/a3KTj20yWw
         dR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fd44UJ2qp7SxlmPH92Hh2fZtRoYOa2yVKq8dtzIHoUY=;
        b=tkSDel7qE9WRkuAstMC0TsdSRvMbXnrTcindt9sgKLxIcywVGK2wtEQ77UT4Xh3OG7
         wC9Yv7NImwxzOTaZooqJwKA65mT5DRHyzs1R8TDoKDEH1NYNPtAjh6JQ79jA1O7SzDJv
         LhjMVbUAMvYi0dFEsRY5688vZ4YvTIcxkF6R/G/yUz16VRKtZfvpns4eQxMDsV7IvYfa
         HUGCNFhiEOecc529/n5adKkAtjc40mTUrhrIxVmjnZFJkuS8kl+pFj1huT/Obvx6IB1n
         6pRq0IcNhYql0oVLgXA6vzRVqQKHvon2VSb2hfTwH75dtV/iapwvwo2WM1ei6CP3AWhP
         Am1g==
X-Gm-Message-State: APjAAAXyPyr1ERXsV3iZOIUUARLHsMSyg2vtHI7XdQ2j4ytdCPyo/OMR
        lHAOli4zYpsP7C2963KqyFH2TJKsGoPl+wuLHigEZw==
X-Google-Smtp-Source: APXvYqxXrKv8m/NgHM1ig0qAYSi29B4YPdGe3bL55eGb9Rww2zvzQ3IpVfOta67Ay2PtbrLdxjwEiKNEmAnXzj6hqYE=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr23663867lfa.141.1568196614289;
 Wed, 11 Sep 2019 03:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190906062644.13445-1-rashmica.g@gmail.com>
In-Reply-To: <20190906062644.13445-1-rashmica.g@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Sep 2019 11:10:02 +0100
Message-ID: <CACRpkda7WAZxUSjOXRj5Q1mSC0ZhYey2E9RkuX7p6Wcs_kXB=w@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] gpio/aspeed: Setup irqchip dynamically
To:     Rashmica Gupta <rashmica.g@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 7:26 AM Rashmica Gupta <rashmica.g@gmail.com> wrote:

> This is in preparation for adding ast2600 support. The ast2600 SoC
> requires two instances of the GPIO driver as it has two GPIO
> controllers. Each instance needs it's own irqchip.
>
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

Patch applied with Joel's ACK, needed some fuzzing but
fixed it up.

Yours,
Linus Walleij
