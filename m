Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8296173372
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 10:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgB1JBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 04:01:38 -0500
Received: from mout.web.de ([212.227.15.4]:47843 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgB1JBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582880456;
        bh=OLX6B01E7giakeT8iy+FXoMCj714HHMGd/9fp4qWhZk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fueQFsa4XuMf/QcAw0HSEo5Hm+fYqiS8wngBRfASHuYlYwEu6KDT/qoAXVU1ojjFg
         7bQYvAHbtJ3fiKqZ5rLKRAsr73eNPyVXvYBmMvvedLSUKcMUN23IslV+Lh3HhGz4EZ
         N7qbnjIGdwazLhxMwLIOaKbE9Bce2u9NNzbxafIc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.179.252]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lhedd-1jlMC11Gxl-00mpHu; Fri, 28
 Feb 2020 10:00:56 +0100
Subject: Re: [v2 0/1] Documentation: bootconfig: Documentation updates
To:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <158287861133.18632.12035327305997207220.stgit@devnote2>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <957cef56-04b0-3889-6c95-a8ed7606b68d@web.de>
Date:   Fri, 28 Feb 2020 10:00:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158287861133.18632.12035327305997207220.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:knO5+5TOAyNYw/bpcty1OC/fCQ6yx0zJfXG6n5L//YJoRBRu+fI
 E3P7UVpJGkwu6G3puQCSliOXqYHVD17SxzbrLZWzSrrj5aOnS87/m68hXRpZGc2ms2pjnuN
 vpkFdB6QTlmcWYOaV32HHKFA8NKkJkSrUIRA2LsB2pNgqH2/A6TBwPweJR+CLEfgKfpt+4C
 tJECRDPcHIfQUVGJpjNyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:npS9/4x9CMI=:t56PeqSY1T3yjJqSAQ6u6i
 Ds45u23XQWBeyJndKIZYHt4wz9BypJ6VJ2XF4aMaBstVsuLxurRH9oyE03FXvzLzSNjzLEKAX
 WSv9IapoE78BNtc0Yi5y9u8PH2qk4RwJ+CeWRmNgQji/lkZOAwupBrA5fx0fFZUeC3KeSO06z
 29eWQUE81Ir5XsJeoIsy4lpLDEOWbGEe6xPoQK26MYaEKCKSL/Jcu7aMZI1Cap2N38yAWKgdo
 GzuDRWk46JvD1HE/p3FrLZTY8W96aobGuCjgINPnjCMXM9oRgBzd/0tD/RFK2KHj2PtNnZP/r
 /ma2tVg8ZQklCZZg0lx7BK5c7Fxd0VxoWRRi3+npZf/mGNvrbTvFSAxTXQ7FGNJVsn7N6MwJq
 QmR4UhrctDPHE8ohBujhx7qBm+p6+VU/S/YG+FYjBUww8SmUP/dNPjOy9QwvPn7U3nAmXIxrK
 mqBN3xqABGIGCLufL15F3R2rJhumKBqMK+M6ByZU1s7rt6orP9S8Z6cTf8sz/BrrEfvKltWVP
 qRomU6V6LgxoIlAQ965VOruxrTulltbNvR1giepvoYmXU4DzkZ3m3dON7P/5lJaS76L1sHfnS
 S4M3y0Bwatf4Cl8ac81gjc5JBVtdhCY53AQ2j/Hu4QgQh+GnfqQsOBZAZF5yNiYrUYp+Wa6DS
 OqUa7rXv18ow6RVz1NKJLS6kkHEz1AxylggoeEB9dfgXmv5U4E8XO9jt2D1ulyjd3f8vsiYwx
 zYWVjz61BhizYkXBTLjjvS1edqdAaigt3i47xi3568eqM9PjIPNvgKXiBRwnylrqrNLRKU07Q
 Qa4tyAtWbBVSZ0Hf3k//YD2hyxR3FXOa08Ct3ypyDKX7eNQ6Vj2EKQJTd1VaxpoZG8vpJI7/v
 TyV1Mq/7uPIvD6tMVraryd1NmV9SnQgx4HOWD155e6YxX361DtBAEreqAv+qyyquILKlKW2Vp
 5ChNAnANPU7pUtb/7K81za+hk3N2rIOgbnvz9zhdV3cQquIYe6uJRBzIAIF6MPm5m3NxyQEqh
 hmgVGb9q9MvGAiHammGES111vjXaeNSVv7NltqHlgfV+wIL1Grd0rFY8E4JPTJDhrR3pitqbb
 h07h1HmArT+gTdxRInnodzQwigY9oRzlwoVnaSPirNACEBqpDH8VNS8u1dgWkfPuO1khndmWh
 s5ghF2ItAhiUNJjT1wyLzYQ3t7xyFQI8x6ADkkBY6a7S9TRO0Ccy2UjijNXiy3hso2OiQZUeB
 8j6KiGSpZc8KPYG/L
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I decided to drop EBNF (extended Backus=E2=80=93Naur form) patch
> since the ISO/IEC 14977 EBNF seems not carefully defined

Significant efforts happened also for this standard.
Does its revision refer still to the year 1996?


> and there are many variants which named EBNF.
> I'll postpone it until finding better solution.

How will the corresponding clarification evolve?


I hope that typos will be avoided also in subjects of subsequent cover let=
ters.

Regards,
Markus
