Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB8D1808F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 21:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCJURj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 16:17:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33576 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJURj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:17:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id g15so8400629otr.0;
        Tue, 10 Mar 2020 13:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SALtb00tEMzq9uXRFmiEx+QH3Zf98Xn1eLOE8cTe24I=;
        b=W/8rLsfafV8/aTCibIqkDcQ0EKqQ6uOq5hOD5FuaM0P8CDcyBM/mX3g8uog911l9t+
         bmQnw2iTun+nHhIjtt4D3QRmb79MgESkz3FCXOm4ygtkLNM21XapZ15zXv6LaF2JktuX
         ra0w9B4U2I6FCF7xLMemaVCeMmctt1ePrA6RuXC1X9R+13h+XomrmcLTj24jQXpG7vt6
         98D0BCpRe8GdibSn+o0w2zpDRjBRPw5k8eE8GK+PeeYt+09GKOYUY7C5W4Mi2R88sNCp
         QHB36NevxLJMo1Vl9shT4CMB07YpzVm+E6OFM6Nnw/7hDLfs2m1xhpZWA82sT9HB6N7a
         ZSOQ==
X-Gm-Message-State: ANhLgQ2tYaiZ2VYMVr4pBfvismgFbOSH+V3wdcl4gwgN0XyvQWAYwYEf
        kTAFV6COHtGDJX6Xs7nM9w==
X-Google-Smtp-Source: ADFU+vvd4bWBEv3HptnfOHpj19yNbzPlCehj5aSpWXjg8ppsPpo03XcBLibrk39Ai/jwvcUg9e35Xw==
X-Received: by 2002:a05:6830:1d69:: with SMTP id l9mr18434593oti.192.1583871456874;
        Tue, 10 Mar 2020 13:17:36 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l1sm4573693oic.22.2020.03.10.13.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 13:17:35 -0700 (PDT)
Received: (nullmailer pid 31532 invoked by uid 1000);
        Tue, 10 Mar 2020 20:17:34 -0000
Date:   Tue, 10 Mar 2020 15:17:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [RFC 07/11] dt-bindings: clocks: imx8mp: Add ids for audiomix
 clocks
Message-ID: <20200310201734.GA31480@bogus>
References: <1583226206-19758-1-git-send-email-abel.vesa@nxp.com>
 <1583226206-19758-8-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583226206-19758-8-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Mar 2020 11:03:22 +0200, Abel Vesa wrote:
> Add all the clock ids for the audiomix clocks.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  include/dt-bindings/clock/imx8mp-clock.h | 62 ++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
