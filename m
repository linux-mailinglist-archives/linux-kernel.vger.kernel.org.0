Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6817188788
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 15:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCQOcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 10:32:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20280 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgCQOcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:32:21 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48hbGp2Myqz9twyk;
        Tue, 17 Mar 2020 15:32:18 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=US6nfTBu; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id c1UWuinpgQZT; Tue, 17 Mar 2020 15:32:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48hbGp1KpQz9twyh;
        Tue, 17 Mar 2020 15:32:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584455538; bh=bX1yuayzkqQCh7QXBiCahWrCtVLSJrNkqvO8rDQsSl0=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=US6nfTBuSRELLFhdu4NSwzzs3rYkHQ1yEkdecUxO1JwarfvNlrNHF1o4xKJdS+dyT
         YBRwJFt75bbnykm1FsOCrmYff5sbZHF10MaV8z4xMAqrf1bx+d1OpxZIBmzufDlDDM
         FCOGs5p8GG7qqhS8aCtYK+zt44O2xAfu44dlgjn0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7DC778B7B7;
        Tue, 17 Mar 2020 15:32:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wV8daE2ZbZ1O; Tue, 17 Mar 2020 15:32:19 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 421538B7BB;
        Tue, 17 Mar 2020 15:32:18 +0100 (CET)
Subject: Re: [PATCH v1 46/46] powerpc/32s: Implement dedicated
 kasan_init_region()
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1584360343.git.christophe.leroy@c-s.fr>
 <165be4c0f0ba674846a244edf9e1116b832d3bfb.1584360344.git.christophe.leroy@c-s.fr>
Message-ID: <c5baf3ce-1c0e-d779-acff-56767b72248a@c-s.fr>
Date:   Tue, 17 Mar 2020 15:32:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <165be4c0f0ba674846a244edf9e1116b832d3bfb.1584360344.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/03/2020 à 13:36, Christophe Leroy a écrit :
> Implement a kasan_init_region() dedicated to book3s/32 that
> allocates KASAN regions using BATs.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Note that the sparse warning on pmac32_defconfig is definitely a false 
positive. See details patch 16/46 ("powerpc/mm: Allocate static page 
tables for fixmap")

Christophe
