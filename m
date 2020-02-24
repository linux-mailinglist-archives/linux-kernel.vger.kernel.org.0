Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A20EB16A26E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 10:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgBXJhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 04:37:01 -0500
Received: from sonic303-20.consmr.mail.ne1.yahoo.com ([66.163.188.146]:36127
        "EHLO sonic303-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgBXJhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582537018; bh=vdONypa+pmkSCxMpJ481zxWsfmYXdIIKq3bhYsM38cE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=YzBuTw2+HE5j2YcFjVmX71RzAQcFmpGcTO6jV2EKTSuJfQ8McK+MllbqZyYObik9h7jMzN0DqQHL5OFbIf7nZc5moczKy4GHOLtLMyvSbr+EwWSn/+3dL/VA7sA0Wdrqm4yXpdgllLKmAJDrPDuSbs4Al1IJPU3cmPxrdtCQMGVn24SXAVm/ibr+VWH7zS9vFIWA89Y9+a2Rm+C/gYDkAuc/y1AVv7gDkx2KlEjhSE6egKx4KsI6Yt3r8kTKMyB9zKVcT0C/agts58trFa7VwMdnooSTxkrlbec4neiQpu32ZJFJVeZFMe2yIIJPypXOhWDWHq6K+9uaTUlqQGuE7g==
X-YMail-OSG: GFuyTS4VM1neyoGYaA9zMb0qB1NUK56U7qu7__oKJfBpw4fjUDpv9gMVYc1Y7sz
 TQ4BhbPPRdBl_f6PApOz73VG327JKvyu8bYYXd09k_Jjb8WDeBTm168mpDqWVfiYG1WiR2PlX06T
 LlYspsDR9I1gzjSj_zoYQ7258vSbMDPELnTS7CDMVrFvywI7j1Q61kFe2uWs8tObR52It3M4HgIx
 69VF5k.mwQaiAn9bUESZwSb44WWgA7_PxOTuR05mREa_1fyKyXOcFWRZ3d.bpqRtKf1Su_n1duYp
 f790D6lXI7ABsmgsfv161gIV_j1dQDYV2N58T30Mu.SIND6qO1O7Mdd6a.tAQjRcocS5uuDJarFf
 _TlC9sSyb_D3escikkEv.tzpn8JCP1dngQg93b_1EAXvgVz.9GgNer7b0k8NOIH5ywXZxIYxxOU0
 _G35MvXFTLUzqdQiLzPDY_ozlRLKmIXDBe7HX_LcNWxNVxrvCr5YTIuthQw_uyIEqtowVvXNkqL8
 vNePoEets0DcjJCxQmmvKEON6DOSaz4.nmhMjLFWhNuvPlA2zlwUIdw6yOrLzaB.PMgN.krFvW9x
 Ft5H9GkAuYfR.08HoE_vJlM5WIDDI7wRGLHSEVdC9DFZhcHbC8GA.LHhIYxfkY.Go.cV_5Azf9ma
 mfEwk0pLa1j1u9QdEYqZAwA.pgMrPrxfeAJWNBtbmJFHQ6DcuU8jyrKwnG9My4EbV8F7Cgo4PXeG
 XUZ47yXcfhrmBDRkns_ak8nN4ZMvbDelyCZc0i.rej74DTJLoHaRkrwPNhFDrVW5nhMDaYMn..dq
 9_vwYmDCt18Sp.rEHuLHdrTj2FKw.3KAKLgnP8nAIltzRzDpmOXj4uurSW02CzmjWar_YnAp4h7W
 w7sr33Zi8N9n.uWzQt0l0KyPL44gFWjX6JApjnEEpvtDhFGtM4gTl3PNLOPim1.7hEUCaGmdRE1h
 7bumqjbvNr3_RiRJw4wFzxI9Fgnb3CYKhRGqZZpu8vxY7pTxLX4jIpdi_ixfL.ZfIHVDgFNbFA8y
 WXRKRC_7whwcXSIkhpnLOnSdSzA4CCLPSB9.jtd5_7i1hD1UvSh2mgulzivmrNw00FFPliWbEwDr
 KwR_9SWwBZOv9ovTm.PWFmYc2LqyQYqwmoKrFaRTFDCdF8IdtH_DyIuaJ5.TJkEgoaR3QYUwMS_8
 YpvZreICIydj2FA7f9xqTnNqPaM3gslf_9fDzrQ1p1u08oXE.ky8eNgc5NpaxBCxd2_5SPap3vEs
 PCCg9fDiytAIesN_zzG_D0jHirNYkc0CxnEr3zBUs.akBqe6CLhtf9Ziasy6HysB2fXA3pQvDxGr
 I36IM
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Feb 2020 09:36:58 +0000
Date:   Mon, 24 Feb 2020 09:36:57 +0000 (UTC)
From:   Mrs Elodie Antoine <mrselodieantoine@gmail.com>
Reply-To: antoinm93@yahoo.com
Message-ID: <1960607964.7298163.1582537017884@mail.yahoo.com>
Subject: Greetings From Mrs Elodie,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1960607964.7298163.1582537017884.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:73.0) Gecko/20100101 Firefox/73.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings From Mrs Elodie,

Calvary Greetings in the name of the LORD Almighty and Our LORD JESUS CHRIST the giver of every good thing. Good day,i know this letter will definitely come to you as a huge surprise, but I implore you to take the time to go through it carefully as the decision you make will go off a long way to determine my future and continued existence. I am Mrs Elodie Antoine
aging widow of 59 years old suffering from long time illness. I have some funds I inherited from my late husband,

The sum of (US$4.5 Million Dollars) and I needed a very honest and God fearing who can withdraw this money then use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR CHARITY WORKS. I found your email address from the internet after honest prayers to the LORD to bring me a helper and i decided to contact you if you may be willing and interested to handle these trust funds in good faith before anything happens to me.
I accept this decision because I do not have any child who will inherit this money after I die. I want your urgent reply to me so that I will give you the deposit receipt which the COMPANY issued to me as next of kin for immediate transfer of the money to your account in your country, to start the good work of God, I want you to use the 15/percent of the total amount to help yourself in doing the project.


I am desperately in keen need of assistance and I have summoned up courage to contact you for this task, you must not fail me and the millions of the poor people in our todays WORLD. This is no stolen money and there are no dangers involved,100% RISK FREE with full legal proof. Please if you would be able to use the funds for the Charity works kindly let me know immediately.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish. I want you to take 15 percent of the total money for your personal use while 85% of the money will go to charity.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish.


kindly respond for further details.

Thanks and God bless you,

Mrs Elodie Antoine
