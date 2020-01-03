Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7752512F5DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 10:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgACJAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jan 2020 04:00:31 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34713 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgACJAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 04:00:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so23295899lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 01:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+bJCZLqGGAfEAm4pWyHBrj/nn/5vuksWt0O0tN8ngok=;
        b=YLgzDTAfGrKOJy7kTl06OexdF/WJipSdmj32S2vZup/GXoPX62/iaHXdQmh2cv3WUU
         wZfiTgkX5vq9QQ8U38lKU5l3CqNhR8/oQdSvd1L7Uf5T/AzAfa8ipCk9wBE/jZ0i4yGx
         p14hyjWijfNc1QD0AHvGO6tDp+fc8fv4ijf07ifPpNVIlRuFrzBdN5yI3I+Y5sYx7UAQ
         Qo+wj1hwSKcBJLdc2ixO1RPwv7QByTEdfR1rnqgc81XXWCuH0WkOFeooLxES6vOXyjLt
         2iI8Gbo+vBlsKYyzHkHYJsSTKNF9X3wOp5O9/3Lm2eiO9Ah+A4XxSKQUMKYqu/MUVrcA
         fGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+bJCZLqGGAfEAm4pWyHBrj/nn/5vuksWt0O0tN8ngok=;
        b=F/KXTTV/TSGwR0hwz8gklpHotG0m5XL9zrrSDXjznXOIYhTqu6vTLWTBAhWXIWSQu3
         IOos34I9emZ8Gb5WeGkPcVFeG0aux7NYs4nOoSbt9p3M4NOAbUZdcSqoalB6VI32x2Bg
         yrkT3z60cSKiOLaaK1IaX/w+iWFePVtndWloS81YLRlcylr2KPLlQj+P7GQo+OGd96t3
         IwrQ6oAit+Jc6+oLspmZR2j7dGzgABBmxB4eKMKiRfJbE4pyFknRAGDlgx9eG3ld+xcw
         n6m8yl7DpieyyaBjDhlDReJo7CYIZHoZTMQLrNnkZbVpLJdIdhBPIcx1IYuZ5P9EdkiI
         vs6g==
X-Gm-Message-State: APjAAAWT1Oi5QOvUm541jsxi9sAto6RShrchvgE/qjpR3D1qJBme1201
        Q+Z/jMB3G7g2cSZtsk6H+aYEVA==
X-Google-Smtp-Source: APXvYqxHz6YOYwivJoSxhqlSJg3HugBnTerrXFQsJwx2kcoUtyy25+ZVE9A88tuIdBzfxaI9c9ocxw==
X-Received: by 2002:a19:5201:: with SMTP id m1mr51956951lfb.114.1578042028505;
        Fri, 03 Jan 2020 01:00:28 -0800 (PST)
Received: from jax (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id k25sm23877975lji.42.2020.01.03.01.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 01:00:27 -0800 (PST)
Date:   Fri, 3 Jan 2020 10:00:26 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org
Subject: [GIT PULL] optee platform driver for v5.6
Message-ID: <20200103090025.GA11243@jax>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this OP-TEE driver update where the driver is modeled as a
platform driver instead.

Thanks,
Jens

The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-optee-pldrv-for-5.6

for you to fetch changes up to f349710e413ad29132373e170c87dd35f2b62069:

  optee: model OP-TEE as a platform device/driver (2020-01-03 09:26:40 +0100)

----------------------------------------------------------------
Model OP-TEE as a platform device/driver

----------------------------------------------------------------
Ard Biesheuvel (1):
      optee: model OP-TEE as a platform device/driver

 drivers/tee/optee/core.c | 153 ++++++++++++++++++++---------------------------
 1 file changed, 64 insertions(+), 89 deletions(-)
