Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E956C0BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 20:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfI0Sv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 14:51:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37171 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfI0Sv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:51:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id k32so3140586otc.4;
        Fri, 27 Sep 2019 11:51:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d41cCTl7w3rkM7T7TH1Wjkv6CwKEi+5QRtnS63WD5ZM=;
        b=Pc7c0jdRUhiQMJMyfJBbfl6M1L8VwnUvd5Zn1MSnnIBqdqVwqBAtO6HzVHCN36jO3I
         QODPHIU25vl89//TY7kO9Jwt+E2FDC/KKxphI+2U/3JI/W//HsPMVZyx4VRnk2+C7lsK
         LCJEhlZOzWzc8prg3L6q/GRThvmSArhLnljK7YHe9rs7hTjs4N0kZHmMPfY5vOqLhF1t
         DPKDgHemyTC9poSdSEZ+Ex6BDKYmFUbU+lhHuBlZZRJJFclOI0n3r7RJUaAHB0DZwRIe
         mbNBg1qM6H/OJ8BGlsvD/V41cXhDcEuQwKzKhqBR3ywC/S5y31uK6CNZTFT/hpYVFD+c
         ElwQ==
X-Gm-Message-State: APjAAAXx3q9hYjaIaDrWYiKMhe92/u6YD5uywBGlwOaZwV6MrQ5UBtqN
        v52PHZyOoYi0pPBYwA+v3A==
X-Google-Smtp-Source: APXvYqy7kAP35+kBMD+IB6YfX5awR9sKBq4fbOg1XNya+RBpUkbPY3uEzjMNx9j7YtN3dMZyiE8Z7Q==
X-Received: by 2002:a05:6830:443:: with SMTP id d3mr4430310otc.93.1569610314662;
        Fri, 27 Sep 2019 11:51:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v75sm1961767oia.6.2019.09.27.11.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 11:51:53 -0700 (PDT)
Date:   Fri, 27 Sep 2019 13:51:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, adam.ford@logicpd.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/3] dt-bindings: Add Logic PD Type 28 display panel
Message-ID: <20190927185153.GA982@bogus>
References: <20190925184239.22330-1-aford173@gmail.com>
 <20190925184239.22330-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925184239.22330-2-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 01:42:37PM -0500, Adam Ford wrote:
> This patch adds documentation of device tree bindings for the WVGA panel
> Logic PD Type 28 display.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  Correct build errors from 'make dt_binding_check'
> V2:  Use YAML instead of TXT for binding
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
> new file mode 100644
> index 000000000000..74ba650ea7a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/logicpd,type28.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR X11)

(GPL-2.0-only OR BSD-2-Clause) please.

X11 is pretty much never right unless this is copyright X Consortium.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/logicpd,type28.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Logic PD Type 28 4.3" WQVGA TFT LCD panel
> +
> +maintainers:
> +  - Adam Ford <aford173@gmail.com>
> +

You need:

allOf:
  - $ref: panel-common.yaml#

> +properties:
> +  compatible:
> +    const: logicpd,type28
> +

> +  power-supply:
> +    description: Regulator to provide the supply voltage
> +    maxItems: 1
> +
> +  enable-gpios:
> +    description: GPIO pin to enable or disable the panel
> +    maxItems: 1
> +
> +  backlight:
> +    description: Backlight used by the panel
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

These 3 are all defined in the common schema, so you just need 'true' 
for the value to indicate they apply to this panel and to make 
'additionalProperties: false' happy.

> +
> +required:
> +  - compatible

Are the rest really optional? 

> +
> +additionalProperties: false
> -- 
> 2.17.1
> 
