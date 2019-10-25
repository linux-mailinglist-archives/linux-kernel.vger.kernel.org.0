Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CF5E5423
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 21:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfJYTMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 15:12:51 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35122 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfJYTMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:12:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id n16so55689oig.2;
        Fri, 25 Oct 2019 12:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jngMWCIPztnYRQYTQh0CwZua3m9mf2/Z8m7qkZoUWLU=;
        b=YeHL5GOPqHNxRGsUu2Ci/MhNya0Tc9/usMscTvjp/e9O0/QM8iUUr4V2+bJnBJTTJ0
         chmu5KJuzQEfd3/fCht85PHe0guvXYCaTZQ3zMkfIBDVmFbQZuoUDssZnAWeUe+imRhL
         /kwgr6rdNsa5xCBoqx6Rd1w9pJB2Vd1s0pUIT7ftErSSGO4MfGlI89gKpsvY0mDcqiLY
         sq/GiuPgHFpnjvPCSmH/FLrJ6fbXlfmDd4w8mFirvVzosE6XUsV47ChqDWzuJB0yhIEJ
         RcSe6WxZcI6hYSCp68EqJg05m6idQZO3acSCwgxMqFuSPu71EuDnKJkTs4W4XbJpbC/u
         qjUw==
X-Gm-Message-State: APjAAAVkeNyKHF9LN+VpYf9kic7VCx5h21VfouMTBksL9qQuiItTLzSk
        X4XOns+80bhSDekNQqOM/Q==
X-Google-Smtp-Source: APXvYqychJbSk5eJXpbRojc8uKVE2GqcHFj9XB/1X5MHc33e7I4ZD+T/fHo/iam0Sh2IYVxB5WcJpQ==
X-Received: by 2002:aca:e104:: with SMTP id y4mr4461365oig.117.1572030769368;
        Fri, 25 Oct 2019 12:12:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n186sm794340oih.58.2019.10.25.12.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 12:12:48 -0700 (PDT)
Date:   Fri, 25 Oct 2019 14:12:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, marek.vasut@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        computersforpeace@gmail.com, vigneshr@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, masonccyang@mxic.com.tw
Subject: Re: [PATCH v4 2/2] dt-bindings: mtd: Document Macronix NAND device
 bindings
Message-ID: <20191025191247.GA7206@bogus>
References: <1571902807-10388-1-git-send-email-masonccyang@mxic.com.tw>
 <1571902807-10388-3-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571902807-10388-3-git-send-email-masonccyang@mxic.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 15:40:07 +0800, Mason Yang wrote:
> Document the bindings used by the Macronix NAND device.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mtd/nand-macronix.txt        | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/nand-macronix.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
