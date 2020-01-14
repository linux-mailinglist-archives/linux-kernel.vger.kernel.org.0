Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF91139DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 01:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgANAUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 19:20:32 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35963 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgANAUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:20:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id m2so6005718otq.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 16:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E6IJAm/G2BZsEtWssBpYlld99L9pgrhy2OUvTYO1Gu4=;
        b=iQBYJCYcobcNFcVvALpMfgcZBJyN5ztyeC4DlN4fZT21F9YxNu6+BmoJ8TgMXHzZ1e
         5IWmDFLAZ9Y9K73IHQYMLzrGJaFOLeLyFHcEAwFd1HQIGmYXVvGKDA3K5WxGC4OmIOmc
         0RO/UDM7B7idZhBqUapSJQ5CTtXCopNWbWcWEzJ6u3J/0QBglo6l8mcMDi/5aw2l8ZR2
         mTgaJ3eA9/XIIIh4XHbuto+Xt1r8tCIlgF2TiUyjRDfviLcqbf/hqLD/wpOAS1//ctk7
         uKWUMpt1R83PDlfadGVDLeIjuWWhWR7Y8P3dUEfAhMe3amJ4FNcSbH+EPZ82QWWi12B5
         /CMA==
X-Gm-Message-State: APjAAAUfh1EVw858NU9qycbdG0vj0RNM2z/Y2iGhsnfWii4n8It6N7I0
        hUkJvkWRXOWACd5VBJEjOW6nslK6RQ==
X-Google-Smtp-Source: APXvYqx+MBhxrlbusOd2/KAQkLg6DTMOwfHUZ898c9zg2r5s6EeMfuM2Om3ksNrBwX6MGiZ9ZI1MNQ==
X-Received: by 2002:a05:6830:1d6a:: with SMTP id l10mr15816197oti.233.1578961230624;
        Mon, 13 Jan 2020 16:20:30 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m11sm4060780oie.20.2020.01.13.16.20.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:20:30 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:16:27 -0600
Date:   Mon, 13 Jan 2020 18:16:27 -0600
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
Subject: Re: [PATCH v2 06/17] dt-bindings: at91-sama5d2_adc: add
 microchip,sam9x60-adc
Message-ID: <20200114001627.GA10411@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-7-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-7-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 18:17:58 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-adc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
