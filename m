Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 418F01135C4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 20:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfLDTeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 14:34:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41418 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfLDTeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:34:23 -0500
Received: by mail-ot1-f65.google.com with SMTP id r27so316363otc.8;
        Wed, 04 Dec 2019 11:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p4mxuGM2xEKk8KHZKZzmKSi85GUqaLcMWhdk6rGaIpI=;
        b=azZih2Z1i6qMkH4ULhxNYAhAIj5WN9R+X2iuS23vHW7/IhrlTmfqz83UckQzyrF27i
         f/wHZOO0R5k6p2hTRfDNIHSiSnU7s9YMbsOQhlwI/+ze41g1Zqmjjrg8CiEJvRjzk8WD
         3IT+UJMkLnbvh6uLg3UkzTB86jp5hJhT1PanD36P7smb8yiWxkairAF1ZlTjk/4Af7gW
         BAkALOgu7mhW4R40CENzCy6xItTkY4fPdECZFuUSdSW1l698gYb07Fk6pDvat+tVZ2WI
         SUBCNU1KAwUujjjyigYGOdURr8d1QmLNnJyMbquXuR1qySOa3PTkUncI2vMhn6UL7ZdR
         7RuQ==
X-Gm-Message-State: APjAAAUnz7rLx4NpMTI+WaLSSRUin+Crkw16Z6neJNRj1W2HRAvuj4Pb
        D17yXN3cuDVRRqKbBGqyzQ==
X-Google-Smtp-Source: APXvYqw5eOGbBaVPH+ueyOZw91fxjIVeOFdA2MP/nej8yeBJ149jFgcf0lgk+mRtwmYNmoKC2nf59w==
X-Received: by 2002:a9d:3b8:: with SMTP id f53mr3946935otf.180.1575488062646;
        Wed, 04 Dec 2019 11:34:22 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s83sm1691648oif.33.2019.12.04.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:34:22 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:34:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jason Kridner <jkridner@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Robert Nelson <robertcnelson@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org,
        Caleb Robey <c-robey@ti.com>, Jason Kridner <jdk@ti.com>
Subject: Re: [PATCH v2] dt-bindings: Add vendor prefix for BeagleBoard.org
Message-ID: <20191204193421.GA15784@bogus>
References: <20191122000926.19408-1-jdk@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122000926.19408-1-jdk@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 07:09:26PM -0500, Jason Kridner wrote:
> Add vendor prefix for BeagleBoard.org Foundation
> 
> Signed-off-by: Jason Kridner <jdk@ti.com>
> ---
> Changes in v2:
>   - Use 'beagle' rather than 'beagleboard.org' to be shorter and avoid
>     needing to quote within a yaml regular expression.
>   - Assign 'from' to author e-mail address.

Still not right...

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 967e78c5ec0a..1cce6641b21b 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -139,6 +139,8 @@ patternProperties:
>      description: Shenzhen AZW Technology Co., Ltd.
>    "^bananapi,.*":
>      description: BIPAI KEJI LIMITED
> +  "^beagle,.*":
> +    description: BeagleBoard.org Foundation
>    "^bhf,.*":
>      description: Beckhoff Automation GmbH & Co. KG
>    "^bitmain,.*":
> -- 
> 2.17.1
> 
