Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9BE6AA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbfGPOWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 10:22:16 -0400
Received: from sonic302-20.consmr.mail.ir2.yahoo.com ([87.248.110.83]:44585
        "EHLO sonic302-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728384AbfGPOWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 10:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563286932; bh=rLzamwWDU6w+ljUNz15IdfH92SpsSZVAbr+GO8Whobg=; h=Date:From:Reply-To:Subject:From:Subject; b=ZdndFwQ9FU2zK91ko29W/NI6vwVdQMIvBWzDP2DNTqXEljNmc75EAYoeFbKW6G7vjBZ8yiVP6DW9GagQJlm5SKaAp47GY/htan+rJRI3FqpkJhUDYgZ0sBiXfLfI47fqOL/oNV383wdn/DC2E5gRc+/+9vPqpYzvaMOWysfQWVwam2Z8wN3gAOe+cuB6vIQUezOCOGUeM1W7V49aEuorA3Gw3wofOh9dcnLWquIH54oT623OKBvHJq3pMhniazNbmQpespNP4/dBbEmo0TGYZc8JzW0a/nxg7LgM82MPWC0xSRN6aCOtWUR5XbsdwbA5/XeY8mlP3U6gYgw/2IwW2A==
X-YMail-OSG: SBBaDYkVM1n58mARBmXI5jShzoEHiSioMGnCnDotHUuL5FU.bNUZNh9uS6ayMtR
 e14syM_gEt.f6f7zF9DTdq5kwJ7oHQ7O4C5M75Cq0HYBiNAwfZKlSpqPLQMRkrG8dcvm02cEXsT2
 HbKwmqq6t6wAGIpCU9Rjxu4kjWrcgfepeteRz5rl44aVrvxhyVgDWlg126EWLAbv2ukH8kx5A448
 siFeCUNaS8p_bqovaofU.au8tZLUAg3ehgeB_T7j55.vcjrRxXqRLtNN5VW.CbBl6VbgMQV.b60l
 jLOEixxVzxbG.V9sw6s_xJ95xdjAiyRDViA0TYaMaBbbPaJcsjJ4pW6dWQ4IQ2p4zZjs_ppchxgR
 YX1TmYCsErGBBMRZTmBVoWKT7PoO_C2ZPn_csVyF7Jt3_PTfL2xuQhKoENXrHJEP1PpiA.pbnlr6
 Wr6wPWan1YP7z1omrTGIptPcrX.qwR4sLWgIUjmLKvxPef8DNvnulaBbECZb6LIJJ2lZNEXkyz_x
 la9WHTiEXCsYySVW8BGLFpIaoLHOndsW6WcP9QAYCIj.nBBUWTMitXgghWkqZ7eYIyW2EmE7DAIm
 KIWYkmxWk2phjUS5Ft9HnxcgFo7JpInSl6wNmb9gFPN96Sv.6gWOo_NLmWeU7K5KT_XMiGl5ONc4
 yuNTeSmlcrIUf4tRkIfiYJpiETKsyq6RBcT3jwf3tj4pRQaNUDpFLbj4E0mQplOPk64UYbMZRxdz
 ffYqSkDHKejCN8hcyKtqOYvF6aM8d.sSu2.tjYF32Bddo7sQYZQhKgcAhskqS2YmWtvRqun8ecHH
 ltQgSzfTm3_eEtdHIumnKBSsEtsWRB0r.nAEXfTUu.F8TZCKjuPxVwqaWWALlmtd8dPM8FV_BvSF
 PtXWH8Ovjg0qyAuNZ4F9w31DEJ0ko1m2M7RJxrBBcqXR.s6AOlRseLwwF9y96bud5jgAkRT79yAZ
 VnK4qJ1r9yV3z7XEzxwBadyo7KWrIXrRZytKjdlWNB6THjaH.1ak0IkeNXfnlYsqUizBpIXyMjNC
 hzKjvDs4URKyRV2YOaZv_Y2B_LN7es4rHnv_JE.25a34Ppt52yfbjDoTqmuOGmVsMivzk8TvYUV8
 K4tKfoOxfQ1M9U28dlFyYScvbFyGxvYDpdwbkZxdXON9FpjeXdaso71.wRB3r3dG_T5ci8SitWSP
 XUQiDnt3I0E58P.md88aw29ovNZrp0xMWxwkVnTT1SGD8.BJ6UGxrgg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Tue, 16 Jul 2019 14:22:12 +0000
Date:   Tue, 16 Jul 2019 14:22:10 +0000 (UTC)
From:   Abderazack Zebdani <zebdaniabderazack@gmail.com>
Reply-To: zebdaniabderazack@gmail.com
Message-ID: <725422301.2898714.1563286930882@mail.yahoo.com>
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

Before I introduce myself, I wish to inform you that this letter is not a h=
oax mail and I urge you to treat it serious.This letter must come to you as=
 a big surprise, but I believe it is only a day that people meet and become=
 great friends and business partners. Please I want you to read this letter=
 very carefully and I must apologize for barging this message into your mai=
l box without any formal introduction due to the urgency and confidentialit=
y of this business. I make this contact with you as I believe that you can =
be of great assistance to me. My name is Mr.Abderazack Zebdani, from Burkin=
a Faso, West Africa. I work in Bank Of Africa (BOA) as telex manager, pleas=
e see this as a confidential message and do not reveal it to another person=
 and let me know whether you can be of assistance regarding my proposal bel=
ow because it is top secret.

I am about to retire from active Banking service to start a new life but I =
am skeptical to reveal this particular secret to a stranger. You must assur=
e me that everything will be handled confidentially because we are not goin=
g to suffer again in life. It has been 10 years now that most of the greedy=
 African Politicians used our bank to launder money overseas through the he=
lp of their Political advisers. Most of the funds which they transferred ou=
t of the shores of Africa were gold and oil money that was supposed to have=
 been used to develop the continent. Their Political advisers always inflat=
ed the amounts before transferring to foreign accounts, so I also used the =
opportunity to divert part of the funds hence I am aware that there is no o=
fficial trace of how much was transferred as all the accounts used for such=
 transfers were being closed after transfer. I acted as the Bank Officer to=
 most of the politicians and when I discovered that they were using me to s=
ucceed in their greedy act; I also cleaned some of their banking records fr=
om the Bank files and no one cared to ask me because the money was too much=
 for them to control. They laundered over $5billion Dollars during the proc=
ess.

Before I send this message to you, I have already diverted ($10.5million Do=
llars) to an escrow account belonging to no one in the bank. The bank is an=
xious now to know who the beneficiary to the funds because they have made a=
 lot of profits with the funds. It is more than Eight years now and most of=
 the politicians are no longer using our bank to transfer funds overseas. T=
he ($10.5million Dollars) has been laying waste in our bank and I don=E2=80=
=99t want to retire from the bank without transferring the funds to a forei=
gn account to enable me share the proceeds with the receiver (a foreigner).=
 The money will be shared 60% for me and 40% for you. There is no one comin=
g to ask you about the funds because I secured everything. I only want you =
to assist me by providing a reliable bank account where the funds can be tr=
ansferred.

You are not to face any difficulties or legal implications as I am going to=
 handle the transfer personally. If you are capable of receiving the funds,=
 do let me know immediately to enable me give you a detailed information on=
 what to do. For me, I have not stolen the money from anyone because the ot=
her people that took the whole money did not face any problems. This is my =
chance to grab my own life opportunity but you must keep the details of the=
 funds secret to avoid any leakages as no one in the bank knows about my pl=
ans.Please get back to me if you are interested and capable to handle this =
project, I am looking forward to hear from you immediately for further info=
rmation.
Thanks with my best regards.
Mr.Abderazack Zebdani.
Telex Manager
Bank Of Africa (BOA)
Burkina Faso.
