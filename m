Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 204B0106788
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2019 09:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKVIIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Nov 2019 03:08:51 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:35466 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbfKVIIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:08:51 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iY3zl-0005Ox-OQ; Fri, 22 Nov 2019 09:08:49 +0100
Date:   Fri, 22 Nov 2019 08:08:48 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: arm,gic-v3: Add
 missing type to interrupt-partition-* nodes
Message-ID: <20191122080848.69f38e64@why>
In-Reply-To: <20191121230915.4410-1-robh@kernel.org>
References: <20191121230915.4410-1-robh@kernel.org>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: robh@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 17:09:15 -0600
Rob Herring <robh@kernel.org> wrote:

> Add missing 'type: object' schema to interrupt-partition-* nodes. Found
> with fix to meta-schema checks.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/interrupt-controller/arm,gic-v3.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> index 1fe147daca4c..66aacd106503 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
> @@ -138,6 +138,7 @@ properties:
>        containing a set of sub-nodes.
>      patternProperties:
>        "^interrupt-partition-[0-9]+$":
> +        type: object
>          properties:
>            affinity:
>              $ref: /schemas/types.yaml#/definitions/phandle-array


Acked-by: Marc Zyngier <maz@kernel.org>

I guess you're taking this through the DT tree? Or do you want me to
pick it up as a fix post -rc1?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
