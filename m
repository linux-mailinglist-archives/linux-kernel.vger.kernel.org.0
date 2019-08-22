Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 876D49A09E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 22:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391372AbfHVUA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 16:00:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388328AbfHVUA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:00:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 222268980FB;
        Thu, 22 Aug 2019 20:00:55 +0000 (UTC)
Received: from treble (ovpn-121-55.rdu2.redhat.com [10.10.121.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4F351001B08;
        Thu, 22 Aug 2019 20:00:53 +0000 (UTC)
Date:   Thu, 22 Aug 2019 15:00:51 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com
Subject: Re: [RFC v4 04/18] objtool: arm64: Add required implementation for
 supporting the aarch64 architecture in objtool.
Message-ID: <20190822200051.in6qxtv23le6jrtf@treble>
References: <20190816122403.14994-1-raphael.gault@arm.com>
 <20190816122403.14994-5-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190816122403.14994-5-raphael.gault@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Thu, 22 Aug 2019 20:00:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 01:23:49PM +0100, Raphael Gault wrote:
> diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
> index e91e12807678..bb5ce810fb6e 100644
> --- a/tools/objtool/arch.h
> +++ b/tools/objtool/arch.h
> @@ -62,9 +62,16 @@ struct op_src {
>  	int offset;
>  };
>  
> +struct op_extra {
> +	unsigned char used;
> +	unsigned char reg;
> +	int offset;
> +};
> +
>  struct stack_op {
>  	struct op_dest dest;
>  	struct op_src src;
> +	struct op_extra extra;

Maybe the arch-specific data structure should just be named 'arch'
instead of 'extra'.

> --- /dev/null
> +++ b/tools/objtool/arch/arm64/include/arch_special.h
> @@ -0,0 +1,36 @@
> +/*
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef _ARM64_ARCH_SPECIAL_H
> +#define _ARM64_ARCH_SPECIAL_H
> +
> +#define EX_ENTRY_SIZE		8
> +#define EX_ORIG_OFFSET		0
> +#define EX_NEW_OFFSET		4
> +
> +#define JUMP_ENTRY_SIZE		16
> +#define JUMP_ORIG_OFFSET	0
> +#define JUMP_NEW_OFFSET		4
> +
> +#define ALT_ENTRY_SIZE		12
> +#define ALT_ORIG_OFFSET		0
> +#define ALT_NEW_OFFSET		4
> +#define ALT_FEATURE_OFFSET	8
> +#define ALT_ORIG_LEN_OFFSET	10
> +#define ALT_NEW_LEN_OFFSET	11
> +
> +#define X86_FEATURE_POPCNT (4 * 32 + 23)
> +#define X86_FEATURE_SMAP   (9 * 32 + 20)

It's weird to have these x86-specific macros here.  I guess they're
needed to compile because the later patch hasn't abstracted it out yet.

This patch should really come later in the series, *after* all the
arch-specific bits have been abstracted out of the generic code.

> +
> +#endif /* _ARM64_ARCH_SPECIAL_H */
> diff --git a/tools/objtool/arch/arm64/include/asm/orc_types.h b/tools/objtool/arch/arm64/include/asm/orc_types.h
> new file mode 100644
> index 000000000000..9b04885eb785
> --- /dev/null
> +++ b/tools/objtool/arch/arm64/include/asm/orc_types.h
> @@ -0,0 +1,96 @@
> +/*
> + * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef _ORC_TYPES_H
> +#define _ORC_TYPES_H
> +
> +#include <linux/types.h>
> +#include <linux/compiler.h>
> +
> +/*
> + * The ORC_REG_* registers are base registers which are used to find other
> + * registers on the stack.
> + *
> + * ORC_REG_PREV_SP, also known as DWARF Call Frame Address (CFA), is the
> + * address of the previous frame: the caller's SP before it called the current
> + * function.
> + *
> + * ORC_REG_UNDEFINED means the corresponding register's value didn't change in
> + * the current frame.
> + *
> + * The most commonly used base registers are SP and BP -- which the previous SP
> + * is usually based on -- and PREV_SP and UNDEFINED -- which the previous BP is
> + * usually based on.
> + *
> + * The rest of the base registers are needed for special cases like entry code
> + * and GCC realigned stacks.
> + */
> +#define ORC_REG_UNDEFINED		0
> +#define ORC_REG_PREV_SP			1
> +#define ORC_REG_DX			2
> +#define ORC_REG_DI			3
> +#define ORC_REG_BP			4
> +#define ORC_REG_SP			5
> +#define ORC_REG_R10			6
> +#define ORC_REG_R13			7
> +#define ORC_REG_BP_INDIRECT		8
> +#define ORC_REG_SP_INDIRECT		9
> +#define ORC_REG_MAX			15
> +
> +/*
> + * ORC_TYPE_CALL: Indicates that sp_reg+sp_offset resolves to PREV_SP (the
> + * caller's SP right before it made the call).  Used for all callable
> + * functions, i.e. all C code and all callable asm functions.
> + *
> + * ORC_TYPE_REGS: Used in entry code to indicate that sp_reg+sp_offset points
> + * to a fully populated pt_regs from a syscall, interrupt, or exception.
> + *
> + * ORC_TYPE_REGS_IRET: Used in entry code to indicate that sp_reg+sp_offset
> + * points to the iret return frame.
> + *
> + * The UNWIND_HINT macros are used only for the unwind_hint struct.  They
> + * aren't used in struct orc_entry due to size and complexity constraints.
> + * Objtool converts them to real types when it converts the hints to orc
> + * entries.
> + */
> +#define ORC_TYPE_CALL			0
> +#define ORC_TYPE_REGS			1
> +#define ORC_TYPE_REGS_IRET		2
> +#define UNWIND_HINT_TYPE_SAVE		3
> +#define UNWIND_HINT_TYPE_RESTORE	4
> +
> +#ifndef __ASSEMBLY__
> +/*
> + * This struct is more or less a vastly simplified version of the DWARF Call
> + * Frame Information standard.  It contains only the necessary parts of DWARF
> + * CFI, simplified for ease of access by the in-kernel unwinder.  It tells the
> + * unwinder how to find the previous SP and BP (and sometimes entry regs) on
> + * the stack for a given code address.  Each instance of the struct corresponds
> + * to one or more code locations.
> + */
> +struct orc_entry {
> +	s16		sp_offset;
> +	s16		bp_offset;
> +	unsigned	sp_reg:4;
> +	unsigned	bp_reg:4;
> +	unsigned	type:2;
> +	unsigned	end:1;
> +} __packed;
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _ORC_TYPES_H */

Since ORC is now treated as arch-specific, and not yet implemented for
arm64, can this header file just be (basically) empty for now?

-- 
Josh
