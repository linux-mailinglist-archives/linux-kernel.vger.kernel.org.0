Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADF3176873
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 00:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgCBXsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 18:48:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34020 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgCBXsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:48:52 -0500
Received: by mail-ot1-f68.google.com with SMTP id j16so1222276otl.1;
        Mon, 02 Mar 2020 15:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=byoAHElTnalS7sh70czz1zpbq5DcI2Go9YowGpXx29w=;
        b=P+oVN0jJrxqFCYAznHgyFF0L/Aq2tKftXsDBd6M4FkjnZyGLDnYvpkO5+OPdd5jePq
         wR41UFuEgJaCF9EGrVxD0UlNVSKJXo8ThH0IVKZ3D9i0xi9xHO6Z/REbLxldq24Xy39n
         g/OFDbZ35XvNFyQoGVqV5nSrM5vvhofGkdHEjcTNQWrsvRc/ABRH1fK0el9KI3itKFPy
         4SxFWlExRgUoWfwkSU5EvbcfxjZe+GctL4KEHDfELGfGW4PpamVanHAq3JLfIxIphuMo
         k4mcdJiNhZ5+rxtOOcMKqtGCDWdt7Kvl9w/xrmwNeLE4SgzAm6HpU9PihD2emZTrp2za
         YEOw==
X-Gm-Message-State: ANhLgQ1szHQTGX8ywkmK52mOqg2N2vkVAChkIIhtW1xf15YbacQMNuYP
        FtWSW2Crab3cyYG61irRMA==
X-Google-Smtp-Source: ADFU+vunmxxGjVzwfLQGBVehqtYrFNHSS1vUq/QZk7+dEkP+TRwtQ/33euUrPd47iWoLdqcHigvWww==
X-Received: by 2002:a9d:5d07:: with SMTP id b7mr1331515oti.209.1583192930303;
        Mon, 02 Mar 2020 15:48:50 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w9sm641711oti.64.2020.03.02.15.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 15:48:49 -0800 (PST)
Received: (nullmailer pid 32323 invoked by uid 1000);
        Mon, 02 Mar 2020 23:48:49 -0000
Date:   Mon, 2 Mar 2020 17:48:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        =?iso-8859-1?Q?Jer=F4me?= Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: arm: amlogic: add support for the
 SmartLabs SML-5442TW
Message-ID: <20200302234849.GA32272@bogus>
References: <1583036241-88937-1-git-send-email-christianshewitt@gmail.com>
 <1583036241-88937-3-git-send-email-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583036241-88937-3-git-send-email-christianshewitt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  1 Mar 2020 08:17:20 +0400, Christian Hewitt wrote:
> The SML-5442TW is an STB for O2 Czech IPTV/VOD and DVB-T/T2 based on the
> Amlogic P231 reference design using the S905D chipset. Specs:
> 
> 2GB DDR3 RAM
> 8GB eMMC storage
> 10/100 Base-T Ethernet
> 802.11 a/b/g/n/ac + BT 4.1 HS sdio wireless module (QCA9377)
> 2x single colour and 1x dual colour LEDs on the front panel
> 1x reset button on the front panel
> HDMI 2.0 (4k@60p) video
> Composite video + 2-channel audio output on 3.5mm jack
> S/PDIF audio output
> Single DVB-T/T2 tuner (AVL6762/MxL608)
> 2x USB 2.0 ports
> 1x micro SD card slot
> UART pins (internal)
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
