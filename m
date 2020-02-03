Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5414150457
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 11:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgBCKgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 05:36:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50995 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgBCKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:36:42 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so15204432wmb.0;
        Mon, 03 Feb 2020 02:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mi8JQt8vSBVzm/nVSeG5kfzc6+/5194gMc5EPhZXRwM=;
        b=uodSqvldUkCTKBEMxDTPgzDXlexchEuIZ/+AKhmrqFo4ll/BE+p9/SuXM+f3lIwPDy
         Ssl7hLuJHKsB/v/YxyGP09prTlDL8sTJoWrvG4aIm6rVZbsisvqVv5hqnrWuAVhWtXVd
         uC6CWnuYfS/uJCmryJkMEAUCdNww3mlWgC9MecxxkSJBI8zJjd/IZJdww2EEZQUQqzGF
         AUPEkD3d/3GKyWAOUNXTWZvs1Np93aXJ+li9Ny/Iz1DEdv+bLjPWVc0UZvrZtwFFQyEI
         8Jr9BeiPSA7Gm/CwS8nkrM37uBp3s9aurh7VWbSgglaNqJ1uHAeooArkZQhCOJ1KMPQO
         q84w==
X-Gm-Message-State: APjAAAUtwVn0c6p8rP9WIhOwCctLKP1odLB+cQ4EGF7QvyPhmlLvyn/e
        IXCMpPpF2TadvHgVFFbIlQ==
X-Google-Smtp-Source: APXvYqw+09mw5xksG28pR2qfO//37YaXI2ChF/h++bNvnZkow//odOZDUP0tAml34WV+7KIKcqxg7Q==
X-Received: by 2002:a7b:ce10:: with SMTP id m16mr27157105wmc.115.1580726200574;
        Mon, 03 Feb 2020 02:36:40 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.163])
        by smtp.gmail.com with ESMTPSA id b16sm25866364wrj.23.2020.02.03.02.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 02:36:39 -0800 (PST)
Received: (nullmailer pid 7250 invoked by uid 1000);
        Mon, 03 Feb 2020 10:36:38 -0000
Date:   Mon, 3 Feb 2020 10:36:38 +0000
From:   Rob Herring <robh@kernel.org>
To:     Justin Swartz <justin.swartz@risingedge.co.za>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add rga to rk322x device tree
Message-ID: <20200203103638.GA32044@bogus>
References: <20200120194158.25357-1-justin.swartz@risingedge.co.za>
 <20200121220242.22815-1-justin.swartz@risingedge.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121220242.22815-1-justin.swartz@risingedge.co.za>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 10:02:39PM +0000, Justin Swartz wrote:
> This patchset aims to enable use of Rockchip's RGA, a 2D raster
> graphic acceleration unit, on rk322x based devices.
> 
> Changed in v3:
>   - Relocate rga node to the correct position in rk322x.dtsi, as
>     indicated by Johan Jonker.
> 
> Changes in v2:
>   - Remove unnecessary "rockchip,rk3228-rga" device tree compatibility
>     string patch, as advised by Ezequiel Garcia.

Why's that? You're using the string still, it needs to be documented.

Rob
