Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735886462C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 14:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfGJMaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 08:30:04 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:1311
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726097AbfGJMaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:30:04 -0400
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 2F9F9216E4;
        Wed, 10 Jul 2019 12:30:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jul 2019 14:30:02 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Eckert.Florian@googlemail.com, info@metux.net,
        dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] platform/x86/pcengines-apuv2: add mpcie reset gpio
 export
In-Reply-To: <3c469213-f2d7-aa7e-4028-e8ce463a4441@metux.net>
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <20190704090205.19400-2-fe@dev.tdt.de>
 <3c469213-f2d7-aa7e-4028-e8ce463a4441@metux.net>
Message-ID: <f931d21e19a12e34841da978d10a615e@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-08 21:44, Enrico Weigelt, metux IT consult wrote:
> On 04.07.19 11:02, Florian Eckert wrote:
>> On APUx we have also mpcie2/mpcie3 reset pins. To make it possible to 
>> reset
>> the ports from the userspace, add the definition to this platform
>> device. The gpio can then be exported by the legancy gpio subsystem to
>> toggle the mpcie reset pin.
> 
> Are you sure they're also available on APUv2 (not just v3) ?

We have the following models on APU2 family:
The schematic could be downloaded for all APU2 family boards from this 
side.
See https://www.pcengines.ch/apu2.htm

They all use the similar PCB with some minimal changes.

APU2
2 mpcie slot
apu2d0 (2 GB DRAM, 2 i211AT NICs)
apu2d2 (2 GB DRAM, 3 i211AT NICs)
apu2d4 (4 GB DRAM, 3 i210AT NICs)

J14 (USB + SIM1) PE3_RST to GPIO G51
J13 (USB + SIM2) PE4_RST to GPIO G55

APU3
3 mpcie slot
apu3c2 (2 GB DRAM, 3 i211AT NICs, optimized for 3G/LTE modems)
apu3c4 (4 GB DRAM, 3 i211AT NICs, optimized for 3G/LTE modems)

J16 (PCIe + USB no SIM) not connected to a userland GPIO
J15 (USB SIM1) PE4_RST to GPIO G55
J14 (mSATA or USB SIM2) PE3_RST to GPIO G51

APU4
3 mpcie slot
apu4c2 (2 GB DRAM, 4 i211AT NICs)
apu4c4 (4 GB DRAM, 4 i211AT NICs)

J15 (PCIe + USB no SIM) not connected to a userland GPIO
J14 (USB SIM1) PE4_RST to GPIO G55
J13 (mSATA or USB SIM2) PE3_RST to GPIO G51

Please check again so that I have not done any mistake.

So all USB only mpcie slots could be reseted by a GPIO G51 and G55.

Kind regards

Flo

