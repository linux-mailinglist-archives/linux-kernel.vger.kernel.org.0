Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E7380ABC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2019 13:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfHDLv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Aug 2019 07:51:56 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:55887 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbfHDLv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 07:51:56 -0400
Received: from yessica.powercraft.nl ([80.127.158.83])
        by smtp-cloud7.xs4all.net with ESMTP
        id uF3IhY7oMur8TuF3JhNoXu; Sun, 04 Aug 2019 13:51:53 +0200
Received: from [192.168.24.203] (ebony.powercraft.nl [80.127.158.83])
        by yessica.powercraft.nl (Postfix) with ESMTPSA id EAA5920457;
        Sun,  4 Aug 2019 13:51:51 +0200 (CEST)
From:   Jelle de Jong <jelledejong@powercraft.nl>
Subject: bios and memtest86+ show different memory cas latency as linux
 kernel, ram speed explained, how, why?
Message-ID: <f32345c4-0ed4-0377-721b-51475b7e0b5f@powercraft.nl>
Date:   Sun, 4 Aug 2019 13:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
To:     undisclosed-recipients:;
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfM3ivNdDomOJPUqKnCD4nPUDJptlAONggyLXrj8R9r/JFS9BfW0njIk9kKBozKaDF/WiT6LsC9NCIwki7YO7CXk3zUHNrMYj75emqQO+X6TzK1+ba5GL
 SdrEBrSqKy6DTgaR/LCIxEv3wtcPjwEOuRoAuyh1bHp4eTTtXDF7X9xuh71BATtqpa9n/dAIapcVxehZNdgEYy0Dqa/Je2wHfCTerWLTnl6laPJZ5N7kz4zD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

memtest86+ shows latency 9-9-9-24 with dimm part 36JSF2G72PZ-1G9E1
memtest86+ shows latency 9-9-9-23 with dimm part 9965516-115.A00LF
memtest86+ shows latency 9-9-9-23 with both dimm part 9965516-115.A00LF 
and 36JSF2G72PZ-1G9E1

https://www.micron.com/products/dram-modules/rdimm/part-catalog/mt36jsf2g72pz-1g9 
(IBM 16GB DDR3 PC3-14900R 1866MHz ECC Reg)

https://www.kingston.com/datasheets/KVR16R11D4_16.pdf 
(9965516-115.A00LF) (Kingston 16GB DDR3 2Rx4 PC3-12800R 1600MHz 1.5V 
CL11 ECC Reg)

However when I check "dmidecode -t memory" and "lshw -short -C memory" 
it shows the module 9965516-115.A00LF running at 800 MHz (1.2 ns) but 
the 36JSF2G72PZ-1G9E1 module 1600 MHz (0.6 ns).

This is confusing to me! Can the kernel have different CAS latency 
timings as memtest86+ and the system bios? Can I increase the speed of 
the module somehow (no bios option found).

I was looking at buying quite a few of the 36JSF2G72PZ-1G9E1 but if they 
can not run at the maximum latency timings of the system then I think I 
have to find other modules. I am trying to see if I am making a mistake 
reading the data.

I got screenshots of the memtest86+ outputs if needed.

# uname -a
Linux viktoriya 4.19.0-5-amd64 #1 SMP Debian 4.19.37-6 (2019-07-18) 
x86_64 GNU/Linux

Handle 0x003D, DMI type 17, 28 bytes
Memory Device
     Array Handle: 0x003A
     Error Information Handle: Not Provided
     Total Width: 72 bits
     Data Width: 64 bits
     Size: 16384 MB
     Form Factor: DIMM
     Set: None
     Locator: CPU0 DIMM1
     Bank Locator: Not Specified
     Type: DDR3
     Type Detail: Synchronous Registered (Buffered)
     Speed: 800 MHz
     Manufacturer: JEDEC ID:80 2C
     Serial Number: E5004045
     Asset Tag: Not Specified
     Part Number: 36JSF2G72PZ-1G9E1
     Rank: 2

Memory Device
     Array Handle: 0x003A
     Error Information Handle: Not Provided
     Total Width: 72 bits
     Data Width: 64 bits
     Size: 16384 MB
     Form Factor: DIMM
     Set: None
     Locator: CPU0 DIMM1
     Bank Locator: Not Specified
     Type: DDR3
     Type Detail: Synchronous Registered (Buffered)
     Speed: 1600 MHz
     Manufacturer: JEDEC ID:01 98
     Serial Number: 11442EEB
     Asset Tag: Not Specified
     Part Number: 9965516-115.A00LF
     Rank: 2

lshw -short -C memory
H/W path       Device     Class       Description
=================================================
/0/1                      memory      128KiB BIOS
/0/5/7                    memory      256KiB L1 cache
/0/5/8                    memory      1MiB L2 cache
/0/5/9                    memory      8MiB L3 cache
/0/6/a                    memory      256KiB L1 cache
/0/6/b                    memory      1MiB L2 cache
/0/6/c                    memory      8MiB L3 cache
/0/3a                     memory      System Memory
/0/3a/0                   memory      16GiB DIMM DDR3 Synchronous 
Registered (Buffered) 1600 MHz (0.6 ns)
/0/3a/1                   memory      16GiB DIMM DDR3 Synchronous 
Registered (Buffered) 800 MHz (1.2 ns)
/0/3a/2                   memory      DIMM DDR3 Synchronous [empty]
/0/3b                     memory      System Memory
/0/3b/0                   memory      16GiB DIMM DDR3 Synchronous 
Registered (Buffered) 1600 MHz (0.6 ns)
/0/3b/1                   memory      16GiB DIMM DDR3 Synchronous 
Registered (Buffered) 800 MHz (1.2 ns)
/0/3b/2                   memory      DIMM DDR3 Synchronous [empty]
/0/3c                     memory      Flash Memory
/0/3c/0                   memory      2MiB Chip FLASH Non-volatile
/0/0                      memory
/0/2                      memory

Vendor: Hewlett-Packard
Version: 786G4 v03.61
Release Date: 03/05/2018

Product Name: HP Z600 Workstation
Serial Number: CZC13377H1

Kind regards,

Jelle de Jong
