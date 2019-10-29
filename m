Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2984E7E50
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 02:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfJ2B7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 21:59:42 -0400
Received: from sonic315-21.consmr.mail.ne1.yahoo.com ([66.163.190.147]:46264
        "EHLO sonic315-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728298AbfJ2B7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1572314380; bh=dRX5d8v++xfAAoPIT3VpAbTnk4dfpHOyQKhLrN2OBJk=; h=Date:From:Reply-To:Subject:From:Subject; b=C1W/ve3ggBZt85fRx4XW4enIrbGA/3miDrvXseF6LyFP1nPafAImrkV68+PLVAr30h2EW2XkizLtroxTeLBS5CjmFKGJSdmShiWRE41x54Sk0RhHem+LZXne30Z7D71fNvUwo8NbW51nPiun+10h6HRKF47SJFslF5gfec+xMOJU2IlVwI72/jKYG2ODElSaxPDAeghEfzkywRyPLFUp7rW7s9cpdIO3KqT3BUNrJJ/abQ4NZWLBhyVbiw91rUtFJTe/AXeFR0fGR3oISmWUvsYsyMIRqp9qbXd/Dw/LXNEko4oTdwlRs7n726lqM+gXFLiwLRDwCtcNzYlWSt2CBQ==
X-YMail-OSG: 2Ft7jn8VM1lb6b1moIqrJ4OgevpmydgG0T6Cntkyy44pA4.il_9G3oUp.TNoqlp
 5l0HhxrH5yP6YUQ1mF9cDQXq2eVPrvMluOwc6h8OWMJowG9KAz4zahXYMXoc3fGNqfElI5yUwAq0
 FvRypN.xi6o27QiPtmLHZeA_2ZkY3c47sot7coUfxXHk.yrExIwzd9oOvtIEgfHSjHrdFISInPi2
 QeUzDnlqdRPZ0AiwKWneuf7h.Zf8_HRoYHU33TUsntEs6qI4mqe8.AzZNOLbGY_2dAXeQsxM9c8d
 Khl5nPyLzhQvG9Jd61wepA7kKN5HYUEOjHzid8B19muZEI7WrcAYMkvlZqKxzlFLWh9uLrc04UkO
 TnRoimo9iY0GQnq4Mdn9ZrnB9Xr9.dMhOrFYzSu8gtl79MaAMJ4cEvpIFkaHxuxjMCxqPNm_NIhS
 qNWBjt57g80qscLZPkagL4MgcBSmgnNiM7DiVrlZz1YNheHOvQjDznwkzLnZsyx..7Mu0F0eSPD4
 xYRKr8FhGfQ20YICBU_3qzlMyQPto.VxENDrvEp.cmetE2zZwEcQN2UO96q1kMvrwkwI1EFuFWgX
 2szorJS2dDyC5rEhgMKzOZ4lkuBvbcJUvGxmAqZAiqLKo10gtTORYBdBREe4tfgj5t6WT09e6Rl.
 u8Gfdpxokc4KAygCaGPqAsDMCaRPGUIH2Dpf5z0b8nmIpZU7SUeFX5P.LxCBL775SxsLwP2iye3P
 X6h.rH_vdM3bZjTN37p5c4DROTfSYWgIA.MYGc1nvxR8FWOznUh1rzZB6M5.bAYj1VQM8B_OB8BW
 puvoX3hO7MOZG_ck00B7Diw30UP_kvSJ6X7GKu1.ByVbrvSJgU6dg8AJl_tC4n0uv7Zdj_EbJocO
 KwZWgrMu4VGVZ9o4T8mGaaZQTdVfiShmqr2yZkadaD9u64iB.z.TUNeRK87_s1.qLni2uF5XYwCp
 q1JjPLYj5Yhzv_wmqC4S2pTBBiQeuLhZoG3SFl9hxDRQCxwfRE1QVXlEvFfHrdxN.ozloCtqNjMJ
 y3NMayB5gA6C9stHQ86YTfxp1Y8BAt7ORhCSzX8UXLj9mmVxx4LxN9ITr_z5Iz4N17X3bMPZCmoR
 uiB5hEhr.d1JoUJNc.c1JNHLrYAuwe_SRp5qTkfltiWNnV7LJm43Fc2bEA8rmFZVmGjci.IRUxqM
 mLwszWHW7jT6i_6SF7..Lg9Q7rVcZOEc6f3mALt2HsRu2R6FY5sHB7l7bT8PlxJ2WAbbg7SzxQqf
 nX7XxBBGdge0d.Q.6E6ohxV60bdu00EJb9f5BfvA2l_cJVFu2ZRuDeglx.yPmoG7jmPj9M1mPrH0
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 29 Oct 2019 01:59:40 +0000
Date:   Tue, 29 Oct 2019 01:59:40 +0000 (UTC)
From:   Miss Abibatu Ali <abibatuali01@gmail.com>
Reply-To: abibatu22ali@gmail.com
Message-ID: <1718773719.3584868.1572314380229@mail.yahoo.com>
Subject: Hello
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I'm "Mrs.Abibatu Ali" married to Mr. Ali ( an International Contractor and Oil Merchant/ jointly in Exposition of Agro  Equipment ) who died in  Burkina Faso attack,  i am 64 years old and diagnosed of cancer for about 2 years ago  and my husband informed me that he deposited the sum of (17.3Million USD Only) with a Finance house) in  UAGADOUGOU BURKINA FASO.

I want you to help me to use this money  for a charity project before I die, for the Poor, Less-privileged and  ORPHANAGES in
your country.  Please kindly respond

quickly for further details.

Yours fairly friend,
Mrs. Abibatu Ali 
