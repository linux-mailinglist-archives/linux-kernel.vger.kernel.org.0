Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1391B139CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 23:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAMWiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 17:38:55 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:47013 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:38:54 -0500
Received: by mail-oi1-f194.google.com with SMTP id 13so9912095oij.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 14:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ro5qRPwmJVtGIpYVE3YFMYFRyOwvi8jNaWfJYatPWAA=;
        b=r+VCiXcp0QztawkkcR0gbV5cTjfp3WtA87TkN5uMf8/R+I9qc1JUgL6ENubRs0DS56
         pzMM7dUoV+HZN2vAgayl/u+6D5/cr3NCys6EnTVl8NJaeeRLBwFRkeNEkaoo8XK6417c
         5g5W7YV6/kY+4kC5F/EXW+vVCIrmKDCrFw1A0v0yScYtFIrQDX1Ddbm8Q6FoDBs13TEv
         1XxkX+YJbbh0mEzhbKmIswhkLlytBOKeKnVH5Ta0ppbv2yZcSLXi7bR7C4gkByTtSfos
         GRq+16laVEMItct/wLvm6jMAzzHoc4Z1KO8QZJQdqA7YcHDBZBaynLwb5YVItYPQV4q6
         hbEw==
X-Gm-Message-State: APjAAAWyMouqI+XX6MM9XqQ6F5pvgV6extVsqw+7XJ0U+2IAQ9dp570A
        g4/9mMK+oxTRrbDHrjvvYI4Avjc=
X-Google-Smtp-Source: APXvYqzDszdGLv3oRJS3lmiA9KpIwjjMqovQFe3S9bYsOUU7iOpW5EbNA1WQHZ3GcH4XvD+8qzzxLg==
X-Received: by 2002:aca:7244:: with SMTP id p65mr13849844oic.50.1578955133687;
        Mon, 13 Jan 2020 14:38:53 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c7sm4691056otm.63.2020.01.13.14.38.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 14:38:52 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 16:38:51 -0600
Date:   Mon, 13 Jan 2020 16:38:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: mailbox: Add a sun6i message box
 binding
Message-ID: <20200113223851.GA30654@bogus>
References: <20200113051852.15996-1-samuel@sholland.org>
 <20200113051852.15996-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113051852.15996-2-samuel@sholland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2020 23:18:47 -0600, Samuel Holland wrote:
> This mailbox hardware is present in Allwinner sun6i, sun8i, sun9i, and
> sun50i SoCs. Add a device tree binding for it.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../mailbox/allwinner,sun6i-a31-msgbox.yaml   | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
