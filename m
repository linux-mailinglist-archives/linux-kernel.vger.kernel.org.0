Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 685DE13A594
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 11:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgANKJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 05:09:05 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44983 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731178AbgANKJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:09:00 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1irJ85-00031o-H6; Tue, 14 Jan 2020 11:08:57 +0100
Message-ID: <d1f969346ad1758943e8f898244c69673f93f129.camel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: reset: intel,rcu-gw: Fix
 intel,global-reset schema
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Dilip Kota <eswara.kota@linux.intel.com>
Date:   Tue, 14 Jan 2020 11:08:57 +0100
In-Reply-To: <20200113214515.3950-1-robh@kernel.org>
References: <20200113214515.3950-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, 2020-01-13 at 15:45 -0600, Rob Herring wrote:
> The intel,rcu-gw binding example has an error:
> 
> Documentation/devicetree/bindings/reset/intel,rcu-gw.example.dt.yaml:
>   reset-controller@e0000000: intel,global-reset: [[16, 30]] is too short
> 
> The error isn't really correct as the problem is in how the data is
> encoded and the schema is not fixed up by the tooling correctly.
> However, array properties should describe the elements in the array, so
> lets do that which fixes the error in the process.
> 
> Fixes: b7ab0cb00d08 ("dt-bindings: reset: Add YAML schemas for the Intel Reset controller")
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Dilip Kota <eswara.kota@linux.intel.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> index 246dea8a2ec9..8ac437282659 100644
> --- a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> +++ b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> @@ -23,7 +23,11 @@ properties:
>      description: Global reset register offset and bit offset.
>      allOf:
>        - $ref: /schemas/types.yaml#/definitions/uint32-array
> -      - maxItems: 2
> +    items:
> +      - description: Register offset
> +      - description: Register bit offset
> +        minimum: 0
> +        maximum: 31
>  
>    "#reset-cells":
>      minimum: 2

Thank you, applied to reset/next.

regards
Philipp

