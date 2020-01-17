Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D258D14071A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 10:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgAQJ6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 04:58:36 -0500
Received: from ofcsgdbm.dwd.de ([141.38.3.245]:33933 "EHLO ofcsgdbm.dwd.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728913AbgAQJ6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:58:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by ofcsg2dn1.dwd.de (Postfix) with ESMTP id 47zc2X49xYz6v5j
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 09:58:28 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2dn1.dwd.de ([127.0.0.1])
        by localhost (ofcsg2dn1.dwd.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 9ZkaTD7x98ih for <linux-kernel@vger.kernel.org>;
        Fri, 17 Jan 2020 09:58:28 +0000 (UTC)
Received: from ofmailhub.dwd.de (oflxs446.dwd.de [141.38.40.78])
        by ofcsg2dn1.dwd.de (Postfix) with ESMTP id 47zc2X24mTz6v59;
        Fri, 17 Jan 2020 09:58:28 +0000 (UTC)
Received: from diagnostix.dwd.de (diagnostix.dwd.de [141.38.42.141])
        by ofmailhub.dwd.de (Postfix) with ESMTP id BBD895B707;
        Fri, 17 Jan 2020 09:58:27 +0000 (UTC)
Date:   Fri, 17 Jan 2020 09:58:27 +0000 (UTC)
From:   Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To:     Guenter Roeck <linux@roeck-us.net>
cc:     linux-hwmon@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
In-Reply-To: <20200116141800.9828-1-linux@roeck-us.net>
Message-ID: <alpine.LRH.2.21.2001170949500.21460@diagnostix.dwd.de>
References: <20200116141800.9828-1-linux@roeck-us.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="646810922-661853023-1579255108=:21460"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--646810922-661853023-1579255108=:21460
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 16 Jan 2020, Guenter Roeck wrote:

> This patch series implements various improvements for the k10temp driver.
> 
> Patch 1/4 introduces the use of bit operations.
> 
> Patch 2/4 converts the driver to use the devm_hwmon_device_register_with_info
> API. This not only simplifies the code and reduces its size, it also
> makes the code easier to maintain and enhance. 
> 
> Patch 3/4 adds support for reporting Core Complex Die (CCD) temperatures
> on Ryzen 3 (Zen2) CPUs.
> 
> Patch 4/4 adds support for reporting core and SoC current and voltage
> information on Ryzen CPUs.
> 
> With all patches in place, output on Ryzen 3900 CPUs looks as follows
> (with the system under load).
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:        +1.36 V
> Vsoc:         +1.18 V
> Tdie:         +86.8°C  (high = +70.0°C)
> Tctl:         +86.8°C
> Tccd1:        +80.0°C
> Tccd2:        +81.8°C
> Icore:       +44.14 A
> Isoc:        +13.83 A
> 
> The patch series has only been tested with Ryzen 3900 CPUs. Further test
> coverage will be necessary before the changes can be applied to the Linux
> kernel.
> 
Here from my little Asrock A300 with a Ryzen 2400G:

   sensors
   k10temp-pci-00c3
   Adapter: PCI adapter
   Vcore:        +0.78 V  
   Vsoc:         +1.11 V  
   Tdie:         +44.8°C  (high = +70.0°C)
   Tctl:         +44.8°C  
   Icore:        +5.20 A  
   Isoc:         +2.17 A  

   nvme-pci-0100
   Adapter: PCI adapter
   Composite:    +41.9°C  (low  = -273.1°C, high = +80.8°C)
                          (crit = +80.8°C)
   Sensor 1:     +41.9°C  (low  = -273.1°C, high = +65261.8°C)
   Sensor 2:     +44.9°C  (low  = -273.1°C, high = +65261.8°C)

   nct6793-isa-0290
   Adapter: ISA adapter
   in0:                    +0.34 V  (min =  +0.00 V, max =  +1.74 V)
   in1:                    +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in2:                    +3.41 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in3:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in4:                    +0.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in5:                    +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in6:                    +0.67 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in7:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in8:                    +3.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in9:                    +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in10:                   +0.19 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in11:                   +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in12:                   +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in13:                   +1.72 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in14:                   +0.20 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   fan1:                     0 RPM  (min =    0 RPM)
   fan2:                   317 RPM  (min =    0 RPM)
   fan3:                     0 RPM  (min =    0 RPM)
   fan4:                     0 RPM  (min =    0 RPM)
   fan5:                     0 RPM  (min =    0 RPM)
   SYSTIN:                +113.0°C  (high =  +0.0°C, hyst =  +0.0°C)  sensor = thermistor
   CPUTIN:                 +59.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
   AUXTIN0:                +45.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = thermistor
   AUXTIN1:               +107.0°C    sensor = thermistor
   AUXTIN2:               +106.0°C    sensor = thermistor
   AUXTIN3:               +103.0°C    sensor = thermistor
   SMBUSMASTER 0:          +44.5°C  
   PCH_CHIP_CPU_MAX_TEMP:   +0.0°C  
   PCH_CHIP_TEMP:           +0.0°C  
   PCH_CPU_TEMP:            +0.0°C  
   intrusion0:            OK
   intrusion1:            ALARM
   beep_enable:           disabled

   amdgpu-pci-0300
   Adapter: PCI adapter
   vddgfx:           N/A  
   vddnb:            N/A  
   edge:         +44.0°C  (crit = +80.0°C, hyst =  +0.0°C)

Patches applied without any problem against Linus git tree.

Many thanks for this work!

Regards,
Holger
--646810922-661853023-1579255108=:21460--
