Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A161C302F5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 21:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfE3Top (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 15:44:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39570 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfE3Top (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 15:44:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so2602053pgc.6;
        Thu, 30 May 2019 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tOkGideby907RBtrOIjKle7GZBE1u6kzscwpZUYpKE0=;
        b=FM2OEZ3GN3bwNq1UjsqaHSfsg8kVmwOrMQr85ikKO6MpKDq0NEkl/yLcklBww55W+/
         C63OZSgCvfsKPmVGNt2edCIw0QDwo2BrgAFIikNPrxvw9HJPoEsZgajMoBeanLhWoWzx
         EWiGa46rv/V2aWL6R9hqdddKY9nUJL4BHp1P6shOpcyUIesmyNcxzU/4FxpJ905CgP6K
         bqUT2/gjzAuwXiZx2gnwE6fLyTQcH8zaJYZOL6i4h3ZDEu94KQcPCbvTxLJ8dISf+P0l
         AO6gppFdP6Eq+wUIf0ut7mt2B9nyisLdbf41uNF+9GtTs2eLNraHTF7VRQg9NwmyMWMe
         7UzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tOkGideby907RBtrOIjKle7GZBE1u6kzscwpZUYpKE0=;
        b=FxJ0F7eA3YZojXLobZegdgC4fb73S3HHLf70NE7KJnfzjE1A3OyKtQ47MRs/rEcVSa
         6gBZLkU/q5tVkokgYwEoO4FlrujQ7NadCjErZWQwOE0srwBeA97SwMzkiXpCustrW7zX
         QUOT3LcF+8yM1Xn4HzTV1VMApegdyEsM/0zLAJSDoewzUnd7eLqLVO+GOPAJAKv0Fxpe
         VNSUhei2+f29aHz3wHJpOxJ4eJ73k9Bhpf1J+Oci0uvmFxq5Kytbvc4Z9CLUxTvwjVPW
         CLLYPLMIIQJpo+qyH1pLjQt11ekdusN3MUWec2yTpLpns42K2atHxCeSqnIdZ6jQ3K8h
         VzIQ==
X-Gm-Message-State: APjAAAWTW6gCSzTJEGzzhWDH3COqVPlz17M1ujwcjv82FpeZfSdFkMLJ
        vV8ISZCic1PerL/vgeU+/DU=
X-Google-Smtp-Source: APXvYqys70QmfcLwxIVpRc0z43hTv7qliHdF9a1qGGNteQ6F/7/vyvccDlhpWdOZWagbjgPXIuw7gg==
X-Received: by 2002:a17:90a:aa0d:: with SMTP id k13mr4784425pjq.53.1559245483769;
        Thu, 30 May 2019 12:44:43 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j20sm1374443pff.183.2019.05.30.12.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 12:44:42 -0700 (PDT)
Date:   Thu, 30 May 2019 12:44:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] Docs: hwmon: pmbus: Add PXE1610 driver
Message-ID: <20190530194441.GA12310@roeck-us.net>
References: <20190529223511.4059120-1-vijaykhemka@fb.com>
 <20190529223511.4059120-2-vijaykhemka@fb.com>
 <0a94e784-41a0-4f2d-f9f8-6b365a1e755e@roeck-us.net>
 <27E78CF3-FAE7-4B6F-ABD7-77F4AE1CD633@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27E78CF3-FAE7-4B6F-ABD7-77F4AE1CD633@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 06:51:52PM +0000, Vijay Khemka wrote:
> 
> 
> ﻿On 5/29/19, 6:05 PM, "Guenter Roeck" <groeck7@gmail.com on behalf of linux@roeck-us.net> wrote:
> 
>     On 5/29/19 3:35 PM, Vijay Khemka wrote:
>     > Added support for Infenion PXE1610 driver
>     > 
>     > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
>     > ---
>     >   Documentation/hwmon/pxe1610 | 84 +++++++++++++++++++++++++++++++++++++
>     >   1 file changed, 84 insertions(+)
>     >   create mode 100644 Documentation/hwmon/pxe1610
>     > 
>     > diff --git a/Documentation/hwmon/pxe1610 b/Documentation/hwmon/pxe1610
>     > new file mode 100644
>     > index 000000000000..b5c83edf027a
>     > --- /dev/null
>     > +++ b/Documentation/hwmon/pxe1610
>     > @@ -0,0 +1,84 @@
>     > +Kernel driver pxe1610
>     > +=====================
>     > +
>     > +Supported chips:
>     > +  * Infinion PXE1610
>     > +    Prefix: 'pxe1610'
>     > +    Addresses scanned: -
>     > +    Datasheet: Datasheet is not publicly available.
>     > +
>     > +  * Infinion PXE1110
>     > +    Prefix: 'pxe1110'
>     > +    Addresses scanned: -
>     > +    Datasheet: Datasheet is not publicly available.
>     > +
>     > +  * Infinion PXM1310
>     > +    Prefix: 'pxm1310'
>     > +    Addresses scanned: -
>     > +    Datasheet: Datasheet is not publicly available.
>     > +
>     > +Author: Vijay Khemka <vijaykhemka@fb.com>
>     > +
>     > +
>     > +Description
>     > +-----------
>     > +
>     > +PXE1610 is a Multi-rail/Multiphase Digital Controllers and
>     > +it is compliant to Intel VR13 DC-DC converter specifications.
>     > +
>     
>     And the others ?
> This supports VR12 as well and I don't see this controller supports any other VR versions.
>     
The point here is that there is no description of the other controllers.

>     > +
>     > +Usage Notes
>     > +-----------
>     > +
>     > +This driver can be enabled with kernel config CONFIG_SENSORS_PXE1610
>     > +set to 'y' or 'm'(for module).
>     > +
>     The above does not really add value.
> Ok, I will remove it.
>     
>     > +This driver does not probe for PMBus devices. You will have
>     > +to instantiate devices explicitly.
>     > +
>     > +Example: the following commands will load the driver for an PXE1610
>     > +at address 0x70 on I2C bus #4:
>     > +
>     > +# modprobe pxe1610
>     > +# echo pxe1610 0x70 > /sys/bus/i2c/devices/i2c-4/new_device
>     > +
>     > +It can also be instantiated by declaring in device tree if it is
>     > +built as a kernel not as a module.
>     > +
>     
>     I assume you mean "built into the kernel".
>     Why would devicetree based instantiation not work if the driver is built
>     as module ?
> Will correct statement here.
>     
>     > +
>     > +Sysfs attributes
>     > +----------------
>     > +
>     > +curr1_label		"iin"
>     > +curr1_input		Measured input current
>     > +curr1_alarm		Current high alarm
>     > +
>     > +curr[2-4]_label		"iout[1-3]"
>     > +curr[2-4]_input		Measured output current
>     > +curr[2-4]_crit		Critical maximum current
>     > +curr[2-4]_crit_alarm	Current critical high alarm
>     > +
>     > +in1_label		"vin"
>     > +in1_input		Measured input voltage
>     > +in1_crit		Critical maximum input voltage
>     > +in1_crit_alarm		Input voltage critical high alarm
>     > +
>     > +in[2-4]_label		"vout[1-3]"
>     > +in[2-4]_input		Measured output voltage
>     > +in[2-4]_lcrit		Critical minimum output voltage
>     > +in[2-4]_lcrit_alarm	Output voltage critical low alarm
>     > +in[2-4]_crit		Critical maximum output voltage
>     > +in[2-4]_crit_alarm	Output voltage critical high alarm
>     > +
>     > +power1_label		"pin"
>     > +power1_input		Measured input power
>     > +power1_alarm		Input power high alarm
>     > +
>     > +power[2-4]_label	"pout[1-3]"
>     > +power[2-4]_input	Measured output power
>     > +
>     > +temp[1-3]_input		Measured temperature
>     > +temp[1-3]_crit		Critical high temperature
>     > +temp[1-3]_crit_alarm	Chip temperature critical high alarm
>     > +temp[1-3]_max		Maximum temperature
>     > +temp[1-3]_max_alarm	Chip temperature high alarm
>     > 
>     
>     
> 
