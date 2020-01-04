Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 077DA130482
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 22:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgADVKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 16:10:12 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:44228 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgADVKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:10:12 -0500
Received: by mail-il1-f193.google.com with SMTP id z12so2898927iln.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJWxvFKjFmedV29LeJwhs6R1fNWpIXjZCncfQO681ro=;
        b=OyTF5aLgWf+o6GMjQyv4AornAnqm2I8D2q/ZmDBrYTRLmFiLJmCG2e9oJW0UIAeGYv
         RbRTehKks9NauLUpcFHkVeKsSwd6C3poONcJX21xSGDoYlGTwl1wxTba5S5k+JN4VvjD
         oYvJrH21wvPzxXlHth9zrBCS6B4FHgw0xFV7DPeItl63cjybSvNlZT3f/4jEc45TDm/1
         pek07HSIdiRPAhYNttZrdK3ZUy442XNYQRH4jiaEjwjyekMoVPR7w1hdmAECKhD5plTh
         kID+N5LnH5ovIG7pzaa1uDhc3tf3aqDujtdWAKEa+dAMyu8wyGjONRYMiYe7vZ1r6+a0
         xMJQ==
X-Gm-Message-State: APjAAAUYf1k37wHZiJyzy6OTqBXcsztLHWXfJ/JisMR4yxDXe9h1VWrn
        +zG+/nHUS5CT8L1p8cQxzTMzr+o=
X-Google-Smtp-Source: APXvYqw4g3JUFxZtQw5K10GDYaSavpupvnmpetikAvrk66W9dgoeYlqhEghnXpkii4fafXcsGhO41A==
X-Received: by 2002:a92:db49:: with SMTP id w9mr76239592ilq.277.1578172211493;
        Sat, 04 Jan 2020 13:10:11 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b145sm15842716iof.60.2020.01.04.13.10.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:10:10 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:10:09 -0700
Date:   Sat, 4 Jan 2020 14:10:09 -0700
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: Document BCM7216 RESCAL reset
 controller
Message-ID: <20200104211009.GA18324@bogus>
References: <20200103190429.1847-1-f.fainelli@gmail.com>
 <20200103190429.1847-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103190429.1847-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Jan 2020 11:04:28 -0800, Florian Fainelli wrote:
> From: Jim Quinlan <jim2101024@gmail.com>
> 
> BCM7216 has a special purpose RESCAL reset controller for its SATA and
> PCIe0/1 instances. This is a simple reset controller with #reset-cells
> set to 0.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> [florian: Convert to YAML binding]
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../reset/brcm,bcm7216-pcie-sata-rescal.yaml  | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm7216-pcie-sata-rescal.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
