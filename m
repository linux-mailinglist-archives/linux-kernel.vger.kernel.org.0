Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2777145952
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 17:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgAVQF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 11:05:56 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45998 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:05:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so6686109otp.12;
        Wed, 22 Jan 2020 08:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BADTgUineejOK2n1J7lKkTEFQH19K5N1CEhgckXRAeo=;
        b=Xb2u4+JjpWuvbkSqc6C3uXRckfBpxtQgrx2kq4FdXuuDN/SY91dpzoMG9s9C2znemm
         JGmgDagQOIBMYQxdkoPF67nM017xt+Mu7OuphrA2hCij4l+D5PVKTb06E+dIyiqJPGpQ
         Ozc6+qtNzoTg4xxVCajzPEkwNHmTFD8iaFApaTe866nXTurfHgYtTjyhOF0S3mhBNmGV
         VDNI66KpJ8fs0/f1Gd5xBs1TtijUTZoRKgAxrAGt7bVpEmOmJI8SflcS+9hUeGhsGsp0
         S7GLGY6BsJhbDu7iBD058G6j3v0jL4lvvsMwqQ03B4Pv0SBDwqGc5k8OOqjW+DH6a+6h
         oR2Q==
X-Gm-Message-State: APjAAAW8VvTnkTfln/HglogrLIaU39aaMM6IhH6TZDgSaS1JLE3yC7m+
        bCFqcwAVApKmgGNAweNgIA==
X-Google-Smtp-Source: APXvYqzU2mv1jLT2PDfalGIskqeW8nSLgN1KpqimkaMRG6wWiRuYAxbX9pFvaWjoXG/gl6a0X2+rRw==
X-Received: by 2002:a9d:75da:: with SMTP id c26mr7977313otl.40.1579709154723;
        Wed, 22 Jan 2020 08:05:54 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a17sm14694628otp.66.2020.01.22.08.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:05:54 -0800 (PST)
Received: (nullmailer pid 10857 invoked by uid 1000);
        Wed, 22 Jan 2020 16:05:53 -0000
Date:   Wed, 22 Jan 2020 10:05:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/3] dt-bindings: mmc: rockchip-dw-mshc: add
 description for rk3308
Message-ID: <20200122160553.GA10824@bogus>
References: <20200116152230.29831-1-jbx6244@gmail.com>
 <20200116152230.29831-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116152230.29831-3-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 16:22:30 +0100, Johan Jonker wrote:
> The description below is already in use for rk3308.dtsi,
> but was somehow never added to a document, so add
> "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc"
> for mmc nodes on a rk3308 platform to rockchip-dw-mshc.yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
