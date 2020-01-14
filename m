Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6057113B542
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 23:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgANWWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 17:22:25 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41251 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgANWWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 17:22:24 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so14254528otc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 14:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yb6xHORuBeJhfPujkVSQ5MYYi1HxS0bOoVjowX+c/ks=;
        b=a1sMDgnPVUJ0VUDL4d3QzT/Fw/CnnaAHaJ7iYDkjHwPloFzLMIHNSdWszGxJh2LsGx
         kkJ/GBk7jthCljETGE7hE249OOppsKABoJXKJkkuzYMdh83yiWz8n4kcZ8VMaROdPqew
         hCjFdXY57Tk1sxismHyDwJi+8B1mmaJC+XiPnZyOs8PFtzPPf3JYE/XHfyG83Ihpe/CE
         kHSxXnoK98Luff/kUnGjfW1z2o4Byjx0rvuBmKczGg+3IV9XoBnTpMx1/Kof4KaNTK0x
         GJ0kA8tPP7Mnqf4/b+6/JD7cygflvJuMLWeUXgYh5ENzdtzgqE0wYVyRysOV/9ri2KEB
         /crw==
X-Gm-Message-State: APjAAAX1H2mMsKatA6TQdFJIecZ7lxxWB+Dmk4JoAZ6y9Hl8a+VRJ1J+
        0bSM47NbpE2tk5GRmeNlGhWlUy4=
X-Google-Smtp-Source: APXvYqzZV3UdqXaq+nrtqjFGCLfPtTBI2LpaKTszPvdInCFpT2JREJY6yB/V7n5yl5P2lj92N+lnBg==
X-Received: by 2002:a9d:3a65:: with SMTP id j92mr476677otc.37.1579040544124;
        Tue, 14 Jan 2020 14:22:24 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 15sm5017305oin.5.2020.01.14.14.22.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 14:22:23 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221a3a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 16:22:22 -0600
Date:   Tue, 14 Jan 2020 16:22:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xingyu Chen <xingyu.chen@amlogic.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, linux-watchdog@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/5] dt-bindings: watchdog: add new binding for meson
 secure watchdog
Message-ID: <20200114222222.GA21654@bogus>
References: <1578973527-4759-1-git-send-email-xingyu.chen@amlogic.com>
 <1578973527-4759-4-git-send-email-xingyu.chen@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578973527-4759-4-git-send-email-xingyu.chen@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 11:45:25 +0800, Xingyu Chen wrote:
> The binding targets the Meson-A/C series compatible SoCs, in which the
> watchdog registers are in secure world.
> 
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> ---
>  .../bindings/watchdog/amlogic,meson-sec-wdt.yaml   | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/amlogic,meson-sec-wdt.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
