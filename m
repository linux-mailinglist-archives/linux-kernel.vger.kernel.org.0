Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF522DD9A5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2019 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfJSQgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Oct 2019 12:36:35 -0400
Received: from mout.web.de ([212.227.15.3]:53507 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfJSQge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 12:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1571502971;
        bh=B0hMDu2p0XqY5CPGLIJ5L0kA11pQyDcIMiKt83mRZMo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=oaPHJjyjJTZD4vHRw/Tvqpo5Mz1tiz+f9fxvVQsTW3NHc3s+fgHf+NZ/7cY7SdRXx
         Rub6AGrNdFJUAPKDhgoiCYyTpv5gRnRqf4thbfIkqVMhmTSiUYSNigfV3BDyooSLYn
         2dVBSTlD2XIhB0fqZQNv6PvXA/aKnEl6Hrp5/iBA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.29.47]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MIBu2-1iKD123SNa-003uva; Sat, 19
 Oct 2019 18:36:11 +0200
Subject: Re: [PATCH] coccinelle: api/devm_platform_ioremap_resource: remove
 useless script
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kernel-janitors@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>
References: <20191017142237.9734-1-alexandre.belloni@bootlin.com>
 <81269cd6-e26d-b8aa-cf17-3a2285851564@web.de>
 <20191019120941.GL3125@piout.net>
 <CAMpxmJVEXubtBhQs5wH00wvK=yp8nr0cZ04x9t8eCTLVU=O1JA@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <88b84610-0789-3bdf-affe-de242f84554d@web.de>
Date:   Sat, 19 Oct 2019 18:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAMpxmJVEXubtBhQs5wH00wvK=yp8nr0cZ04x9t8eCTLVU=O1JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:RqEjkPj0dj1gUDbQZXEho1GqQnd02nd97QjCF5lXXOl0+VfE/Df
 mJ0RWFhmQoHlpKqGPOoWUG4C+RuL9OdcjwU/TENoQBPbs99ulFPdVbbMKsYwQ0sEY8BG+7a
 JBJHgYE3hE6zkypvEf5Zl9M4saOVWlNT5jYc9tO5CMoFOtFlmRfKnkiMKlbGASWlJ9pOpu+
 GWH1b7LtGhLPAqISeo7yw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MuDYgV3wfwk=:zrzQa6oOmZTV3vpCtBOlFD
 80djKuQmUctIWFdbUbRVDYyeKB/wMSe4ggtb/l8UmVyXhm2VxLd4xNTgdQedBBdx3h2H/SH3g
 GGjNWDYN6/iRhQhyQuGxWYfPuOntU5SrnXzYc0hgnJMyrQneYrzT4oNI97RMu7ozCIUfzw6bC
 S1hT71y0qRCB9UxolL3bxPkqrq72+MRxvnD0XyblfJ8GubHQErrZAmIYdoIi++YvQWpHlBuC3
 Jyq+CJJBQz4tDTcYVaN9kbkd4sybdWytcexEZaHzwNfmCYkSKxS58MOxyQq4lsLXTtO1obfRR
 w0xbI2TRhYXVG1OWAFCzgSYOnPEXFiq9hTK/JkR6odFgO7flQcOGu0QrjC83CNoje4YdlkfSQ
 8igOroq3I70LEXboV6ic9RLImrka8m+bMbcjOktWCb72nPpkM4uclxJjdYgGKrTAwzwN9N2iS
 vDzJgme/naJHYil7ZSHHGXE4FEHfFJINMEr7QHKy8tPmPfTthLWLu+zCbCGS+VY7Ao/MybNRr
 Kkme/RjFW+O+7x0mqMX67NOXqznBvdOCSYc1Wp7Cz+PgTEgE8I6WCfct8OThdmWKiBlXtu4gL
 rRrJh9tfCipJn3oyP2QdB7yvHpaAGWavNEsJlrhmpczJIHoytpUi8MWUQ7DTIdSVHEddsQSXv
 0aTHSgDdqwtmmbf0RprD7LwGVppnmcjdASKgVU36+QKz98ADK0xvGy8T/x9cLmE4SJ0FTsqOl
 eUoDjHl5W6xFvl6cpMunkxj4iuxrJYai0qDL3OlUOl4/rtjZm5zWWngyD9u1y3YLwdrqjk9iM
 w/miYYkE0z1oKjdMZI6vZsH6Uao4aAJzTOHzNtuAT/sydNHSEH/gKP48YGVfmz0/DBV28U5xF
 5dlvuAMjhUFCkKumehJWHkTNnoqPdXQyyN+WZDvVKwx+i4g/qouqlGNB8SBpgibiuVRN4Plzx
 5e25TCEao59ecdTH2hRlvGZtPD8kwdKLP6LOsZdYd+g+3/OIgtliy3uAmWy+3dCz6RJFo1jdg
 0l6V01lXkCC/NaRgFcYxkxZu5w7ncV5TP4dwCb2uJgd5jy5fzxLhUVcVG8pHpHd2fLz0v/j1u
 14EFG1gJ3ojl7Vuz71RFWtLOa7cWTbQIjfCrLEbzSEWrYBo35M4362AdpfvccWONX86R5WMjv
 ++MA3+bRjgFNUbelYkxoDmBDlwr/D9CnHut67TtdBdjSFUyNW5wLaWZHeUz++IF1hIlkrxJXv
 2XdV85vi2JslK1/47cvX8/fWWWNmqwJMv+GvkClLZtKQcXDNZ82KzuS+W044=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Markus has been black-listed by several core maintainers already,

I am still curious if this communication filter will ever be adjusted
in more positive directions.


> I think you're wasting your time arguing.

I hope that also this software development discussion can become
more constructive.


> WRT the patch: when introducing this wrapper, I definitely didn't expect
> people to send hundreds of often wrong patches based on coccinelle reports,

The reality can provide various surprises.


> so I guess removing the script is correct.

I suggest to reconsider this conclusion once more.
The application of SmPL script variants can be continued despite
of the recently committed file removal.


The constraints for the usage of available scripts for the semantic patch language
are explained to some degree.
https://bottest.wiki.kernel.org/coccicheck

Regards,
Markus
