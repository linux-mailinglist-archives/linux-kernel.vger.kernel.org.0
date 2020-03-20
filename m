Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E73E18DB34
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 23:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCTWf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 18:35:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40866 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgCTWf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 18:35:28 -0400
Received: by mail-io1-f66.google.com with SMTP id h18so7656874ioh.7;
        Fri, 20 Mar 2020 15:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LRGI96tcI4ghnjFtC4NBoCbXfwi3WMWoeeiOveVxAlo=;
        b=o2003rKgxG0vwqCtWteBesehbiGFikRIOurCP5C3lbrYZUa4u8cEi5Okw3dqNAA5So
         KLC34BQ6vGp7PF8yOYnwHNxai2siKcamn5t19+8O9qT9p12SRXrkHXqADwmdAAaMciVS
         DZUOGecraS7JMhuXjC5yTtw2GIFFVGrxLR/DjmDmSZvqx78HJncwYH2e1O+U+vOdZc5P
         yVRCWW8DKVFvst/TEV7iIzgj5BGJlo647A5M0GdYeLYVa2qtgX8nUiM1hQ3EQfeEm/6r
         ybg0t2MV5lK+lQ+E5G9VqMJx5iaHUZGiNmE/yopciPu+fd7li3KTcEzZyelKYaVIuSvt
         PLvA==
X-Gm-Message-State: ANhLgQ0uW8kMdo8edModu+EfRWxjA+TiMsBt9AQCxomAufiwjvADD7pu
        cVKGkKo8eOITfZTF5zyLdw==
X-Google-Smtp-Source: ADFU+vstZqfejwgfrWB4ZuxMmHA68v/Z1RwURf4BOfv0nPRoPofxGNKzQ2XmCiQNzs3JDFNcY9p6zg==
X-Received: by 2002:a05:6638:59b:: with SMTP id a27mr10099268jar.25.1584743727296;
        Fri, 20 Mar 2020 15:35:27 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f12sm2082920iog.46.2020.03.20.15.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 15:35:26 -0700 (PDT)
Received: (nullmailer pid 21977 invoked by uid 1000);
        Fri, 20 Mar 2020 22:35:24 -0000
Date:   Fri, 20 Mar 2020 16:35:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robert Jones <rjones@gateworks.com>,
        =?iso-8859-1?Q?S=E9bastien?= Szymanski 
        <sebastien.szymanski@armadeus.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: fsl: add nxp based toradex
 colibri bindings
Message-ID: <20200320223524.GA21944@bogus>
References: <20200316143345.30823-1-igor.opaniuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316143345.30823-1-igor.opaniuk@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Mar 2020 16:33:44 +0200, Igor Opaniuk wrote:
> From: Igor Opaniuk <igor.opaniuk@toradex.com>
> 
> Document Colibri iMX6S/DL V1.1x re-design devicetree binding.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
