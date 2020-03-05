Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADDF17AEBF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 20:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCETHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 14:07:31 -0500
Received: from mout.web.de ([217.72.192.78]:48591 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgCETHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 14:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1583435212;
        bh=LYVvZ+ioeHQCWAJBhSwakN48c0rS/9vm6Ks4MGkOiuE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eM1DNVJFQkiHAo6IDh23w9rEz853kXN9HtRQDfPPcE94a2BbiS6vnm1MOwQWQE1dC
         gZZiWSMy6Cuo1qR49pvW2guygM74lbXXVCckFCP3bgJuXsD4xEOmzBZAK6ry+PKjWx
         8nuQq3nFCNjMbg6JcIWe4LsX5K0Pm8ZCbQARQmkM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.16.47]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LuM1L-1jKCnD2VQl-011mKP; Thu, 05
 Mar 2020 20:06:52 +0100
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
 <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
 <29c599ef-991d-a253-9f27-5999fb55b228@web.de>
 <997f73af-dc6c-bc8b-12ba-69270ee4b95d@infradead.org>
 <dbef7b77-945a-585e-12fe-b5e30eb1a6bc@web.de>
 <e20f52a0-e522-c2cf-17a4-384a1f3308bc@infradead.org>
 <ecaffba3-fccd-32ee-763a-a2ec84a65148@web.de>
 <a6a216ce-8e41-ca35-bd65-25bcacde1d28@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ac1c953b-fa5d-818d-5232-19a28f52f556@web.de>
Date:   Thu, 5 Mar 2020 20:06:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a6a216ce-8e41-ca35-bd65-25bcacde1d28@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:65ZTYSgKUz2mCBGIJJQxrZ8BYb6sFEeEf6UROplhtqR72sSHMu6
 hNu/egyHmPnEnJgrd0Wt2zme4N1yHgkku2CjTGiliKB3Vn43MtF5XyaLTdUXHPqjFwJNdBb
 8WoCDmWy8bmsLjsWprKjW81XVBktEbveGOzr03dbVVOAQR5aSIPCl6oEG0ErXZKKzZr53Sw
 R2GJl3+alMzhT4mre9s1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xe+WGJPJiaI=:lwwZjy+B6OP7a1s2HlYFGu
 ymch7fGq/5ZkBl/EIl4h5Q8fXYLRl2Dj72Z9IRvnQY+52XQg9uUqrc/SZIr/LkMed6GseHp94
 5m5LTbFAbo+RclU3c/Pau2Tt+e5/VefZkUw8qMK0wTw16RImtBeJpG09mNCq2bszNoygP8A7I
 AkNzEQ+eIzNVJne3ediMpK4U+2OSdRkq45Ak0HPY9a3H78ARHjKOWLItNY26tdAdN1mW8mj4p
 VUFrgB3LXuY26hV136SaK2NiO4IsxLrRjPryPenV6N8JIgonflXiOITe0g35mZ+X7ReBlH2AD
 n0Otf5gMZWiATG1UsSxW6keDDIvgmLCnvqk6AblZApJ4e8FXYwUpyZWo/Q2kYlC2cCHA5G38T
 WOygA4hNght7K70AFIq5VdiG8Ug1oYuDe+peVCV0hPY+SvDQOC+XuAZmTo92RVnVsOqBrwC+m
 hCiRuiAvr2lu+ZCZI1nHlCisVONBnSVsTfn4KBxUgKSkR5DlW55vPDYwklBmqhgxz6rInsXj5
 XiDhdG6DXAp7d5r65FyR71gSDZ1cYtZRoAdeaGc5iq72sSv8sXAuGclpMwsbWg0a/P2VbOsbK
 J/9C3KooI/hnd2Z9NlxRKc9iUekrfaZGL2UmlmYdiekF6fwjd75ZQPg14hXNI72ng5hMC0eAH
 d4t9nMM/uwvQjX5/arA2wq/Z0Pa4NlJXmU725Epgp3tfkABxuZ/oRGRJnVHqLo3nvg80tESya
 Amg/GirqM8fsjcIxbMX9EXGZ8iB7X8PRsdj8rPLyEGZgeHKCD+7A70ulIvy2wZ4UHLodJeOBH
 hdYnJfnOcK9zZwgtHdAg8T7rC+n4FGfAR87yZilwiE5+FgfNQrWBf2OE4Ohg1VT/wUu53w7/r
 nFG2t9MyyTs1bghCRP3vOdwNNByb53S4h0IMdIV+ATkRqe98yET9K80vQX8HmUiwMd0aVtFTI
 50mQrgyXP5ROUV7cpg/kUQ2gnNXb8h6QOJkUHVhVHxEvzTjqXWyg4m0iJU7urXiKsMxGzyrLG
 /X1WFK7kfhCCqS3juztFblDgcyew3sSMusDMFE+XGWHGm9W/QdO+nMpT8u2JmIouNRrYl+bMO
 9ikopWX3G/6eAwIuomcMcDs6UxIfOOL7wgeyHyW4SOPbYEoTNtfUr1D+Nb1gmSHJYLY1REAWF
 VqfhVYU1rPUiF82ns71NkBagz5k8NRk3vbxGh3Gvyb6I1eaJlptXWuE8GEjOdjeFwD1AeV8FD
 tJNHxwYufEDlqpYEJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Which of the possibly unanswered issues do you find not concrete enou=
gh so far?
>>>
>>> e.g.:
>>>>>>  Will the clarification become more constructive for remaining chal=
lenges?
>>
>> Do you expect that known open issues need to be repeated for each patch=
 revision?
>
> Ideally not, but not very much is ideal.

Did you notice any aspects where I would be still looking for more helpful=
 answers?


> IOW, it is sometimes required (if one cares enough; sometimes
> one just gives up).

I find this communication detail unfortunate occasionally.


>> How do you think about the desired tracking of bug reports
>> also for this software?
=E2=80=A6
> Masami seems to be responsive.

The involved contributors show different response delays, don't they?

Regards,
Markus
