Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61B87C26
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 15:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406739AbfHINyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 09:54:44 -0400
Received: from foss.arm.com ([217.140.110.172]:47700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfHINyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:54:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0363C1596;
        Fri,  9 Aug 2019 06:54:44 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCE773F706;
        Fri,  9 Aug 2019 06:54:42 -0700 (PDT)
Date:   Fri, 9 Aug 2019 14:54:40 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Joe Burmeister <joe.burmeister@devtank.co.uk>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add optional chip erase functionality to AT25 EEPROM
 driver.
Message-ID: <20190809135440.GI48423@lakrids.cambridge.arm.com>
References: <20190809125358.24440-1-joe.burmeister@devtank.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809125358.24440-1-joe.burmeister@devtank.co.uk>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 01:53:55PM +0100, Joe Burmeister wrote:
> Many, though not all, AT25s have an instruction for chip erase.
> If there is one in the datasheet, it can be added to device tree.
> Erase can then be done in userspace via the sysfs API with a new
> "erase" device attribute. This matches the eeprom_93xx46 driver's
> "erase".
> 
> Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
> ---
>  .../devicetree/bindings/eeprom/at25.txt       |  2 +
>  drivers/misc/eeprom/at25.c                    | 83 ++++++++++++++++++-
>  2 files changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/at25.txt b/Documentation/devicetree/bindings/eeprom/at25.txt
> index b3bde97dc199..c65d11e14c7a 100644
> --- a/Documentation/devicetree/bindings/eeprom/at25.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at25.txt
> @@ -19,6 +19,7 @@ Optional properties:
>  - spi-cpha : SPI shifted clock phase, as per spi-bus bindings.
>  - spi-cpol : SPI inverse clock polarity, as per spi-bus bindings.
>  - read-only : this parameter-less property disables writes to the eeprom
> +- chip_erase_instruction : Chip erase instruction for this AT25, often 0xc7 or 0x62.

This should be using '-' rather than '_', as per general DT conventions
and as with the existing properties.

>  Obsolete legacy properties can be used in place of "size", "pagesize",
>  "address-width", and "read-only":
> @@ -39,4 +40,5 @@ Example:
>  		pagesize = <64>;
>  		size = <32768>;
>  		address-width = <16>;
> +		chip_erase_instruction = <0x62>;

[...]

> +	/* Optional chip erase instruction */
> +	device_property_read_u8(&spi->dev, "chip_erase_instruction", &at25->erase_instr);

This will not behave as you expect, since you didn't mark the property as
8-bits.

Read this as a u32 into the existing val temporary variable, as is done
for pagesize. You can add a warnign if it's out-of-range.

Thanks,
Mark.
