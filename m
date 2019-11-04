Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B1DED8C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 06:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfKDF54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 00:57:56 -0500
Received: from sonic317-28.consmr.mail.bf2.yahoo.com ([74.6.129.83]:42008 "EHLO
        sonic317-28.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbfKDF5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 00:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1572847074; bh=zPC9p8T5S06DA73PD5F75wViZ/EpBpeYylTS7OqjCU4=; h=Date:From:Reply-To:Subject:From:Subject; b=XjTs7/A2PX/qca+GCgku9hZylbWYGv2IJx2kSsaeQTwgrk40MKCbWrvi0gROdOD5mM6fLOp5LjtqJz2ehRWa1ey2u16eRRrHMbvoBcimGEMVuwCdbAxS3K81hEz8kojVjKuXc6ZjzBIWIPSfBsGHNwXGfSZS8wZBY6dgTczqrD5RJcYFNZYFxKCBgAkE4CLuVVO/PusolfH1JuB/Q3fnmsObqAbnrhdLL82iZpTzFPL5/5pidKzPW20V2yu6PciLVy9pj/0pMrl3Zugw8Qwd/2hE3IPe8jL3OVmacAzhBxsQJdlt8NXolpGuOWFbZ5vgJyMKQ7TeGv/1MHyfd/XC0g==
X-YMail-OSG: K3RhNE0VM1mPPQ2PVK9.IqUwKJKE6Tl7ie9VkmZ8GwV0ebzvvzg1V0l_qkLqEwJ
 Bti.UpMAi2bjmZj_J85csh7M80yJ37omPres4q0yWdDOLw30l.hx30ZEODVlA70SbeFGwUr2caib
 LchT3rmNlRYlkDpf0zzvD7aU4sEbr9lvjt1sxPgdvjX23ybrwgPTnmMqcqqnhLY06Qqgmc3knMUm
 oApwXDZSSrdJblwjPHEo4nVd3pAJcDH7O1PbBuFy0rlbrZy9xAzb3mhVFvd6Ng_fX2gsmNlNa7xO
 nyBlQ4pA3Ph1BYQ1CGU4_cpYNL8LEJn48uYTD1bKGLu_rWgytklcX.wEDSG6OSu18b9.VM9ZD_se
 4gVkqACzmVpu0Uc0MZFAw2kn4fEzbv.oHts8x_QwsluamEI7QXugLJhZ53f6wlQg6oCUc9hNX5n6
 NNmcmKKso4pMJgAzWTjMnb4fC7QyJYGrmydvK4LREs93DaPdDrwjngHMA77g3WOIsL3Xt2hGeaR1
 9vH8nidjSt7GxQY0yZveV56hdFsLYbHsVZ4GtJt87P6rx1hZ_kK5xZJPiIvGQg3ZZAs2Rz7cMBTL
 3mxVTFZwopfGj5_4eIbrEIu1KjQK.mEzWIunu9ANJxu0CXF6HbItq0TRqJ8yAsQVaIWEUxfCO89c
 vnpueGahG7LTwc8236fJfrEiCZkSPPRUiyDchJ__.TNnWbBSlTI98irWflRp9_tNCIsI6gUO3GJU
 JnyI6r2ELtyJ5UZnIrMQm972TMBmYqtRvZ4Ek_gzhrDIAzwilQH1xzaDrCA46o7h.uqYITRFnmsc
 0ABREuEXr_6UDnh0QuZCy1AyKVn9gOi2PdPcW3stn6Vpc1Diuoxxp4oY06eagf_.38.J3B88POb6
 Xs5lRS4.7Hbb8K.NM_m.BpTkP6KT13PffWtMWHGuELSTy5bQUtRconcJ1TNHY9IUoZO3Cj0q1MB.
 ykeuEULGHle9g6xKe6l6iqnUgCYkD7yHY9NbDG4s_aQqGpZRBgZU02564TgRqcKmOZm.tDgitsZy
 qiaWdwyPkN0hpTYYn.aaV4dj2Usi7dGaV7NMTfPkKfSugqrriojVMwcNy4imSL4s4gV5ivM_p8_H
 86DwA3zi7fFai28PnhuE5r4.n0mp3BCHugy8Wtza46fgqsU2wWAapbrpjH_Lzk.V_goMTuMrLQuc
 p6S7TkQiV9JjObMVUypuGIjXPIbYTi9u0sejVfeGSOhIdrqtbTsgZxcnht0noXjWRqf.EoBYjw1z
 aZx3bbmGiTc3_aSRHt8Ezxg_ne3DwNwOq2y.DD5UJIt8MBip8b.b6bshzMZ262C_Z.bQOskYK8F2
 qsJkiSw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Mon, 4 Nov 2019 05:57:54 +0000
Date:   Mon, 4 Nov 2019 05:57:53 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh222@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <260798141.461284.1572847073934@mail.yahoo.com>
Subject: BUSINESS AFFAIR CO-OPERATION
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
