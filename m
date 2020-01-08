Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9285A13484A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 17:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgAHQoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 11:44:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32909 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbgAHQoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:44:01 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so4240951otp.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7YudrN+HcdAitESoUxkwkQAilxZS2k+YB5rlrRgMBQ0=;
        b=EuE2DBW5TtEZFBB6WaaWEqIUdIALTfx3hdATG8x+wtlijSkkfTP09yYrjs8K23MHQF
         3mjMObIkAKqwxD3DOCiNA2L93y0QNGJc8Exk3fm8wRG1I1FEvYUuO7Sx4VF8cAto2ouW
         GlsMzZqZXBicj9+O4D9p60JI7iks7RonUaV+0urpQDD/0t0MwUplwQNira198GQbPL1B
         UKMq7U/ccboab7gbNWc905hyxMbj/gHBgC3ZBP2YlyDIuH6zim5YW683dqpc1G6JXCAu
         YMkxewTga5G3y8QzF1dhwYvmfA9XpgZtzywXgPRbin17pzYo+vSk6Z8JpfOd7tGxBnq1
         golA==
X-Gm-Message-State: APjAAAWUY9RyFrfLpO+3Av4fnjwkwW/oF+Ln5lBcoaQjrlTKcTylZSrA
        FiZdKuprjif540PW18upy/w54NY=
X-Google-Smtp-Source: APXvYqyLBABHJxSEPkZ5OjSme+Bqm1TkN62+xeRTdGMgNwZ2vVpiLKh6sK4tEZ4ZkU8YnhJZMttYlw==
X-Received: by 2002:a9d:23b5:: with SMTP id t50mr4705581otb.122.1578501839308;
        Wed, 08 Jan 2020 08:43:59 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c21sm1233489oiy.11.2020.01.08.08.43.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:43:58 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:43:57 -0600
Date:   Wed, 8 Jan 2020 10:43:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: Fix compile warning about
 of_mdiobus_child_is_phy
Message-ID: <20200108164357.GA17209@bogus>
References: <1577442659-12134-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1577442659-12134-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 06:30:59PM +0800, Tiezhu Yang wrote:
> Fix the following compile warning when CONFIG_OF_MDIO is not set:
> 
>   CC      drivers/net/phy/mdio_bus.o
> In file included from drivers/net/phy/mdio_bus.c:23:0:
> ./include/linux/of_mdio.h:58:13: warning: ‘of_mdiobus_child_is_phy’ defined but not used [-Wunused-function]
>  static bool of_mdiobus_child_is_phy(struct device_node *child)
>              ^
> 
> Fixes: 0aa4d016c043 ("of: mdio: export of_mdiobus_child_is_phy")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  include/linux/of_mdio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

A similar patch was already applied.

Rob
