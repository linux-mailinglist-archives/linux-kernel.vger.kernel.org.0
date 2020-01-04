Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824CC13048A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 22:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgADVMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 16:12:00 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40661 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgADVL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:11:59 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so44727987iop.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B0Hpin+TA8PZ/UPU++QRg3TQKcelVhxJf7UGPi4P5JQ=;
        b=nN0V+WZpJ5UlaT1O78jrptteqVlT4hAp+Ko0GrPl+RZosDaMnsodOP2u7fOQZEzp2Y
         ZpPRgY1fZ41lvk5oa1bFd9NVorsJEa4GiwAa8rLGlb+LhY0Nf5cE33NkO+9bGwSTuKnD
         cKAWLxore3b0v6HeSUieTdTLYqRn9NiPq7ouwWtKD8UDfAD2Tr5n3ZXRQ3ei3ZAdzS8z
         njgtM/Y+htgYEzG3UQeO9z+6RHFYpqPihreNFWf9r44x7BAzVhaYOlgdr/hKiSanzVeN
         vfETgXjWjZxhla6qJpOChdKTKpHTKfg3ikZgWA4JQhh61rPUR2moLCC8s73+R42nQ3p6
         rjWw==
X-Gm-Message-State: APjAAAVfaqX8PDFHkYBra6G7oPU/wyYbs1oQmvm8ZapAUFoL31NOUj0s
        O59D4/HO9sLyjIheRVbmwHVSLJ0=
X-Google-Smtp-Source: APXvYqyzY+6834ibtMPFhWZUostIJt5cws3qVg4M8Mksl9w5vRkkbOZcZmgcNnwCfFKf/ltIZgd3ug==
X-Received: by 2002:a5e:8417:: with SMTP id h23mr61258716ioj.17.1578172318591;
        Sat, 04 Jan 2020 13:11:58 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v64sm22429235ila.36.2020.01.04.13.11.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:11:58 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:11:57 -0700
Date:   Sat, 4 Jan 2020 14:11:57 -0700
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/9] dt: bindings: lm3692x: Add led-max-microamp
 property
Message-ID: <20200104211157.GA21511@bogus>
References: <cover.1578134779.git.agx@sigxcpu.org>
 <015c9818d17d81783614da2b89ec46283468765b.1578134779.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <015c9818d17d81783614da2b89ec46283468765b.1578134779.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Jan 2020 11:54:21 +0100, =?UTF-8?q?Guido=20G=C3=BCnther?= wrote:
> This can be used to limit the current per LED strip.
> 
> Signed-off-by: Guido G�nther <agx@sigxcpu.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  Documentation/devicetree/bindings/leds/leds-lm3692x.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
