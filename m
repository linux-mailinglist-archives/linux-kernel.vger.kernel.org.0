Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8A011257BD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 00:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfLRX2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 18:28:04 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42446 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLRX2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:28:03 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so4554074otd.9;
        Wed, 18 Dec 2019 15:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ZyKu0j0L9P7EvNBTxpXXf5dLPtT7NxrO5TJj8pvG5Y=;
        b=hagH+WzcPCj5kQRzJkjSsDBJnAZ/8sDX4zQp2MbznxGTBL5dBiKdyTL2bhj/vVz67r
         rL7fvtQ6l4l6c7D2BIwYuzw/lswe7WDPTNUXs1i91koDMMKOGvgfkDGi8JXl/LknXQuE
         8KS+zSW/0VtccllfqnZOLFMuBOZiky7NjQFBx0oSLqiVcBOSEDLlR+HKWsUZLGCdDZDN
         4+AcvxImpEAFcvb6vCbmjwnQb6tpeCdLQAgJ6EPk1/LWeHMl1J3ijSu4QE8wqotHVtuD
         GP93pfS7VV8Qbeo5hOYuoYRPdBfMCzRX2migc6XrAKAi5OcdNySJpuAJxCFSarjHm/6f
         0lDw==
X-Gm-Message-State: APjAAAX2FnoHyrdDfhScWEU53eMrpOW/HaxIFa24EqjqflJ1Uw/7qnuJ
        vwW7IRullOVFVLF19DBUbg==
X-Google-Smtp-Source: APXvYqwFPAhcuE93trHjiCLFU7ouah/UBbc6dMZe8ceDZG28OQ30K7jW48tVS8UqkME+NAqnpXd6Vw==
X-Received: by 2002:a05:6830:1248:: with SMTP id s8mr5388885otp.202.1576711682987;
        Wed, 18 Dec 2019 15:28:02 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w203sm1369927oia.12.2019.12.18.15.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 15:28:02 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:28:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     James Tai <james.tai@realtek.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: realtek: Document RTD1319 and
 Realtek PymParticle EVB
Message-ID: <20191218232801.GA28835@bogus>
References: <20191205082555.22633-1-james.tai@realtek.com>
 <20191205082555.22633-2-james.tai@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205082555.22633-2-james.tai@realtek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2019 16:25:54 +0800, James Tai wrote:
> Define compatible strings for Realtek RTD1319 SoC and Realtek PymParticle
> EVB.
> 
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
>  Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
