Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86EBAF766C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 15:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKKOcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 09:32:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:42024 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfKKOcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:32:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1CEA7B53B;
        Mon, 11 Nov 2019 14:32:18 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
References: <20191111133421.14390-1-anup.patel@wdc.com>
        <mvmv9rqcxpq.fsf@suse.de>
        <MN2PR04MB60616625B9BEFF634FA680728D740@MN2PR04MB6061.namprd04.prod.outlook.com>
X-Yow:  I'm a fuschia bowling ball somewhere in Brittany
Date:   Mon, 11 Nov 2019 15:32:16 +0100
In-Reply-To: <MN2PR04MB60616625B9BEFF634FA680728D740@MN2PR04MB6061.namprd04.prod.outlook.com>
        (Anup Patel's message of "Mon, 11 Nov 2019 14:21:17 +0000")
Message-ID: <mvm5zjqcwlr.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 11 2019, Anup Patel wrote:

>> -----Original Message-----
>> From: Andreas Schwab <schwab@suse.de>
>> Sent: Monday, November 11, 2019 7:38 PM
>> To: Anup Patel <Anup.Patel@wdc.com>
>> Cc: Palmer Dabbelt <palmer@sifive.com>; Paul Walmsley
>> <paul.walmsley@sifive.com>; Atish Patra <Atish.Patra@wdc.com>; Alistair
>> Francis <Alistair.Francis@wdc.com>; Christoph Hellwig <hch@lst.de>; Anup
>> Patel <anup@brainfault.org>; linux-riscv@lists.infradead.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH] RISC-V: Enable SYSCON reboot and poweroff drivers
>> 
>> On Nov 11 2019, Anup Patel wrote:
>> 
>> > We can use SYSCON reboot and poweroff drivers for the SiFive test
>> > device found on QEMU virt machine and SiFive SOCs.
>> 
>> I don't see any syscon-reboot compatible in the device tree.
>
> I have sent patch to QEMU as well for generating SYSCON DT nodes.

What about the kernel DT?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
