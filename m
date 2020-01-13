Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0A8139D35
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 00:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgAMXXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 18:23:03 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41839 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbgAMXXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 18:23:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so10718983otc.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 15:23:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F2iDZ52lWikDVmU5g/bwIONEfUCTF197jf9k+MTeRXI=;
        b=oqOTUhNmQPc9KdGW7aY3bGLFyZuMxFd/m5iUwI/GO/uAeHsSN8ifSW3t7kOVDqcleC
         Ztqth+0g/vCSmvNNi1lfOLs6i9KZmTkAXDZVfYq7m66ob369xlwdwTpeNJ/rWU9/Vwwi
         jLwcX3DOMYQZlvvtuHugljRGG27pooA+wX611Rrmr1J/9vhdnYVm5rz9jbVxnOG4PoF5
         6D3lkMEQIjuxi9dHiHZqWOorfwPiUCR7C2lMaoOcRDDRZNeJgJWkaNCEzOFvqEGbm+JC
         00IAzXIl8jP90PgBrXcLo7IychApiz0k6zBu+5RiraZ+iHgrLTiQ3aCHpChekudalHtN
         L/fQ==
X-Gm-Message-State: APjAAAW1ydIiQJ6fhShfKW/QiriTocNPJF8Jv6aMc4Cv5cXkgPdksFsn
        KwEmoUov398rRTmJlKN9XaMjMwE=
X-Google-Smtp-Source: APXvYqyK4ZE3OHsPn0g0tuq4dbvuEasvgvKzVqUBFrBP3g/bItwSEmEJ7MbN9CtID3EvFTruwdr9uQ==
X-Received: by 2002:a9d:73d9:: with SMTP id m25mr2222469otk.350.1578957780674;
        Mon, 13 Jan 2020 15:23:00 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j10sm4689457otr.64.2020.01.13.15.22.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:22:58 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220b00
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:22:57 -0600
Date:   Mon, 13 Jan 2020 17:22:57 -0600
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
Subject: Re: [PATCH v2 01/17] dt-bindings: at_xdmac: remove wildcard
Message-ID: <20200113232257.GA30124@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:17:53 +0200, Claudiu Beznea wrote:
> Remove wildcard and use the available compatible.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/atmel-xdma.txt | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
