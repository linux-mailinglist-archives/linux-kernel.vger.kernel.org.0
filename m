Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD2041807F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 20:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgCJT1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 15:27:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35877 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgCJT1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:27:41 -0400
Received: by mail-oi1-f193.google.com with SMTP id k18so2057027oib.3;
        Tue, 10 Mar 2020 12:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2lXAOtfUNJwV/UZjRrVCvi9g1TVoJjiAHJ4McAxapBE=;
        b=Z/UaSsJ7Xf8XQHU83iHe6WjA9jj709JqHPyL8FExhS1tFFuvkXjr2lt1W3yxeh7XSB
         QXklCW/mdXjzTczUsJBvv0rN/0Ag3oAqI1ryeZZqr9UXRNQoTk5WRkCgXDtVEHiC0mJx
         4sqvYi6BHW1cjjaay3klz8SJH0q+oaoaOkuCKpaTFz6c3abZZeJjFwYN+UPf3gIjeFws
         OV6FJ0pgjt3g69qEFKxOF7hkzF12pZ+iVNjdpKk2s5ERtwPF7QkBIKDyaIjUGjtL/5rk
         mz9nwA8pheDdQa+EpTHtZfoHttyjmsj29ydd/huvGNMiMivolAIAbxQqAJ74RHVACevg
         A9kw==
X-Gm-Message-State: ANhLgQ0WuRdiug5j+Ldtc2+tdscGFmqnVc3Fye6HVns9sNrouqF5INEF
        M7FCShS5w3xo83olNqruvg==
X-Google-Smtp-Source: ADFU+vtHlGSiCDvcMp7DplfwyvRqWh2+hg+grkGoN94UOz4kFCTNzNZ+btv/5xQ+r3ApEWQB3x7C2A==
X-Received: by 2002:aca:8d5:: with SMTP id 204mr2257269oii.141.1583868459024;
        Tue, 10 Mar 2020 12:27:39 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s2sm8970666otp.35.2020.03.10.12.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:27:38 -0700 (PDT)
Received: (nullmailer pid 14587 invoked by uid 1000);
        Tue, 10 Mar 2020 19:27:37 -0000
Date:   Tue, 10 Mar 2020 14:27:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: add Rockchip rk3036-evb board
Message-ID: <20200310192737.GA14520@bogus>
References: <20200302092759.3291-1-jbx6244@gmail.com>
 <20200302092759.3291-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302092759.3291-2-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Mar 2020 10:27:58 +0100, Johan Jonker wrote:
> A test with the command below gives this error:
> 
> arch/arm/boot/dts/rk3036-evb.dt.yaml: /: compatible:
> ['rockchip,rk3036-evb', 'rockchip,rk3036']
> is not valid under any of the given schemas
> 
> This board was somehow never added to the documentation.
> Fix this error by adding the rk3036-evb board to rockchip.yaml.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/rockchip.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
