Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F84B03C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 20:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfIKSi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 14:38:28 -0400
Received: from sonic308-18.consmr.mail.ir2.yahoo.com ([77.238.178.146]:34550
        "EHLO sonic308-18.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728105AbfIKSi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1568227105; bh=P6dqk7bv618YJyTF7lFCi4TpsrtdcZef3AXEWXgAAZk=; h=Date:From:Reply-To:Subject:From:Subject; b=p1Ul+wvFzAFGpqjcryrvyxfRLXUCMSTkUJCgxJHD1aU5kAYIRZWEiI1qUVmjoBFfYYQU27RKvSlOUK2PEoyrYCMpy14cF6pn/CbVqoA7LaKa+AeMob10nuzReQECLZXoQQM4lO4ruJ3tN2KcEK4ybqua3v01txf598v/ksf8YrTesulgTIm82GAHitTp27qzLFR9WA/d7phG7nVvjzm5lNXbIBLDoJSP5VK4jP92qgavKMIs2dtEvhDWKwbgwNAC9315Ci5H690GGvWT9pqHojPWswofOIPRXZwXtaRMZRrBnK4uCxN4xEmJ6Eo3mifafYyPzo87R7qS15hDPD0OCw==
X-YMail-OSG: vRpW84gVM1lI3VqvY1aiBE_jFpk4SGMEbOMHgqD0PkxntVBZU3GaDTHixWa5B9_
 IbC6SoA8h7pU3KNcjVhaLqaJ6KHpyhmOaOGylDnyfha17TjzKO10SGyLlHeg1oTnk8FKduQf0VoC
 hDw5VE7LOwb3Dt6p4n2IcFgir7sdsargn.AvQO6Vhd423PHZFh3E4O7dG7GXkrFK06i3UzJ6tXQk
 kJAveHYZk5DODva80KjiQWo4QrQcrvgX0W6crAd0w.hVAX_gnfk7AYZuA52_RSV1hHq7etwTCn9Y
 qHwcLgXFropsmf4vmhZ7cIMghA6QnX7HlyDIQB1a9pLmF6AnjjSi5aRGH_0SwndUoZQr18_rO9me
 UQU_S4xfaEx8qv0s6kLQEsHEbhoD4cGhNKSBhGNjeTkfesPx0.IV9yblfieMgvkgqsfT7RuVty8k
 THcBSnOGEMdGyxm0BV1LClUCn_ibKG4YYDCb5EzAlPhTgnc0IfCGkcGXxlJ63BGlWCDjV1cIO01i
 HpDA78Cxq6WGB3o0ZD97X1x6BNaybN38iBaY5jKGcrlFuO8_9tlXGUIE67nXKk_Oxd46hL7xe61s
 Rs5KhMwTTOT._JQMjk7aAhG.oXKJTC3AiCIV7DnHtnWnLGf4EKyC5f4rM1QvDQ9_770dBbwAr4yJ
 _RQGazBvAZBiO15W_HIRHXj7CMi6lsUJ6aGltpTj32LtCyxCVawd8XxYUYjeZZBtvwwg59TQrjCE
 U5UUJrXBNzS.UlJsx4KN487sb0BOh9hBD0FPxaGtOHGPT812PXzIfOREZgYGRbv4H9SkiW7lwlNF
 l.QIuirjaoK8Z_Fg0t05SQOxs4sxKXU_FkNc4Y2q2i3m9s2_AVZK_6CgKpyLUx0glFHJbY301YnN
 QEb2MjFr_I_ZgueLV.Msz3XTl1YVHjSZmlhKsfKADvD5Cj52kCLYbhhAFFgk.lp.nYMtYQmlNNYn
 i9FGTikgHfh3NGnAfascr__eP6UkGsgtrQPG_dDUv_x.8_5ouQpEMeZ.CAVcsV0MGtJSZkwOFywU
 FD_FNuqtXK0WpiEwuxHmbgRLjbJIZ7UIVicDIAAcUoP8chheePoMCi9gBXB.ovFdRzk5MiK0Wk5m
 fya75kT_L9QJPQxHnkH61t81bTHtf9cLXUYhcjaEmeWMj.ShPud3ddPA1VuA6X7Rki6J8F2_vOj1
 g46QSkfFluqd_tNz5PzXkn0y7x_dDA1_uHecL5yUfexn74d2YOGrjE5Py24IUOFbr8bfyphDLrAt
 Tud0DDaw_amwckKpkWKCISvWoPw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Wed, 11 Sep 2019 18:38:25 +0000
Date:   Wed, 11 Sep 2019 18:38:24 +0000 (UTC)
From:   "Mr Mohammad Z. Raqab" <raqabz88@gmail.com>
Reply-To: raqabzmoha009@gmail.com
Message-ID: <1926689927.8069476.1568227104810@mail.yahoo.com>
Subject: ATN:PLEASE/ I AM Mr Mohammad Z. Raqab
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ATN:PLEASE/ I AM Mr Mohammad Z. Raqab
Before I introduce myself, I wish to inform you that this letter is not a hoax mail and I urge you to treat it serious. This letter must , come to you as a big surprise, but I believe it is only a day that people meet and become great friends and business partners.

Please I want you to read this letter very carefully and I must apologize for barging this message into your mail box without any formal introduction due to the urgency and confidentiality of this business and I know that this message will come to you as a surprise. Please, this is not a joke and I will not like you to joke with it OK, With due respect to your person and much sincerity of purpose, I make this contact with you as I believe that you can be of great assistance,  to me. My name is Mr Mohammad Z. Raqab, from Burkina Faso, West Africa. I
work in Bank  as telex manager, please see this as a confidential message and do  not reveal it to another person, and let me know whether you can be of assistance regarding my proposal  below because it is top secret.

I am about to retire from active Banking service to start a new life , but I am skeptical to reveal this particular secret to a stranger.  You must assure me that everything will be handled confidentially because we are not going to suffer again in life. It has been 10 years now that most of the greedy African Politicians used our bank to launder,  money overseas through the help of their Political

advisers.  Most of the funds which they transferred out of the shores of Africa were gold
and oil money that was supposed to have been used to develop the continent. Their Political advisers always inflated the amounts before transferring to foreign accounts,  so I also used the opportunity to  divert part of the funds hence I am aware that there is no official trace of

how much was transferred as all the accounts used for such  transfers were being closed after transfer.  I acted as the Bank Officer to most of the politicians and when I discovered that they
were using me to succeed in their greedy act;  I also cleaned some of their banking records from the Bank files and no one cared to ask me because the money was too much for them to control,  They laundered over $5billion Dollars during the process. Before I send this message to you,  I have already diverted ($10.5million Dollars) to an escrow account belonging to no one in the bank. The bank is anxious now to know who the beneficiary to the funds is because

they have made a lot of profits with the funds. It is more than Eight years now and most of the politicians are no longer using our bank to transfer funds overseas. The ($10.5million Dollars) has been laying waste in our bank and I don't want to retire from the bank without transferring the funds to a foreign account to enable me share the proceeds with the receiver (a foreigner).
The money will be shared 60% for me and 40% for you. There is no one coming to ask you about the funds because I secured everything. I only want you to assist me by providing a reliable bank account where the funds can be transferred. You are not to face any difficulties or legal implications as I am going to handle the transfer personally. If you are capable of receiving the funds,  do let me know immediately to enable me give you a detailed

information on what to do.  For me,  I have not stolen the money from anyone because the other people that took the whole money did not face any problems.  This is my chance to grab my own life opportunity but you must keep the details of the funds secret to avoid any leakages as no one in the bank knows about my plans.  Please get back to me if you are interested and capable to handle this project,  I shall intimate you on what to do when I hear from your confirmation and acceptance. If you are capable of being my trusted associate,do declare your consent to me, I am looking forward to hear from you immediately for further information,
Thanks with my best regards.
Mr Mohammad Z. Raqab,
Bank Telex Manager
Burkina Faso/Ouagadougou
