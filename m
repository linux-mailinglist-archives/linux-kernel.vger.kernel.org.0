Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F4191EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 02:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCYB72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 21:59:28 -0400
Received: from ozlabs.org ([203.11.71.1]:34371 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbgCYB72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 21:59:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48nBBP1jKDz9sQt;
        Wed, 25 Mar 2020 12:59:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1585101566;
        bh=DbtFmqRT8V9GpajJ1kFCBoHEqZgLl/5/UANC/xKI3s0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BkZ9AsjDqXY8v+ztK0YKORVmsZMcDINt9MZK0b/uxGLYdi9Coy+Bz+Ubi9x6rHiS4
         YociJuOWuZmr41ZDgMWphIS2vP/JI2F4YWmAsGsE5KcLrK5EWamNPzxi3jg3eyhcP5
         u4jS63ly4k/YU6faqB/XVJa9grwHX7l/mWZnnJkiDnlSoflH9NC3Y0tHf7CohJZ74m
         nXrO5b8UBQg/7OPLaglOpfYQzhKQ7rVnA93tTMu9l0WywejpwoV/c2gnW/xB/G9P9S
         jIXwkxXK+iaAlt3BJSj/IhLVWlmPWHeCLnalZ7f/MVJCXg2o2SMfqUPCdPGa85QI4u
         QKJOerRLbJeag==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, mark.rutland@arm.com, paulus@samba.org,
        benh@kernel.crashing.org
Cc:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Scott Wood <oss@buserror.net>
Subject: Re: [PATCH] powerpc/fsl: Add cache properties for T2080/T2081
In-Reply-To: <20200324213612.31614-1-chris.packham@alliedtelesis.co.nz>
References: <20200324213612.31614-1-chris.packham@alliedtelesis.co.nz>
Date:   Wed, 25 Mar 2020 12:59:28 +1100
Message-ID: <877dz9xkhr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Packham <chris.packham@alliedtelesis.co.nz> writes:
> Add the d-cache/i-cache properties for the T208x SoCs. The L1 cache on
> these SoCs is 32KiB and is split into 64 byte blocks (lines).
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

LGTM.

I'll wait a few days to see if Scott wants to ack it.

cheers


> diff --git a/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
> index 3f745de44284..2ad27e16ac16 100644
> --- a/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
> @@ -81,6 +81,10 @@ cpus {
>  		cpu0: PowerPC,e6500@0 {
>  			device_type = "cpu";
>  			reg = <0 1>;
> +			d-cache-line-size = <64>;
> +			i-cache-line-size = <64>;
> +			d-cache-size = <32768>;
> +			i-cache-size = <32768>;
>  			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x80000000>;
> @@ -88,6 +92,10 @@ cpu0: PowerPC,e6500@0 {
>  		cpu1: PowerPC,e6500@2 {
>  			device_type = "cpu";
>  			reg = <2 3>;
> +			d-cache-line-size = <64>;
> +			i-cache-line-size = <64>;
> +			d-cache-size = <32768>;
> +			i-cache-size = <32768>;
>  			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x80000000>;
> @@ -95,6 +103,10 @@ cpu1: PowerPC,e6500@2 {
>  		cpu2: PowerPC,e6500@4 {
>  			device_type = "cpu";
>  			reg = <4 5>;
> +			d-cache-line-size = <64>;
> +			i-cache-line-size = <64>;
> +			d-cache-size = <32768>;
> +			i-cache-size = <32768>;
>  			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x80000000>;
> @@ -102,6 +114,10 @@ cpu2: PowerPC,e6500@4 {
>  		cpu3: PowerPC,e6500@6 {
>  			device_type = "cpu";
>  			reg = <6 7>;
> +			d-cache-line-size = <64>;
> +			i-cache-line-size = <64>;
> +			d-cache-size = <32768>;
> +			i-cache-size = <32768>;
>  			clocks = <&clockgen 1 0>;
>  			next-level-cache = <&L2_1>;
>  			fsl,portid-mapping = <0x80000000>;
> -- 
> 2.25.1
