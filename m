Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93CD3CCABA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 17:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfJEPLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 11:11:19 -0400
Received: from sonic314-13.consmr.mail.bf2.yahoo.com ([74.6.132.123]:40164
        "EHLO sonic314-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbfJEPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 11:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570288275; bh=zPC9p8T5S06DA73PD5F75wViZ/EpBpeYylTS7OqjCU4=; h=Date:From:Reply-To:Subject:From:Subject; b=eWqrrIs7XCz/oIaWZzipiC7FLvgzgqA7e1dPMs5+YecxMBmTf0vmzNia6fDDJw85PxCMP7yRejvT0wKSzF0xgOg3MfkCClScI5tCN/dgivr5m2QTCel5cA9UgcMYZIL2dUu3yxtoVcZ/RM6ItKeeu5ywqtJHX7hRO+vSIPX/APN8a9GbhrFR2xXI73SBYpN1FP3BGqclsP21PH0x4pvTfSmECqXRzH1zQpiyW/q/JHrknODXFOVqu0MkwvYVU6uNTlHmpyJ/HfiL5ug330KNNYc00XBS19L+NMUcatklcQYLxja7q5XZUChfZIXuCSffhjrXSvSLpfH8yG0ZWYcROA==
X-YMail-OSG: jp6v7m8VM1mkOebNzF83QA6A1LqvPAwOQx0W9w2Ra7WzTIQ6SiimMAuf6xXk8BI
 mmkcb5Qj475wZ7dWqZUxPWD4UPSlw985.91s9InnQ8Z02ENDhKBHgFaa.5b2iyZ0RvV6s9N9pr_y
 NTkMHexY4VczCF6h2.FXv.8aitqDJgCkbSOYzQUPzevTglSLENF5YLUKW0GHerjXvUQNYBrV5.RS
 G89H3O.CGe.4hysuJHRK1VeWXI24W66tkd8gMzy6VS1HrqG1tQqxV.HTJkxB6M_WnvEXqrtBG9qv
 XfA.jHJGI3L4QeExytn5qGM.3pRYLp_mro7AC3a0Tg2st8.4MnV63D6Ra1ZtiOjv_cCPtCr_sKiw
 P8.fTCSiFdfGiaon3SpFybKnKxTmPwkS5wbP2m1wyigYv6agoO2G8QDCi2SBjsWeM66.96imst25
 afLAIGdQvZGnnhOOeLtPkCazzFNpQkzZK4yosmziy1QbK62.f_NRw8MW7ppQsdc313Anci.dfPni
 24dND12o9hLPGOC5XFyCaRM5Izx_7Jb.E869UdD.cYg1ovCiG5WHyg1Q.mzWTuy2LfCVo0ROvbsH
 YJA8Vn_gCEw7KwFuCnXUv9Bx.cXB18VtC32gy1jLnrKTFEpUGl52dMtN2iILPN0kwV7RlGBYLaIH
 EXsnjHeo6j18oB5WMidGp7IH6A.ZALrQzW8HfaWyGkkS3NcH8_eGcg0d705vMVEHaZQ3E4bZalq7
 blyTQRe4CiokUD2ChD65Hr97Wk_R7p73DSWoWa7J.FCNfStC1zLoWRnaifyBTpTmh6mk2h1BkQEl
 Xw1u2W.NapgKlWWjsMS5c3MoF_B0bAZteY.AHvUm1HZTJ9xU9YHBwrsxBXEhHomj7ScX3jD2YDPD
 BCWVHR4iSbVtm7No1HmwkmfJIbKT53__luHuFWNr8YjWzph_GOhtd7OuKFaWz2mynIFB__glzgcR
 WySqyrWZOhI6oi30a4uNWSjfX3lJsNZaxSmSQFLByaC6PMA7deMNGUL5ZeNC3BYwSdv8h0hZmdtB
 qdEi9eQNfcZ_rJi5tRViEugThvl0.8sfKJIeiH2b.Rk85COurlc_xQXodj.OCdpGEme5jqBodp9X
 ah5g2dThIxAaJZglnihKsGMplWHA6eeoIBwDFAMCIjcSsIGljATn5xqv0AK4bmr2FPwnoAOdVXma
 EilgQLix2Fv8YztCtz2v4Qw1qalX7m8LJEB7VT2fxxMQ_ydhKIBfgw8f2dW27CKNjbUelCHc7ZZt
 2j8b8gp9hK40M3jqsdsnFV21c1Q8owQGGPPz2aimEtSIbkpzRXr8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Sat, 5 Oct 2019 15:11:15 +0000
Date:   Sat, 5 Oct 2019 15:11:10 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh222@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <937979823.2638891.1570288270874@mail.yahoo.com>
Subject: YOUR CO-OPERATION WITH MS LISA HUGH(BUSINESS).
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I am Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me forsuccess.

Note/ 50% for you why 50% for me after success of the transfer to your bank
account.

Below information is what i need from you so will can be reaching each
other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa Hugh
