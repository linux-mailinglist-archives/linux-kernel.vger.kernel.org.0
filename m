Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50DA3EED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 22:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfH3UXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 16:23:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35555 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbfH3UXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:23:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46KrXQ3nFMz9v7DV;
        Fri, 30 Aug 2019 22:23:34 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=rbZ8hJa3; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ODbiOs4J1zxq; Fri, 30 Aug 2019 22:23:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46KrXQ2gp9z9v7DT;
        Fri, 30 Aug 2019 22:23:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567196614; bh=UgwxLUs4u6Sh8OD5zo6PgM/AnxALlgnMTsxPNdaKZsE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=rbZ8hJa3TCltezr70eDq6/qwUbFCM8AK3bY2SuvEWI4wK9lP77fPooJZaZxT2KKDx
         0gMwAF3PWE/rYyBJrQOrvFHTYKnOPh97G6xw1ZlCuKcIIOiyhldYQMbgxmol4+vsCd
         6Hk7l+gR/dRuXk+WrEJ9W5qc2ub3Thc4AE/vi+Gc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A639E8B911;
        Fri, 30 Aug 2019 22:23:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Nb9esVOMa_TC; Fri, 30 Aug 2019 22:23:34 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 746798B90B;
        Fri, 30 Aug 2019 22:23:33 +0200 (CEST)
Subject: Re: [PATCH v6 5/6] powerpc/64: Make COMPAT user-selectable disabled
 on littleendian by default.
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Breno Leitao <leitao@debian.org>,
        Russell Currey <ruscur@russell.cc>,
        Nicolai Stange <nstange@suse.de>,
        Michael Neuling <mikey@neuling.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Brauner <christian@brauner.io>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
References: <cover.1567188299.git.msuchanek@suse.de>
 <a4704404cccb801457aab577781001b28c495233.1567188299.git.msuchanek@suse.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <6e362534-e764-0290-c868-30e4ae542678@c-s.fr>
Date:   Fri, 30 Aug 2019 22:23:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a4704404cccb801457aab577781001b28c495233.1567188299.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/08/2019 à 20:57, Michal Suchanek a écrit :
> On bigendian ppc64 it is common to have 32bit legacy binaries but much
> less so on littleendian.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>


> ---
> v3: make configurable
> ---
>   arch/powerpc/Kconfig | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 5bab0bb6b833..b0339e892329 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -264,8 +264,9 @@ config PANIC_TIMEOUT
>   	default 180
>   
>   config COMPAT
> -	bool
> -	default y if PPC64
> +	bool "Enable support for 32bit binaries"
> +	depends on PPC64
> +	default y if !CPU_LITTLE_ENDIAN
>   	select COMPAT_BINFMT_ELF
>   	select ARCH_WANT_OLD_COMPAT_IPC
>   	select COMPAT_OLD_SIGACTION
> 
