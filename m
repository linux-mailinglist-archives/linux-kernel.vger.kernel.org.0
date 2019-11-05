Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38614F0540
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 19:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390739AbfKESlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 13:41:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36300 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390673AbfKESlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:41:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id s3so10939736otk.3;
        Tue, 05 Nov 2019 10:41:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZcTS25xDAMIirazFonzLL/ydaCeZnXdtGHuL+mEiDCE=;
        b=On33/WZ7v90DPLefOw73E6gL05C/Lp2O+3ICbWdqaXSD6FD0D2odj/9IU7kq5WY9Iq
         e/n0bA2Q67knARnjqpoHO+FoCzjEcVeY//uDebP+tW1MqftIJKBW6SHH3dsRictKgBFm
         APofYnhDRAKPCEh3N4HgMj8dCLnveGUGsZkKeIdZkC3v4bIHWgUrzRmSCoUZfYkC9Fpo
         7TiMFiASDCvU0nEloxHg6c6uGbFjiH6p54aAGw6rDhsmfQk56hSEu8yQ+3fePQJk3krG
         9XpV55VhDecIo/tcNYKL0ZNss59fpf6emntngkF0q9ZwVx8sSlHa8q447Myd49M1YK6d
         rBiw==
X-Gm-Message-State: APjAAAU1+Yz5nu07Sy7SpXsr9ugCOJ5Nl75e9QTb9eM7OvgZrgyDgwe8
        I8uSH7zHmGnVVqNNALUCiw==
X-Google-Smtp-Source: APXvYqwa/eDD8mpnX7OYEJYfOGvN4ZSwKb0NYl0obJNUJgwpRsdPswN/MTugiyfx57WysSknfSo7fw==
X-Received: by 2002:a9d:5605:: with SMTP id e5mr869941oti.150.1572979306019;
        Tue, 05 Nov 2019 10:41:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c20sm1474934otm.80.2019.11.05.10.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 10:41:45 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:41:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: atmel: add bindings for PIT64B
Message-ID: <20191105184144.GA29029@bogus>
References: <1572880204-4514-1-git-send-email-claudiu.beznea@microchip.com>
 <1572880204-4514-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572880204-4514-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 05:10:03PM +0200, Claudiu Beznea wrote:
> Add device tree bindings for PIT64B timer.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> 
> Hi Rob, Nicolas,
> 
> You Reviewed-by/Acked-by v1 [1] of this patch but I didn't collect it in this
> version since I removed the clock-frequency binding in this version. 
> 
> Thank you!
> 
> Change in v2:
> - removed clock-frequency binding
> 
> [1] https://lore.kernel.org/lkml/1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com/
> 
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
