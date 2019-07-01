Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E562CC83
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 18:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfE1QsO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 May 2019 12:48:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56506 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfE1QsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:48:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45D0CG3N1Kz9tyRP;
        Tue, 28 May 2019 18:48:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 667rjOW_1YQx; Tue, 28 May 2019 18:48:10 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45D0CG2Q0Zz9tyRN;
        Tue, 28 May 2019 18:48:10 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 1E81174B; Tue, 28 May 2019 18:48:10 +0200 (CEST)
Received: from 37-170-84-163.coucou-networks.fr
 (37-170-84-163.coucou-networks.fr [37.170.84.163]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Tue, 28 May 2019 18:48:10 +0200
Date:   Tue, 28 May 2019 18:48:10 +0200
Message-ID: <20190528184810.Horde.kzboSxOzA1nukNNnhCIE7g1@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v1 00/15] Fixing selftests failure on Talitos driver
References: <cover.1558445259.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB34850975FDD8F5F1CE366A9C981E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB34850975FDD8F5F1CE366A9C981E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Horia Geanta <horia.geanta@nxp.com> a écrit :

> On 5/21/2019 4:34 PM, Christophe Leroy wrote:
>> Several test failures have popped up following recent changes to crypto
>> selftests.
>>
>> This series fixes (most of) them.
>>
>> The last three patches are trivial cleanups.
>>
> Thanks Christophe.
>
> For the series:
> Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
>
> Have you validated the changes also on SEC 2.x+?
> Asking since IIRC you mentioned having only HW with SEC 1 and  
> changes in patch
> "crypto: talitos - fix AEAD processing." look quite complex.

When I ported the driver to SEC1 some years ago I only had a SEC 1.2  
(mpc885) but I now have also a board with a mpc8321E which embeds a  
SEC 2.2 so I also tested the changes on it.

Christophe

>
> Thanks,
> Horia


