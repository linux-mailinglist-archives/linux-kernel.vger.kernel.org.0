Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69EF671857
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 14:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbfGWMgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 08:36:02 -0400
Received: from sonic312-25.consmr.mail.ir2.yahoo.com ([77.238.178.96]:37008
        "EHLO sonic312-25.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728845AbfGWMgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 08:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563885358; bh=KjKGiq/tr9NN0mgK6YCZSOGLZC65Q3KkqnZKDVp3POs=; h=Date:From:Reply-To:Subject:From:Subject; b=t0Rp2zQPqhHB1NhMVOHynT8/eq93TL6n3Ab/lPzQhb7JOwl9gqGEVs9tsUptVDir7UK4ayRIfX7F6Ycs5pjgZpPKGPB8OqMn5yestBVovLLzJJm5u4QQ65sJZsh34bRCzkX6OSXio9rj2l2Y/VVoNHPwr4+kOkeuhjz+SCmiiNGucniVjuQFqggejsTOmXHyd/HBXwcLgPWU99c6DFIgfWBVpTpB6AFdUrrM4ZHtCSyozNyx0qctSOZERdktn3pcCaT34aJac83jkYa7jic6c+eVG28BEj+BUFrEM4mYVfTF5X0XVGTKYJxqb0Ms0fKrKjfgWl1C3n8CbUODF4BoQw==
X-YMail-OSG: x_P.FhoVM1k7mIJVGNxURCrvax3d0gCm82yDiGglSDZztWh1oHR4_g7e5YX6Qbh
 LxHFD6pcgTa1jk7ETl20tBwoZYs2DmdP1hkJJqZ.qT4xXFTKx5OIYzTniNqPnoh_6RXFrK7HguMs
 _bxCO78iqqN7IeUNijI03zWBcPKE3i99_OfbB2la6dLuqVnp_sKj_SZDm5CUpMdRpmM0AlHdC64Y
 4YLhaPnUDfwQ708iC6ZdJ5hvgp0jaEyIrcDku90bcYhl.fkKeDEe8fJoICburERTM_tWOo.a6Ro5
 1KEmoNaCyFttAc801xmicG9OS1J3S7guU_PG1cZRRtFYN.XiYcKex_z81_5k4_7mPvA.aLmMh6gK
 eRicWPa.CV4ZQDf._AT3ct52QUrKF8YTILsDB1Mw3NotOTyLxxAncrZ1_xtNIYdIIBNEd4gNPzG2
 ugZpZTFBtSnmwWMIuuktlwf5Rep9z_OPJEWcrJ9h.yw8tGmxFXPMUUdZfXqo0dEsXezfkSbf9xkF
 y1V__AJ1QG2q881WHGoj1jQDnis9p9Pq_ZuWCLHSl7B9E67Ub3RSy0bLS9YEtZAjVvMAh91YRmhP
 ieUs7tlQHY8UTtDkt401nSUMpY0iDfvTGoTTHirpWE3zAVwu3K48TUjqRp2p7dw5GgG3LuWn8VCi
 QlH1uufwM42BFfoeoa6_4kjHevESgoAWW.JhmT3uowXG91L89OsAJ0eypjcZZJ2gaOqrX6_hqtNH
 ..lkiKwxyRho_T6EK8sQMznIehKV.neSiGiKHoWjQhFY5XU5ZNao0PNR6afdjqsPmMzH0Gl2eg7s
 MQfM6GxXP_XJPDtZRbERe8CpJirevtKjwsKh1KiUJpLXVZYnFKWT4SEIUWpmpV3g3rBpTxE3IdKh
 0Tw1yf0zWzFw0exVwvD0b.wvo3J_QgN4__dDI0znBJZTwpMNDALjHn7qc70KFNy0I5.464NrzPC6
 dvSepYmK4QuRxohj.qIQGd3mSDWW75PIgcvYhR5IYs.ij5kVYposbMoVxF__zqOt_43LxM8X7gQD
 KOILBLjWzJ69KjXLDXb99xOMtM7AhXrrwvDoe7hH1mWAuwsbKEbgJfZkaRyiu0fhJdBrCxqvxOQD
 5Kj1l87Z3d0fBbORFAtDEmvFcRAedHDgpwuTt5EXwk8.O9udIgY3NXHTftDko6vLIfMWcgSEUOtV
 sZyeYhOvhgTiDjL6anaK35mnoAEccAh.p8IFTsQzMCGm638vwVvnMpsAbzV56PyQCguM9BodjkfA
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Tue, 23 Jul 2019 12:35:58 +0000
Date:   Tue, 23 Jul 2019 12:35:55 +0000 (UTC)
From:   Abdoul Moussa <mabdoul865@gmail.com>
Reply-To: mabdoul865@gmail.com
Message-ID: <546671560.7622052.1563885355185@mail.yahoo.com>
Subject: HELLO! PLEASE TRY AND RESPOND SOONEST
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Dear Friend,

Before I introduce myself, I wish to inform you that this letter is not a h=
oax mail and I urge you to treat it=20

serious. This letter must come to you as a big surprise, but I believe it i=
s only a day that people meet and=20

become great friends and business partners. Please I want you to read this =
letter very carefully and I must=20

apologize for barging this message into your mailbox without any formal int=
roduction due to the urgency and=20

confidentiality of this business and I know that this message will come to =
you as a surprise. Please this is=20

not a joke and I will not like you to joke with it ok, with due respect to =
your person and much sincerity of=20

purpose, I make this contact with you as I believe that you can be of great=
 assistance to me. My name is=20

Mr.Abdoul Moussa, from Burkina Faso, West Africa. I work in United Bank for=
 Africa (UBA) as telex manager,=20

please see this as a confidential message and do not reveal it to another p=
erson and let me know whether you=20

can be of assistance regarding my proposal below because it is top secret.

I am about to retire from active Banking service to start a new life but I =
am sceptical to reveal this=20

particular secret to a stranger. You must assure me that everything will be=
 handled confidentially because we=20

are not going to suffer again in life. It has been 10 years now that most o=
f the greedy African Politicians=20

used our bank to launder money overseas through the help of their Political=
 advisers. Most of the funds which=20

they transferred out of the shores of Africa were gold and oil money that w=
as supposed to have been used to=20

develop the continent. Their Political advisers always inflated the amounts=
 before transferring to foreign=20

accounts, so I also used the opportunity to divert part of the funds hence =
I am aware that there is no official=20

trace of how much was transferred as all the accounts used for such transfe=
rs were being closed after transfer.=20

I acted as the Bank Officer to most of the politicians and when I discovere=
d that they were using me to succeed=20

in their greedy act; I also cleaned some of their banking records from the =
Bank files and no one cared to ask=20

me because the money was too much for them to control. They laundered over =
$5billion Dollars during the=20

process.

Before I send this message to you, I have already diverted ($10.5million Do=
llars) to an escrow account=20

belonging to no one in the bank. The bank is anxious now to know who the be=
neficiary to the funds is because=20

they have made a lot of profits with the funds. It is more than eight years=
 now and most of the politicians are=20

no longer using our bank to transfer funds overseas. The ($10.5million Doll=
ars) has been laying waste in our=20

bank and I don=E2=80=99t want to retire from the bank without transferring =
the funds to a foreign account to enable me=20

to share the proceeds with the receiver (a foreigner). The money will be sh=
ared 60% for me and 40% for you.=20

There is no one coming to ask you about the funds because I secured everyth=
ing. I only want you to assist me by=20

providing a reliable bank account where the funds can be transferred.

You are not to face any difficulties or legal implications as I am going to=
 handle the transfer personally. If=20

you are capable of receiving the funds, do let me know immediately to enabl=
e me to give you detailed=20

information on what to do. For me, I have not stolen the money from anyone =
because the other people that took=20

the whole money did not face any problems. This is my chance to grab my own=
 life opportunity but you must keep=20

the details of the funds secret to avoid any leakages as no one in the bank=
 knows about my plans. Please get=20

back to me if you are interested and capable to handle this project, I shal=
l intimate you on what to do when I=20

hear from your confirmation and acceptance. If you are capable of being my =
trusted associate, do declare your=20

consent to me I am looking forward to hearing from you immediately for furt=
her information. Make Sure You Reply=20

To My private email: mabdoul865@gmail.com=20

Thanks with my best regards.
