Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3E619822F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 19:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgC3RWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 13:22:48 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19903 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbgC3RWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:22:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48rfRM4FSfz9tylK;
        Mon, 30 Mar 2020 19:22:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=DLwBP/ep; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xq3prVx1OlT3; Mon, 30 Mar 2020 19:22:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48rfRM2m3dz9tykx;
        Mon, 30 Mar 2020 19:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585588959; bh=ulUvoo3Ro9DxxhRQJNnMZFz2WT9S1VItEsa9t4gqwss=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DLwBP/epB04LafmrBZhNsq2OP3B5O0MpNT0yCfZsTKOuNeoQb4oh+/VJHVz6JlBXO
         5k3XLO7aY5eoWfYs9ppHai1NZBpEKGZj8H7lVk96cVwsUkrF+qE50OvVRitHV2GWwr
         9k45fy6pyR2x6EwmbBS9jTCN9m42s9bvhVfNNENg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 994748B78E;
        Mon, 30 Mar 2020 19:22:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IxmJZ6U1Fysv; Mon, 30 Mar 2020 19:22:44 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7EA6F8B788;
        Mon, 30 Mar 2020 19:22:42 +0200 (CEST)
Subject: Re: [PATCH 06/12] powerpc/32s: Make local symbols non visible in
 hash_low.
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
 <a19105b21c08020c2af9bf4a37daff8642066ef1.1585474724.git.christophe.leroy@c-s.fr>
 <1585587984.mmaeo0dvju.naveen@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <6bb184ed-b42f-f334-9445-e4fde107e8c9@c-s.fr>
Date:   Mon, 30 Mar 2020 19:22:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585587984.mmaeo0dvju.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/03/2020 à 19:06, Naveen N. Rao a écrit :
> Christophe Leroy wrote:
>> In hash_low.S, a lot of named local symbols are used instead of
>> numbers to ease code lisibility. However, they don't need to be
>                 ^^^^^^^^^^
> Nit..                  visibility


Lol, no.

I mean't "lisibilité" in French, which means "readability"
