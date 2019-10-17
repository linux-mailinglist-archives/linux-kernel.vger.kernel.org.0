Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25F4DB15D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 17:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437851AbfJQPol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 11:44:41 -0400
Received: from sonic312-20.consmr.mail.bf2.yahoo.com ([74.6.128.82]:37003 "EHLO
        sonic312-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731569AbfJQPol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 11:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571327079; bh=sgFa7Cs4ss6n8sA+brLiAjHMpjB11xRWsbVGUlCB1X4=; h=Date:From:Reply-To:Subject:From:Subject; b=tLwdr900EIPeLMyTVj069+VG/Qt2XrAHJ6J1lJU7TLPTbZiRP7LuojHnRF8PlaSRf+T3IN6nepFxvLc7NiDcojbe6sAhCgLqfOsaEOzovweOuNgZCd6MylwFVyo5VTymmFxr0x2QIOu+WPfd3OXYZbYkpo9JhHJjObZkGh9a+tsHpgF+gp6ucABab4nEloyjb99/vorI8n0oWwMknGepg9E/ovqJ0qUHoluZ6HnP0KPafYOBouuM7UCSBdCzaFpbTN2/QJ3ciGO+vSdPqqJ3++wA3gmi6S0RlEijqMyD/X76Um9+94ik+r6AA4qNtUiNPia3r7BJrUqpoqoKlXZt1g==
X-YMail-OSG: tEnrlgAVM1kGH6MrRHlYtJ9RSW927BN0QSe_or1MIFbPBdBH21nJ2PfLNs_xMYC
 _LbSPFTlbXaeshN9u0OhtjVk9eMSvQrhkHN9Ez6pejqpHVhtCf2gXxRu2qzSsHBk9EE8S8TEwSwt
 EjjWy_4D8ZQmDjSCWO4YvNjyl.d9SfEh5J55lKkF.qE7Mn_Z0Gq4JjVZ_qkV69voMxMdU.XbM3PG
 mKq1vpaqEW7Dzc..rDWCPoBL5jBMptj5vC7twz3TDHz3hE15ADeM_lq0Fu_CHBEer_9zDX9yu2TL
 r.hVxWaYHsrbbL2VPhCMGFFucmEN0lTjhmq32bfxN7OXjMm3Ubpjcb.G7s9.G6NDHaKm_gkfe3a0
 NP7g.SlP8lt7bren3ZytruHiO4tLGKO7k6t9mi2Mdf64LZRS97xyjWtVmtc1YJaBMEp_WuFrgDqH
 z3VKUwm6_Ko9N1ChGp9mFiCDDCX7PsedsFIeswkjIWhGH2shoLai._jONLHVApHTZ0aABr7V2Sgv
 mEKAUfhfYxeFipbk1ALAdQLaVipz6V3mfPXwTqi7a0d8SPX_C8rXzfeuMD0uuGVBWUaPO_Iq5rjI
 MsT2vg3U0nfhOoq1R_nXwRIPqzZad4qprDKee7XA7A1.xTQDPkoonlWotL7Crm.zIPbaw4wtIRw5
 u8rdpMJyzzVmJSY0CGhmBdUgR2a1Wj2Ew.be4RAhD.e5Y6WnM39tov920L26VGHaf4m6f2MDOPlS
 1hPVLg6Bf12ECjrAdQy9NDwqZ9o9YjhoRTW6jPZEHrAGQeuUt7EmMcdvAyzDJ1FM0TPJnqmMfYxX
 05RtTFivT0Dzy6qmLv2z25_QEQ8HIjtisYTNbLJne3_L_vC2SMWAIJHK5cx63JiVilbFo2z9Rzyl
 1XytmljSdg6BBKw8C6lDpqvI5Hr4jN8exzo9MsnPZYRACBhzF6h.qW_c0RECIFzrfg0Xu7qKhYNq
 cDT6cWSdCdcVxYF2jeUagASDMfoszAwPSjrH8she_Ej4dhYxLK2uCHg6_15B3pfejYB1R4IWcjAE
 itlhupmlXgDUen0QOkL7c.z_1Oe5aQJxiVMRa3LiJ5qwANJxkiJX6Z7soN6DYs8juGQI0A0VSPdy
 AJ3X07CXKnI.4giV3UmDds0F0gic7iU7EzlxW5a6EGuD6L.D7aXoMHI_4VP1TMoalUToA2YABixY
 IIop4T3uZedspSesOoTL1pM9N38iw8bvUGSliGT1TjwTWnhba8g415Hjbq4chbx8D3JNWa7KIoKK
 MTDBfTSfe0AxumRIxXfm2n4pAU8_RJpsOfmMjWmesuKKiR52KN8aaa2sDcKwTSKAEjcyBQk4.eup
 dHEnu
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 17 Oct 2019 15:44:39 +0000
Date:   Thu, 17 Oct 2019 15:44:36 +0000 (UTC)
From:   "Dr.Youssef Bakary" <Mr.Sohalarfan.latif009@gmail.com>
Reply-To: dr.youssefbakary1960@gmail.com
Message-ID: <333396270.1994220.1571327076614@mail.yahoo.com>
Subject: Dear Friend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend

I am Dr. Youssef Bakary, I Have a Business Proposal of $5.3 million For You=
.
I am aware of the unsafe nature of the internet, and was compelled to use t=
his medium due to the nature of this project. I have access to very vital i=
nformation that can be used to transfer this huge amount of money, which ma=
y culminate into the investment of the said=20
funds into your company or any lucrative venture in your country.
If you will like to assist me as a partner then indicate your interest, aft=
er which we shall both discuss the modalities and the sharing percentage.Up=
on receipt of your reply on your expression of Interest
 I will give you full details, on how the business will be executed I am op=
en for negotiation.=20
Thanks for your anticipated cooperation.
Note you might receive this message in your inbox or spam or junk folder, d=
epends on your web host or server network.

Thanks=E2=80=99
Best Regards
Dr. Youssef Bakary,
