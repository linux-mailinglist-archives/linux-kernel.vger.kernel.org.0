Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E43C36732
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 00:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFEWEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 18:04:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:33847 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfFEWEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:04:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x55M47Xh023780;
        Wed, 5 Jun 2019 17:04:08 -0500
Message-ID: <3f29edea9d7989152cec218df1c99db4830267b0.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: interrupt-controller: Amazon's
 Annapurna Labs FIC
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Talel Shenhar <talel@amazon.com>, nicolas.ferre@microchip.com,
        jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh+dt@kernel.org,
        davem@davemloft.net, shawn.lin@rock-chips.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     dwmw@amazon.co.uk, jonnyc@amazon.com, hhhawa@amazon.com,
        ronenk@amazon.com, hanochu@amazon.com, barakw@amazon.com
Date:   Thu, 06 Jun 2019 08:04:06 +1000
In-Reply-To: <1559746758-20208-2-git-send-email-talel@amazon.com>
References: <1559746758-20208-1-git-send-email-talel@amazon.com>
         <1559746758-20208-2-git-send-email-talel@amazon.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-05 at 17:59 +0300, Talel Shenhar wrote:
> 

 ../..

> +- compatible: should be "amazon,al-fic"
> +- reg: physical base address and size of the registers
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: must be 2.
> +- interrupt-parent: specifies the parent interrupt controller.
> +- interrupts: describes which input line in the interrupt parent, this
> +  fic's output is connected to.
> +
> +Example:
> +
> +amazon_fic: interrupt-controller@0xfd8a8500 {
> +	compatible = "amazon,al-fic";
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
                            ^ should be 2

> +	reg = <0x0 0xfd8a8500 0x0 0x1000>;
> +	interrupt-parent = <&gic>;
> +	interrupts = <GIC_SPI 0x0 IRQ_TYPE_LEVEL_HIGH>;
> +};

