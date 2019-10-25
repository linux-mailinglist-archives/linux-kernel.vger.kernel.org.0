Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97597E55F4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 23:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfJYVe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 17:34:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45429 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJYVe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:34:26 -0400
Received: by mail-oi1-f196.google.com with SMTP id o205so2529656oib.12;
        Fri, 25 Oct 2019 14:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7s13LulzXudWEH5AkoywW9MOEghDGN0K+d1ZGtH3B3c=;
        b=tVHnNSNJLp2979W8b6xbt0OarM8UhGcRhCSaN/oB1YbAhXcRZtx4WeBdEReFQgcOHo
         okH7OPH0QIyyTMQvpMeN8KcUHcqFJ/0Q3xnvqmzAkSnZkgf6ZTKb1JwHAgufCVH1qXpP
         oG1hsp89Qof2SIp3ahPS9856HsHHBoQo+Q2MczZHPhda+EZfqkw2xaZYjKSjTNmYk9Kf
         W/JsN3eKJ56UdQjZvYMz5Utrb5bfduJrBjPhUGfFb0VCs0quGQyTJ7767oMvQk0QaWZm
         aC1j1Vg8p6LauhHXTs9NrI2/VagRAaQVmESdXAobC6nT39zt6MzxgrZrxYXMr8pDrZI1
         xoWg==
X-Gm-Message-State: APjAAAVY9KaE3De93bYYh4p7RMGL16RtfEcFF4iVfMOrW2DeHupiMMnn
        KyL9I2nTZEdYvR8Xm+gt8012v34=
X-Google-Smtp-Source: APXvYqzEB0xkyNi3l5evme7y6Aqv/FjHQN7vgdqXP2eNniCNF6eIh+57bLjIBDVD2J2VvpizXaoAXg==
X-Received: by 2002:aca:d882:: with SMTP id p124mr264599oig.44.1572039265901;
        Fri, 25 Oct 2019 14:34:25 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y6sm943059oiy.45.2019.10.25.14.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 14:34:24 -0700 (PDT)
Date:   Fri, 25 Oct 2019 16:34:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: at91: Document Kizbox2-2 board
 binding
Message-ID: <20191025213423.GA24616@bogus>
References: <20191021125804.23856-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021125804.23856-1-kamel.bouhara@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 14:58:03 +0200, Kamel Bouhara wrote:
> Document devicetree's binding for the Kizbox2-2 board of
> Overkiz SAS based on SAMA5D31 SoC.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> ---
> Changes in v2:
> 	- Removed other kizbox2 boards as the main difference between
> 	them is the usart configuration, only add the two heads variant
> 	for now.
> 
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
