Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D869170B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 23:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgBZWYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 17:24:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35826 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbgBZWYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:24:48 -0500
Received: by mail-ot1-f65.google.com with SMTP id r16so1054452otd.2;
        Wed, 26 Feb 2020 14:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7Tc2pp6tfwt+3v34tpbOx19kPSdtNqYuqm/8GY/cfw4=;
        b=ui0X/+wq3tOeJAS9wzI/U+gx79VRj7YYPEZB9pXU3E1IMe++89jfGJLvgCwt1uRSYl
         Wb4l5zd1n6luzHCZaQUvJb/8iMZMQ19lKpPWCdEBBJKkz627ubPau2/0XOfYExWAzqoj
         l8u4oUXQKOMejEaEAy6xHXuo5jcAa/GeJCPndUdom9WBHWbc9PYO6jdpG/1rdndmYoVq
         yfaIc9Ac+GrdXDqcoLWZcemoXWl8NZt4zonSmz02av66wOd7rsi01/WRF9y6ZRxl8V5T
         EW6WIiTp27Grg5xPxQR25TMogd9+xtglKIAfIcirKM4s0eoZMU+Sr3H/AS5BuW+QC286
         T6qQ==
X-Gm-Message-State: APjAAAVcJFzAdrh7B2GA3mfqpiZKnNhD6ZKHRyQKtAWdXxeKD39Dwdat
        FwISw6eW0DR3GfahB/t1zw==
X-Google-Smtp-Source: APXvYqxl4VG5brncJNWe6fMfCvBfkuDhRp8hGrhJHHYhzyTZwH2sy+iDxqHEY0c1dykRMxt3Vt/Phw==
X-Received: by 2002:a05:6830:13da:: with SMTP id e26mr781681otq.97.1582755887742;
        Wed, 26 Feb 2020 14:24:47 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b4sm1250798oie.55.2020.02.26.14.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:24:47 -0800 (PST)
Received: (nullmailer pid 11405 invoked by uid 1000);
        Wed, 26 Feb 2020 22:24:46 -0000
Date:   Wed, 26 Feb 2020 16:24:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@protonmail.com>
Cc:     devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        lkcamp@lists.libreplanetbr.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-crypto@vger.kernel.org, Matt Mackall <mpm@selenic.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: rng: Convert BCM2835 to DT schema
Message-ID: <20200226222446.GA11350@bogus>
References: <20200222200037.3203931-1-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200222200037.3203931-1-nfraprado@protonmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2020 20:00:59 +0000, =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= wrote:
> Convert BCM2835/6368 Random number generator bindings to DT schema.
> 
> Signed-off-by: N�colas F. R. A. Prado <nfraprado@protonmail.com>
> ---
> 
> Changes in v2:
> - Remove description for common properties
> - Drop label from example
> 
> This patch was tested with:
> make ARCH=arm dt_binding_check
> make ARCH=arm DT_SCHEMA_FILES=Documentation/devicetree/bindings/rng/brcm,bcm2835.yaml dtbs_check
> 
> Thanks,
> N�colas
> 
>  .../devicetree/bindings/rng/brcm,bcm2835.txt  | 40 -------------
>  .../devicetree/bindings/rng/brcm,bcm2835.yaml | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 40 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rng/brcm,bcm2835.txt
>  create mode 100644 Documentation/devicetree/bindings/rng/brcm,bcm2835.yaml
> 

Applied, thanks.

Rob
