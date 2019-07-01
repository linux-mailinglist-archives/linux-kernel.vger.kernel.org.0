Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEBE1EB81
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfEOJ4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 05:56:01 -0400
Received: from mout.web.de ([212.227.17.11]:41291 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfEOJ4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557914130;
        bh=wiOwEve7My4tHH++4uxUcctldc8mMAV7k9UajMFXLwA=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=O6Tk1F0yDDlNtjKRq2x0YP+h5tVpSGLxNx9GfBKy+tSeuQe8syh/xRC6HZN0gpVBj
         VdPHfQpiXHX/QjuTF2r90wzetwADHXPDKDlZxQ8JZAfULB2cUopugTy+UFfhVePCdK
         yBKgggsEHWIO6SzFuWRMdL6aVFoL8PKZXIdIJo70=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.73.153]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MA5v3-1hX9Eh1XZp-00BHvi; Wed, 15
 May 2019 11:55:30 +0200
Subject: Re: Coccinelle: Handling of SmPL disjunctions
To:     Julia Lawall <julia.lawall@lip6.fr>
References: <e30b9777-6440-b041-9df9-f1a27ce06c6c@web.de>
 <112fa697-3073-1a95-eb5b-fa62ad9607fb@web.de>
 <alpine.DEB.2.21.1905142146560.2612@hadrien>
 <20b242a6-23a8-9b48-5cfe-c99df809dd24@web.de>
 <alpine.DEB.2.21.1905150811310.2591@hadrien>
 <1794c3af-cec4-8b28-a299-400b857f0644@web.de>
 <alpine.DEB.2.21.1905150908550.2591@hadrien>
 <020c9629-fa44-170b-b2b0-baf3ba636a71@web.de>
 <alpine.DEB.2.20.1905151120370.3231@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Ma Jiang <ma.jiang@zte.com.cn>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
Message-ID: <e59c77a0-f1d7-2f4e-fba1-c8ed11f93669@web.de>
Date:   Wed, 15 May 2019 11:55:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905151120370.3231@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eyNCQxRg0X/ivVkQ+NNUbeFJhxD5hbn1WJJgIUv1/I9JpAGRVRx
 vIkMuE2y2BcYPsnu7BuL5imn6xpzuYDD4gAnRp7h3SaoC9DZwPAhtGznJSxXA9JsM/buAXb
 iLmkPmHGuIBxmptdJtuej8w7x0VBclkfp9w1A8Meu/dpuHmqraP3sR0sM+oZZXVLfCMvK2b
 a+AHrcs7MU2BRwoHK5Hfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WZMiCF4LA6c=:SQteLxtZ1sHJXWPx/MTTxT
 +UXGg8K+AqEZ9kZtuEi2NU0xW6yHb6RNIjsnsojl8KJChZ1ToxqHS3P6ifhEsfNZrhFzgbJco
 OMmHZCD9VsUddt1u4yzAuX1rmlB4bVmuOZvmh/XcyOa9Q+kbQcgfjoHtYAuaTQ5yoHyrSd3X3
 ojYrfsWr7Dke8VUSNvISN3Zhbs6ZSz9NL5DmAh7eByf3dYUm68tw05gx9EUhoO4p31h0IP4yv
 mmO3VJn8wKHLbOBCIjQQZbrBgWc38DuxyrMD6bt1p3JJffOirxU652MoxTEI7UGqxmi9gzauB
 zB08U7RbVZCULVsYRvoBl79/lh5/k42hV06dH/5J3Nz7wOXgPSx7Nal9xuhCWzscw6rpnEBPX
 uZCTvEce+aDtE+83g8q50WTQ+xbY1lZf1gNYAFBBcQQ142oSqcuzoZzMgAkGMxtdFFQE1GTKI
 oXR4DWKAq/VbCBppKOTBm7oLSAyPSMljRDRBuxOV6Sx9PoFTgH9RyLfnhytO4AcguE7XOWlpf
 zHoPrcyBrIr6vd6QgLgTMG6DTDGiRb4brA10gFAE/dns4NL/fHaZHJId0Z5udW7FVP8DiEJpr
 HwNqdH0bcZ9GHDUaC2DECswBWmJAokecAPwUjn27B+qIba2ALLnRT1zGPTrJQFtZJkTTtrtkt
 IWe/ch0gawlFGSe0b7zVm3ZYkJEhh2PdBY0fxKhmCsCRk7d6DwSukVI75myLVjRjNv6tGMspK
 x85MZshh4S1pBayTzKov4C33cppjE4EV+iaqFiTyj25UcVZ/zffJXuZAsyJOI1Vy2QPBga3ni
 10J7PvbxnC6XDVhxL5dHanuNVBOX8MWILI7tNgI/F3NufVCTvW0K0P1jgaC3Ch+13Xomh+e4e
 StSepROnd9z6vu60UP4MmxmnLC5AF1DIm5v5f14lbv4kFpBcE/RX6Kym89G43rci5mG5LbJlR
 IHK96EWw/6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Thanks for such additional information. Is it represented in the softwa=
re
>> documentation (besides the source code format)?
>
> It is not a concern of the user.

I got interested in corresponding aspects.


> The documentation is not going to contain a description of every line
> in the implementation.

Some extensions can become nice and more helpful there.


>> How do you think about to increase the matching granularity
>> for this functionality?
>
> No idea what this means.  Disjunctions are expanded up to the level of t=
he
> nodes in the control-flow graph.

We have got different expectations for working with such nodes
for possible (data flow) analysis.

Does the term =E2=80=9Cdisjunction lifting=E2=80=9D (from the SmPL manual)=
 fit to this feedback?

Regards,
Markus
