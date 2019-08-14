Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85118CBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 08:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfHNGX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 02:23:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:33162 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbfHNGX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:23:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467ffy4tKYz9vBn1;
        Wed, 14 Aug 2019 08:23:54 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=avbdMWC6; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id a4nZaAJs1IUV; Wed, 14 Aug 2019 08:23:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467ffy3jSmz9vBn0;
        Wed, 14 Aug 2019 08:23:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565763834; bh=riZMoyaCD1+ZQ3eW9ssk+3+aGprxE6J0aY0oTm8WUHk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=avbdMWC6gc6VxruvxXJGtYUHAYWYzSiS4yb5QNH+51hPcJHVoUSm6e/d/DNpYKicI
         vS8BErZ65r9GgWrakVITqUbxe3MQx1YDyYqkEDsIDZE0uQCzGij7OUCEWw2XfNC49T
         7TCdqwMlO5wSet+PmpAdKey3vLAnVDf8FPuOq+Uc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 828FD8B780;
        Wed, 14 Aug 2019 08:23:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ApWTthVaOqfG; Wed, 14 Aug 2019 08:23:55 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FC4F8B761;
        Wed, 14 Aug 2019 08:23:55 +0200 (CEST)
Subject: Re: [PATCH v1 10/10] powerpc/mm: refactor ioremap_range() and use
 ioremap_page_range()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
 <bd784c8091cbf41231a862f73b52fd2a356ec8f1.1565726867.git.christophe.leroy@c-s.fr>
 <20190814054941.GC27497@infradead.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <3f866bc8-7cc3-cb09-92f3-016dfb906526@c-s.fr>
Date:   Wed, 14 Aug 2019 08:23:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814054941.GC27497@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/08/2019 à 07:49, Christoph Hellwig a écrit :
> Somehow this series is missing a cover letter.
> 
> While you are touching all this "fun" can you also look into killing
> __ioremap?  It seems to be a weird non-standard version of ioremap_prot
> (probably predating ioremap_prot) that is missing a few lines of code
> setting attributes that might not even be applicable for the two drivers
> calling it.
> 

ocm_init_node() [arch/powerpc/platforms/4xx/ocm.c] calls __ioremap() 
with _PAGE_EXEC set while ioremap_prot() clears _PAGE_EXEC

Christophe
