Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2283013C77C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 16:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgAOPYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 10:24:04 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42183 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgAOPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:24:04 -0500
Received: by mail-oi1-f194.google.com with SMTP id 18so15701856oin.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 07:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P/3+h18PWi0rPObNUTxyncVSLqQVYDEB0c+gxo42pyg=;
        b=muAE11BY+dsL+d7U9r5jlGmG2500bRFQtovxDogqcOgY5VotmejA5h61I4JYKnN+Kd
         s51gwtyfR/1KxMsboY/Fl1JYJMHZ9N00664B73mqGDmqKwR0Z4e7WHqZ2PoSwNU/0Adm
         3OrzHcUmMOmM7D95j3DkWtKLmeBoPoB5vtOR7FeqXQsaJkAU9dUUDjZuaV7nGwCdr2GA
         RkEYPfDBTYvYfWkuEDw1LFpbbrru+pjLWEIRxFrsy7rxwR4aPD/8pDvb2xnnlcL9msnc
         9jQJ3sdqKdOJQHfOjeuViHly23SLCGscRPjWdW3JrQ3NjSycEVAvVw2DwCio4l8qcj/q
         ZKwQ==
X-Gm-Message-State: APjAAAUq0X6ZqfJATmQung1jiW1I4XitWMeW1vGW4JCOSN/SsuUkRxjz
        oE7oddBismMIAmUgjaGOys9htVo=
X-Google-Smtp-Source: APXvYqzxTJotCPWMl+o9sttzXQQpi6ioeIP2OQvXISpkacf/wOhsB4zLTsih9XLZfFBtgMpcrNMs3g==
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr277497oij.0.1579101843137;
        Wed, 15 Jan 2020 07:24:03 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z21sm6600079oto.52.2020.01.15.07.24.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:24:02 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22040c
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:24:01 -0600
Date:   Wed, 15 Jan 2020 09:24:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 4/5] dt-bindings: arm: sunxi: add binding for PineTab
 tablet
Message-ID: <20200115152401.GA15812@bogus>
References: <20200110155225.1051749-1-icenowy@aosc.io>
 <20200110155225.1051749-5-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110155225.1051749-5-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 23:52:24 +0800, Icenowy Zheng wrote:
> Add the device tree binding for Pine64's PineTab tablet, which uses
> Allwinner A64 SoC.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
