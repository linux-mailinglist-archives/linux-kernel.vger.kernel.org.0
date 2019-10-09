Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93E02D14D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 19:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbfJIRFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 13:05:03 -0400
Received: from mout.web.de ([217.72.192.78]:57299 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730546AbfJIRFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 13:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570640665;
        bh=NXrU8n/Law5n9E/yXApsMMxu2X+rcbA9DcxVWhPlL6Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=otjZq1L5TKL5VDiDCGFc8TNklioexJ73T7x3IdSgkvSWjAUDcOICnwb/K2O1GrClB
         H9dg3E6hVQcbB6htvHfyglyMor0idCEfGnCdhCsxtiRc7OfsN3E7+gCgHb7YmoB5d4
         TtgRj+8vwNtR7NvdO89WgYoQso9AZr/7sHrv8WQI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.177.35]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGA7n-1iLI3q2u9v-00FAec; Wed, 09
 Oct 2019 19:04:25 +0200
Subject: Re: string.h: Mark 34 functions with __must_check
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        kernel-janitors@vger.kernel.org
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
 <20191009110943.7ff3a08a@gandalf.local.home>
 <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
 <20191009122735.17415f9c@gandalf.local.home>
 <CAKwvOdkvgeHnQ_SyR7QUqpsmtMPRe1SCJ_XJLQYv-gvLB6rbLg@mail.gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b8bdfb25-deb8-9da0-3572-408b19bb0507@web.de>
Date:   Wed, 9 Oct 2019 19:04:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkvgeHnQ_SyR7QUqpsmtMPRe1SCJ_XJLQYv-gvLB6rbLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:PUruM+8ZpvaFJjBl1R93O+WN+hQ+T/z1KVGbQhaTtAJkABNTflN
 bhC+Fi2mtbu9RS59neOIWcBsg2wgsFaKn5NJbM07C6mtrcVRNgyT4ZtFhXHPxhVSF5sQSZJ
 UiJHRHcg1kuXQLW+EJicHbdFKJe81DF9fKcxCpq1b0NbYol4g7eHoU1oedf/NVwQA9xDvsX
 mD/wdEds2AEERHYdY+8ng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kLWa9EPXSmc=:g4tJaaIecxZtWHegHm1XIq
 FbX1UBVB79UeYKqQdmOyqJUPiiOvKkq2SKiGrTdi761lyC571IWiI7HfXhNJIulbYF9fnXF/I
 IoQ6tUrf9AT61YmE2gClfqy7lXffMRmyskEDfcIrtCSJ+ZSN7of+aKZN8wwiS+q/1TWFhZQG+
 r8MDJ7btOnQa4AK5jSXMmRxRobKvnTlPLxNEudgyuVAdL4uXEbthkCksgSBl8OqH/VVjdyyW5
 7ygGH4F/2MwlhwfWDNDrOeznf3wLEkDjsyAdC99h1L6MhErgsHIECB1qAwquiH8XvtWyo911G
 7VggBuWhUnt0DRy7fi8DL+oU7r+BYe+S0HXMsMGZZnFsWP3GmXqLR065TIgKw6ehkOGq9S0vA
 6QYkSAquhpFEMuYwBr2m7Vvy7oUu6ap8HZBkD+4jHEam8dQnPSxTfj/0LbjGOWO57G+xtgHvS
 pu52cJSW89ifKlBvx2L8CR7+nbqx4HTdrlLbGcsopOIu6+Ubx9sf3BTCNvz4t1ws6egqGLmGQ
 j7QZlymkcx1SmNNoNpvL0UEA28asuV25GOALgYkgrhzv1wm0ajDD9ADUmII0R1xaQ7cDK0QuK
 QGPQAA5pOiyklGaBG2wXaPITAHYWrdn8tPUXsa3S1YMyZpdHEmULMA6n192UYKcD9WPJRWQ4d
 HXimyCXlJTzTwycJuIDSBUYYs1l1Juyc/lQ+/xR9Cz+u2rkMg+4VrwWw5spQxe8IFksp+IPdt
 3XLZsy+Cwo1j6k/RcJm7gKJiQkAQ3PGFjqjAeqyjar9tELKSVq0G+hjE8VijXxe2MII2dubZE
 SCFDWyIs8Hjeaj5GOhnHowt6L5RDgyDLiVaIQR3HXxQR6PRKZTYX4BQUfG5Nk0suPHsgqz5Ad
 T3uIHkKzSq0meWQVpJZrHCMLPQhLMIOsKxayjsO/3fyXMxEyMs6yq1dwswXVvenMc2lGbCtE6
 SFm1Zm8cmDKQXeZlobEapO1B197tpJ6c2AxkeJ4IV4GpgU5V6xZHvzlSgP+yLBNIE9KKCoJve
 pbcg6FjBq7riHZPIp8NWp0SfKpGfZmbOpS7EDfnJbZCw+M7uW2qQjCvvTfEnSw1o04XiH7FOk
 ylcMKRU65j1BwAd/T7rlRaprF1wtO2xcNb/yHuJl6ZIVW339j5C9hl50qwdVNcZHOJfALNW81
 yG8lkq9uexOhm9bBx1t9CqCbNpr2V0yGIhDcsOt+ma6p2aFHcweAJ8SP+JsJRGWerHGGQvqcV
 /xs+WofOT1+H6TkSopW69SqZm8QfRwle1l+Mw9Z+18990r8avI8gMJQIiMUw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, granted, I was surprised, too.

Thanks for this view.


> Maybe would be helpful to mention that in the commit message.

My Linux software build resources might be too limited to take
more system configuration variations safely into account
for this issue.
Would you like to achieve further checks here?

Regards,
Markus
