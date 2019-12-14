Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9582D11EE8D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 00:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfLMX3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 18:29:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42584 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLMX3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:29:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id j22so2060276oij.9;
        Fri, 13 Dec 2019 15:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m7ZDoVimtRbppkq3mXaQzzU3mfgleq0CeC6M4xh1UDQ=;
        b=AKRx9J4dwBwHs/RtXmcqHbSkL/7XG4sxYXPt7kDkdhGBmXPcbqG7i9bmyfxtPjG9Jj
         uHcGDBZdckyueZECdIQW0r312BvW5MYTxnqmH4bmGw6iaLcuvlsAtmQCZuSlpcHieKf2
         ie6CfIuxk3nIdfBQXE7ARvxZ7Wl8XiWJO0Y3uqkSG8Ftl+z20Q/U4B/hqfXT7BRC9uv4
         fyAIBQu9qekslX4zH5YZLzRq9lDXXE1gu/y6UtSehWgd2YCUYn/aFLNOsuNDpH0f0flV
         ioNC27BcVYXGHWPY6VSM1eP7LH3nhb3c1PJpNLZ9srI0oRGjfzQyDnUIsdmL9SZZ8+w/
         ef/g==
X-Gm-Message-State: APjAAAXNjTBUQEjUSsH+d34vkbWNlIcdGhrMd79X5RpRU/NGOW4p9U49
        aG+0vGIv2voIcidn2gX3kg==
X-Google-Smtp-Source: APXvYqxxxXP3ATVpyq8gPqENQUD4uftWKFxljdXqs0fD2LDAfZJ7txJETyw1WR2Y8EXOFX8+Q3+Nmg==
X-Received: by 2002:aca:4183:: with SMTP id o125mr7767626oia.125.1576279779822;
        Fri, 13 Dec 2019 15:29:39 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q5sm3788415oia.21.2019.12.13.15.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:29:38 -0800 (PST)
Date:   Fri, 13 Dec 2019 17:29:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     devicetree@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Add a broadmobi entry
Message-ID: <20191213232938.GA26283@bogus>
References: <20191202172203.11917-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202172203.11917-1-angus@akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Dec 2019 10:22:03 -0700, "Angus Ainslie (Purism)" wrote:
> Add Shanghai Broadmobi Communication Technology Co.,Ltd. for their modem
> dts entries.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
