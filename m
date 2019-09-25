Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81DDEBDC5B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2019 12:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390479AbfIYKnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Sep 2019 06:43:10 -0400
Received: from sonic308-19.consmr.mail.sg3.yahoo.com ([106.10.241.209]:36281
        "EHLO sonic308-19.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729957AbfIYKnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1569408186; bh=VvuyvMElMBxMgVM065W8Mb7OgboYNAf/LGiLQZjTnyM=; h=Date:From:Reply-To:Subject:From:Subject; b=Jypu8c1R9KcgtkJ0zWBF6MinZcEH8tQkXjGwlnpwWd2R6Df2iS/IddgM5qiVp85z8rsZGngolhOlFDI/YMYcvJtawicseGWHg69s2c6UZMV5/gtiAH++Lc9c9hcNy4/IzYa525tQBM7e3L4RDfgiHtLxujABT5eZ0dR5fG3DdwCZXBYDQLYEQoRL4DfcmPoL2usFlPtAHyXHiZ4pAW7nrUiTwYfQj7/CsbHzS/jwvkUKvvUsoyNgx3/OT3YNVovFZaiJzGqFtejP+FluriL3pHDSoyUmxRjlCVicUKjfK9eEjA9X+Hvn6E/dkMULjOHpoYbI6jwUJlEEY2twyzR49w==
X-YMail-OSG: EvTRF0QVM1khuePEb6tuDKqileBwL9rffX.GTy4pWUOeww7kImbOiZFCB2IcDgh
 uG41PsSCl70n0fTlziqkSKaNEiFwRxbe2Y.vqRR63vXhxXgDXcDzRjbZUU5z3oC6hyK92gGECf4e
 X6d1j4c87ARxtxa29qlchalpkz4Rvy9u970j92cqLYRzzeb0nzR6b1fTJLT6Yzr5P667MTDGDCD_
 yDzt9mm7VsnlbMR0NJ2bxOSATmjalr6RGnNdcdq2i7cxpb9329SUbQg.ln5MJj5.rSRwhDXjX12I
 eYE.N4k1D9JbzEYXZJocG5qBh149Db5.nllvcuRpLAoUoxuT_T1.0hWXCvOwr7ZJTVHH3pzRb3OH
 9i8gWWb_CiKUe4F0sRkXgDaavSTDEmRdty2kkrJ41_recJpBhkkBl_01QvMdo8zAwYIGOvmcfeLP
 b7o0DZ_lwIXKsag2hMsXHWCwpS_bOrlnorrGIA7vbh_5kCVFq5As8.jfZacH.Q8NdXjzp9wLGyLY
 T7r9Z_gmwOvDmwoVpjvTw1gAFEEJRtGoEWURRE2_BGKrF9TOAIwIHihMxT_0Rm6RXSyDuvyO0ttQ
 17pxMF0UgdwjdC3Rs_OZR1lV.6wvmATG4BOItdBFFk0b3C1a1Qnvg7dUrgRpG5xfzrWXgpax82TG
 XnL3jJstJeKanTc2DDR11tI6BE..Pm.J4g6lpoTa6Ozn_AGtff0eeqKkNU2193RGy2.Z63AvKYDX
 XI9YIjqkWZW0Ds5pAD2cAa4_3WJhO2NGiVmMXWtAqCbA1JoTjdaqb8m2K_MfONiUUq4AGxzH35fw
 .DX3BiAbbNkqGqgpEj5bxhv9Pg6OEii.VZvKtvISBZkwSHi9YPoS3.AdxMydTcvyukN93wA09_kf
 .mdJJ9qrg_bHJlZVbrSie0Spb2FToIA8REUpXfM3gFFxpBl9rdsMSYX9awETVlbvHX.Vr9TUdzTK
 NN_RqK27gxhW9nx3rJk7tmF3l73vME4idU2AzS0L71SyOIZVUEL_xh8x8P3FaWe5LuAbyAOoU0S8
 C7NujGFgns0GoNjdMdXfuyyNA_co8_aIYyk__O5VzWRH.Okc137A16TwQsafFvW7BiB_M88vJ_Tt
 cxeY7SCs3CyV25eRrN8iPVXF6._KcDzAB0UnEx8mqO3D60NSIpIGSgeYU7ae9Dacv7qwObZyfUk3
 ivdU3kxZ5qB2IKdaXkV_MihiXZB61Oz5Y8ChkxX4T0D0VMJitbyBjmxOzNomwobnhgTRrzadH43r
 DO3KqjVorfF3Vq35c0MbJ2hGP_TkondUB
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.sg3.yahoo.com with HTTP; Wed, 25 Sep 2019 10:43:06 +0000
Date:   Wed, 25 Sep 2019 10:43:00 +0000 (UTC)
From:   mohamed <mohamed4bennani@gmail.com>
Reply-To: mohamed4bennani@gmail.com
Message-ID: <419077367.9956007.1569408180951@mail.yahoo.com>
Subject: Greetings My Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings My Dear Friend,

 Before I introduce myself, I wish to inform you that this letter is not a =
hoax mail and I urge you to treat it serious.This letter must come to you a=
s a big surprise, but I believe it is only a day that people meet and becom=
e great friends and business partners. Please I want you to read this lette=
r very carefully and I must apologize for barging this message into your ma=
il box without any formal introduction due to the urgency and confidentiali=
ty of this business and I know that this message will come to you as a surp=
rise. Please this is not a joke and I will not like you to joke with it ok,=
With due respect to your person and much sincerity of purpose, I make this =
contact with you as I believe that you can be of great assistance to me. My=
 name is Mr.Mohamed Bennani, from Burkina Faso, West Africa. I work in Bank=
 Of Africa (BOA) as telex manager, please see this as a confidential messag=
e and do not reveal it to another person and let me know whether you can be=
 of assistance regarding my proposal below because it is top secret.

 I am about to retire from active Banking service to start a new life but I=
 am skeptical to reveal this particular secret to a stranger. You must assu=
re me that everything will be handled confidentially because we are not goi=
ng to suffer again in life. It has been 10 years now that most of the greed=
y African Politicians used our bank to launder money overseas through the h=
elp of their Political advisers. Most of the funds which they transferred o=
ut of the shores of Africa were gold and oil money that was supposed to hav=
e been used to develop the continent. Their Political advisers always infla=
ted the amounts before transferring to foreign accounts, so I also used the=
 opportunity to divert part of the funds hence I am aware that there is no =
official trace of how much was transferred as all the accounts used for suc=
h transfers were being closed after transfer. I acted as the Bank Officer t=
o most of the politicians and when I discovered that they were using me to =
succeed in their greedy act; I also cleaned some of their banking records f=
rom the Bank files and no one cared to ask me because the money was too muc=
h for them to control. They laundered over $5billion Dollars during the pro=
cess.

 Before I send this message to you, I have already diverted ($10.5million D=
ollars) to an escrow account belonging to no one in the bank. The bank is a=
nxious now to know who the beneficiary to the funds is because they have ma=
de a lot of profits with the funds. It is more than Eight years now and mos=
t of the politicians are no longer using our bank to transfer funds oversea=
s. The ($10.5million Dollars) has been laying waste in our bank and I don=
=E2=80=99t want to retire from the bank without transferring the funds to a=
 foreign account to enable me share the proceeds with the receiver (a forei=
gner). The money will be shared 60% for me and 40% for you. There is no one=
 coming to ask you about the funds because I secured everything. I only wan=
t you to assist me by providing a reliable bank account where the funds can=
 be transferred.

 You are not to face any difficulties or legal implications as I am going t=
o handle the transfer personally. If you are capable of receiving the funds=
, do let me know immediately to enable me give you a detailed information o=
n what to do. For me, I have not stolen the money from anyone because the o=
ther people that took the whole money did not face any problems. This is my=
 chance to grab my own life opportunity but you must keep the details of th=
e funds secret to avoid any leakages as no one in the bank knows about my p=
lans.Please get back to me if you are interested and capable to handle this=
 project, I shall intimate you on what to do when I hear from your confirma=
tion and acceptance.If you are capable of being my trusted associate, do de=
clare your consent to me I am looking forward to hear from you immediately =
for further information.

 Thanks with my best regards.
 Mr.Mohamed Bennani
 Telex Manager
 Bank Of Africa (BOA)
 Burkina Faso.
