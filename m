Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9353178460
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 07:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfG2FSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 01:18:41 -0400
Received: from sonic304-20.consmr.mail.ne1.yahoo.com ([66.163.191.146]:42984
        "EHLO sonic304-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726048AbfG2FSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 01:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564377519; bh=7aFoyR57WImRukCD5BsKdMSTKWGbIcpHKXFyypQkOm0=; h=Date:From:Reply-To:Subject:From:Subject; b=O3zjfQO3zIITBaY9oeIqsBd9PkVGfGFlyikXlX59t8gZmPetD6Q9hBzOT/8j4zW+XuP7F7Vk0ezYVCK4UbeAI21LJ6l/6ARpYlZ59xfeihc1lZlVoCx+Q9s5TSwCb9cTd5w0dKNdL9NUG4OKAKT8g8URLHK5kiITCXA6lXVZ8APDocDaOBKS65yZ74je8Tx3DxCtiDjcFmnQrUpR0ex8my+pAAV7F9fjHNxpIK6ja+2d3cfHMS6HMy/+CV+ASSMZCQcNTlvof8eNQ9POD/sl80BAGMuOr/e1qxs55uqEkdb4+akB2JYM9sYUMt11QPfudF8ZMapkBlrCbmqjeV7kNg==
X-YMail-OSG: ps.innMVM1mEjFmQYi9JKRe9k23tQ2iwBpCUM_PD4yWFrRTQZrN_eHqt6FB9Tbn
 0sHr1ygcqYDtSA.ncbxOmKeD7I5C9yxtCqkd0o6j0gNW3XVHqQCuIa.SqyHKdu_j6QyQRV6iCMVx
 LDomfiewbPX5qnKHez8NJrib5uVC6LEvbtxg.2eeYoHoHRnM.C_iksPAM45ZjqVIaqiwtcmtyV3b
 2Ux88z9_63l7VkDNxM.Ibvtv8cAHbIkTNOsWrdLefa1CeXn3OF_zh8r3uaL3QIy.OwOlGdpCzzVA
 cWBq0FnUCrEFGS0eH.GCFxjcBNFvbvNoCwpfnJ1apI_Uz5LfSuE5kYAvJSQPsVdD9.xjNuR9CUKb
 mZ0TC3Pox4Q_595aonpgQfwq4gK7DFJvIeQKW3o90DlNZgNsL2AwdRqiGT9osjuvAR1padRfv0wG
 _FW8N.Nl_ZG1ULEFzdpOY9Dofgq.k9PKQCWcklAJjpeyiOJLpCZbejq_FKkNfR3vs20d3nCx3MPE
 1Ej8mtLVRFo58kcYePDLob4bMThtK4DIjsN22JeFDL4RRicAeS.zzmh_UhnqmcTDNJgJhCsvwLuw
 y4K5PtpzXQBLN7_MXLuWUPfeGW6wdd8VeD6oKolIxcQ9OFHhTK9XutzMWLcGmxa39CGHUtR0p4HB
 jlRR3h0vnAzPU_lVd1NT4vYG4zUgGdjEa32Tsk2hzbGIjd6uMH4EL6BRbYGhX.3D4At8kcTRr8GZ
 qNpwVwPCit6qqh9MuqHhrq73328vYWwfuNtuc.U6ca_iRD1pRdpRDUuDrDc9zUl26Z3xqSrgNh.L
 JAY9nwNrMPZKANa6mEGm0oQd24FekiJt3POOt7K065vu6.9_UeTf_mhoYPCT90AhGlzQKGpj2DZ5
 SHQXE1co._GTqs0_B_d3LLdb0xNAnRdkjRXjHpy6Qn9l0k6ZDogK7ZEk7PdYahTDAl5nQPRjmH42
 SnNCl756NfkD3QlJPzUEzpCJuUVedcaX1VrluIv_VoFdTtpRYMDVAGRGlAj0ij4zuULoHKSxOS4H
 3daxHnkSTIkwSXgDwQnhyFgA9P6cZZoR48V0naMYrv2KMoayGu5Ogp7xaU2fC5HYloriyn8LbAmn
 gi.4gzQ39jnlvObll7EZn7vSnl11y0ngcGvovA83vEiY85W9vixhpRhW6dXaSAi.FP0ELQM4zRWc
 cFyZrPtk4YdU4fdu0a1tqJhnJ3QTsd0xXQ_k.jBMuS.LCw3CSj7Sz9umuoB6Z1nAC1z0msCrQSha
 8C7alUZFOgcJzyQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 29 Jul 2019 05:18:39 +0000
Date:   Mon, 29 Jul 2019 05:18:34 +0000 (UTC)
From:   Mrs Ivvone Davida Balakiwal <mrsivvonedavidabalakiwal1@gmail.com>
Reply-To: ivvone.balakiwal01@gmail.com
Message-ID: <1763807816.2286690.1564377514556@mail.yahoo.com>
Subject: I WANT YOU TO USE THIS DONATION TO HELP THE POOR URGENT.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Sincere Greetings,

I am  Mrs  Ivvone D Balakiwal, I decided to donate what I have to you for investment towards the good work of charity organization, and also to help the motherless and the less privileged ones and to carry out a charitable works in your Country and around the World on my Behalf.

I am diagnosing of throat Cancer, hospitalize for good 2 years and some months now and quite obvious that I have few days to live, and I am a Widow no child; I decided to will/donate the sum of $ 9.5 million to you for the good work of God, and also to help the motherless and less privilege and also forth assistance of the widows. At the moment I can not take any telephone calls right now due to the fact that my relatives (that have squandered the funds for this purpose before) are around me and my health status also. I have adjusted my will and my lawyer is aware.

I have willed those properties to you by quoting my Personal File Routing and Account Information. And I have also notified the bank that I am willing that properties to you for a good, effective and prudent work.

It is right to say that I have been directed to do this by God.

I will be going in for a surgery soon and I want to make sure that I make this donation before undergoing this surgery. I will need your support to make this dream come through, could you let me know your interest to enable me give you further information.And I hereby advice to contact me by this email address  ( mrslvvonebalakiwal02@citromail.hu )

Looking forward to hearing from you  soon,

Yours sincerely,                                                                                               
Mrs Ivvone D Balakiwal


