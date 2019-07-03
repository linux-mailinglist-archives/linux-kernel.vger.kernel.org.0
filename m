Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A6F5DE68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 09:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGCHIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 03:08:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:45434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726670AbfGCHIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:08:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9D3A6B12A;
        Wed,  3 Jul 2019 07:08:17 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Alistair Francis <alistair.francis@wdc.com>
Cc:     linux-riscv@lists.infradead.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, alistair23@gmail.com
Subject: Re: [PATCH RESEND 0/2] RISC-V: Handle the siginfo_t offset problem
References: <20190703005202.7578-1-alistair.francis@wdc.com>
X-Yow:  Disco oil bussing will create a throbbing naugahide pipeline running
 straight to the tropics from the rug producing regions
 and devalue the dollar!
Date:   Wed, 03 Jul 2019 09:08:17 +0200
In-Reply-To: <20190703005202.7578-1-alistair.francis@wdc.com> (Alistair
        Francis's message of "Tue, 2 Jul 2019 17:52:00 -0700")
Message-ID: <mvmk1czh9y6.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 02 2019, Alistair Francis <alistair.francis@wdc.com> wrote:

> In the RISC-V 32-bit glibc port [1] the siginfo_t struct in the kernel
> doesn't line up with the struct in glibc. In glibc world the _sifields
> union is 8 byte alligned (although I can't figure out why)

Try ptype/o in gdb.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
