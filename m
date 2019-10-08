Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9D2CFCCD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 16:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfJHOwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 10:52:05 -0400
Received: from sonic308-19.consmr.mail.sg3.yahoo.com ([106.10.241.209]:39550
        "EHLO sonic308-19.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbfJHOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1570546321; bh=VvuyvMElMBxMgVM065W8Mb7OgboYNAf/LGiLQZjTnyM=; h=Date:From:Reply-To:Subject:From:Subject; b=cB6xxHewnrZI5e4j3dPJtLAl+9FE9Cr2AmxdfPNJLq44zp7Jtnep7IqG5nw65Rg0f3xoVil0Qd+BKc1PjbVrStrIq2x7XQgwxb+XkLzgtefQjmz7rT+QI+1kYAX6OIU+hlyWZVIZhA8SiWqfGQZ3egxyoNKQMG/qv8SsYHIR+NZEIq08nLE+L5n5t6b5ktpODm873DT8eSBg3IfB48FQElGdMZydX33bvCLLvKTfHPIISgiPKxi50xvGW1p+dWhJq0KE3RiNQg8uKiGTk0A0uvDt5CJLifrkkrBigPKGOOXMoOChQw51ZVBOo1gGwH9PEu7+fIKdlwYfJNXq6Nzt0Q==
X-YMail-OSG: A7LONBoVM1l6QUMHcxDNWKApYQ7YKH3_QxgK5AAZVfm7LhAQ6jDxlK1Pw43AkvY
 ioj9WtguEnm_LBgP.kBUBzJrxBNlM4baFwdoofxRFmy0Cpz_vBjDlRpqoWVFKSJC8hnHcIQibu9X
 srCdx15xveS79CX_Tl11W.dR8yzs6.GM9_xxDwMTDN9zrRmo1f1iWJ5pf2OaZS3n_Ljz7q.w4GYu
 vBzxwWOY5poLLhwcLk.IlgGaSgcaQmFvReK0OgXYnkOLZ5fGBwiZaBiX6DwefrlRITiG5tPTxVRT
 s7cmzmxPwlejhNkLmTFwAWKwJ_lQzh9lqc_6ui7e6V5URIinR8gy0PDNfsw.KMnKbuWPU580i0ul
 h3vZweu_5LyMTU9g5uaq6AQbSDjSzV8migswuVMnQIssGzCwaRKlLXQsJkh8yqxjCOBnbRTiJpaR
 CHWu.Q98j_mkBEMZMo8gVt9IIDX6ca2kjdtmLrEe.gXuplir3U5.gkCySv.27XI5iSO.sAGZ796Y
 qO8LzQNVUZe42JHXiIB0P1ZAgXt.ki6THsSGsCf7B5Fnkjv.oLkwEfOmjvdpfymUzcgddkRu0jWj
 uCSwepih43Oozie7EqpDueSu5bmJzwzuOukzQW5WuGeweqa5Eyn9r1kbYveWrpkHKXNFXLIZoxBW
 4dB2obvkR7CYbgJ79kT7so2Dxwvb_m73qsavQI18Dgy.6xBQx75NRZjvXF83hSgmIQsJqcTReQjb
 .iXhQGRyohidiajlga2NPWPTcdEupGF3yKmvHokHQCQMvm6lehYuMCsrjwGPAej59yah.uWHpJxU
 ZSBGP_0ahylNiQc8hwfugz3CxNUwpaJJ1u7d788Mtls1KoDNuGrGEivhpz3JaU.GeymLTcko3i.k
 bmdl_5ci1wkegTSSZLAG9P0KT18J8I.3b2GQmG3slDgUPPMvwKCU24xX1kmpOgnS4XwsGNT4tGRE
 OeA0CM9AbRG2Yud3_UdMYJWvK9pQPBlPdE0gectIXgdo4_vdXejE7xsEQquRiyEsAklVtvR_1iWj
 HNWZ580IaNw.aRDAOlTMqAiDtVVjUr0LBngs2Gve1EHkxv5CVAseW3NM6Z4bcILEynfY3MFRSShZ
 VK4Kq0Yv5X_yZjejkQhRsHgL27q7ur_Hzw4gHs6YVjhHP_vdBbRfuo3pIQ.jBL2aq_2kir_WSzQT
 ht.drMXr.xmr_KrdyeICpTLJlqBAwulQZV1w9fCVjtBN9ZemKa464THdA_Ph7C95Rc9RUcP_7YD.
 ENC0FHOk_0mEbEUJbXszm0WDnKKcExSlD.ydrdalDsG6Q.c5YDG8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.sg3.yahoo.com with HTTP; Tue, 8 Oct 2019 14:52:01 +0000
Date:   Tue, 8 Oct 2019 14:51:57 +0000 (UTC)
From:   mohamed <mohamed4bennani@gmail.com>
Reply-To: mohamed4bennani@gmail.com
Message-ID: <1648048918.4829388.1570546317408@mail.yahoo.com>
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
