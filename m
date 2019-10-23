Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2497FE1F13
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 17:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406591AbfJWPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 11:20:13 -0400
Received: from sonic301-2.consmr.mail.bf2.yahoo.com ([74.6.129.41]:36858 "EHLO
        sonic301-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390636AbfJWPUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571844011; bh=rLzamwWDU6w+ljUNz15IdfH92SpsSZVAbr+GO8Whobg=; h=Date:From:Reply-To:Subject:From:Subject; b=eVygccjpxvj3t034xJtqhk9aD8QcwtWT/3uCFtuOeU7ddtG8R2AQIfUQ3Glu044y1oeHZtIbU4sXzgANDFvLTLZHBMOnn8UVYY4LgXu/U8s/ojyOpLifq7zvGbYsWZHJMB182+8sqEwVwVKjRODR7+QPcff5OszWoMXp185CCY6aDSyrDw3/3iP6O+NQAKaF2EKCI0DCSV4ab77oPyWOLkLLfhEzjUEe+pOJvhvsxA0H9uuoK0dKSQKmBZzwa52Ufya0W4fU98j6kE3rIZdEeT9QvrZJ/fOr73QtgP0DisCJF7VEL3713LGSuIG4KmemnA8hWGMOMO6EiLPi24Rn7A==
X-YMail-OSG: wKOfQCoVM1nTCA25UKNC4C8RYoXfGIFDDrklSIlNj11xDM7X6PrzROMVKUcdkCn
 v_WyfTUk482XWV5u0BJvKzNWzzN3UWFHyOlg.ABTVCvOSXWT8Xb0cw41.xyKT4EzL.f6oPnQS2lz
 Ak.uCTuULjaS95E8YUcJ7MhpJDP3FDgwpM8rNOZc5wYYWsgRtnPet.kuha1r_bOi_dNTVfWS5BM8
 lhs3WJgRDRICcPz0WPI4Q7TMZzzNDPamWBwDiBRvMGgS0FJkgbpxP.8UJVuseqFMN0uMP.Mh.wSQ
 gHiBnJBaYRi5ygDlNFohet2RIoo7CRARJbLmuwhtcycBVGrLu1.bKj_HhXabeICXZJ5Vs9QzEoxd
 CzndDIdziWvjiVovppHJOriLwWsEA2hUydnbITsTZBgbl5QoMRTPR_M46EgkR8G3LZDa7AUSnpYy
 rLJmzPJko38fkaMe9qeJ8jbUyIXzMip80gP87ACvzcWlClasQcEU7139k3T5dgIknqgQ6wqK0W4J
 Nppxbc6Rt9oXOAOmwIy4q0IYpCJZnawdjwb9fBALCBg5Xc25_J07pvbyiP6UiiqblAh9Ga6EaRcv
 AA7gwa4w1Zh33M9nO6yvz4Sl1Mm7Q4D2z1bJRXajZ0xqRhLeRCbpB3MmaX3fiv0SG084yER79Vde
 flfLbSLNUsTLpgg51DLqGbIE4ZoyyOsPEu8t6NV2vQCVWhD3cAmKJfKN2SN_kaVkndIocn_h.KL5
 6JyK.mx6zeCrIf_CEvQw3r67R5cTL8dLPuxiaddIjFC3sq2juGv5IrbPlGg14kCc1vEZzv7rX6nO
 rA22RTstDY0Pvec9brZ6Gsc6MMyGGViJC.PAAwWbRMZRBsou3qaPQ8BFv9qW8yKtBZ5n6BwcTf5X
 1TL.AxlcQkFq.Ye0FRw_DGqOBbkxaa7K9Xj6b6Z94fJrChvljb_Tqq3QtX7iev.ZGEJ3QL_UL0mM
 3KgsjfV4c.90Q6UwFtbAeP5ruu3Qf573XNmdOze8dBunoFhzhFGr4F7O_esmxNEuWBeQo2F0RKzr
 2f3MtOZ1doAeVPqvzXwsRUNotgdaO5ZxDe4_6fVGQvOfJ1HEFPo2j.k5OCBIQLq5YZU_D3gKf4Um
 LqRrmDTtY5ESveVV7SAoFLTPF4DdZ7ETWfrDIQOFLeX3R3vls6qec1X.NkmJjLgqhcqpb86YKr24
 m5kHmUyV8eSQbpn3MUKiqttC_gJCiOwuehcqb9Msy3h0Nz3agO83aqQZgjyh13Z_dS9n_K74OKtK
 r1z12PE7C5uotfTnieSYoeI24qH2HLz0au4SyoNhBxWD.cegKfc2yqD5KZC2K0Ft5g1db3O9g8VE
 0heZSKg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Wed, 23 Oct 2019 15:20:11 +0000
Date:   Wed, 23 Oct 2019 15:20:08 +0000 (UTC)
From:   "MR.Abderazack Zebdani" <zebdanimrabderazack@gmail.com>
Reply-To: zebdanimrabderazack@gmail.com
Message-ID: <18223875.3879344.1571844008168@mail.yahoo.com>
Subject: DEAR I NEED YOUR URGENT RESPONSE
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
