Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3EA1646A4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 15:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBSOPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 09:15:16 -0500
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17853 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727280AbgBSOPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:15:15 -0500
X-Greylist: delayed 939 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Feb 2020 09:15:06 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1582120725;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=N2QbMOWOsgHlIL0+1XeUQl6yeERWT5IeVW5cvxRhqk4=;
        b=Ao4P6aa+d+a5roISEio/aq8swJ2pMb1l3dNcrChYVajpKRXGgp68M8U/lEPdkeYM
        SOFGE3h6C3QHuNrHvSPdS86V4/fwJ8W+9qWcOoe3KId85fyOTI0GvytdwHwdRpO3IL+
        0FG0v6NodBHXd7wGgmLrewgYG7xEf20VC1A6FMgE=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1582120723154112.79243865540991; Wed, 19 Feb 2020 21:58:43 +0800 (CST)
Date:   Wed, 19 Feb 2020 21:58:43 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     "yuanzhichang" <yuanzhichang@hisilicon.com>,
        "johngarry" <john.garry@huawei.co>,
        "xuwei5" <xuwei5@hisilicon.com>,
        "gabrielepaoloni" <gabriele.paoloni@huawei.com>,
        "bhelgaas" <bhelgaas@google.com>,
        "andyshevchenko" <andy.shevchenko@gmail.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1705dbe62ce.10ae800394772.9222265269135747883@flygoat.com>
In-Reply-To: 
Subject: Questions about logic_pio
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Logic PIO gives us a way to make indirect PIO access, however,
the way it handles direct (MMIO) I/O access confused me.

I was trying to create a PCI controller Driver and noticed that I/O range parsed
from DeviceTree will be added to the Logic PIO range by logic_pio_register_range. 
And than PCI subsystem will use the ioport obtained from `logic_pio_trans_cpuaddr`
to allocate resources for the host bridge. In my case, the range added to the logic pio
 was set as hw_start 0x4000, size 0x4000. Later, `logic_pio_trans_cpuaddr` called
by `pci_address_to_pio` gives a ioport of 0x0, which is totally wrong.

After dig into logic pio logic, I found that logic pio is trying to "allocate" an io_start
for MMIO ranges, the allocation starts from 0x0. And later the io_start is used to calculate
cpu_address.  In my opinion, for direct MMIO access, logic_pio address should always
equal to hw address, because there is no way to translate address from logic pio address
to actual hw address in {in,out}{b,sb,w,sb,l,sl} operations.

How this mechanism intends to work? What is the reason that we are trying to
allocate a io_start for MMIO rather than take their hw_start ioport directly?

Thanks. 

--
Jiaxun Yang


