Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2EAA8CBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 08:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfHNGLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 02:11:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35458 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfHNGLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:11:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 467fN43NP3z9vBmv;
        Wed, 14 Aug 2019 08:11:00 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=duCN9Vgw; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kd7CDSTzq66e; Wed, 14 Aug 2019 08:11:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 467fN4166sz9vBmt;
        Wed, 14 Aug 2019 08:11:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565763060; bh=XH/hXUYOtyI0ss05GLpoqwKxWjKTlS/1d5666/vUiPQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=duCN9VgwdfKgbD5Ie20Lmdq7BCnFCQEvgMw5tWhphRKFd11RezdeQJ7mtSKud6GBm
         Mwl4ENf+lN/roTnNcUvF7mUWRd0iax97slF3ej3mPTtqDutzv21SqwhKq9973gMljN
         hjR5Ssl98zhfen6I7hExkSU7f5lTJa3JTOCTKfzw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 227608B780;
        Wed, 14 Aug 2019 08:11:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YFDPe1e-wMz0; Wed, 14 Aug 2019 08:11:01 +0200 (CEST)
Received: from [172.25.230.101] (po15451.idsi0.si.c-s.fr [172.25.230.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F075D8B761;
        Wed, 14 Aug 2019 08:11:00 +0200 (CEST)
Subject: Re: [PATCH v1 05/10] powerpc/mm: Do early ioremaps from top to bottom
 on PPC64 too.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <6bc35eca507359075528bc0e55938bc1ce8ee485.1565726867.git.christophe.leroy@c-s.fr>
 <019c5d90f7027ccff00e38a3bcd633d290f6af59.1565726867.git.christophe.leroy@c-s.fr>
 <20190814055525.GA12744@infradead.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1d44ec1d-339d-e22c-2133-175e0aa745f6@c-s.fr>
Date:   Wed, 14 Aug 2019 08:10:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190814055525.GA12744@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/08/2019 à 07:55, Christoph Hellwig a écrit :
> On Tue, Aug 13, 2019 at 08:11:38PM +0000, Christophe Leroy wrote:
>> Until vmalloc system is up and running, ioremap basically
>> allocates addresses at the border of the IOREMAP area.
> 
> Note that while a few other architectures have a magic hack like powerpc
> to make ioremap work before vmalloc, the normal practice would be
> to explicitly use early_ioremap.  I guess your change is fine for now,
> but it might make sense convert powerpc to the explicit early_ioremap
> scheme as well.
> 

I've been looking into early_ioremap(), but IIUC early_ioremap() is for 
ephemeral mappings only, it expects all early mappings to be gone at the 
end of init.

PPC installs definitive early mappings (for instance for PCI). How does 
that have to be handled ?

Christophe
