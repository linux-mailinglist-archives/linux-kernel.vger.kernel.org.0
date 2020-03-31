Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04431199FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 22:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbgCaUCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 16:02:38 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:42405 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgCaUCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:02:38 -0400
Received: by mail-il1-f181.google.com with SMTP id f16so20713449ilj.9;
        Tue, 31 Mar 2020 13:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=upP4G73Ul2SBmEIEQRpdxDJ/Oi/LqfJPjjsfAUlUCuA=;
        b=hZCMr5pqBFRnd9adFzdzifKLOXmuG23voEATK6EAialNcl8tIg5P5Iu4/k1774T7Kj
         81W3HHASFCqC45a71HLIVEtKDyz0OoPDVdR35OSKjrp9u6hLm/qb1XR5zxTSU9OF9A+0
         /+g7u0aESSamKGNC1Lf5g97MOIk+aZo86UhKh8bfzuAaGpq/VF8pJuhZUogMnVejgEOl
         qEhHyFgVEdnwY1C2utTtXMkeyjJkKMum/6RhbkoJHL7nPmCOLHiYoA3GKCYXjL4uR0Gy
         yHl5XIVhyrtnScJzRwqLtUMDrcdxuNXilZyG4+9Djf4V1zrvpmoelkJSbTzsoQzAM4P4
         Vx+A==
X-Gm-Message-State: ANhLgQ0ArDQMqmO30NCCCQAgqkEp5LWnpMxlXluzSxy5hyZi05cE0QkG
        zUrhIDeLPxIAfxjXR8g+YKgr3gMfvg==
X-Google-Smtp-Source: ADFU+vsJ21NZsBEEqm7Lb7K1Azezc2Df6E2CAGi6OWzLR6nfUVM5t4Rj0udq+sSnbbVAaPxyxLYSJA==
X-Received: by 2002:a92:b68d:: with SMTP id m13mr18155314ill.152.1585684957653;
        Tue, 31 Mar 2020 13:02:37 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o23sm6237099ild.33.2020.03.31.13.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 13:02:37 -0700 (PDT)
Received: (nullmailer pid 8303 invoked by uid 1000);
        Tue, 31 Mar 2020 20:02:36 -0000
Date:   Tue, 31 Mar 2020 14:02:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: Add Beacon vendor
 prefix
Message-ID: <20200331200236.GA8247@bogus>
References: <20200324144324.21178-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324144324.21178-1-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 09:43:22 -0500, Adam Ford wrote:
> Beacon EmebeddedWorks is the brand owned by Compass Electronics Group,
> LLC based out of the United States.
> https://beaconembedded.com/
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

Applied, thanks.

Rob
