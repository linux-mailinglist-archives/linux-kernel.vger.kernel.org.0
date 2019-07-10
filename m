Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E00363924
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 18:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfGIQQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 12:16:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36308 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGIQQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:16:29 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so28805173iom.3;
        Tue, 09 Jul 2019 09:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cmH0c7rU2QLLyWG/6xPHKfwtrFCXaKp58TMMmxWczzs=;
        b=kS/DDqnkmmxjoLgy0uvqD6o7PBPT3zHGL6inZdhVqjD5P6pjs13B0/pFAeA0OMqQ/p
         HHhsCGkLFwtB3VFUZsxKPSTV78sDmzL3NDGz7iiLjhjX8+Xk9P6k4MmbqEcER0yAGhAV
         W4T7ieZotHL1zUz8Hmlji4io3plVHOh2YOGOmF060iFGWQ5S989s49Ikb4G3C2Cyeu0z
         DVFkcLRs2o7ZpYzC09KsTaJdDtX6QsoA863J0IjYdKyLIl3hOXqy7ZucYx7JdUhSFZmz
         3soW6tPL37HdZZXQIhlRvH8vkZoFLgvQZuGs05hKt/B6RVZAzVylTbTUVB7BUTvRIQ4q
         3DFg==
X-Gm-Message-State: APjAAAWTqG8tSOdfv+x60kc3pruI/YoDpBpHZLn51Lw4ZeAHUnhsUk5Z
        chJRSBTVmZBOsWuGxKas4iiz3J1V9g==
X-Google-Smtp-Source: APXvYqzdvfXwgR2WspdKABPMp95eGUqFQLHUA9L2KvpwEo20v19atw5mJsEZC4pFZvMvyV7fMi+5Rg==
X-Received: by 2002:a5d:9711:: with SMTP id h17mr20726190iol.280.1562688988577;
        Tue, 09 Jul 2019 09:16:28 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id 8sm13425764ion.26.2019.07.09.09.16.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 09:16:27 -0700 (PDT)
Date:   Tue, 9 Jul 2019 10:16:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v2 7/9] dt-bindings: sun6i-dsi: Add R40 DPHY compatible
 (w/  A31 fallback)
Message-ID: <20190709161626.GA28908@bogus>
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
 <20190614164324.9427-8-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614164324.9427-8-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019 22:13:22 +0530, Jagan Teki wrote:
> The MIPI DSI PHY controller on Allwinner R40 is similar
> on the one on A31.
> 
> Add R40 compatible and append A31 compatible as fallback.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
