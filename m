Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC73018FE39
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 20:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCWTze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 15:55:34 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33448 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCWTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:55:34 -0400
Received: by mail-il1-f193.google.com with SMTP id k29so14600998ilg.0;
        Mon, 23 Mar 2020 12:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kFJFA9AgWvFk/kEnU8vamRR2gWaNyHgegYHT2Tyfw1s=;
        b=O8ZWyFaE9bazNLLN62jwG01sbQAjbsK4pZw93SIyXBLERnq6QilWejswF7KYNeNy8S
         PU3N3W0r9eELCFk2Pk4GgbiKcuSygct9FlJK4XuoRqQISl/GDX6hlKz50oivMGg3LPlB
         BLhWm26v8L4RxF8n2aTUqVF3+4ALWmMpbGyNpdJBrGvJQYCw9PT5OHTNEuy+jXWVwQa/
         ybMJF3FPKEp8B/esieC/mWjkGzoH0ot9gIX5Omz0VSShSkYBZmJMDrbS2pWoOTHQDNIw
         GAG+uZ2kDK2LdwpmV57MWRhC8ZxDzfjaYMs8C02oPzqQ8yvZXVkJQIccRYh84wH+/nSm
         5dMA==
X-Gm-Message-State: ANhLgQ1gDQTHFiS6/WRGNV/faLDUvLhg/5YYn10w0K715kRaDK4aRM8d
        NzBMB4KLUZIT0T4VMrcNYQ==
X-Google-Smtp-Source: ADFU+vvuzRa31naxtDjJTr2hNuD1sIvCIOHJrm60YMlQcXIoc6vaYFq5cIIV9MqEbf92kT5yUeZ1Ng==
X-Received: by 2002:a92:c790:: with SMTP id c16mr393841ilk.206.1584993333182;
        Mon, 23 Mar 2020 12:55:33 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l17sm5488218ilc.49.2020.03.23.12.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:55:32 -0700 (PDT)
Received: (nullmailer pid 6267 invoked by uid 1000);
        Mon, 23 Mar 2020 19:55:31 -0000
Date:   Mon, 23 Mar 2020 13:55:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        christoph.muellner@theobroma-systems.com, robin.murphy@arm.com,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        kever.yang@rock-chips.com, linux-kernel@vger.kernel.org,
        jbx6244@gmail.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: Add binding for Hardkernel Odroid Go
 Advance
Message-ID: <20200323195531.GA6201@bogus>
References: <20200308223250.353053-1-heiko@sntech.de>
 <20200308223250.353053-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308223250.353053-2-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Mar 2020 23:32:49 +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> Add a compatible for the Odroid Go Advance from Hardkernel.
> The compatible used by the vendor already is odroid-go2, to distinguish
> it from the previous (microcontroller-based) Odroid Go, so we're keeping
> that, also to not cause unnecessary incompatibilites.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
