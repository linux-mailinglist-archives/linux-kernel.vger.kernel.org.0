Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBED134DAA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 21:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgAHUc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 15:32:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43074 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAHUc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:32:28 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so3846615oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 12:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jcxZrCd2+72i2RRqwXRwqBU4vHF81GUXpnT3KHwf8To=;
        b=HUiz3qUFI5y+MJMjiwU69geyU2tTIOn0v5s4msy3WbzG386P63A4bZxaXkShmxdgYI
         N3/2x1WCvpB1EgwreAcyxBnbyqgaoUTFCQmYGLa8bzoAB+mPJBw63vnOz1FvIOCm/lnb
         J1UESfMUMwnq9R32qi0tbnG1ecHlFdQplgNDCPIvgauPpp9//BTW6crVPgvLaLhFAsXF
         k0q5q2FbIdIQ+x8b0L0ZJMTCzDhKJPyp6cfngEwuF1+5wPraBPaUplJjbfy3dy7xvYSy
         AQaI3fWGdSc/XzshWJujrQnXWlCadpgtI1mjH/ePwkJHsIc74aTfbWpCtGXw3y8r2MaU
         15yg==
X-Gm-Message-State: APjAAAUs/rBQmw12nKnAYQFBLPFTMbu/sDhKq4YigD791ovsFPacRQNz
        baavLb/arfIDHzlphLbxyw/SJgU=
X-Google-Smtp-Source: APXvYqwCqd3UXGz7qYbVmkMd6g3xpts8sw7NQNuSE2yDi1S//qQnIY/xTSeUC6IJYZC2YyKLro/Diw==
X-Received: by 2002:a05:6808:ab1:: with SMTP id r17mr324954oij.141.1578515547778;
        Wed, 08 Jan 2020 12:32:27 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z12sm1500194oti.22.2020.01.08.12.32.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 12:32:26 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 14:32:26 -0600
Date:   Wed, 8 Jan 2020 14:32:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] dt-bindings: add vendor Monolithic Power Systems
Message-ID: <20200108203226.GA17283@bogus>
References: <20200106211633.2882-1-m.reichl@fivetechno.de>
 <20200106211633.2882-4-m.reichl@fivetechno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106211633.2882-4-m.reichl@fivetechno.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jan 2020 22:16:26 +0100, Markus Reichl wrote:
> MPS produce power regulators like the MP8859.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
