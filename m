Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8BC107E74
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 14:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKWNBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Nov 2019 08:01:33 -0500
Received: from sonic316-11.consmr.mail.bf2.yahoo.com ([74.6.130.121]:40251
        "EHLO sonic316-11.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbfKWNBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574514090; bh=rLzamwWDU6w+ljUNz15IdfH92SpsSZVAbr+GO8Whobg=; h=Date:From:Reply-To:Subject:From:Subject; b=kxTMvpnnpViXsB0qMaZRDYnzqgYjIS96FV4w3TGOgQCJyvbpavMSIc7nm6vIUMBGxRWIWzLWCY8Cp3TA5ZO6vwmkyYMmxLoX7Lorbtmu1MpyVBXLODQxyB+8ziRHGhoFjkaM8UwrGSViLG5Jhr+86sBF1m7B9k50QlDOTDAr/DfHLOL2ylxkO7MlX4IE5+uFxk8QLo+hlSPMpkuqx/7eU6RqEwgHpJWz4d/vPnJpo7XwTD2IER4WjlZ6ffKC9Z1NhVEcUYmvKTS849dL8Ix3FNfrKkVnBXwrvOjh9ZQQBBZ6/Yj6FjVY0Fw2jJD7xzuWIdcodjm2YQRKGXhj0rM02A==
X-YMail-OSG: dqpsE8sVM1kTNNw60.IR2GhcIMYeu6Zkf5TLOjz5_UWf85UZFR3_tRZ2JVs.9tp
 jTqgqGQUtBND71zdW1J.uTX4aNuhM4wsxh8TvV2wNoR7y_DdD08jH7ssnE116vVNRjsZA0JSEmqn
 eTkdQJu87aXCQHa0vAh0HvLNs0spljY_rZ5VjR5X_9Ugri9q6s82j9iyHc3W1X741da5DLIUFBSu
 6UrlvL9LAaFqiUbTDDZ5iT94KElxV7KzJCIrUeloSp1obCkmgeKio3.IlNvMeSCJ5C4HJKagYrfs
 h3xJr1LwVgDglG_ZKlabjlz3WNZNRhBX2ksDtMhqRiUyviRtQYkt7sLTsrv6wbKeeKQvxvRVHb89
 4Ze01gyyjmnhvvIEeilfyb33hzYAOY0mI1F9lBDSwFPvp_4_XP1xVJwMg5xkMZGgONjxvSD11Nm2
 37zq3.jbTeTm13rLOxLos7Lsb7HBHa5jpkJarF0ZMLE3GUj5GY4Z33JMEYUDHQFguYPAb_C7yXpa
 uOdcA0RnHtfitLxMw4vXWZdb_y0m1p2cCgZDQVdn8sapxvprF.HclSeeJICdeKjr6ra5yWntQ_b.
 fKGg_coZ4rkjYK_iMij_HcUlH4AM_iTbRhZmkzMlTIJXrSPoDX2GtPm5zAjTacksvljF7ZsDlPjT
 Z4mXXcpwEPGvv071duQBl9EfUgnWGnSOVSUMu.x7FPRS15pY2RBBl.nv1Okaw5Sf680voTjPsOVL
 I9wQTluxgrNd060DcAyFKzedgjXAqRex_M5JgyF33fyYE_flw1lblM2oKD1We_.T9kgcOhaKmavJ
 j6NbmwTq6elYsiti4FS4kWoUke8cJWq68NOA9ICFeL8wMjSZs46MZXUpqYRFP1LfwS2LXkhqmXGc
 8yVdntqNJdYN0v4nvyUs48V7ZnkdrOKmpjNNsww4eq0C3alYzWtPBGfJ9VWvIdux3OeEkO.3ap2r
 muN1jrNQQ2WOyu4D6bV5E0B19Vn3vZl7u2vwSyA4LdShh4lzx3zUR9o_mSG_eP4dDWG3uMPdrCDd
 l.6ZGENd2uvZ31sWrsO4VO4lIwgN6VQ8lQIme.mk48ybwM7hYciUuBK_9WM2Huudn2cvRHz42g3W
 T1qBTWrD_CWxTjpl3M1zP5jmAYoEZ7g0h60CxUWlm4kUA3HZB3W3.c71uq15pCS9DhctDw0PJUJu
 w2pgx7WtDo2CWtoqGHz_H7DWaYInGtQifttCXpcuRghc5fGNUNXd1v6EZxO9lr59Jl_CmqtQOiiq
 Tjaaaaa5yGLP2a6IddVjHRfyKS7e5duTKsavhAEt9VORAM3KOXHYzu6Iu98DzsfUuG5K7TqX5Nws
 6CtWCoVDPsA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Sat, 23 Nov 2019 13:01:30 +0000
Date:   Sat, 23 Nov 2019 13:01:25 +0000 (UTC)
From:   "MR.Abderazack Zebdani" <zebdanimrabderazack@gmail.com>
Reply-To: zebdanimrabderazack@gmail.com
Message-ID: <1669594160.2876682.1574514085830@mail.yahoo.com>
Subject: PLEASE I NEED YOUR URGENT ATTENTION
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
