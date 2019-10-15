Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DDD7F79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 21:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbfJOTAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 15:00:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39897 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfJOTAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:00:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id s22so17905475otr.6;
        Tue, 15 Oct 2019 12:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hp+e/XzrZOsUlcsoMFFN5qSzcFIMEZCM+YYALCx114o=;
        b=Mpbn5AbGzD1V84GycsJIx5GHgz7Kbxc4ekcoP7MHemOUUcz8D1Wys7u6/NFPnSQuSF
         0CmLNiFgk6U7bgjkhSExpNxEExP6oGmMJdmG9iIfv3o+FjrW8PeTmD/r2nbiZ+UUUi/6
         mxB/THDg+oc/AX6KqkmDZlEmeHKsR06gNGJairuUqZKsPt3XVKuhadtM8nyhj+6Y/9X4
         vCsWCuOcBDLM7mBVCuiMKqzWD4/QnLy85m1XTvo7cbbY6iF3y9mjA+xHFgv+oh7XtPIi
         cEIF60Ikhb2qd50+3ME7GkAmuGDcciI69yt09kNV+HZFrKeHIxuAj1d6kzuRPL3NE4hZ
         DlMg==
X-Gm-Message-State: APjAAAXuA+rlkhaxbTnyC+G89OpXRWHgV+npPwBsSDtI06hZMLG7E/Nx
        sA+1TqiSTZ3/gnLuBL24/A==
X-Google-Smtp-Source: APXvYqz2lsFOsoKMnXxtnOj8CPhDijUN329kcBws3qA3JeZj1vIj2mFKXCylZvqBmzugsYRfMd4HuQ==
X-Received: by 2002:a9d:5907:: with SMTP id t7mr20286521oth.118.1571166046567;
        Tue, 15 Oct 2019 12:00:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 23sm25341oir.50.2019.10.15.12.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 12:00:45 -0700 (PDT)
Date:   Tue, 15 Oct 2019 14:00:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/7] dt-bindings: interrupt-controller: Add
 brcm,bcm7211-l1-intc binding
Message-ID: <20191015190045.GA28661@bogus>
References: <20191001224842.9382-1-f.fainelli@gmail.com>
 <20191001224842.9382-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001224842.9382-5-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Oct 2019 15:48:39 -0700, Florian Fainelli wrote:
> BCM7211 uses a very similar root interrupt controller than what exists on
> BCM2836, define a specific compatible string to key off specific
> behavior.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
