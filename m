Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0391446CD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 23:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAUWBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 17:01:37 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42967 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAUWBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:01:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so4413976otd.9;
        Tue, 21 Jan 2020 14:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WLamrH1KcwfwPOF7XObLexp7z6M67I0bzxIY4IB2VTI=;
        b=YhoBsbiJxcXZp/lcxUzSb2KCWnDAJndgQZco12qzO4sPMiXHL92cU7QUTljYZdgA3C
         LIPdzKH7Kbz/bKT3NFJh0HupbcH32vU7/wigvwAwIh6PjnCp2LQjkaFDWgEkcTbGxgeD
         zTR3JH2MxKQH5h+M3T10mMZ+yYoP0l7d0+SDw4otd+R/W1ArPdqa8i0ejT7ROOKtV/uv
         49zLUiH172/wakj6++T8bDRTjiUjKjGksZJ2nUrQmvaeKBQVeathUUx08iRNjz9M7ywy
         fYsirte6uH25XhuiHPHva2tYlVdfOuRfyHaEkYarW/d+rnPvG5vZUJq6n/BudtCPKEol
         kRUA==
X-Gm-Message-State: APjAAAVcFCwFt9n5GGByjDhHtFF2BhkMsYUk48J7izf3tQ0TlfTr0PE2
        1EEI3td+q/4f07FXGbfCmw==
X-Google-Smtp-Source: APXvYqwYUtpnZeBhFJqfIbqggpjOxvmlOgiW69hH8RKvbBjceT9T20olL0zhaSZwIuY0rUy9QYz9lw==
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr5244408otd.266.1579644095826;
        Tue, 21 Jan 2020 14:01:35 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g19sm13994048otj.1.2020.01.21.14.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:01:35 -0800 (PST)
Received: (nullmailer pid 15322 invoked by uid 1000);
        Tue, 21 Jan 2020 22:01:34 -0000
Date:   Tue, 21 Jan 2020 16:01:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 3/3] dt-bindings: clock: Refine i.MX8MN clock binding
Message-ID: <20200121220134.GA15267@bogus>
References: <1578965167-31588-1-git-send-email-Anson.Huang@nxp.com>
 <1578965167-31588-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578965167-31588-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 09:26:07 +0800, Anson Huang wrote:
> Refine i.MX8MN clock binding by removing useless content and
> updating the example, it makes all i.MX8M SoCs' clock binding
> aligned.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  .../devicetree/bindings/clock/imx8mn-clock.yaml    | 48 +---------------------
>  1 file changed, 2 insertions(+), 46 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
