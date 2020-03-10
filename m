Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E9C1807F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 20:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgCJT1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 15:27:11 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46114 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgCJT1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:27:10 -0400
Received: by mail-oi1-f195.google.com with SMTP id a22so15047232oid.13;
        Tue, 10 Mar 2020 12:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zk3nV+rnevYhsEtIp8S5NhXsIWAJWfizdxJq3VogyBs=;
        b=WBI0Gj7K7iCUKY0aY61jBT6XVmHyhQx/3+S2opbg4My6XvJYAGZphzn13IwfnWqKKa
         dDeEm5JZymplkjLnWXggzvszpi6Gu5moELZ53bgBvbryxscJsBeUl1O3SffJC7phRiy8
         vkl2BkjLUDpdJl1sJhJUMMPSbdp8nfY9OKgWbmo9TsNWjHfqkOsd+mLSAF2yMtPks/Ro
         LDTexfvS+g7S0bHCwvfnbRRAiJfWEweSiH+HDDfoORK3P+wTDCpUPaMaZCKnLoyjOuXy
         4Cj661k+77I9w98Bgs+Ic3o6jV/rgdLs2Vdtqt+ce2eBAVmGjIUDvBEMISV4y5nSdqeq
         9vCg==
X-Gm-Message-State: ANhLgQ1AI2ImgqdYjgIkbivelrHV1UCwXcF2N4u8sqtZEEkOSDUQPlVM
        8qFEKNUW+7C2g9+5JYU9iQ==
X-Google-Smtp-Source: ADFU+vt4+g6JzZFc2bA7YzaatPyonL9+FOXoSCwg0RcSGx+p2akdnElyUgvTbw3URfv8kOoMSIEdUg==
X-Received: by 2002:aca:b1d5:: with SMTP id a204mr2321167oif.82.1583868430034;
        Tue, 10 Mar 2020 12:27:10 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j5sm16235753otl.71.2020.03.10.12.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:27:09 -0700 (PDT)
Received: (nullmailer pid 13676 invoked by uid 1000);
        Tue, 10 Mar 2020 19:27:08 -0000
Date:   Tue, 10 Mar 2020 14:27:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: fix Rockchip Kylin board
 bindings
Message-ID: <20200310192708.GA13604@bogus>
References: <20200302092759.3291-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302092759.3291-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Mar 2020 10:27:57 +0100, Johan Jonker wrote:
> A test with the command below gives this error:
> 
> arch/arm/boot/dts/rk3036-kylin.dt.yaml: /: compatible:
> ['rockchip,rk3036-kylin', 'rockchip,rk3036']
> is not valid under any of the given schemas
> 
> Normally the dt-binding is the authoritative part, so boards should follow
> the binding, but in the kylin-case the compatible from the .dts is used for
> years in the field now, so fix the binding, as otherwise
> we would break old users.
> 
> Fix this error by changing 'rockchip,kylin-rk3036' to
> 'rockchip,rk3036-kylin' in rockchip.yaml.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/rockchip.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
