Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD5A11503FF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 11:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBCKOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 05:14:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40547 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBCKOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:14:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id j104so17184815wrj.7;
        Mon, 03 Feb 2020 02:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VeTk9NFWqY2AFFX1U47JHNOnYrtYJUipcDdzTnxdTw4=;
        b=XjGEM5zQuiMM2+w0ue2qncdk/84TqjsZ+tE88qHyRiy82oonsahji6PskEo8i2jy9q
         6orEtFX1r2LL02m4+WYHRvdqC8m+PNTJHdDqUJKIOKiE2bNYXr3ljyHT91KphRvFS+Ek
         Gi5WI7GLqhhOezxkVvnCrOuEbGxI4y7v6rY0tcLJ+IM7a6nJhEmRDAqF7+acDBjmqbcY
         uAl7AKUHXUbBHoqiXx03k9kCGu9NlJJ18ek1pOkF1pPPyyufiIGEs3lH6pVFYOjosqWl
         LxICDm6M21T9SWDa1TaXjImckV2XXIMCuiBs/PTAInWZHxZ2gV8FFd+FYQTaq9kAvu59
         1HeQ==
X-Gm-Message-State: APjAAAX3GFOFHS55aaa0ZRR71hGjvajmjXBEpqtO+sLpVK8uP9GX5jct
        XGmqUygdmMqLNuTtC9Imgdi9DMpyzg==
X-Google-Smtp-Source: APXvYqy+FnFfJwsfZztZ3WYAtBH/oqT3NH+T+W2/hO9SuPbGror4fjsAxjEbIcawDdvgCPggf1l6zQ==
X-Received: by 2002:adf:ff8c:: with SMTP id j12mr14349774wrr.354.1580724882064;
        Mon, 03 Feb 2020 02:14:42 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.163])
        by smtp.gmail.com with ESMTPSA id k13sm24011191wrx.59.2020.02.03.02.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 02:14:41 -0800 (PST)
Received: (nullmailer pid 814 invoked by uid 1000);
        Mon, 03 Feb 2020 10:14:40 -0000
Date:   Mon, 3 Feb 2020 10:14:40 +0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH 12/12] dt-bindings: arm: bcm: Convert BCM2835 firmware
 binding to YAML
Message-ID: <20200203101440.GA31848@bogus>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
 <20200202211827.27682-13-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200202211827.27682-13-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  2 Feb 2020 13:18:27 -0800, Florian Fainelli wrote:
> Convert the Raspberry Pi BCM2835 firmware binding document to YAML.
> Verified with dt_binding_check and dtbs_check.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../arm/bcm/raspberrypi,bcm2835-firmware.txt  | 14 --------
>  .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 33 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml: $id: path/filename 'arm/bcm/raspberrypi,bcm2835.yaml' doesn't match actual filename
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1232487
Please check and re-submit.
