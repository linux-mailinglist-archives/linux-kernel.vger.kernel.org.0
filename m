Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B6A4D376
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 18:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbfFTQQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 12:16:50 -0400
Received: from sonic301-3.consmr.mail.bf2.yahoo.com ([74.6.129.42]:45692 "EHLO
        sonic301-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbfFTQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561047408; bh=q0klBQI4vbOV8yr3MxjOcIs0aoIIe58Na4Z8WYaQ1C0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=CjN/0ypp6TF2s8TFfgGgSHEoHxS2ANUQpSDqJdrvhjh8qh6t09amA/KzuM4JcahhnlzrGCLzwtMx3JsIJeF5wA8i36rpS8DHiFaRui7tkvl78ACy8odYFFBtjhVvOV8FKAOY1I7SN+YiGQei3h8VGvYD6T+1Q02lYjOUnYNM1vHaCHGugnLVj8Elx1yEMoo5D9u107HAwIKNzptVRPri9CYFcOth3KhWCJCwZaPQcirKO2hVdu+sc7idYidMM+9+PY9h75Gc3OdhkuB6nEo3yIlIoE90pLzC65FvU1OOME0wnDLoBDfOn5K81OQ3aK9o1xatIJtzJOIwF0O0YcF7/A==
X-YMail-OSG: R7fZpGgVM1nif.4lmkQVCTOxwSThzY2zKXJCN0DeLqqghnlPFCRgpkXUHMhh0zS
 v36epaRgdoG_lryGSo.usdXWH2rulqlNfUGhaoWVpv7G7tWC7PvnFi.Nq5GTId7nJitRghcfHyUg
 8typaa.QqhnG5vDo9D2cGEnafS4QE9L2USicBR4ma22yGANpliHJl2dvmlEkqyo8LBYDdpvQ2krX
 6P_0GShuNit5n.HRQPFLV6zG4lyoppX8QSyfXGEI3MRDjh.1J7OLrM08xM6hlYIKfEMeL0nVSB.R
 7NiAweXVQIpc.vbLBScGeSCkJsoC3TVaha7suWz9hA.W2GKEWXJtCqAhzUwxvtXmqE4bnBpU9hft
 JpvS4VRTTBQHktGmE7TsjFDd12stR8K2AbM9di0EwZ0Wq25WbiOu3XV9RVgMprFKvnrakhqx2IBP
 CNGDBnvKGmSSXuu_9ETFN1LuNLvVIKr0luhs2t7wKctUcM7K2o3g7zz__0CDvZ06iPq8JJuDlRd.
 LEHpukUy.2tGo7rQX50b2uECNkS5W1lKC92YIJRGUSPImV7V2s2CpsGVTpSPJbDOsjEkR0WHkuK1
 txMRCFIPxbJzAlIYoP73jT_Riv_SFQBnPjRzOsNP7OuceWqSHv.fhv.DLhI81cAaIbA7O.xZg5eJ
 xNg488Iywgicr2IGBQesTIzpptZpZ_yRa_PcxVStqyOMt7GHdfUOVw91CzNPIqSQReo6WBv9bbG5
 g_oEnfHI89KPCwAuEyjnHA1MMK.bK903DN0uy9.d0HQRLV_5WHA_8_Go7CEJC4i_XxpkrEnNrHCu
 puKcM63JNXhDqnlapL7uHaq_WPTABViQC.ldazlytkVh35koMnX_tHE1JmE07WZsSnmVnu.tpyOm
 nfqcXcnnBR31KimAknOZzDpSCMuTV5m8DL8pBL.gy43n82JVnYX6l2FBDwZddM7UdvTYxenympok
 4p1DnvpfhPC0HH85z1zkfkN6eXDd7Px3NwAycthBPCxueE3SD3923.C0fBAB1ptr4QlT8KoOgRxk
 0GDb7xdT0zie.zEtab7H.B7C4U3hTyVachk2YPUBRrsSdanGeULnAsoN3DskMr7fKBWWzY3gYTjo
 yHPC6h5HjyMbsS2rksoIeK.LCJtbaMTaqjMsT9pVEVACli997zlDajBL3qyC5zH.ej5fo9QSxKWF
 .xdp8nK3MNnOoB.HJ2MHO8VBiaLXIvm_lqaqSmag.Ky.HRfICiHjMveS2VvN4ZcuwLV_X2Jn3J.D
 c91Vfl9weAMjP
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Jun 2019 16:16:48 +0000
Date:   Thu, 20 Jun 2019 16:16:44 +0000 (UTC)
From:   Jerome Njitap <jeromenjitap700@gmail.com>
Reply-To: Jerome Njitap <jeromenjitap100@gmail.com>
Message-ID: <2021156192.3266800.1561047404279@mail.yahoo.com>
Subject: Dearest
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2021156192.3266800.1561047404279.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13837 YahooMailBasic Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:67.0) Gecko/20100101 Firefox/67.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I am Mr Jerome Njitap, former ministry of Agriculture and Urban development. I have also held the post of the assistant Governor of the BCEAO bank, quivalent to the central bank here in my country
Burkina Faso. Also, former head and chairman of the Burkina Faso electoral commission.



Now i have been made head of an auditing department of a top bank here in Burkina faso. Here, in my department i have discovered an unclaimed fund in our bank here belonging to a foreigner. Further research which i discovered upon research that the owner of the account has been deceased for years with his family members on an air craft. He was a French business man into Agricultural and mining business.

Hence, upon this discovery i have made this offer to you to stand as the beneficiary of the fund and with my technical assistance as an insider, i will do the necessary underwork to make sure my bank releases and transfer the fund to your bank account. You have to understand that it only a foreigner i can present to my bank to apply as the beneficiary of the fund since the deceased beneficiary was also a foreigner and not a citizen of Burkina Faso.

Please note that this discovery is known only to me at the moment and neither of the bank managements are aware of this for years now. I have the statement of account of account and every documentation that shall be sent to you for your analysis once we agree.

I intend to share the fund with you 60% for me and 40% for you. While i intend to invest my share under your guidance and directory in your country and into profitable business ventures and areas such as Fish industries, Textile, Technology, Real estate, etc. As soon as i receive your confirmation i shall direct you on how to apply to my bank as the beneficiary of the fund so they can begin the transfer and release procedures immediately.Please all communications should be through this email address for confidential purpose(jeromenjitap100@gmail.com)

Feel free to also check my professional linkeldin page. Revert with your confirmation and direct mobile number for easier communication.

Regards,
Mr. Jerome.N
