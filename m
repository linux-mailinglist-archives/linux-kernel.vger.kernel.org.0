Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91CB5B26B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2019 22:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfIMUcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Sep 2019 16:32:24 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45125 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfIMUcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 16:32:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id o205so3710222oib.12;
        Fri, 13 Sep 2019 13:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BGIWuDNYrQwWqig+AD/FBHIPnZv5C2i4xJ4AwfsT/OY=;
        b=IvBydacSyFYsbGXTGUcsreU+sWqyWPVVXBDwhphgTUs382jDYSYD/L6M4ETwhD+X9L
         GJ/e+taR9E1DKP3lyELDZcNeUGZ3f814HiSWc9E0+2OBTVEsnkqCr3LhgevJwBPF6Tgj
         2FjXXb9S9B/NHrd2dxKmvCUbx+vmEA2IyCmt8/+nTKzQeSadaWFHXVtofH06hmaBGRAo
         +NEkt0ObCGgOw5pnBJ0hTYJxA3/F8dCrttdontj25Cm4JaJNNygezuzACjIa1e36x89Y
         MZIMRDR8D8XE6p/e+OXY0BjbtpSCOwa3AD9J/92oh6Juz/4kxArSFyvYWUfD4hgkZpUm
         f7SQ==
X-Gm-Message-State: APjAAAVaHGGdfZNaVb5tBixG4X/JE8HqimjlzkMrqzTQnmEBFVzZMmzo
        +gYrYvgUJGAlm+DYEgXS7Q==
X-Google-Smtp-Source: APXvYqzFbRU+snVUDd9MMC9DD08qEbNF3nw90SquEx0edL36n1/nyysG5QDi7pc411CpUKfeTsFBbg==
X-Received: by 2002:a05:6808:4d1:: with SMTP id a17mr5063804oie.71.1568406743044;
        Fri, 13 Sep 2019 13:32:23 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t30sm10013349otj.40.2019.09.13.13.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 13:32:22 -0700 (PDT)
Date:   Fri, 13 Sep 2019 15:32:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v7 2/7] nfc: pn532_uart: Add NXP PN532 to devicetree docs
Message-ID: <20190913203221.GA19194@bogus>
References: <20190910093256.1920-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910093256.1920-1-poeschel@lemonage.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 11:32:53AM +0200, Lars Poeschel wrote:
> Add a simple binding doc for the pn532.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
> Changes in v6:
> - Rebased the patch series on v5.3-rc5
> - Picked up Rob's Reviewed-By

And dropped in v7?

> 
> Changes in v4:
> - Add documentation about reg property in case of i2c
> 
> Changes in v3:
> - seperate binding doc instead of entry in trivial-devices.txt
> 
>  .../devicetree/bindings/nfc/pn532.txt         | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nfc/pn532.txt
