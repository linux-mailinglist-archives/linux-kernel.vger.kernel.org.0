Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B049CF787
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 12:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbfJHKxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 06:53:44 -0400
Received: from sonic311-13.consmr.mail.bf2.yahoo.com ([74.6.131.123]:45630
        "EHLO sonic311-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730497AbfJHKxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570532022; bh=zPC9p8T5S06DA73PD5F75wViZ/EpBpeYylTS7OqjCU4=; h=Date:From:Reply-To:Subject:From:Subject; b=Xx862rLBFXSU57lKDjLNxjuVBwuGVMhoMsAz5FaYNmVy6by3FKn8mTLpvQC1/SKpkGqd+BqC2wko21zrC7E5K140RHvR5Td6iMoE+EY2W+zpSvBx9RpmTVb056cWlpVM0oKbeqq9avY6irVhued42QKcnm154t5kZVGz8hnIzIT8ZkpDR6pDeziO7pdQbP8lfQpTh3ZAprkzRMD57Mtwa+QGesxkkMw717XgI6APeps0FBxTZP/RtaCJ3RpkXoHMXSbPgh22HGyddqYRwlf08Oj6Q0RFCKs3L7yOwSPVM46YTP4o3LKmkxuC4QNtkiSB3Ysrd4rjBMrcasvAAYBtBg==
X-YMail-OSG: wld7PHsVM1nxwOas3qgStdeyvVXNZnOUigfZQCsq.vJSzRLn.piynw3o7E2RSKw
 EqyudJQbiNOo6r8lQLDgZm4i3M8ZtayHt9o9VTeuyOUZAOiDMxOML8m3O172VnKH19hZr2uK256h
 _yLoXzQhq3zF0gDuJtWHXugUqG8Os4kkeiicT2LiJH8OMYoVKoKIaqFeDclIEWT8_zHCT10ZYybN
 MSl4D4lwZM_nZLKGVBwMPYP3a4.spxWtX2k26PN_gukleAGFF5TaYINtQY_Au8x7CtGbB77tPW8Z
 ftRPEQuYuC5UtomwqZIYP6.ZMFoT3Bge2u4L2PMjbwrsMPYC..QO1s9g_7CNCq6wKJAqp5K.PfL3
 7TanqdiU6IJLk42BMYkWpBTz3A1uCptwnNuIXg6gTEChr_QfE1BPC8H.N2GhzbIpVA1.j8F6hcLH
 wULjKR.3oKNNv2AE4Np6_1ukTKwcFTz2cHAzIBZ26Oif1MAMwn5PF95LSpbvb4C6pNlbXBLf1mcE
 Uqr48ULNQJnubZlx7YyVWviKeyTVsH8xZZxxOPKMGqjUJ9Xl0fynEpnqnhMfALpjKV0j80KPoA._
 K9uJNDFyrt3Nyoa9LWaBaV81ljViS9.un6lbbOP6anKMUVZjunSXgUQE0ZW3UwXYBJ1mq8xEUSNZ
 DHGq9tRj9lb1t557ocWZtvJuABtCuwz0g0gQDvtheyaDTBz8ajwMqUqG1hZ0HVRV4EuJ5NU9qnHl
 HXZ_NK3vc9miRb2ECWWA6Tdeb.fGsi2.Vf3573z19d_lqj_EHffsybSdOPZ26_Z6Vh9BKAXR.Cqh
 I_SMKIbXq4yhVIyBAf6FXlD2RVzdTe9O_gKpmEjt9qvHUML1wR9EasMjpzFy1fqThjAWQk5OMi4c
 mN5M6YSuyENIUIKpDKTW4gmBf9XsuzVgpLKW6_7XwI_bE5vwTKWnExF75.VUuPNWfOuj0f7KxlXl
 J0JWadKhpZ.HBCkib6dvxSZW9NYLdfpNwTQNld7.kwP2Usey9at3t3CP4JZWsCz4QMHflo1o63Sg
 xmk.D0ONA84m1kWt_DKttDhKGCSOzk4k4o57zmSAEnAC1Lb.7z04HAFlseMH47B41ZlHYKsOGQzr
 ae2b4Z.OsuWLNkBjNjNZwmXD.fPWA8TrvtA.kfmVqM3m62KgT3uorAUuAi9v922AF1sgrqRHV5O.
 7fdzjx.VA4X_xYdwrBMPUz.Rxy1K7gZt.SlRdb.2zpW1XohOgYlYEi5BjDjf2GfR9SH4.YPGGD6s
 PCjfsANbpb3FPQwi8XERILrdmZ9sVRvrEFbQ7VW.LkmguDwmwEA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Tue, 8 Oct 2019 10:53:42 +0000
Date:   Tue, 8 Oct 2019 10:53:37 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh101@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <246021388.3343132.1570532017567@mail.yahoo.com>
Subject: FROM MS LISA HUGH (BUSINESS).
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
