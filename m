Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACFAF578F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 21:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391088AbfKHTYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 14:24:12 -0500
Received: from sonic304-9.consmr.mail.bf2.yahoo.com ([74.6.128.32]:42520 "EHLO
        sonic304-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731956AbfKHSxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573239180; bh=FV1waOWroAVjEnN/rWoqGnF6OwY1eg/3wC8sp7AN1X4=; h=Date:From:Reply-To:Subject:From:Subject; b=uLyr6cML+KqWaZjV1mmmq28p9rnnvYT4TsgH7aWHOGiuJ31eJcPEa1ArN3qhZibJOL7ZTebx0UczH3VLZVqo3qxwemgm8tGXImOmCCcwVScK+VSEYgAsIobhTfFG3PtI/tgqpdLEheFiR0ouSX/lhap31LHboJkLt1q8SJi9RnQZWqaIMDM2qrDW8zwq6/q1RJRGP50Q94WMoW/c3F5yoC8+iwM6sQkGoNr2eUlIJdZo7eWxXFTFtn3ILS9x3VI1NBEaS6vXjzfCN5O782OTrg6NL2vSpPv7kElV5kMyQZTs9VCiBEeVEWnOqVTob1qtjHfhdUTJSzC01M+1dtCZpg==
X-YMail-OSG: KffsqRwVM1nW1iFB9OdL8DevJCsj69nDE1NpryGNbBMh0zAsocBuzRnICRDBpSX
 l17qT8LtbXLUt9sJ.28GK3BgT8c4NAyvoKptQdpWxB9UkQPJ4L6XIMVWvIZ1SYDQDeyW_uPt0nkS
 DaQAUOlaeMAr1R7QnO8uNriXcRncOqUmJB4DE.NOKpi6kof4vpKN.7EP2GGVtOVLbOBQ7nvv0uSy
 iAMrImK1cG1Kdgg5RNa0J9EGgmItouE_PNQA1tIZTmtf5UvF0Ad4FAZQSZJleZJU9c4pQCY7UMTa
 16yT8y67cf248fdrBC5R94vq77IAyXfg59DAtUej75k_8dpgBMt06BB.wEGkLZVsovA0tt5mzuKd
 49PsJ5rXPvF8_kQnKJNP4Brpb0c_tAILe9E70GotijhM.6RK4aSthuyZpSHKZJQ06BQDdqBpzMcm
 A9SqSPolNLZn0ESMlMKIlbvRnuRpU3104SpW4CFBlK95xmvuVMHbRRuz9m0Gjd8WtJ8yYYh4obuU
 h5U9b3pjXYvbhi8vL.251sjPyJRdJdyZ0bo.oFImc92NGQCIV_AiZH3h29536hU8n0W6JUOuj_xl
 Bo5_9aci1h3lGqx9MK.OIip5x12wTqQH_GV3B.5KzPcD5byJA2Tb.3jwdSz6mfc2yNhCyiiOVOku
 aY6w0sWrZavNr5vurE0E2fWE69t8XSkf7QTgcshv9MfY.epdQtL3.KnE4yN.Jda4UzHP2TzSBrxW
 fKaPfHP23F3_0RFPEiNuKhIhrbVbfhmyWBFZBxNCLAZ1rJyARW.esCiQNBZ3x8O1kbpHlhxlhZXC
 WAfegdNWGENgVRd7IgLEnf9muxymD3ZZNZsEejCr4XXMLSpLa5IbN.aJ03LAsYh1Rw184On7EyGh
 QduepzwZodtkAIx7bF5143qlKpo4xC.8wOI3f0OlIRPk265vZcGDuw4mwqkJadZZIkfitaP.R4iV
 TztYwZCAlcuF9MzdV.UK1NeeYB_wlG1PeprOqS5lcrnbWElkf.svmj06W3Csmju_52sj7CqsoyxH
 jXx2KZh8Z2kpnOFhEk7xVovHXchTz3_62uvQUw61VT3bwypsQHt6Dr6Su.K8UIrjA8Nt3AxcPy1v
 536rjznWWO1_UlP.uR4rBBclPxcRa.u00t7mpm1YRJSn9Su_P1Q.27G4_Evcpm_NNgehXYyUh63s
 UaDvd2_saissOFDYd85Rj9el1zdzNvytmUqHA.45xSx2xyqEiV.63FcdfKIE5gWnyyItHmFp__i8
 yIvsZqg1yJZ66SQ4wT41ifQ1BUM4PK_Gl7QYsTYCB7drWs_SQrYxWCFhzTv6yl6_8q5QmwHXeiuU
 CinA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Fri, 8 Nov 2019 18:53:00 +0000
Date:   Fri, 8 Nov 2019 18:52:56 +0000 (UTC)
From:   mohammado ouattara <mohammadouattara27@gmail.com>
Reply-To: mohammadouattara53@gmail.com
Message-ID: <1024787436.1050798.1573239176393@mail.yahoo.com>
Subject: I am expecting your urgent respond.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I know that this message will come to you as a surprise. I am the Auditing and Accounting section manager in (BOA BANK) Ouagadougou Burkina Faso.

I Hope that you will not expose or betray this trust and confident that I am about to repose on you for the mutual benefit of our both families.

I need your assistance in transferring the sum of ($12.5M) Twelve Million, Five Hundred Thousand United Dollars into your account within 7 to 10 banking days,as one of my Bank clients who died at the collapsing of the world trade center at the United States on September 11th 2001.

If you are really interested in my proposal further details of the Transfer will be forwarded unto you as soon as I receive your willingness mail for a successful transfer.

I am expecting your urgent respond.

Have a great day,
Mr mohammad ouattara.

