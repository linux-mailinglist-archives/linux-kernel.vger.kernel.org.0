Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2638013C80D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 16:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAOPjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 10:39:44 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43288 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgAOPjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:39:44 -0500
Received: by mail-oi1-f195.google.com with SMTP id p125so15751641oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 07:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oQF2OHgOU668qHE/qFtSpHWzGnN6zfD/pu9qzKZX2wY=;
        b=oDz8y1GKbWCc6UbtNs79m1I5dhg3oqhni7kZjeA7BZaoC8/qQxs9L22AoMl5iWtPZT
         0vOYML6jObM7FT3J3cc8Aa3k37PUEmU5dIHMsmbbdTDzTtxrP1g9P9s/M8debGK8xu++
         JTddaOT+qLQqXturfLfakMT+RXQOsWIRujm9hbBCZLS77i2WuJa1y57l2uJobrFduTSg
         U/hze+OIccDwToeKM/NVy17qHUZ0sJihRiOVDY1CLTeKxHjjha5en2SLsdLaNa5vTzyS
         UPQPMTTONmhl+B0Vz5J3QQZ2O6IbhpT3T+Y6av6HJtjZEM5pcQ7Q0gXkyfY7BSZodyE9
         lofw==
X-Gm-Message-State: APjAAAVrXIe1DaFcFAxg4Ypm49Y6pkIiwqB00m25e2fhhk9nRqPJuult
        uJgmQGP/DKxcPUHsebPF6lcaq9s=
X-Google-Smtp-Source: APXvYqwVzq1HBVQMjXZ4Stb24USqsheuar03FmHPZtSywxqvlMytJUJqps7cJ+gvqvSZ1nyQmUtj+w==
X-Received: by 2002:aca:b703:: with SMTP id h3mr292853oif.148.1579102782992;
        Wed, 15 Jan 2020 07:39:42 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q5sm5750501oia.21.2020.01.15.07.39.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:39:42 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220379
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:39:41 -0600
Date:   Wed, 15 Jan 2020 09:39:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Robert Yang <decatf@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: iio: accel: kxcjk1013: Document
 mount-matrix property
Message-ID: <20200115153941.GA9685@bogus>
References: <20200112203301.30235-1-digetx@gmail.com>
 <20200112203301.30235-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200112203301.30235-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2020 23:33:01 +0300, Dmitry Osipenko wrote:
> The generic IIO mount-matrix property conveys physical orientation of the
> hardware chip.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/kionix,kxcjk1013.txt     | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
