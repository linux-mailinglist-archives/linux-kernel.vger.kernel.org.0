Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7A15E2D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 13:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfGCLdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 07:33:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53598 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCLdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 07:33:05 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hidVW-0001K8-15
        for linux-kernel@vger.kernel.org; Wed, 03 Jul 2019 11:33:02 +0000
Received: by mail-pf1-f198.google.com with SMTP id h27so1320658pfq.17
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 04:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ufNYN0wFou7V49GspdJXldNYi7W8aWs2LrCrfDoH9jY=;
        b=MZ7EBmpy0b1dzCrLJit+lU/njmyMyxS5DQF/37GXRP3qYAZXA/SZO8xi0eWvRyHB7z
         ANfRFtNm3yLuu/b+WRQYB3lyu/HmlAEt9MP+Se4LiYrSB8uuCKInrkx4gQxirGCE7JjZ
         cvn/iRREF2VWyW6pRMNDFBQkKC4yf1KsU4jsVl+X2KMRW3zwgm7wSoZ89FAN3sq6OLAt
         YsWdtuKi+5QjkN9/e6g+xS+DIIRrYFPsYh/hLzA7BldzaR8bTIgiSj4mmEcYlxVZw/ej
         lExUWqXkMz2xGE0wJ3zHHmdZjelGndnvvg2BQ7eT8LNs+dSH64RQLkvF3w+K8Nz485EF
         sPaw==
X-Gm-Message-State: APjAAAUC86jq+VAl/rhBNcqxPrH+DT3V3UHaZhyOyupj6YkniSzLeldX
        KjqWuGX5Af8BaEUPXr+jnXRKIWJMRHrnHEa9tqArxnui94IhxA56Qp8pMRynemDiMVKFoNBl5RD
        EeEguZkEeHynKIECmGN1g1Ek08VkLLvFzfBbYfCDvtg==
X-Received: by 2002:a63:5610:: with SMTP id k16mr11638574pgb.335.1562153580715;
        Wed, 03 Jul 2019 04:33:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxVY8F9W8+FiFFBSzRkjtsGiPHFdm2fPfGek+lVyQn1qowVFjF9HEvd43aml9Mn9wYSrjW8Iw==
X-Received: by 2002:a63:5610:: with SMTP id k16mr11638556pgb.335.1562153580379;
        Wed, 03 Jul 2019 04:33:00 -0700 (PDT)
Received: from 2001-b011-380f-3511-504a-71ad-28b3-6aae.dynamic-ip6.hinet.net (2001-b011-380f-3511-504a-71ad-28b3-6aae.dynamic-ip6.hinet.net. [2001:b011:380f:3511:504a:71ad:28b3:6aae])
        by smtp.gmail.com with ESMTPSA id x25sm2086715pfm.48.2019.07.03.04.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 04:32:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: RX CRC errors on I219-V (6) 8086:15be
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190702180112.GB128603@google.com>
Date:   Wed, 3 Jul 2019 19:32:56 +0800
Cc:     "Neftin, Sasha" <sasha.neftin@intel.com>,
        jeffrey.t.kirsher@intel.com,
        Anthony Wong <anthony.wong@canonical.com>,
        intel-wired-lan@lists.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <FD81A21F-BEAF-4400-A95F-8F29FCCC42F5@canonical.com>
References: <C4036C54-EEEB-47F3-9200-4DD1B22B4280@canonical.com>
 <3975473C-B117-4DC6-809A-6623A5A478BF@canonical.com>
 <ed4eca8e-d393-91d7-5d2f-97d42e0b75cb@intel.com>
 <1804A45E-71B5-4C41-839C-AF0CFAD0D785@canonical.com>
 <E29A2CD2-1632-4575-9910-0808BD15F4D3@canonical.com>
 <20190702180112.GB128603@google.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 02:01, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Jul 02, 2019 at 04:25:59PM +0800, Kai Heng Feng wrote:
