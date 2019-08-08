Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCD885F1A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 11:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbfHHJ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 05:59:24 -0400
Received: from sonic313-20.consmr.mail.ir2.yahoo.com ([77.238.179.187]:44508
        "EHLO sonic313-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728289AbfHHJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565258361; bh=rLzamwWDU6w+ljUNz15IdfH92SpsSZVAbr+GO8Whobg=; h=Date:From:Reply-To:Subject:From:Subject; b=QtnF3Hxrb5Z5ZgYwS+J2DFFNcZE+KWAlCnVggvf0MZHkzVSYHGyfh9WrpqrwNgqtPiT7GbIvN+b6jwSBojuuj+2PURCv6HYwy9KPufipa7mCHBza0XVkRBnUtGT6UUFpSUJBq5pGBq/tHsd2SvueB10K2KnTfyR05dhHdbwl0S6chb7Y6Q13/qv7NJ5OiZhlVtemHY7k/6dCRA0s13MOviekxE8810i8GDEEqsVGr2nv+O/1bvN34ucVkCcR6FaXBSCF89YpkCO65itLR9nDoR4v8bAEzjQ/fASWydt5c9buaIVbdlSTnOys+UJM5mSbnDw1ho2uiXvnQqnTWrO6kQ==
X-YMail-OSG: 4rFx03EVM1lDdb_OAgrP0ahsmI187Ys.i6pTAz0M7oj5s7WOvARfoqeZrPSGvRW
 XenW1sBFWawtcxiuExDKxsxeuQkIY0m442NQDFmOE_ggU27R4SzoLDWcZ_7HWV8TFUWak3_sKBm2
 9_PzeubWgRaOh0I5QtLlkU00U3OQSg8fa24sE60Ws4q3t6utCdd4hN5QeSeUWIJ4gmC2nKdJIET8
 JLHGhtN.SrbR.5MdXkgodzLLEDslM4yaW7a6DtVevmKYK6ANmDIVF5KWgyPGSQiT2SOelXAfegIx
 jlKQCHUQCOKxqtaFgDtaqOj0x3P2FH3BR0e3NLonqLTbT4FlxHhO_1bmZCA_DrU0CgD3IN2m9Gzv
 1MZlexTttX0jmhfJ.fykSg2GOvBjnCO7DOjbedLXyWRqkURXaBqnyR8RghaIUXy8hLhE9FhkuVYj
 VeTUmRsBbBP7pwfoRZQOpq_AjA4qd7Y_fTcNw7nnrmku4osrkaqUj6Qz0dTZ1B2Wd92pikQfKgDo
 PiLEACg99eq8PyM0WefLEHaLAN3zZEEF2ZeIjxI1GrByV7J_U7JuU4Q2qcsPeFTgGs7PfnUpI9yi
 5TtxjpSUMbep5RdK7W9YPCnXmzGZEULQEgWsWmoezLA8R9qaz40mYR9bBdEvPujm9Xb53xZkXJfj
 bqovcjtQCfxlsEcbr_z_WIOTqlNcRMdKmOVzopSOBtFvMsT8zMZRR476BXk8Qd2L0zamNJcaSNJC
 MXQKCnoRvlisWupwCAEDcnYDZagotePe4mhwqWgXBKh.sf1357SpYvAGud6HADj1pJ71dRqg9jSs
 qa2qc6_kHlvzpmniWEqi6YtE5cMWg6losvBQL.Dxmw7o2rzBy0o7bZWROdK1bFFZIWhRf3UUOTMO
 vrnIvPiD7uiU6wPD7CeOlK.qwJZTwbLdPsP9ptTw2QgpSLHl_6mlUQN.hzbzxaOzuAlJU2uT4wCw
 zJrdt8raTj7ijscSz5vZDFWNokQ3kCfShK8SDWjt.SHAETOLguQxX0ftUCWUnzCMlsTDwUYaZ7rF
 16o.g8tHl4IN5G_W3TLsdNa.bHC5zmfvuLB3u7MFdwcw2ccU7Btot13_n479DfW41sUnRoYjHpdH
 54KspYyvi.LQwxeXOw2NGhzEqyAA7MaxjnDUfeYbgX_mvz9Ck8KSCnb1DxnD93Zg0L.wdT_qHfk6
 pN8lx5q2elBy5lvx6kqY1NYesPNbA1QN53ndsbvkA3vVvoHZTb.YxeqG7q2c-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Thu, 8 Aug 2019 09:59:21 +0000
Date:   Thu, 8 Aug 2019 09:59:16 +0000 (UTC)
From:   Abderazack Zebdani <zebdaniabderazack@gmail.com>
Reply-To: zebdaniabderazack@gmail.com
Message-ID: <1721234584.3662390.1565258356977@mail.yahoo.com>
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
