Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E49841970A0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 23:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgC2V5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Mar 2020 17:57:38 -0400
Received: from sonic314-14.consmr.mail.bf2.yahoo.com ([74.6.132.124]:40927
        "EHLO sonic314-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728966AbgC2V5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 17:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585519056; bh=uKvLrfbQW5ttrC8kUeRbvaFFRymjnt/GX57x38e+rD0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=kz7U/8sACIRthM8AqQDhkUfNHIBQMod2TBDKYzuhzPYukWPNwcNYBWeFPisdE8IGojdan5vogKAPsv/aEewV7IN/rYjUycoB/K7ZWZzgKjzjjqO00j0xEBla1v7qQKFSOZQSwJcPkT6pgzQfJvG3NeqJwSeEZBbdUFjzSvoY5cI85i5lVt+ETsNF5eodo73zTf9znh/3LicNEjSYnWLsdmjKnjsRTbnwuYlR6rRjr3RKyeP8mWByb70V62H4NqcNUUGKW9oYks3rDO3X1J5gIt9r8ywAqTi+XTx2gGsxCuk8KeUeoRDS1VlU1QP0+9bCmVG00cIkAlYXicFxUvGaBA==
X-YMail-OSG: wyUIS1QVM1lZi2e.agNOeQUpObaUIPc5tKYL32c.gMKTqDzt.BpjZI_e9fmgl_E
 lSBO1yxJyWF.2MWs13TYd0VIhJ65xiz4EOdWQZihOKXRFb2g1pWRgRzRClvExj7eJymBC6lj0pG9
 1xBm_QhwVjpovPnl7XqlgKhybaOrVgN.OGiNjRRMabIgZQYzkzhWmYhJkpaL8jl.EaSRRJZTZeXb
 T.DqlBckA6dMmeEI6GjjWHeBL9dcMMD_rjrsVnvMSf9gcwtH.xyg.LJIJHG4LO4TRkiiWYIMHflg
 bedumN4_WOaCpSpz95X1vtjHw___kc.eQvPNHMl0m0EDtFD5xQvi8IP_u7dWbKwbHtxvaepoon4_
 EAVBW5w4mDS70cp3dGlwcroqU4hRcfEPfGmonin1sMgnc20u1jiBNkugl.kEbJRQ6H6zZai8oGff
 3fxl.RPMzgWKHmYplomwwCOlMkw3qEPvC4YDWf.4fK7tvqE_EeHXhgEKm7yizK_zgw8j3PZpoFd5
 5RRIZejdm4SfvOdrsn57xNETO4VuI9UuAdkoxTmBxlq.8LU8GHpvp.VlupXnG7tINHAfThTU6gRk
 0fea8Ijz.JqwwtuV6djuZjRhEXa9fn3CB7hfdYYWEGGu7wVQ4tpF_1eBudlMvR7qzDIa.JgvjihN
 sjRP.T8GjGUX2oY_WtQ7fv260yWXRwM8OQ1TPumN3lT6HvRaHBUyPUMWH7t.Ps7gsVRq0AvKQJxf
 UKeDs6guoYBxo0xj.L7Jd.MRyGgleQwgqe4hx6Qlpf.WFimTBvprj.lFnl0vYUQCWyEpZenB54vY
 NJDj00i0KwARprgAriffO76.GQh7b34ql0aIhFFfCPsGYkRKlaWSIpxMIgS1MITRHoWm.2FgjQ6H
 iBysk7o4xNf9yrQii74oP63uoEwYH0.vOE2gsqWNcWc30SbpqzdEgXJ6FpWPOc9fFGoGC3.GrPjT
 9JPZwPGHqh0.7ZriRCkWFtWRCX5DcUI2AOXyiZW0a.dZXjz9zQ7AQWRp58gIz5BPvehqzx2UxTMk
 Td5eA2H_gTeE_P3NJGaus0xHwqu3QvvbI5SrMZuSrhhJCGr5FF9JvCKadXJvK5vwbdJo7LlVsUoR
 GFzB._2K4LfIE6AdZ96CCPuNdaVMD7lTcre_1xU6rQJO9mz3xRSmbYCe9w3ejJGHYy_gRb_75RsU
 miJAXICYHfCRDcfqk4WmS.SCbtQfItRCYCIAjmG2KuY8PgxyuhBuP88LluwX9N_Gq.ss9uGdaFDw
 Mz2pCJ56r49UH7BYL9I3DA9C7rO_CmSLWZqxsY8NRoVGsSLmGc5z3XJfT07kdyncZ348-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Sun, 29 Mar 2020 21:57:36 +0000
Date:   Sun, 29 Mar 2020 21:57:32 +0000 (UTC)
From:   Salif Yoda <salifyoda34@gmail.com>
Reply-To: salifyoda34@gmail.com
Message-ID: <2035845015.490086.1585519052555@mail.yahoo.com>
Subject: Good News
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2035845015.490086.1585519052555.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15555 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:74.0) Gecko/20100101 Firefox/74.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Dear Friend,

 I am Mr. Salif Yoda, work with the department of Audit and accounting manager here in the Bank of Africa, There is this fund that was keep in my custody years ago, please I need your assistance for the transferring of this fund to your bank account for both of us benefit for life time investment and the amount is (US$18 MILLION DOLLARS).

I have every inquiry details to make the bank believe you and release the fund to your bank account in within 7 banking working days with your full co-operation with me after success Note / 45% for you while 55% for me after success of the transfer of the funds to your bank account.

Below information is what I need from you so will can be reaching each other,

1) Full name ...
2) Private telephone number...
3) Ages...
4) Nationalities...
5) Occupations ...

Thanks.
Mr. Salif Yoda,
