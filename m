Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 378BAB34AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 08:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbfIPGZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 02:25:43 -0400
Received: from mout.web.de ([212.227.17.12]:58779 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbfIPGZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 02:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568615100;
        bh=k2E2Ntp6ZUnN/wRnRegLghDHBJ24BZAb9hxJrYFaDxo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=f9NT3YkIX1I2oasSrcLf1bSMreJeJSEHk8eFsuNaB3LMYh2KDyiCE/5Pi4xLb0q0K
         QhaMMu1CETx0tyAEzmcBt/0rs6Pi5iTb6VqgACQJnsiXCDlM0wJZxQZXr2BfXWFRwV
         VuAAJ9MpFhdleVpnHGWtWL7jiM9XIjX/6PTtdCeo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.32.36]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqDYi-1iehTP3ZCq-00dlKv; Mon, 16
 Sep 2019 08:25:00 +0200
Subject: Re: Coccinelle: pci_free_consistent: Checking when constraints
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
References: <9666134d-0ff6-81eb-b088-f0086a0e61b1@web.de>
 <alpine.DEB.2.21.1909081019020.3340@hadrien>
 <63e433b4-06cf-cecc-46e0-9f31226f71d0@web.de>
 <alpine.DEB.2.21.1909082149100.2644@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <lkml@metux.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
Message-ID: <7fc4c8fd-c00e-a455-29ff-ec016cbff08a@web.de>
Date:   Mon, 16 Sep 2019 08:24:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909082149100.2644@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KwksYw4+6yxAX7JCyj/rwqZG8kZW8CP6BCuDYkAI+FGpSUcwYRh
 vjDCQuKz7o3EWToiQ10jENs+BJAFBuPGLfUnacEnBd4JGvxjvQK/BxrYZNvl+CqLvynWbte
 2IounRmwrJ8FLgcg94mV2zAs1Fj6SmiFyUsLGRpmzGh5N4/hLjTEpultBrU7KwIdj/jsky+
 zLJAy/iKUKtua5mWaxopg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/EcsmFGcW4Y=:re6gANQZN2GMN93QuH6xVC
 nu7updoRrPP+GS17Morf6UYrf43cRh0kjHPnE5lFffizc1hW2IeN8I9D4xREkG3PwzonTLNjG
 X8X7EhmHFm044tZCz1p7IBojBW2EdWPpkceUS1ZRs/Kujg8vZBlxwne6OF+i0xOc6lYkF692E
 osvGoBMv04CNU6mAKyrI5iroukHR7ex0VTVcmRV/gD05dy909dEP863HgJJjx4biYLvMgJNLz
 Xw+E6MowCUv5Wv//6HLsBspwpUQfEry2bMOWv2TXwyp9MMaHjZNvSa7U1/B4Ka5as5naw+UVF
 UzOW4yBX9EpG/YIudOjRuLIQ0YqF4SG5EfdZQXrlVYGPTV2asBZm4tG7V0WqmXMropKNyRCs9
 A2h7sH7PmvuARzbOmCMTNzh77V+8x9/fJAenKEzF13errW0SUmP6AQRXPEo2XFZFXXQ9m60JC
 tqZgsgta2MmovgrNY8rrgi1qNzlmZqZLPWHoVhJdkR6W0mCR356CxmT05SEjq8d/pS8SAkBsD
 DpqxW1pNnKp6wuhMbhqDtRXN27VfLltfTJf8/shNXPTMU4qeMCVPy8WXdU2okGKtr88YXMNUQ
 0s2eYeJ+m1qXcOubrIzPDn3Y+eZfDygVV4s8MIqukKlQXzZJ3uh9e81kYw5oWzHV2/k0SR7Rl
 /5RcwCFj/lfVPjt4IYlRTODKP9wDC2Oe+l1yyauB4g3Fs1NTXKojvlkz/UpiIFlqGy61woQer
 NNsa84kaDsF+AclAliJyuq455lG7Pvh1nduqapPJDmXuLc5tij9AX029bhgx5L8KXZQZd9JU4
 s3GlkhuQYwJZB0g8xQW3Xye3otGuNQd+TEXH3N59P136dzoGGPOaXOh4lw4Cmw1Kwmp2601I2
 i7A5b91LFvPELMbIIWTeeK6mZb3vs2YjJOgvmLjeXtEPjbsUNFLF6PR8kMm43+8ZdGMcCGOL4
 g/IKgMNHFPrkt4UMCWPR+46BHllgraJ50BY2Dv3c5UgZwYVrSonxhq0RwEhjm4rNVK0SviKDQ
 NhoBG2atTBbZMxnlbuicC/ek9MAoAGNb1/AEsf5q0PYHBb16SgpHiAga1+LWZ/FGuc7LDvs+P
 YZOP2AWdXitAuLJzlKI/9Vx39lM83cBbk4iV6Z2r6q0J4lA8khqWWU+qQzTtRiXmsE35cq8bj
 B8beLfpHR141+flNclc4SuIgmIaixshEN4t4mp8DT+jmvupPcQYw/0uwuWm2f42VBbhlLTK9q
 +jxxaWRaXx+Blu/jlBm4qyttEVZUww4zQMJ0Ew69HRKtO4KgTqTGBNwCzKr4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you had made your change and tested it, it's at least highly probable
> that you would understand why it is not sufficient as well.

Where do you expect to find the information how the Coccinelle software
should handle SmPL when constraints here finally?


> You first reflex when you have a question should be to try what you are
> wondering about, not to head for the mailing list.
>
> Please stop spreading misinformation.

* How will different application views influence the desired clarification=
 of
  software behaviour also for this use case?

* Can such an open issue be resolved better?

Regards,
Markus
