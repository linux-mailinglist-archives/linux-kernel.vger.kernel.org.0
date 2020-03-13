Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707DD184DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 18:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCMRph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 13:45:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45278 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMRpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:45:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48fClf0NDqz9vBKD;
        Fri, 13 Mar 2020 18:45:34 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Dbl5JwBj; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id W8z7nJP6HoHj; Fri, 13 Mar 2020 18:45:33 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48fCld6Ksnz9vBK9;
        Fri, 13 Mar 2020 18:45:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584121533; bh=1nnYMqV+aFWDUjZlBjvP/V7b77hSbc506QLsfMci+8Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Dbl5JwBj8r6q6vEsg8fMF5tmhL2kXlWu+A7dlp30E6bgN5nLYTuWYC4P8dWQZMbKr
         6ywh2J/Q2wRA/dx7Z7OALnU1vK6GAis09YvON/mOGp5YaNzVk36Np+h+dauPGtt2uQ
         +EwXJFW69TujEKpXXkqdXE7Tz6SwRGrxLWXZzoy0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 986888B8D3;
        Fri, 13 Mar 2020 18:45:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yk10owCl4XFs; Fri, 13 Mar 2020 18:45:35 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4CCED8B8CE;
        Fri, 13 Mar 2020 18:45:34 +0100 (CET)
Subject: Re: [PATCH v2] powerpc/fsl-85xx: fix compile error
To:     WANG Wenhu <wenhu.wang@vivo.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Richard Fontana <rfontana@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, trivial@kernel.org
References: <20200313171953.63205-1-wenhu.wang@vivo.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <320843ad-32d5-8799-7c4a-150fa5fd7ef8@c-s.fr>
Date:   Fri, 13 Mar 2020 18:45:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313171953.63205-1-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/03/2020 à 18:19, WANG Wenhu a écrit :
> Include "linux/of_address.h" to fix the compile error for
> mpc85xx_l2ctlr_of_probe() when compiling fsl_85xx_cache_sram.c.
> 
>    CC      arch/powerpc/sysdev/fsl_85xx_l2ctlr.o
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c: In function ‘mpc85xx_l2ctlr_of_probe’:
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:90:11: error: implicit declaration of function ‘of_iomap’; did you mean ‘pci_iomap’? [-Werror=implicit-function-declaration]
>    l2ctlr = of_iomap(dev->dev.of_node, 0);
>             ^~~~~~~~
>             pci_iomap
> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c:90:9: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
>    l2ctlr = of_iomap(dev->dev.of_node, 0);
>           ^
> cc1: all warnings being treated as errors
> scripts/Makefile.build:267: recipe for target 'arch/powerpc/sysdev/fsl_85xx_l2ctlr.o' failed
> make[2]: *** [arch/powerpc/sysdev/fsl_85xx_l2ctlr.o] Error 1
> 
> Fixes: commit 6db92cc9d07d ("powerpc/85xx: add cache-sram support")

Shouldn't you Cc stable as well ?

> Signed-off-by: WANG Wenhu <wenhu.wang@vivo.com>
> ---

What's the difference between v1 and v2 ?

Christophe
