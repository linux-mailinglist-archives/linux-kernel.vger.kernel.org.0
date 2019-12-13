Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A38E511EC31
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 21:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLMUyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 15:54:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33949 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMUyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:54:19 -0500
Received: by mail-ot1-f66.google.com with SMTP id a15so652390otf.1;
        Fri, 13 Dec 2019 12:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KIIcKgZTADTDSwYU9GOa/p2g/0/rTYnBM6ztrQxNYsA=;
        b=nPxoH3UeHn/URwo1q7n1eYc3GBA+4z6PGyqbUIaNxM/W1i4ocgxRXKtD4Rhb+sMZTA
         DEcAnmaeiOzWx+Z4DFnIBhGoVWoxxSC/kETAw6nXoo5GLUljlFOzjTsfCnqgb1LpTpqR
         /D+diQly+1bEyidrJg6AxZ8oYpFEfWh03lKYiqPr3qcPaY5BJ2iwP8mjBe/DaHnA8rtP
         WKt0eAckjPs2NPf4x06b7nxfMlvBLMV55OfOK1Kz8r+yWLhrzR5G+bRJQdlzL+OFv9fr
         XbM72Gew5sIt860wQo1wq5mhqaY/ZwmZgqgD3gJ48XA7yo8wYk5jOwmFOA+dIJTO0GHI
         UbjA==
X-Gm-Message-State: APjAAAUylxdecYuit4x2ACnFq0odwkCiqGsHxEu5zt4R778wu+fSVJ9H
        ESrgSJTnsAgFTmp+towhku/oPTU=
X-Google-Smtp-Source: APXvYqxBJilDDGyTaDxnBj9ynh4myRloS+dQ+fRGAJGegSEuz8ivs5D3EYHV6sgRP4EHkpn4SjlIrA==
X-Received: by 2002:a9d:c29:: with SMTP id 38mr15865869otr.1.1576270458920;
        Fri, 13 Dec 2019 12:54:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m205sm3702145oif.10.2019.12.13.12.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 12:54:18 -0800 (PST)
Date:   Fri, 13 Dec 2019 14:54:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Anil Varughese <aniljoy@cadence.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 01/14] dt-bindings: phy: Sierra: Add bindings for
 Sierra in TI's J721E
Message-ID: <20191213205417.GA8776@bogus>
References: <20191128104648.21894-1-kishon@ti.com>
 <20191128104648.21894-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128104648.21894-2-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019 16:16:35 +0530, Kishon Vijay Abraham I wrote:
> Add DT binding documentation for Sierra PHY IP used in TI's J721E
> SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-sierra.txt  | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
