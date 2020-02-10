Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80E5615851A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 22:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBJVlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 16:41:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJVlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Bi5ZQJFBMzA+kW8+yReWTA9nK6Zvg47Tahp5fR5TmJA=; b=mi0i8VnW7Jku05F+sglcDrB+k3
        Khuh1Fk7hEFZpJdzGsn4Lx8AGrU2A1LkRbgqIaNrlIs8WvsugZxRH/ixjg2dbWNntuP062wi1V3m/
        3s54eqm+tvwdNEhsm4OgMxfhqGPltChj7PWMGWfAKHxQdPH/bLEqO+m2oOsLnG2MybPn4MTQImP2M
        ZAmYQZapSF1lAU6y3zLKRS73lEXCS4cjSYuGVfOIh2+JChKMZghNtGY2oesMHJai1FamniqHQdzx2
        CVStHF/QUsnOBxqbPYDPYf7ThWW+5/69CcZPg3Ed3aLZJwwBE2wi/L76EQqlskZET3RcRRuCNhJy0
        IxQV/43A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1Gnd-0004mr-AX; Mon, 10 Feb 2020 21:41:01 +0000
Subject: Re: [PATCH 4/4 v2] random: add rng-seed= command line option
To:     Mark Salyzyn <salyzyn@android.com>, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Theodore Ts'o <tytso@mit.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>
References: <20200207150809.19329-1-salyzyn@android.com>
 <202002070850.BD92BDCA@keescook> <20200207155828.GB122530@mit.edu>
 <20200210144512.180348-5-salyzyn@android.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4bd0d1cb-44cb-d02e-6aac-2b2cfce52eba@infradead.org>
Date:   Mon, 10 Feb 2020 13:40:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210144512.180348-5-salyzyn@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/20 6:45 AM, Mark Salyzyn wrote:
> A followup to commit 428826f5358c922dc378830a1717b682c0823160
> ("fdt: add support for rng-seed") to extend what was started
> with Open Firmware (OF or Device Tree) parsing, but also add
> it to the command line.
> 
> If CONFIG_RANDOM_TRUST_BOOTLOADER is set, then feed the rng-seed
> command line option length as added trusted entropy.
> 
> Always erase view of the rng-seed option, except our early command
> line parsing, to prevent leakage to applications or modules, to
> eliminate any attack vector.
> 
> It is preferred to add rng-seed to the Device Tree, but some
> platforms do not have this option, so this adds the ability to
> provide some command-line-limited data to the entropy through this
> alternate mechanism.  Expect on average 6 bits of useful entropy
> per character.
> 

> ---
>  drivers/char/random.c  |  8 ++++
>  include/linux/random.h |  5 +++
>  init/main.c            | 88 ++++++++++++++++++++++++++++++++++--------
>  3 files changed, 84 insertions(+), 17 deletions(-)


> diff --git a/init/main.c b/init/main.c
> index 9f4ce0356057e..ad52f03fb8de4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -524,6 +524,31 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
>   * parsing is performed in place, and we should allow a component to
>   * store reference of name/value for future reference.
>   */
> +static const char rng_seed_str[] __initconst = "rng-seed=";
> +/* try to clear rng-seed so it won't be found by user applications. */
> +static void __init copy_command_line(char *dest, char *src, size_t r)
> +{

Please add this command line option to
Documentation/admin-guide/kernel-parameters.txt.

thanks.
-- 
~Randy

