Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD326126EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 21:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfLSUVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 15:21:21 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39348 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSUVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:21:20 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so3641121oib.6;
        Thu, 19 Dec 2019 12:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vCk/wZ8+53X69AE5Vwm5AlfPBaAA/4+cWf78YhT9OhQ=;
        b=KMGR05cmpZ/VgyhfvYsl3uHe4ReFrC2x3D6XS/k0SM0xmKjN5zdJ2iNQLYB/fU8meP
         h/PYNE/XCdOitb1N28A6hOJijfdIlIvVO7ZeUPg3pZ1Bdv1jaOificzPxKi2oULmOyPT
         pZ+w3JWDjjNsso4jpccJusn5qQ5JHUnRzWRiULrOTjbGpQvqKsXpv8WAWSG1MbrN7GSW
         rW/TP3+jL18bPsOkeaiHWSwJqFGAPQF/b/h2eImxkdmRtcqshng5VJyd/xCtBeDz8Hdm
         eS+DEReDft4JhbklxXA5DWBtLwQDg0AKubx6TamuxLahO3aDzVbUytCIEMtT+8CaOLEM
         oAOQ==
X-Gm-Message-State: APjAAAWwdk11ZdDX66b2uAkZLrKh79X8Zp2ah+FQgIIPodneFQZaXVDw
        SF/FlcqNU2KIa6KMdq9/37kSsmMsyA==
X-Google-Smtp-Source: APXvYqwbFiuAJFyxAMCtPYazAAIq9AV9TjEXYJL4GBqW7nJ7J1Biy0JAgWT/L+qjqI5/lWeQMyJdVA==
X-Received: by 2002:aca:1b08:: with SMTP id b8mr2901674oib.106.1576786879892;
        Thu, 19 Dec 2019 12:21:19 -0800 (PST)
Received: from localhost (ip-184-205-110-29.ftwttx.spcsdns.net. [184.205.110.29])
        by smtp.gmail.com with ESMTPSA id k6sm2480458otb.65.2019.12.19.12.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:21:19 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:21:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 7/8] dt-bindings: ata: Document BCM7216 AHCI controller
 compatible
Message-ID: <20191219202117.GA23339@bogus>
References: <20191210185351.14825-1-f.fainelli@gmail.com>
 <20191210185351.14825-8-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210185351.14825-8-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 10:53:50 -0800, Florian Fainelli wrote:
> The BCM7216 AHCI controller makes use of a specific reset controller
> line/name, document the compatible string and the optional reset
> properties.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/ata/brcm,sata-brcm.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
