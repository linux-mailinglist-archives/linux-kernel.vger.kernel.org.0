Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D40E984B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 09:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfJ3IlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 04:41:25 -0400
Received: from mout.web.de ([212.227.17.12]:49099 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfJ3IlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572424858;
        bh=Zvh6PElDHOvLvzhTAFQmYtBoj7EBVf8dG1gdmzcc9Eg=;
        h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
        b=oVufxpss10/MEg9GR7sMJabX3XIszFjeYUZ68TasNm0Amam+UZ4WbDLJvQHQYVfv4
         rEr6U0Oj/kqv+SfC4nYJJP5y0ubgT7lw74gvPy04gH/joZrR9KSSb5N+NN5U7XwBYy
         emiyXGz3EaxNQc/qgRplqdYSqj3WBWEn8srcPwo8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.104.79]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxOQ2-1htOoC06zS-016yXx; Wed, 30
 Oct 2019 09:40:58 +0100
Subject: Re: [v4] coccicheck: Support search for SmPL scripts within selected
 directory hierarchy
Cc:     linux-kernel@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <201910301059095572036@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Message-ID: <d457995b-fed3-d560-e6b3-b8fa4b0059a0@web.de>
Date:   Wed, 30 Oct 2019 09:40:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <201910301059095572036@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Plh1uJC1FphsuVWzEOoEvaOSNpyW7XB5MX+FxuNADIiNj4T4ANs
 5xjE01LENnlQ+yN0/CeoxB1rIxTs7zEWBTLpguE6v4T1L5sGSid95MCwsjaYN6J/cIPzUtS
 WJCZVCpjMgMXg4sThq2rFNhcjIblW6kFBAh7W+AMRyAvss9vGpnnOTV38crueLqESOXKfmR
 mN9QzRUUZP+DbaHzICBWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:N1XjkKcbh9w=:Oo6JQjx3OCTrFdDGCudGln
 uxxiDYKmUBvgfmACwcKchSwewiZk4h/kDfNJiKNFhhSBPoxD921dZpXFEjKxeo67ShV3a1YWV
 d/aeORNFJB8FMzatFGKqLn4QTPZCYIBsLGtRBa2qCCgjIvXBoBdc3u5swjlPl7/5bpnVSoaQI
 OKpAZitFEHZPzSrkgxUkeZU0SNsc99J2WBmhsYgJbOQ/MFDUyrZxGN9E4Y3K8HtisArP2iht7
 ZVxywBDHJDO3vq+TUrZPIyWii3PNck4egmjhgMlXgfO+u4febT8nlCbWm4+IChAnVj/TbJ8PX
 nS80ike2va6LUorqZqmE2ctTs4giU+twRqWoBGL90N35fut0qU9uBRa2wBIWVYEA/zxNuF17D
 wHfAMs+ntrMy/nvo2kdkvV4n6ooWn9IeZhdArgNP5HUHxno+DuSdiveAAyz/muXHmcaKjvJfd
 mcVuy7KXUqIzZxIpZueOqWeyfLdbuPljpif79oUjSe8276pSLjzlcx/y0tHp6AxEGLE86YkfV
 Sptiabb9upLikYIrGlrWgPTht7ZDlK7otvVHKDgQu8kB0i0RCo/m2WKa+83gYI5y3cDTGjiIh
 TSd02Rd5GiSIBXGi3Kt9/2z8bfKsQWKXQdEfrALe6iKoO89UDtnRanZYeW4zp6letx8azhRM4
 OpKM/xAKX0tcwZv5/PlM1wEAbJvxyrnF1kv2Fv6mgAgMQd0jeLRD/de5N2npzfmBGBl6kaazo
 ThJNJ0JkqdLszRTWhPCtnW6tEJk0Pe9UkQq1EeM2Yqzx0l34a1R7KePjezpJgXKe9VjVQ8aQt
 2IbU0/70qnSitiQLoDnHWLCBeQRl5v8K6uAi/u3TM3+njz5YnOF5YDs3YJSpUsNt/BYJQoISu
 AQIrGjRlwYOaejcogDzUUFXdwFy+plxfvbVPklIL/vNaD5rUU0rmARrYi5Ls7MTbL1Ab1tvQp
 iO+IMEIFFzgattPfb6+GdceUmKpXWhbv05MBNIpdg9ZhZdU7PqXGaGouHEHV7m5au3efgKT8Z
 IvYlziQPf1XoOxFIpWu96XsJCkRUF6ogGZzEoUjC+ltFcUVAMa3hQL+b7Jcq4rfxYoXTJAg1S
 Pog21xAZKNPUIULFf3k2KtvKKJqAmO9H3GR60cTBkpGpwJ0RPcD4p2wbawqQVDUe1cRARUgW8
 VSpbXEO8veHJWW9V5b1zV8OOHSVjkS9D/ZVAI/zfVznl9AKWPkNt3PMzoYIVYeeCWjyyPvwG9
 RBRj3BpfPr6IJrjQ0tpmUu/4+ubc4PZPxisN8apYdqrpTQk9e6wxgvjCALoo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Please reconsider also the section =E2=80=9CUsing Coccinelle with a sin=
gle semantic patch=E2=80=9D:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/dev-tools/coccinelle.rst?id=3Df877bee5ea0b56c39cd0a243e113a=
577b5a4ef92#n151
>
> Could we add new lines?

Yes, of course.


> How about the following?

I suggest to improve the case distinction for the make (and environment)
variable =E2=80=9CCOCCI=E2=80=9D also by adjusting the document outline.
* Empty string
* Directory selection
* File name specification

See also:
https://docutils.readthedocs.io/en/sphinx-docs/user/rst/quickstart.html#se=
ctions


> The optional make variable COCCI can be used to search SmPL scripts in a
> directory. In that case, the variable must be initialized with the name =
of

=E2=80=A6 it should be set to =E2=80=A6


> directory contains SmPL scripts.

a directory which contains scripts for the semantic patch language.

Regards,
Markus
