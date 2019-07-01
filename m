Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCC624D9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 21:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfFTTDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 15:03:30 -0400
Received: from mout.web.de ([212.227.15.3]:38657 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfFTTDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 15:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561057372;
        bh=5Xwxjs0RUToH9qJFQEuzFSAmrjrpbM5RBcjKSRnTB0o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=I9EGS0zYxrEV1Lq/XuuF7JkjW0xy43tOoLGjcmbzoL12jhCb77ywzc8PPJezFJf6R
         +FeCUOp3dPt4kdyIzVse7dDlEMPIFnSoh2syzQREpbhX1437z5Y9DRWrxFOwV4Hq6s
         zHSRtINXMaQ4mfjSPxDMqxskylSwU7WYUgsmZRvo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.128.109]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRTzc-1i2Bxk1sIy-00ShXI; Thu, 20
 Jun 2019 21:02:52 +0200
Subject: Re: Coccinelle: Add a SmPL script for the reconsideration of
 redundant dev_err() calls
To:     Julia Lawall <julia.lawall@lip6.fr>,
        kernel-janitors@vger.kernel.org
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
 <alpine.DEB.2.21.1906202046550.3087@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <34d528db-5582-5fe2-caeb-89bcb07a1d30@web.de>
Date:   Thu, 20 Jun 2019 21:02:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906202046550.3087@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kyiA8ZPxAZHFfJHNkZBsYAZLElHdRiQKHIn7PmkhgsI1ZLk/oxO
 PlLr3+kjhOlypfzIWpNevk5IbYSTGtlCJrLJ4ZLy4jZs49LusQ6HQc/8nF4knMMpilpRx9W
 elEFjzZfQuAZ0s6KrnDp8gcWnlhsIz4Q/wynKqiiMQyiGiXEDq6eWG7tvRgEOty6p+WHuzg
 k/3ynWdsxfKM0MTzxpjFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rkia6fHN3PY=:0v8bTS7aSvjVS1ljG/qLKY
 mbMeVNlmzYnzWe8aIsu7UJ0mFfItT+jXkinvHeKoiWstb1YhGbSiht58DE1IqUmRwBzhnoWqi
 n+qsi6Zqon7m4TO7s4A8dwUgeqg5T1g0iy47E54BqN9C8OjQX1mTxGsrnqlMkyUsCce/rKwJP
 T4cMC/6XRg1WO2VCs/ojBVUJ0bt77baR0uF5zg3b6qARawo+KPJSp6L7TjffJKRPL4I7y/I47
 p57Qtm6j3iWyL+6uQQtnUGHZe0/gVEBxKkXH3Iz6/0HVdRFsyghfhoGR0sjYPcKQJXOXyci0D
 PloZ4f191ixK95Nq8JVC2tGHkY91y1PAz0NzPi3TCH4Y0Qqir6nUuwd3C8l4dvGqBrmu4Rg+h
 ZU8dkU+TeWG81PBaBOrlUhKOzCcEo9MXqgqh5S2By+YldRsbRRCJI8tTWTJbRaYXoEbh3AkbB
 CLo8l0K66ucsUh815HDCGVEtMplSbdVVXa0RgQImmwQEdG+nzevrywQbc2VI1ba3xi9COGqLM
 +L50WFpO9YSUUxKKopC/AbL3yPFuDxSSsH9E8YJFKu8fNLIYqkQSiCv7cGUV7kkFo/BqCGirD
 NDqBa0AWNvIxU2AJSVBA7W/lUb9NHLfkcPD1rC/4s+5phmM9SS91ccieBIqcnjMMRNZlXloxT
 j1LFyD7aeE98RJ9RtbKmKqlEBdrGEgaa4kyTCss+5XvhC5zoD4nKwrv7C/oBeQs4zTr9aEaPd
 iY02IR36+rxa8bCs5rx8KAcPL1F5ThHaepnAOzbhoJ1mz/n7KTifRJwmGTzGRLQDPDXliAfth
 jDggWQx/flc3biVG6A2MShn79RYMDOp2MTEyB+FeeI8iIjg5ekwtpyE46H3mJjpDk2qJsOMBt
 NjIR+sQqh681PelHDch9N5I5mEKxx176VaF0ZxUe72/MmlTekhgHdGz266+R71BN6pavWWeE1
 jM0qo9C0nAADM6FIgYniDYXcl+Ek9ETHz2g36rFM8UuqyeDxWTzyJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +@display depends on context@
>> +expression e;
>> +@@
>> + e =3D devm_ioremap_resource(...);
>> + if (IS_ERR(e))
>> + {
>> +*   dev_err(...);
>> +    return (...);
>> + }
>
> Why do you assume that there is exactly one dev_err and one return after
> the test?

I propose to start with the addition of a simple source code search patter=
n.
Would you prefer to clarify a more advanced approach?


>> +@script:python to_do depends on org@
>> +p << or.p;
>> +@@
>> +coccilib.org.print_todo(p[0],
>> +                        "WARNING: An error message is probably not nee=
ded here because the previously called function contains appropriate error=
 reporting.")
>
> "the previously called function" would be better as "devm_ioremap_resour=
ce".

Would you like to get the relevant function name dynamically determined?

Regards,
Markus
