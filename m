Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3677C199F21
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 21:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgCaTcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 15:32:12 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40112 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgCaTcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:32:11 -0400
Received: by mail-il1-f196.google.com with SMTP id j9so20687466ilr.7;
        Tue, 31 Mar 2020 12:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ffyuJBft5eRj0uXoExB7KaHT1VC+KdBgrEZukPCp/jk=;
        b=IAUlI2ghkL9cn58LkUS49/bjbCNzfOlDNObjJN/kNLwam+bz7q7J0PqGi2/wMVe7f5
         Yz/LCLVveHaAMmshrLoePN9r849zogGjRYnVgQ2u3t7Xl2EdbjXv4LcvD1GEe/+V17Ud
         /gjyp6HpEOyQUKMaZyfGo+LDEkhbo4LIW1JaiEku2ErdWR+dMDIj8TYkSpvOVr9nG8kR
         iTTQgmbQqRVOPJ23Q/iP48NRHjjP/5XnBtYZhPLUZ5gvJCgkOQJS+/J+2Tsuxkna8yrF
         mh8TJJhNoP9eUNnK5Cwff39DXJ6f0aoiZV/uMjuYIS1Y4L+XoI1Ul9W2ipe8foJdL1sY
         m6lw==
X-Gm-Message-State: ANhLgQ3/LCTsXW8HNBdyFZ43eKLAn9OTbBHPk3cVA5s3ExstqFC0mz9i
        KRw+M4vTTa+Pi1ffoOtm0A==
X-Google-Smtp-Source: ADFU+vs20F/WPfwobCVQDiWAIDI6LL0zgRgv9YyT1gwXPo5RofbdAd8avWmVDPg2Lg2rbY31XKH7RA==
X-Received: by 2002:a92:48cb:: with SMTP id j72mr18224637ilg.162.1585683130347;
        Tue, 31 Mar 2020 12:32:10 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d70sm6197008ill.57.2020.03.31.12.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:32:09 -0700 (PDT)
Received: (nullmailer pid 30593 invoked by uid 1000);
        Tue, 31 Mar 2020 19:32:08 -0000
Date:   Tue, 31 Mar 2020 13:32:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, heiko@sntech.de,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: sound: rockchip-i2s: add
 power-domains property
Message-ID: <20200331193208.GA30530@bogus>
References: <20200324094149.6904-1-jbx6244@gmail.com>
 <20200324094149.6904-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324094149.6904-3-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 10:41:49 +0100, Johan Jonker wrote:
> In the old txt situation we add/describe only properties that are used
> by the driver/hardware itself. With yaml it also filters things in a
> node that are used by other drivers like 'power-domains' for rk3399,
> so add it to 'rockchip-i2s.yaml'.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
