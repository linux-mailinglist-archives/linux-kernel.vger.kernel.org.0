Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08E216F102
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 22:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgBYVTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 16:19:52 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:49638 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBYVTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:19:52 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 56992200ADD;
        Tue, 25 Feb 2020 21:19:50 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id B38A620AD2; Tue, 25 Feb 2020 20:42:19 +0100 (CET)
Date:   Tue, 25 Feb 2020 20:42:19 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 1/8] x86, syscalls: Refactor SYSCALL_DEFINEx macros
Message-ID: <20200225194219.GA3954@light.dominikbrodowski.net>
References: <20200224181757.724961-1-brgerst@gmail.com>
 <20200224181757.724961-2-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224181757.724961-2-brgerst@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the updated series! Looks nicer to me now.

> +#ifdef CONFIG_X86_64
> +#define __X64_SYS_STUBx(x, sys_name, ...)				\
> +	__SYS_STUBx(x64, sys_name,					\
> +		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))

I'd say it's easier to read if "name" is passed to this macro, and it is
expanded to sys_##name only within this macro...

> +#define __IA32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)		\
> +	__SYS_STUBx(ia32, compat_sys_name,				\
> +		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))

... and in particular here (with compat_sys)

> +#define __IA32_SYS_STUBx(x, sys_name, ...)				\
> +	__SYS_STUBx(ia32, sys_name,					\
> +		    SC_IA32_REGS_TO_ARGS(x, __VA_ARGS__))

... same here

> +#define __X32_COMPAT_SYS_STUBx(x, compat_sys_name, ...)			\
> +	__SYS_STUBx(x32, compat_sys_name,				\
> +		    SC_X86_64_REGS_TO_ARGS(x, __VA_ARGS__))

... and here.

Otherwise, a nice cleanup!

Thanks,
	Dominik
