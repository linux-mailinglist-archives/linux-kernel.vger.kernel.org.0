Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2713CC2337
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 16:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbfI3O0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 10:26:48 -0400
Received: from foss.arm.com ([217.140.110.172]:55616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731276AbfI3O0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:26:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18DD228;
        Mon, 30 Sep 2019 07:26:47 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E2FF3F706;
        Mon, 30 Sep 2019 07:26:45 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:26:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V10 1/2] dt-bindings: mailbox: add binding doc for the
 ARM SMC/HVC mailbox
Message-ID: <20190930142640.GA24945@bogus>
References: <1569824287-4263-1-git-send-email-peng.fan@nxp.com>
 <1569824287-4263-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569824287-4263-2-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 06:20:09AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The ARM SMC/HVC mailbox binding describes a firmware interface to trigger
> actions in software layers running in the EL2 or EL3 exception levels.
> The term "ARM" here relates to the SMC instruction as part of the ARM
> instruction set, not as a standard endorsed by ARM Ltd.
> 

FWIW:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/mailbox/arm-smc.yaml       | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.yaml b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> new file mode 100644
> index 000000000000..c165946a64e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/arm-smc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM SMC Mailbox Interface
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +description: |
> +  This mailbox uses the ARM smc (secure monitor call) or hvc (hypervisor
> +  call) instruction to trigger a mailbox-connected activity in firmware,
> +  executing on the very same core as the caller. The value of r0/w0/x0
> +  the firmware returns after the smc call is delivered as a received
> +  message to the mailbox framework, so synchronous communication can be
> +  established. The exact meaning of the action the mailbox triggers as
> +  well as the return value is defined by their users and is not subject
> +  to this binding.
> +
> +  One example use case of this mailbox is the SCMI interface, which uses
> +  shared memory to transfer commands and parameters, and a mailbox to
> +  trigger a function call. This allows SoCs without a separate management
> +  processor (or when such a processor is not available or used) to use
> +  this standardized interface anyway.
> +
> +  This binding describes no hardware, but establishes a firmware interface.
> +  Upon receiving an SMC using the described SMC function identifier, the
> +  firmware is expected to trigger some mailbox connected functionality.
> +  The communication follows the ARM SMC calling convention.
> +  Firmware expects an SMC function identifier in r0 or w0. The supported
> +  identifier is listed in the the arm,func-id property as described below.
> +  The firmware can return one value in the first SMC result register,
> +  it is expected to be an error value, which shall be propagated to the
> +  mailbox client.
> +
> +  Any core which supports the SMC or HVC instruction can be used, as long
> +  as a firmware component running in EL3 or EL2 is handling these calls.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description:
> +          For implementations using ARM SMC instruction.
> +        const: arm,smc-mbox
> +
> +      - description:
> +          For implementations using ARM HVC instruction.
> +        const: arm,hvc-mbox
> +
> +  "#mbox-cells":
> +    const: 0
> +
> +  arm,func-id:
> +    description: |
> +      An single 32-bit value specifying the function ID used by the mailbox.
> +      The function ID follows the ARM SMC calling convention standard.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - compatible
> +  - "#mbox-cells"
> +  - arm,func-id
> +
> +examples:
> +  - |
> +    sram@93f000 {
> +      compatible = "mmio-sram";
> +      reg = <0x0 0x93f000 0x0 0x1000>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      ranges = <0x0 0x93f000 0x1000>;
> +
> +      cpu_scp_lpri: scp-shmem@0 {
> +        compatible = "arm,scmi-shmem";
> +        reg = <0x0 0x200>;
> +      };
> +    };
> +
> +    smc_tx_mbox: tx_mbox {

[nit]              ^^^^^^^^^ s/tx_mbox/mailbox/ ?

mailbox sounds more generic name to use, you can always use what ever
name in the label. This is not a must change, just thought of mentioning
as the pattern followed is to use generic names.

--
Regards,
Sudeep
