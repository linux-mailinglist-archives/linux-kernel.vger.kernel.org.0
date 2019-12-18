Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 985A1124390
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 10:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfLRJqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 04:46:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:44020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfLRJqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:46:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 78232ADCB;
        Wed, 18 Dec 2019 09:46:07 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bin Meng <bmeng.cn@gmail.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: reject invalid syscalls below -1
References: <20191218084757.904971-1-david.abdurachmanov@sifive.com>
X-Yow:  Here I am in the POSTERIOR OLFACTORY LOBULE but I don't see CARL SAGAN
 anywhere!!
Date:   Wed, 18 Dec 2019 10:46:06 +0100
In-Reply-To: <20191218084757.904971-1-david.abdurachmanov@sifive.com> (David
        Abdurachmanov's message of "Wed, 18 Dec 2019 10:47:56 +0200")
Message-ID: <mvmo8w63r1d.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dez 18 2019, David Abdurachmanov wrote:

> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index a1349ca64669..e163b7b64c86 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -246,6 +246,7 @@ check_syscall_nr:
>  	 */
>  	li t1, -1
>  	beq a7, t1, ret_from_syscall_rejected
> +	blt a7, t1, 1f

How about using bgeu instead in the preceding check?

	/*
	 * Syscall number held in a7.
	 * If syscall number is above allowed value, redirect to ni_syscall.
	 */
	bge a7, t0, 1f

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
