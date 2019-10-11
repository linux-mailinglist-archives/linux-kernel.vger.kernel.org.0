Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBE3D42CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 16:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfJKO0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 10:26:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42080 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbfJKO0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:26:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id c10so8106237otd.9;
        Fri, 11 Oct 2019 07:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0sXP7aU6qKZTyZKXCQXYeDcKFa2nychpYgtG2BtNMcE=;
        b=f5FFESqzYTK8dFMwevcKKjdoiHYy2OuFCRSnXA/HIdv9XUtk179xuUeFxhQ/M6ikhr
         VY/39XvZmibQAoXzmfrholvuKG4t95MRbISaDo+BxPGqj2mlF8RVrPM0TMUiQ/g5sB8t
         TwnCR9hlUEI3PS0/6/sGEUGuRkUy5y/cbJmJlr3XnnRJQcJ4oTHFrufIauDFuxbikBsp
         iYrRtlaJfCoD5RLuz7TqM2h6JeJr3LgxeHTZBxHwjwjoxQWXmWuy9UaPIWh03ohLTOWj
         BtF46gDr65k5vBO+fb8zaMUIpMGg4/nG8w4nrtSZSdNxvrO3nVYHi3r0l/ea26rjmSEf
         WTCQ==
X-Gm-Message-State: APjAAAV0G4rbYtb7njsvFmStfEkK6PFDuePvATjfvT1VKqW8yDIFWfK6
        9J8iLlUQYDh1L4WSy75G8Q==
X-Google-Smtp-Source: APXvYqzgN/fv6O0f3DUaNGIVyCz4N6l22G8C1+jX2gKw2dQJ11I1w+uXFqvbkbZLVrJUjhEeDCwV5w==
X-Received: by 2002:a05:6830:1619:: with SMTP id g25mr12671280otr.195.1570803982282;
        Fri, 11 Oct 2019 07:26:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y18sm2621979oto.2.2019.10.11.07.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:26:21 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:26:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     catalin.marinas@arm.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux@armlinux.org.uk,
        mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, will@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH v3 03/11] dt-bindings: crypto: Add DT bindings
 documentation for sun8i-ce Crypto Engine
Message-ID: <20191011142620.GA11285@bogus>
References: <20191010182328.15826-1-clabbe.montjoie@gmail.com>
 <20191010182328.15826-4-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010182328.15826-4-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 20:23:20 +0200, Corentin Labbe wrote:
> This patch adds documentation for Device-Tree bindings for the
> Crypto Engine cryptographic accelerator driver.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  .../bindings/crypto/allwinner,sun8i-ce.yaml   | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
