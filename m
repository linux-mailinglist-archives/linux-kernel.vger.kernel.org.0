Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB1771536D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 18:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgBERje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 12:39:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33604 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgBERje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:39:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so1583360pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 09:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aO5p5IBLxlU8LmggP8EmaW7PqxkUQ4rk9prwoiPWExY=;
        b=LFEU7F5uRUHvjlHxU71R+6/md8i08kseXhFg8q/mXFNEvx4HMeFGZljgfUttHo5+J6
         kV7Np7W1PZZ38VSOWJtq3+lnECqnHmlydR90zYKVffplVYCGHkFqnG0mtYWUPxioAWZL
         UMsKw4DME/VMUvTxq642siQQgTIfXUOghivlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aO5p5IBLxlU8LmggP8EmaW7PqxkUQ4rk9prwoiPWExY=;
        b=MT1HLH97cIN7fOu5Bn5GYLmRBzm7UUayApHGIG0JI2lVvRuCNNb6e8DZJVovct9vvK
         QOlS9tE7UeEdAqUTZr/Posgs+XLZ3TEKLptbxlkFaqImX3vaatwroKrrcWqCA9NEyiH0
         xphM4DkyZAlwzuCyVqTVXJT1hMEcidRTFQd8LomTKwjonuWebX4bcYstjyBU67mp+F/6
         3d/3mk+8mxK1ylXa+EZy4HA7QuggiqVWShY+bX/qcz62lsyCaXzhw5DF1k+KKK+kSQdD
         tGopv4QhJFWFWAsNV63BWlD8f/fAN7JJBRpeaBR4Bs4g5OK3UUM1lp8TEGTqEMVQw24d
         fupA==
X-Gm-Message-State: APjAAAVmOldY3Zh4gzfporTWx1m54NUMFY+2R1WiawI2gEEeWejJ4onT
        dBYEx86tdN5xYN2lVIwsKUp49g==
X-Google-Smtp-Source: APXvYqx8kJG30FrBwFchNB07QuFE4dTA8rPgEi4RVVBWzFM230ur6MhRgba9ASq4e0C0OXPpkdRZuw==
X-Received: by 2002:a63:4d4c:: with SMTP id n12mr38694833pgl.212.1580924373586;
        Wed, 05 Feb 2020 09:39:33 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id h3sm140257pfr.15.2020.02.05.09.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 09:39:32 -0800 (PST)
Subject: Re: [PATCH v2 00/12] dt-bindings: arm: bcm: Convert boards to YAML
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Maxime Ripard <mripard@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "james.tai" <james.tai@realtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <2d263951-fbc5-ae5f-6643-b72debf5aa05@broadcom.com>
Date:   Wed, 5 Feb 2020 09:39:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Florian,

Patch series:

Acked-by: Scott Branden <scott.branden@broadcom.com>

On 2020-02-04 3:55 p.m., Florian Fainelli wrote:
> Hi Rob, Maxime,
>
> This patch series converts most files under D/dt-bindings/arm/bcm/ with
> the exception of bcm63138 and brcmstb to the YAML format. Those two may
> be split accordingly later on since document not just the root node.
>
> Changes in v2:
>
> - fixed typo in Vulcan binding
> - simplified how SoC compatible strings are specified
> - fixed filename in bcm2835 firmware binding
> - added 'secondary-boot-reg' constraint
>
>
> Florian Fainelli (12):
>    dt-bindings: arm: bcm: Convert Cygnus to YAML
>    dt-bindings: arm: bcm: Convert Hurricane 2 to YAML
>    dt-bindings: arm: bcm: Convert Northstar Plus to YAML
>    dt-bindings: arm: bcm: Convert Northstar 2 to YAML
>    dt-bindings: arm: bcm: Convert Stingray to YAML
>    dt-bindings: arm: bcm: Convert BCM21664 to YAML
>    dt-bindings: arm: bcm: Convert BCM23550 to YAML
>    dt-bindings: arm: bcm: Convert BCM4708 to YAML
>    dt-bindings: arm: bcm: Convert BCM11351 to YAML
>    dt-bindings: arm: bcm: Convert Vulcan to YAML
>    dt-bindings: arm: Document Broadcom SoCs 'secondary-boot-reg'
>    dt-bindings: arm: bcm: Convert BCM2835 firmware binding to YAML
>
>   .../arm/bcm/brcm,bcm11351-cpu-method.txt      | 36 --------
>   .../bindings/arm/bcm/brcm,bcm11351.txt        | 10 ---
>   .../bindings/arm/bcm/brcm,bcm11351.yaml       | 21 +++++
>   .../bindings/arm/bcm/brcm,bcm21664.txt        | 15 ----
>   .../bindings/arm/bcm/brcm,bcm21664.yaml       | 21 +++++
>   .../arm/bcm/brcm,bcm23550-cpu-method.txt      | 36 --------
>   .../bindings/arm/bcm/brcm,bcm23550.txt        | 15 ----
>   .../bindings/arm/bcm/brcm,bcm23550.yaml       | 21 +++++
>   .../bindings/arm/bcm/brcm,bcm4708.txt         | 15 ----
>   .../bindings/arm/bcm/brcm,bcm4708.yaml        | 88 +++++++++++++++++++
>   .../bindings/arm/bcm/brcm,cygnus.txt          | 31 -------
>   .../bindings/arm/bcm/brcm,cygnus.yaml         | 29 ++++++
>   .../devicetree/bindings/arm/bcm/brcm,hr2.txt  | 14 ---
>   .../devicetree/bindings/arm/bcm/brcm,hr2.yaml | 28 ++++++
>   .../devicetree/bindings/arm/bcm/brcm,ns2.txt  |  9 --
>   .../devicetree/bindings/arm/bcm/brcm,ns2.yaml | 23 +++++
>   .../bindings/arm/bcm/brcm,nsp-cpu-method.txt  | 39 --------
>   .../devicetree/bindings/arm/bcm/brcm,nsp.txt  | 34 -------
>   .../devicetree/bindings/arm/bcm/brcm,nsp.yaml | 36 ++++++++
>   .../bindings/arm/bcm/brcm,stingray.txt        | 12 ---
>   .../bindings/arm/bcm/brcm,stingray.yaml       | 24 +++++
>   .../bindings/arm/bcm/brcm,vulcan-soc.txt      | 10 ---
>   .../bindings/arm/bcm/brcm,vulcan-soc.yaml     | 22 +++++
>   .../arm/bcm/raspberrypi,bcm2835-firmware.txt  | 14 ---
>   .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 33 +++++++
>   .../devicetree/bindings/arm/cpus.yaml         | 33 +++++++
>   26 files changed, 379 insertions(+), 290 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method.txt
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,hr2.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,ns2.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,ns2.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml
>   delete mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
>   create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
>

