Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E4FF85A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 01:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKLAzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 19:55:01 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38180 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLAzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:55:01 -0500
Received: by mail-oi1-f194.google.com with SMTP id a14so13257296oid.5;
        Mon, 11 Nov 2019 16:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pBpMOp1pnVgL27PeyDlmextXWELG5e17FH+NqeYI5mE=;
        b=N3nCP7upDxnXysmPlJxAq+8jZ1XG029yweofcWKWUhUKOtUw2RRUE0OR0hPZ6AwLUz
         HWorQzwShA91trXRO/m0+xhOoxW3aLXX5VOSqXUTV8g/hlvtOurxJ5GI0r5kzz01KaTe
         do7RUGIki2g5WRn55Oa8WtgIO67ubaF3o1QEC5dCDNOBMXM5JXv4vByfwpuluIY5xTSO
         Cq1ypDkxINtADTvfk5Z+Vs5C4mZiuYrKpLDpwe8xce7Ep74kVzorxgAPPIiustmYXzu6
         Nj2xzpqLiBeFQRy8kWBhxFRTvHOlpG2v9wFR+lNNKHCrXxHQkp5c1KydCtIbqNW+zjXK
         FJ7g==
X-Gm-Message-State: APjAAAWv5To+OUQX2IMALee8/KMvOH/WiazGrGDP8IJo7hPz2pqRPnwW
        yEgXdIdG0OktcVNvI+kMB2oG/2A=
X-Google-Smtp-Source: APXvYqyljVDthsZCN8eV9945YzI8i3G/6sNTkp6Sv0OOGAYMLdcUA3NT8bIiajw8luXTBalycNC9pA==
X-Received: by 2002:a05:6808:106:: with SMTP id b6mr1537840oie.44.1573520100283;
        Mon, 11 Nov 2019 16:55:00 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 94sm5835461otg.70.2019.11.11.16.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:54:59 -0800 (PST)
Date:   Mon, 11 Nov 2019 18:54:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        andrew@aj.id.au, joel@jms.id.au, maz@kernel.org,
        jason@lakedaemon.net, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/12] dt-bindings: interrupt-controller: Add Aspeed SCU
 interrupt controller
Message-ID: <20191112005459.GA6260@bogus>
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
 <1573244313-9190-2-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573244313-9190-2-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Nov 2019 14:18:22 -0600, Eddie James wrote:
> Document the Aspeed SCU interrupt controller and add an include file
> for the interrupts it provides.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../interrupt-controller/aspeed,ast2xxx-scu-ic.txt | 26 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++++++
>  .../interrupt-controller/aspeed-scu-ic.h           | 23 +++++++++++++++++++
>  3 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
>  create mode 100644 include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
