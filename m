Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E99525C43
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2019 05:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfEVDmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 23:42:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36542 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfEVDmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 23:42:21 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hTI8w-00045F-Ut
        for linux-kernel@vger.kernel.org; Wed, 22 May 2019 03:42:19 +0000
Received: by mail-pf1-f200.google.com with SMTP id k22so831957pfg.18
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 20:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NPTfaApxYhJLazeTc6j/yypjFDd8f8Hs9lpKwzlxSxg=;
        b=aG3rpC1K5pl29A/j/bBkqAJCllT0ykAMFbcNkOgoWyw6y6fTs+XVay+PluIrPI+7JW
         M3WrUkHQlbjclo/WiYAHomII+22kaJdFPTaTr6WjJhbV/9G0nScs7UcgfXm8wHit68Dy
         xQODzQ8nzS91yFFizwnyWNnqOAAPV0JrwonXQOp1/+ydO0x6vDzE1TlmjO2nj9MVWoOT
         gVKKdmhKvPHkeh2TQFjLgTrT+PvrevjhPqgGurT5nkeeq/WH1pMdeGPUu9aCkg7VosSC
         1InG++hgwOcaesff8OcCU5h9AQZdLzOKZPq3hCdi5l6gZEL+8546Exi9j59qDMdwUJKZ
         7xKw==
X-Gm-Message-State: APjAAAUlRvsmmb0IMO1hHtSW99jA5I6yso2TgxFcXRsYVFWlwJ7ycp6A
        KNk+O7PIqy6NhgBwRYk4ZNYEzneRfYbDFa6pZZ8xSa7pibTEFbwZyYpkIgkdV8999zdP6/3/BsU
        K1V/EWaIkSaEe48bh0Q2tys8fQUNkU2fi9NFKVHxG9w==
X-Received: by 2002:a63:fd4a:: with SMTP id m10mr86016123pgj.302.1558496537571;
        Tue, 21 May 2019 20:42:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx6Crm8I8i1AnlXR0t9YOt0OdN/qVVPqLZbTo6dRoYrFXqVPXoCm+7hvxVmOVPBRx5TFq/tKw==
X-Received: by 2002:a63:fd4a:: with SMTP id m10mr86016105pgj.302.1558496537321;
        Tue, 21 May 2019 20:42:17 -0700 (PDT)
Received: from [10.101.46.168] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id s134sm34046394pfc.110.2019.05.21.20.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 20:42:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] PCI / PM: Don't runtime suspend when device only supports
 wakeup from D0
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190521222300.GG57618@google.com>
Date:   Wed, 22 May 2019 11:42:14 +0800
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <AE3B21D0-5BD9-40A5-B5A1-3E9A8B8E1327@canonical.com>
References: <20190521163104.15759-1-kai.heng.feng@canonical.com>
 <20190521222300.GG57618@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 6:23 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Mathias, linux-usb]
>
> On Wed, May 22, 2019 at 12:31:04AM +0800, Kai-Heng Feng wrote:
>> There's an xHC device that doesn't wake when a USB device gets plugged
>> to its USB port. The driver's own runtime suspend callback was called,
>> PME signaling was enabled, but it stays at PCI D0.
>
> s/xHC/xHCI/ ?
>
> This looks like it's fixing a bug?  If so, please include a link to
> the bug report, and make sure the bug report has "lspci -vv" output
> attached to it.

Ok, I’ll update this in V2.

>
>> A PCI device can be runtime suspended to D0 when it supports D0 PME and
>> its _S0W reports D0. Theoratically this should work, but as [1]
>> specifies, D0 doesn't have wakeup capability.
>
> s/Theoratically/Theoretically/

Ok.

>
> What does "runtime suspended to D0" mean?

It’s runtime suspended by PCI core, but stays at D0.

>  Is that different from the regular "device is fully operational" sort of D0?

Yes it's different to that.
Because of _S0W reports D0 and the device has D0 PME support, so it’s  
“suspended” to D0:

00:10.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] FCH USB  
XHCI Controller [1022:7914] (rev 20) (prog-if 30 [XHCI])
         Subsystem: Dell FCH USB XHCI Controller [1028:096c]
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at f0668000 (64-bit, non-prefetchable) [size=8K]
         Capabilities: [50] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
         Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
                 Address: 0000000000000000  Data: 0000
         Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
                 Vector table: BAR=0 offset=00001000
                 PBA: BAR=0 offset=00001080
         Capabilities: [a0] Express (v2) Root Complex Integrated Endpoint, MSI 00
                 DevCap: MaxPayload 128 bytes, PhantFunc 0
                         ExtTag- RBE+
                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                 DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF Not Supported
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
         Capabilities: [100 v1] Latency Tolerance Reporting
                 Max snoop latency: 0ns
                 Max no snoop latency: 0ns
         Kernel driver in use: xhci_hcd


PME signaling is correctly enabled:
Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-

> If so, what
> distinguishes "runtime suspended D0" from "normal fully operational
> D0”?

The xHC’s own runtime suspend routine is called, but PCI core’s runtime  
suspend routine decides it should stay at D0.
So it’s technically runtime suspended to D0.

Kai-Heng

>
>> To avoid this problematic situation, we should avoid runtime suspend if
>> D0 is the only state that can wake up the device.
>>
>> [1]  
>> https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/device-working-state-d0
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/pci/pci-driver.c | 5 +++++
>>  drivers/pci/pci.c        | 2 +-
>>  include/linux/pci.h      | 3 +++
>>  3 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index cae630fe6387..15a6310c5d7b 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -1251,6 +1251,11 @@ static int pci_pm_runtime_suspend(struct device  
>> *dev)
>>  		return 0;
>>  	}
>>
>> +	if (pci_target_state(pci_dev, device_can_wakeup(dev)) == PCI_D0) {
>> +		dev_dbg(dev, "D0 doesn't have wakeup capability\n");
>> +		return -EBUSY;
>> +	}
>> +
>>  	pci_dev->state_saved = false;
>>  	if (pm && pm->runtime_suspend) {
>>  		error = pm->runtime_suspend(dev);
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 8abc843b1615..ceee6efbbcfe 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2294,7 +2294,7 @@ EXPORT_SYMBOL(pci_wake_from_d3);
>>   * If the platform can't manage @dev, return the deepest state from which it
>>   * can generate wake events, based on any available PME info.
>>   */
>> -static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>> +pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>>  {
>>  	pci_power_t target_state = PCI_D3hot;
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 4a5a84d7bdd4..91e8dc4d04aa 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1188,6 +1188,7 @@ bool pci_pme_capable(struct pci_dev *dev,  
>> pci_power_t state);
>>  void pci_pme_active(struct pci_dev *dev, bool enable);
>>  int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable);
>>  int pci_wake_from_d3(struct pci_dev *dev, bool enable);
>> +pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup);
>>  int pci_prepare_to_sleep(struct pci_dev *dev);
>>  int pci_back_from_sleep(struct pci_dev *dev);
>>  bool pci_dev_run_wake(struct pci_dev *dev);
>> @@ -1672,6 +1673,8 @@ static inline int pci_set_power_state(struct  
>> pci_dev *dev, pci_power_t state)
>>  { return 0; }
>>  static inline int pci_wake_from_d3(struct pci_dev *dev, bool enable)
>>  { return 0; }
>> +pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>> +{ return PCI_D0; }
>>  static inline pci_power_t pci_choose_state(struct pci_dev *dev,
>>  					   pm_message_t state)
>>  { return PCI_D0; }
>> -- 
>> 2.17.1


