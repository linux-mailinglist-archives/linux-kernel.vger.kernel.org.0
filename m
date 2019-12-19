Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40C411271AC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 00:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfLSXll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 18:41:41 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33716 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfLSXlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:41:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id b18so9369742otp.0;
        Thu, 19 Dec 2019 15:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tuBWf96skjWrgBgsVs1eiTg/OmTbAgb7ulePOSz2Qnw=;
        b=t7Pn1zrF/O+rbi8qdRYBTy6nROYC1ohU+dua5kLpjcqbqhJ3UygqVr0RdSSMiuJyFp
         OlVKJrJur/PpSs5UlSkHXxzFsUmQT0OJrYdj2Vv8ODgMWJN2JrfDjLo69ctuu1sqiS2d
         qEB+5qwRxqjuPmBcTQwWaif9j3c6dX6RjUWQykV1vlKbwq1PD/KQ8Fi7nY67fegzdid5
         ceyqfWJpXsgYd1fYROz2ZVlSzKDARUL+6yErHWu7taEyUS8gmRu3eusY4FKFHo9z1v8J
         gEy1gb7tOnzBGv6dHTQspDDLLaePEW19fxKo7fXfvYwHnI2AGiFdboR8WdGf8lcIZ4t+
         w78Q==
X-Gm-Message-State: APjAAAXImPdAPFQePoRcFE9XzmFv8kQidx93utwiXovr1/Jxd/Dz/qCg
        MCvxW9uN9SxEKmjZiyFYBg==
X-Google-Smtp-Source: APXvYqx+c5pPnClOFiso3xv+CWXNZAeT4mHx+To+J+sLUZ0f72ogS0fPdQJKxDJGcfYcgfzf04IN3A==
X-Received: by 2002:a05:6830:1608:: with SMTP id g8mr11056854otr.169.1576798899680;
        Thu, 19 Dec 2019 15:41:39 -0800 (PST)
Received: from localhost (ip-184-205-174-147.ftwttx.spcsdns.net. [184.205.174.147])
        by smtp.gmail.com with ESMTPSA id c12sm2555901oic.27.2019.12.19.15.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 15:41:39 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:41:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, peng.fan@nxp.com,
        ping.bai@nxp.com, Adam Ford <aford173@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/7] dt-bindings: imx-gpcv2: Update bindings to
 support i.MX8M Mini
Message-ID: <20191219234136.GA21689@bogus>
References: <20191213160542.15757-1-aford173@gmail.com>
 <20191213160542.15757-5-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213160542.15757-5-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 10:05:39 -0600, Adam Ford wrote:
> The with the recent additions to the driver, the GPCv2 driver can
> support the i.MX8M Mini, but it needs updated 'compatible' entry
> to use the proper table.
> 
> This patch adds the i.MX8MM to the compatible list of devices.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  No Change
> 
>  Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
