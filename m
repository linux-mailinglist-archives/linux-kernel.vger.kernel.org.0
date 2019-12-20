Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58DF1271D3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 00:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLSXv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 18:51:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39399 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLSXv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 18:51:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so9369465oty.6;
        Thu, 19 Dec 2019 15:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OjXAZ2TKobv9yoEqrbBdYh7biWU4O3QAfvZyc2J4dWM=;
        b=d7c0+FpNKokOaqdyyz1TEhYS+0n3crcbv5S/9WszL7V5byNQ3oOJhOingMhovakWSa
         v5xQ78IhZV8+5/0z+w/GhqJVbQudh6sPb20+2yJ0KEE40Yfa1t2xb+dMwN5OA7zMvGOY
         0JpMFfaTTsGVdaIPrNrhUsF2uSfO/78mNiEOPdrGBbyJOmG0RD3JqQDhKF/en29NXDpE
         ca73LQaUzQWyrhNjEhiYABFkdkT5dVK7jeLwI5uWCqtdD752JZUsL+g7RIF7Lna6LgKn
         AykDhuDaRBezN8EfzIitBAzw5cYgW9Eg0JD+B5rDsSA/zhZRxY1yIDaBn7/dyZVqBX0+
         gbIA==
X-Gm-Message-State: APjAAAW6pPBVlzbaT0Awqi3sY+OXI5SyG6FVoDqhlwKX1zT06gb0m8/W
        1dKXQPlcj0nuwP+q4/JVvA==
X-Google-Smtp-Source: APXvYqzaPjmepv4a279sIAA5ICFmA0B7tF34IOFNH9fz0KHDHD1DOST2PYO1ecY606VakqN6h26qsA==
X-Received: by 2002:a9d:20e4:: with SMTP id x91mr11381091ota.335.1576799486409;
        Thu, 19 Dec 2019 15:51:26 -0800 (PST)
Received: from localhost (ip-184-205-174-147.ftwttx.spcsdns.net. [184.205.174.147])
        by smtp.gmail.com with ESMTPSA id y24sm2577643oix.31.2019.12.19.15.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 15:51:25 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:51:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: Add vendor prefix for Satoz
Message-ID: <20191219235124.GA2960@bogus>
References: <20191213182325.27030-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213182325.27030-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 19:23:24 +0100, Miquel Raynal wrote:
> Satoz is a Chinese TFT manufacturer.
> Website: http://www.sat-sz.com/English/index.html
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
