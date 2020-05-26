Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE46019A133
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 23:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgCaVsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 17:48:50 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39356 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgCaVsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:48:50 -0400
Received: by mail-il1-f194.google.com with SMTP id r5so21022084ilq.6;
        Tue, 31 Mar 2020 14:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B+duCudawvbCTKmXyXJ3eOuf7ahuLnq9qxk7sNQ38hY=;
        b=F0ji6U0UUpLzGf4Vn6+sg/9iTZQ/OFV+rJe6tX3XuR5ujZIvIniBHiwQ+OsrZfBt1a
         38CX8OwvWfWCNdkv0l1y/zTmDBFouuxQ2sxoAtbp53RFoOonuSzfq9Jw+g4TkHJqMXKl
         eGPjKmuQuv6UXm3hnP8cfRnqDBfOxcrmtsui3n0x3qB9MDmlVYMhFtrUWHifQkoHGFX1
         3UfJfFumLWNp2FEnhT1A4o5UMdVeJpzr1g0fCqvy4aATjh0A0NMmDjocuG2d+hQkqbP5
         0/QG+gFB0AFhP2Kt1JNGCIZppWRrNRTqoA+uKF4uMgMNtEY3qtcmQHeJJoylZ+MKKj1D
         ePjQ==
X-Gm-Message-State: ANhLgQ3UmNMfASDfp6GEE7kJFwMvGzs+FcZ3V/UHyN//lCOET9GE0c0s
        g7kcy78Mx5NLsWKCxJ/Frw==
X-Google-Smtp-Source: ADFU+vtHHB1tl92aufQ0mANPRYsjwcdU/Os8skfqkgrsqVhrY2o1LqgNd3APlflmiWiOCVZRfjC7aw==
X-Received: by 2002:a92:8548:: with SMTP id f69mr18533450ilh.20.1585691329472;
        Tue, 31 Mar 2020 14:48:49 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d19sm30169iob.30.2020.03.31.14.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:48:48 -0700 (PDT)
Received: (nullmailer pid 31436 invoked by uid 1000);
        Tue, 31 Mar 2020 21:48:47 -0000
Date:   Tue, 31 Mar 2020 15:48:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     kishon@ti.com, heiko@sntech.de, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: phy: convert phy-rockchip-inno-usb2
 bindings to yaml
Message-ID: <20200331214847.GA31349@bogus>
References: <20200325121335.12249-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325121335.12249-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 13:13:35 +0100, Johan Jonker wrote:
> Current dts files for Rockchip with 'usb2-phy' subnodes
> are manually verified. In order to automate this process
> phy-rockchip-inno-usb2.txt has to be converted to yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Changes v3:
>   Replace oneOf by enum
>   Remove allOf phy-provider.yaml
>   Add "#phy-cells"
>   Add additionalProperties: false
> 
> Changes v2:
>   Keep "rockchip,rk3366-usb2phy" support.
>   Add "#phy-cells" to example.
>   Add allOf phy-provider.yaml
> ---
>  .../bindings/phy/phy-rockchip-inno-usb2.txt        |  81 -----------
>  .../bindings/phy/phy-rockchip-inno-usb2.yaml       | 155 +++++++++++++++++++++
>  2 files changed, 155 insertions(+), 81 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
> 

Applied, thanks.

Rob
