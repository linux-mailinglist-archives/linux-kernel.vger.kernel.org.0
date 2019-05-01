Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 649D710E50
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2019 23:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfEAVAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 May 2019 17:00:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33617 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfEAVAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:00:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id l1so100517oib.0;
        Wed, 01 May 2019 14:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fhyjh+pEfTmxGVzs4D2NxCU9BjdUSsUEryv2fL7NV2Q=;
        b=aJ27kwJKE1bHITPpYzgGDnZvwKlGN6k5VpQDiDet08cxGP9h+A04A0X0IrOVGFsHOK
         fq6dXT6D+mBZ6k+PMDLngx8UFdXEdKWdHnIfLA3VUuvb8yvc/dyiBoxDA+I27iTfXIFJ
         AccRIrDPye+28jjp650/n8qY91jKPQN4QHrawqYAGJPacZ1yqypu2zfJ0xmWrA2Ly6nC
         y0qlutIHwoNalFwY4NJQP0d3aVK9XGmNjOxfK5nhCIvYq8XqDwjuhv0u01yeR3Fx551F
         NvFwj2WhSpdfqYS2FK6ZepkfVhl/X2bna6ALLsgun1FtqfX/wpUD6+3XKRaTWHgDFU/W
         msuQ==
X-Gm-Message-State: APjAAAVHyUmwVzSvSbSBz5J4IzNRM6FpZwN4SXL8rYB3WQiLBonMELM/
        Z7AwX/45hLbJKQIHS/TtWw==
X-Google-Smtp-Source: APXvYqyNVKjPoji2SxJxP3ylggeCueF4E0E33rMuGH1+fipTxjK6PYV0QFeg1sxueHl1rXk5rOqFqA==
X-Received: by 2002:aca:fd52:: with SMTP id b79mr241015oii.34.1556744451588;
        Wed, 01 May 2019 14:00:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m206sm17199824oif.50.2019.05.01.14.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 14:00:49 -0700 (PDT)
Date:   Wed, 1 May 2019 16:00:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Scott Wood <oss@buserror.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: Re: [PATCH v2 4/6] dt-bindings: soc/fsl: qe: document new
 fsl,qe-snums  binding
Message-ID: <20190501210048.GA20658@bogus>
References: <20190430133615.25721-1-rasmus.villemoes@prevas.dk>
 <20190501092841.9026-1-rasmus.villemoes@prevas.dk>
 <20190501092841.9026-5-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501092841.9026-5-rasmus.villemoes@prevas.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2019 09:29:08 +0000, Rasmus Villemoes wrote:
> Reading table 4-30, and its footnotes, of the QUICC Engine Block
> Reference Manual shows that the set of snum _values_ is not
> necessarily just a function of the _number_ of snums, as given in the
> fsl,qe-num-snums property.
> 
> As an alternative, to make it easier to add support for other variants
> of the QUICC engine IP, this introduces a new binding fsl,qe-snums,
> which automatically encodes both the number of snums and the actual
> values to use.
> 
> For example, for the MPC8309, one would specify the property as
> 
>                fsl,qe-snums = /bits/ 8 <
>                        0x88 0x89 0x98 0x99 0xa8 0xa9 0xb8 0xb9
>                        0xc8 0xc9 0xd8 0xd9 0xe8 0xe9>;
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  Documentation/devicetree/bindings/soc/fsl/cpm_qe/qe.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
