Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF73139E16
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 01:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgANAZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 19:25:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37986 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgANAZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:25:05 -0500
Received: by mail-oi1-f194.google.com with SMTP id l9so10156554oii.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 16:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2uIWxQRw2ac2zDhobeFtImF06Kett0ywn6nB0mPlAo=;
        b=fpOBpZVdxKn8WP40gBvwSedqL+f9kLtftENQU6YXakio8Dlpq+8aaWsN7n+RBHIr3S
         JGXjNLnrkx6WSByQtY4rZFU2ODYj79fB+hDciyopYPvS+mMDbxvPIrjsaEhz2mKywS7w
         F7OhmJH9gTCbsdOHARRZjLkNS2VwUMcaXUeu/btM2J7lht0aOHfhUmGPb7PMVCB6EL99
         NQMJQbxrNcy1FfarfNCy0tiw5KzHEPpfQyi+DmF2qLOr0DOPsshBDyMLKZNA9GHG0x0U
         yzXka/8hgoh4s6oe0GTF+WlMQt8bv5YnsKa3Q3vbU0g2+V5c8fxStAPu6mbnwIc4Blzc
         dK/Q==
X-Gm-Message-State: APjAAAWV01bL9kPpSTVqXLQNgTpGozw6fjq1l/8AjFGxtTR7p/D2HWiK
        d4i7r7ZQZC66lLCP3Z3t8z9kscTo0Q==
X-Google-Smtp-Source: APXvYqw8djaXuF4JmATkaipC5JeieON2HW+UX0IFG7J4lskYzgJ9CMWz7FxXqAhl6i9qJVcbqlQ2pA==
X-Received: by 2002:aca:4306:: with SMTP id q6mr15180865oia.54.1578961504571;
        Mon, 13 Jan 2020 16:25:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n25sm4065143oic.6.2020.01.13.16.25.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:25:03 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221ab2
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:16:59 -0600
Date:   Mon, 13 Jan 2020 18:16:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 08/17] dt-bindings: atmel-nand: add
 microchip,sam9x60-pmecc
Message-ID: <20200114001659.GA11452@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-9-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-9-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:18:00 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-pmecc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mtd/atmel-nand.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
