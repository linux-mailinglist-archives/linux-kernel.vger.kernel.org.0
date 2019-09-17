Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93313B46D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 07:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392391AbfIQF0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 01:26:10 -0400
Received: from sonic313-15.consmr.mail.bf2.yahoo.com ([74.6.133.125]:43345
        "EHLO sonic313-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbfIQF0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 01:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1568697967; bh=tPdyM4f7Tq8kspt5syr9wxbiHLUxanV8lkCr2Pkkkas=; h=Date:From:Reply-To:Subject:From:Subject; b=diQZtqlnOi6x8CKvI7aOB8YUf5Mq2ecQCYr2qxrQCxcBIdFEXsN+5X6oQxdnOAX6stk0C8zKVnJWS2oYEMo8RU0D1/aC8g43+44+ZHXZmHTCWqQ51Fu9XtFf+I03YrGCW7FsD148Y2OdskxsjdAiWLRtg2HYzo8Vv8/6oKMt/9mqL4LyQwAVowGiln4zikOzu3R3o1eSHcInW6XkyYtcf6p8sB6HJ9cEEZeTXO8Tk0eKHLTSrT7P3xWFPSh5kAr4aDblQ3DhoUdHsO7Y2zJvbo9Ng+ApkW6hrjh7IZNHp2Ls7kp5htknWMzcQ+yU7GZ/okssGHC4nzYdgq6XYUGhjw==
X-YMail-OSG: 2COV5KIVM1mce8X2oLoUKWc2yIKH.BzqoWcQ6Wr56m0n07XmLQsltMGNKhqgLOo
 XuM4lJZ.Idkq7kmWa6FbWUzICb_p4QQP.0u9lI6lnY9Y5YXOGou71FEkVCPBqLE5wBS3bSbStnpS
 ihWpHCeS7pYbAX8UVlC.4eBNY8NCoJEMXHNZzfURyptLtsJ4psQNK5nR8zKu51Sjspf69.bWoGXo
 wLxPbMS_za0KHfHyIl6S8ag436baxOAUr7lOnvv5.bgx6gCMA.gwKEXMTnhFTHZzbsXMmZs8sZbA
 lfh6vW8jLVo7.uz.upyYOOW9_3S3PrW5xO7ylD_ArmV224XXjO1QOlRd2v_P5E19wfnjCsO2Nw6T
 jbV_gsP8Sb3Xr83mPydc.fJSHQ2dIPoLxLbUXQQOm6QsZR7JtgBgvUnEP55J0rc5vP4iPyBOJNs6
 YwW1Nk44d9lOtIw4iX9FOIwW0RLIQQFrZHiqYD2Zm4UMbQru2XjQpYGINJ3Jvnh2BDI1oha4_Ddg
 F9VQ9h0OtcckMt8y5W87LVKRQsUws_vzfZqTXpoyjt60EI.2YiGe0a8SxfAR_rhwO562YK_BZFL7
 beaD9MJfl7hFqqzicCyGUfFdYAeioT5GA8EYQ4HSxTFZg4jchqwFzj4nuNunOunjj8P1NXuVnwj0
 eK8N29PYoWViyUoBbDwzQWm2Uph7XgvJwhUOHc0rh5DubJVsCcFQEZ3oahAaq2KjSOPs_ppyjvbY
 bFe62OKiuNi.d.CcFtJy6gHIqK.xCJ6ef.ldIIsiGRmimECWAJk4uqA3Zj1Ih5dYmIqchawWrp8p
 rxOTL23AleB76uD2W.BtoB6j7dYpqNthbLFagcHdR3STO4YnR13EWORmEjjZiJisUNk1TMFLoyfk
 VzI9w0fdeDNujKI6urCPRLBWWKK2hgy8ILWh73KuRNodK724vnymFiYOvypGlwCh1drnWGji_Bx9
 HzhRfgIMaoGn46Sm_Pd.7QJiQQa4mMP6.JGP6lqUHRdsB1MX_gnIhVdl7yPzOXij7BxTBU_b7641
 OmxOrrqfSP.6qLTPveaEvUCC6hqdq8VvuT79WFGzpT47dDnJF3nCM0yrSEGWMbiBdsCD00fkOr4r
 R1BZ_coHmbzjnlUzXE7pXkVNUVwyQ1ktmadFk9usQLDR.EKgkAKAe7M1_QSGf8_DZ7nyFnwE0xxe
 XILXngteZX4bxLscGOEcZbtHPDjxOnsBOIJ1R2FgBOHsZmpcEVC__J3hP4JRORaY0jTqWUlMVQC0
 _eBN3Lnx9cNS0BxXssT9J8Dov1ZmdjkAL4O_5qSkM3IFO2.yJCw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Tue, 17 Sep 2019 05:26:07 +0000
Date:   Tue, 17 Sep 2019 05:26:03 +0000 (UTC)
From:   Aisha Gaddafi <aishag637@gmail.com>
Reply-To: gaisha983@gmail.com
Message-ID: <1012537828.5630022.1568697963786@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaisha983@gmail.com)
