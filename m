Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C9BB2234
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 16:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbfIMOgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 10:36:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39966 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbfIMOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:36:22 -0400
Received: by mail-ot1-f66.google.com with SMTP id y39so29707215ota.7;
        Fri, 13 Sep 2019 07:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:mime-version:cc:cc:to;
        bh=MYCnm1KBQZKBx96HB0JscnfcL2xUFb85JVsOSU3qDc8=;
        b=T10MKHdcWwnn2dxPfllVx43PCmiif9sd26Wj8/1ryOcCTrqwMJmFn+4pTBKAx7u5Eu
         pKOkdyl1GWYueQMSfEksMXpmWIhoCXZlfSZjY76bU4JEQWlaoK1j8qkrqQMyRquKRL0N
         WiMcqbzatice/hIla//ybAHRW6nvgujhPC7HgLK74fY9UGgKG50FO2cgf/k29p6PmUxH
         RKHGLvpmWYHOneFkqODimAxURE4BjW7OezodN0FFBO+Lh7jfG/7WZ3AZ9pjNodnhx6yX
         E1nRi2jOHlin/kNrieuXGFuqyc897iDZsTN+UYcuSgki9oDcGqUT1XVk0e3zWk4IU60l
         5hYw==
X-Gm-Message-State: APjAAAXAsC5Vsqx+zZGSOUyqNhbknFxmlk+Ryo6PGsIb8cqhSBB10krg
        JLjOjcCU2U8bWRQkh8W0lw==
X-Google-Smtp-Source: APXvYqwnDo+Q7hxaXltlbSSHIDiUF0pJOKm7cavp8WC4RBGH7oOlkrEXpJ8E4zYLuUHbxns7zp9g8w==
X-Received: by 2002:a9d:7d91:: with SMTP id j17mr14847510otn.120.1568385381585;
        Fri, 13 Sep 2019 07:36:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a22sm861167oia.47.2019.09.13.07.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:36:21 -0700 (PDT)
Message-ID: <5d7ba965.1c69fb81.ad771.5fc1@mx.google.com>
Date:   Fri, 13 Sep 2019 15:36:20 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] irqchip/atmel-aic5: add support for sam9x60 irqchip
References: <1568026835-6646-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1568026835-6646-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sandeep Sheriker Mallikarjun 
        <sandeepsheriker.mallikarjun@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2019 14:00:35 +0300, Claudiu Beznea wrote:
> From: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
> 
> Add support for SAM9X60 irqchip.
> 
> Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
> [claudiu.beznea@microchip.com: update aic5_irq_fixups[], update
>  documentation]
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  .../devicetree/bindings/interrupt-controller/atmel,aic.txt     |  7 +++++--
>  drivers/irqchip/irq-atmel-aic5.c                               | 10 ++++++++++
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

