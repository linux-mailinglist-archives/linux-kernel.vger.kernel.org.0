Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD5F3D431A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 16:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfJKOlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 10:41:08 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36331 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKOlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:41:08 -0400
Received: by mail-ot1-f68.google.com with SMTP id 67so8153437oto.3;
        Fri, 11 Oct 2019 07:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=13+exJToatmaIzt24oxwTrGZYM7rrhfRGi/WJDiOBwA=;
        b=ebbDWM1+OkzY1heajDUmUY1nK4V4X7Sk33fWZiWAAq7cs19JmhixlcR5/PwcNor4Ru
         1mksjdxhSWWCiVxbq/fcfRkofzvlxvvfJ77UBJ+SAvlKrYWGIyJavGmXIAym+9isK629
         n9my1j57KH1mA/iPp4+/I8DG+Lzl2+DnW/C3cfein1nYG90AXRtI5F4zIjaNlVS3AG3g
         g+qFGcLAyaxdKF+orcVngrR1emzX72+We4lgL5LwIKLDxSaqsLcZsSVNXsh2s/9ipTv6
         JqNOQTaupvaNtkAdDXeTJtnYfW9IT1B/ZT0c9uldMubIy1rR0R8wB81gBRGjfqiFAGic
         9BnA==
X-Gm-Message-State: APjAAAVMCIvQTwXiGqYRptI3tEEgheimcMsvczf6FSvD+DYRkwpRTnWD
        2omLDNonF5oc0RIRIf0Euw==
X-Google-Smtp-Source: APXvYqwgioBIlOsE8YnkGA0AfZmGlUiR67ETRFc335JqHw8L5b/6qB4u2WDleLxV+K+60E0+AtJRLg==
X-Received: by 2002:a9d:5e12:: with SMTP id d18mr12786439oti.220.1570804429525;
        Fri, 11 Oct 2019 07:33:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w201sm2694172oie.44.2019.10.11.07.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:33:49 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:33:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, joel@jms.id.au,
        mark.rutland@arm.com, robh+dt@kernel.org, maz@kernel.org,
        jason@lakedaemon.net, tglx@linutronix.de,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: interrupt-controller: Add Aspeed SCU
 interrupt controller
Message-ID: <20191011143348.GA22630@bogus>
References: <1569617929-29055-1-git-send-email-eajames@linux.ibm.com>
 <1569617929-29055-2-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569617929-29055-2-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Sep 2019 15:58:46 -0500, Eddie James wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>
