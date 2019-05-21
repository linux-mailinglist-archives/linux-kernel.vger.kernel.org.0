Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E8B254F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 18:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfEUQLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 12:11:09 -0400
Received: from foss.arm.com ([217.140.101.70]:37994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbfEUQLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:11:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F8F9374;
        Tue, 21 May 2019 09:11:08 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4174D3F718;
        Tue, 21 May 2019 09:11:07 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] arm64: dts: meson: Add minimal support for
 Odroid-N2
To:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190521151952.2779-1-narmstrong@baylibre.com>
 <20190521151952.2779-4-narmstrong@baylibre.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4eb6aa5c-14e2-944e-9f15-692063ef072b@arm.com>
Date:   Tue, 21 May 2019 17:11:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521151952.2779-4-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 16:19, Neil Armstrong wrote:
[...]
> +		cpu100: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73", "arm,armv8";

Nit: we've recently tried to eradicate "arm,armv8" as a fallback 
compatible for real CPUs (although I see there are still a couple of 
instances that have slipped through).

Robin.

> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu101: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73", "arm,armv8";
> +			reg = <0x0 0x101>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu102: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73", "arm,armv8";
> +			reg = <0x0 0x102>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +
> +		cpu103: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73", "arm,armv8";
> +			reg = <0x0 0x103>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +		};
> +	};
> +};
> +
> +&clkc {
> +	compatible = "amlogic,g12b-clkc";
> +};
> 
