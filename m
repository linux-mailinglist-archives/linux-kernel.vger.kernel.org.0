Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13B176CAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 10:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389349AbfGRITj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 04:19:39 -0400
Received: from sonic311-30.consmr.mail.ir2.yahoo.com ([77.238.176.162]:37053
        "EHLO sonic311-30.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbfGRITj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563437976; bh=QWuaa+lHzclsY2yyOL4j0kQhI4PRaQdtpwh12ByH9z4=; h=Date:From:Reply-To:Subject:From:Subject; b=P4SHJhFdZkGYPyx3AtlfKy3/z1W2NvDjRbaaRppqq+R1HPjXvBb6c6V0d6GLwFFR1Q6dFJUGx6i+1ldEUMERB4K0UdzIVxactziaAYj0gOv2IYa/gW8AwHv4HOP1MHt8k8xVYBxTs6XoGFGcpspQrINwSVxAL8V/095BjZHIeZ7HKoPLuaKFghlLJyrbTuuR1EJOxv8Tki9cQPrJKDtRcFs7KYwCf0xYeMgeOOHy7E9ycimbQIa/Zjwgu2dZI754iFGY5BbBTa+OMZ5TVdAGWzGz7XNALOTcJ5P7RhaTMXSbpqgrjfkrIBmLp/fmzxLYBFp+YGVyYsNGfftS62cBEg==
X-YMail-OSG: 5J6EGhYVM1lumDRhKP6x0xNFvbUf8tMQkSc_9EG7EZ_x9j192FvvWzQHfVgOSZn
 GDaPA8EpbODsnDeR3Z1R_7ORP41sdm6oqF7HVIVO0Ui8W2kar3EGtfcvSANzow6kSYHbmkOgH.oV
 GF1bhcXJVxN.rpR0pxeejxfuyw790pMweoMCHwELWvKpg0p0yCELpATR5WzuVSY6yzhrEYA9NqCp
 EV7Yg76Qx.DZ.ZIow0qfp9T94XhtsAMUXFFINKkwO2hcuhTk2blVzUsP5cFmoE1R6vWXZcKJRi2D
 RSBCbfTBvClCsZkGYaB5y5Z.JJLwJUhbnmb4kdjS61Nw0UTDpqgHj7Dq.FUExbvk5N_52d6ds6ag
 R3mKR2fPyjZdt_w2U1hIeQeCWHpE2dKGlXl6pvKlR.MsaDkHd.7_UKjWXLIf2FT3NIpM1CS1tfz0
 w547HgHYum46vvQ6isath9uiE0_mC4R7nW4VRxpcpTh9Az3Z3FgZCwu4nKhIaErJtSXsn1FCIRl6
 iv0J_jXDgIcfE.JoCOW5flWV8tqLzXOcnP6id7YVLAD.qC5hXyc6n3QOiv3uBK8HFRVvWCmnnhhn
 sVM4Sh.kea3I7YcmB9yGMpn6aN_usU6PHj5m4YNPUvl1AcEgXs4XC7gpBvA6JnlP5k5b9KiOD4WM
 4ii3hN_yI3t6hDEerHKYauMUY_cwO3ftjXevkpKHjfXpIiGHRuASZXv.KE6W7BFi1eaEdblNCDX.
 kBwXlK2T29rVKdTPJjqBGd0xLDJya6F8f_WqSTbz3HEf.Z0FPP6_YQP21hczpuPoxcfnIZc1LTz7
 9fLoMUhr_L0dFaH6S4Vuxg2ulu76Cs2eRq53YjShued6wBUp5AKqwyoucR0.s_9mFseHkiz3TcW1
 VeGcrYfKmmeUlV_6s0JSJR7hpCnu52tSrN1QtqS3RBafkvTYsM.dyfIsTS00KW2RySqy71PtOSqd
 O9WlmW9IlDDfzYIXXoV0U0KQHx_0g_ENJFPNI7wLalsNvfK0L_VacUxJK5ftsg0yFD1HAZHCIHy5
 ktVn1NC8CWLERZ__.CvSq08rwAyE2uQrhXbyVCy9yA78IEx.olxnUVH2KKtBRxZIm9rPEFX1Om8V
 22mbHSK25T1L_1U0iMMUlovQ3I7YW3FAjg9YPMOK6xzapqhSXIpYVU9YDEtqyRi103xvVCmF2q8G
 5pZUR0EPLqY7Lopc_wWEjvYGkXTzxcffLeif7gS1kbUyI4P09xPrfZU75LAPp5H0.QHm2yza3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Thu, 18 Jul 2019 08:19:36 +0000
Date:   Thu, 18 Jul 2019 08:19:32 +0000 (UTC)
From:   Abdoul Moussa <mabdoul744@gmail.com>
Reply-To: mabdoul744@gmail.com
Message-ID: <1839340843.4227597.1563437972424@mail.yahoo.com>
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
oax mail and I urge you to treat it serious. This letter must come to you a=
s a big surprise, but I believe it is only a day that people meet and becom=
e great friends and business partners. Please I want you to read this lette=
r very carefully and I must apologize for barging this message into your ma=
ilbox without any formal introduction due to the urgency and confidentialit=
y of this business and I know that this message will come to you as a surpr=
ise. Please this is not a joke and I will not like you to joke with it ok, =
with due respect to your person and much sincerity of purpose, I make this =
contact with you as I believe that you can be of great assistance to me. My=
 name is Mr.Abdoul Moussa, from Burkina Faso, West Africa. I work in United=
 Bank for Africa (UBA) as telex manager, please see this as a confidential =
message and do not reveal it to another person and let me know whether you =
can be of assistance regarding my proposal below because it is top secret.

I am about to retire from active Banking service to start a new life but I =
am sceptical to reveal this particular secret to a stranger. You must assur=
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
xious now to know who the beneficiary to the funds is because they have mad=
e a lot of profits with the funds. It is more than Eight years now and most=
 of the politicians are no longer using our bank to transfer funds overseas=
. The ($10.5million Dollars) has been laying waste in our bank and I don=E2=
=80=99t want to retire from the bank without transferring the funds to a fo=
reign account to enable me to share the proceeds with the receiver (a forei=
gner). The money will be shared 60% for me and 40% for you. There is no one=
 coming to ask you about the funds because I secured everything. I only wan=
t you to assist me by providing a reliable bank account where the funds can=
 be transferred.

You are not to face any difficulties or legal implications as I am going to=
 handle the transfer personally. If you are capable of receiving the funds,=
 do let me know immediately to enable me to give you detailed information o=
n what to do. For me, I have not stolen the money from anyone because the o=
ther people that took the whole money did not face any problems. This is my=
 chance to grab my own life opportunity but you must keep the details of th=
e funds secret to avoid any leakages as no one in the bank knows about my p=
lans. Please get back to me if you are interested and capable to handle thi=
s project, I shall intimate you on what to do when I hear from your confirm=
ation and acceptance. If you are capable of being my trusted associate, do =
declare your consent to me I am looking forward to hearing from you immedia=
tely for further information. Make Sure You Reply To My private email: mabd=
oul865@gmail.com=20

Thanks with my best regards.
