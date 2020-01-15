Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4030A13C75F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 16:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAOPWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 10:22:31 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34666 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgAOPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:22:30 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so15726142oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 07:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A7MJTIvyK8kzMyer64PozPs2FgL7mrURdQQ2XoMswP4=;
        b=RW1pvE7+MWZ8MDYxAr570wxsXXSF/KqqFxt03EOh25WLjcYKPCl3aI30JcaP/6C39H
         dIglYps+5ImcuFPNNbMOX2IHHIeL33vWl3gJ/lmLjYa61rB6rpgj0zgQIaE21geQJ6JN
         SX+ZCOfWiGWWbweHtWooCEz3YFNvDEpvSc0nMtwy0A5zmzcG1GnIo7ZE7V+bdPFI4ynY
         o+WKaOpYmJV5lPZuZOZB3DNQ4hNubOeZZe+zMYWWZvQX0QexMb5wrXwqQn4mzeXAq01G
         jRYRpOx2aSG+Fyj/3tMg1+299JcNkQkHLD95kerYJIdFs3Bm1F8DEkW0nf6IeLKy4EuT
         8k6g==
X-Gm-Message-State: APjAAAXBWPQxHGK1CvodXkhXvrSXxJwU3AEu07DsXQeEMa7zkZAdfSO3
        GESFtOUbvxRfhiJvI1alW4iYFHM=
X-Google-Smtp-Source: APXvYqzzvsrN3HUb4HIwiRBapyOBtPXjpHgANdZlfPR9VAjVXsszqPdZOM5PK6DcUR0nJeALs7R31g==
X-Received: by 2002:aca:f5c1:: with SMTP id t184mr222486oih.23.1579101749825;
        Wed, 15 Jan 2020 07:22:29 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i6sm5723991oie.12.2020.01.15.07.22.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:22:29 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220379
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:22:27 -0600
Date:   Wed, 15 Jan 2020 09:22:27 -0600
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
Subject: Re: [PATCH 1/5] dt-bindings: vendor-prefix: add Shenzhen Feixin
  Photoelectics Co., Ltd
Message-ID: <20200115152227.GA13106@bogus>
References: <20200110155225.1051749-1-icenowy@aosc.io>
 <20200110155225.1051749-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110155225.1051749-2-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 23:52:21 +0800, Icenowy Zheng wrote:
> Shenzhen Feixin Photoelectics Co., Ltd is a company to provide LCD
> modules.
> 
> Add its vendor prefix.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