>> +linux-pci
>>
>> Hi Sasha,
>>
>> at 6:49 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>
>>> at 14:26, Neftin, Sasha <sasha.neftin@intel.com> wrote:
>>>
>>>> On 6/26/2019 09:14, Kai Heng Feng wrote:
>>>>> Hi Sasha
>>>>> at 5:09 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>>>>> Hi Jeffrey,
>>>>>>
>>>>>> We’ve encountered another issue, which causes multiple CRC
>>>>>> errors and renders ethernet completely useless, here’s the
>>>>>> network stats:
>>>>> I also tried ignore_ltr for this issue, seems like it alleviates
>>>>> the symptom a bit for a while, then the network still becomes
>>>>> useless after some usage.
>>>>> And yes, it’s also a Whiskey Lake platform. What’s the next step
>>>>> to debug this problem?
>>>>> Kai-Heng
>>>> CRC errors not related to the LTR. Please, try to disable the ME on
>>>> your platform. Hope you have this option in BIOS. Another way is to
>>>> contact your PC vendor and ask to provide NVM without ME. Let's
>>>> start debugging with these steps.
>>>
>>> According to ODM, the ME can be physically disabled by a jumper.
>>> But after disabling the ME the same issue can still be observed.
>>
>> We’ve found that this issue doesn’t happen to SATA SSD, it only happens  
>> when
>> NVMe SSD is in use.
>>
>> Here are the steps:
>> - Disable NVMe ASPM, issue persists
>> - modprobe -r e1000e && modprobe e1000e, issue doesn’t happen
>> - Enabling NVMe ASPM, issue doesn’t happen
>>
>> As long as NVMe ASPM gets enabled after e1000e gets loaded, the issue
>> doesn’t happen.
>
> IIUC the problem happens with the mainline and dev-queue e1000e
> driver, but not with the out-of-tree Intel driver.  Since there is a
> working driver and there's the potential (at least in principle) for
> unifying them or bisecting between them, I have limited interest in
> debugging it from scratch.

I wonder why disabling ASPM on a device solves another device’s issue?
The issue may just get papered over by the “working” driver. I’d like to  
understand the root cause behind this symptom.

>
> If it turns out to be a PCI core problem, I would want to know: What's
> the PCI topology?  "lspci -vv" output for the system?  Does it make a
> difference if you boot with "pcie_aspm=off"?  Collect complete dmesg,
> maybe attach it to a kernel.org bugzilla?

Parameter “pcie_aspm=off” doesn’t work for the system.
I need to use "pcie_aspm=force” and change the policy to “performance”.
The issue is gone once e1000e loads after ASPM is disabled, either globally  
or only disabling ASPM on NVMe.

Files attached to https://bugzilla.kernel.org/show_bug.cgi?id=204057

Kai-Heng

>
>>>>>> /sys/class/net/eno1/statistics$ grep . *
>>>>>> collisions:0
>>>>>> multicast:95
>>>>>> rx_bytes:1499851
>>>>>> rx_compressed:0
>>>>>> rx_crc_errors:1165
>>>>>> rx_dropped:0
>>>>>> rx_errors:2330
>>>>>> rx_fifo_errors:0
>>>>>> rx_frame_errors:0
>>>>>> rx_length_errors:0
>>>>>> rx_missed_errors:0
>>>>>> rx_nohandler:0
>>>>>> rx_over_errors:0
>>>>>> rx_packets:4789
>>>>>> tx_aborted_errors:0
>>>>>> tx_bytes:864312
>>>>>> tx_carrier_errors:0
>>>>>> tx_compressed:0
>>>>>> tx_dropped:0
>>>>>> tx_errors:0
>>>>>> tx_fifo_errors:0
>>>>>> tx_heartbeat_errors:0
>>>>>> tx_packets:7370
>>>>>> tx_window_errors:0
>>>>>>
>>>>>> Same behavior can be observed on both mainline kernel and on
>>>>>> your dev-queue branch.
>>>>>> OTOH, the same issue can’t be observed on out-of-tree e1000e.
>>>>>>
>>>>>> Is there any plan to close the gap between upstream and
>>>>>> out-of-tree version?
>>>>>>
>>>>>> Kai-Heng


