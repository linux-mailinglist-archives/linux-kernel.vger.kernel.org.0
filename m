Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6E510087E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 16:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKRPmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 10:42:43 -0500
Received: from sonic301-2.consmr.mail.bf2.yahoo.com ([74.6.129.41]:41899 "EHLO
        sonic301-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbfKRPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 10:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574091760; bh=vdONypa+pmkSCxMpJ481zxWsfmYXdIIKq3bhYsM38cE=; h=Date:From:Reply-To:Subject:From:Subject; b=jGJe9SJK6VR72wxygvKDDvE3ZTTktzOdlExK1D4ZlcMatCklAgF5y1zPwCUdLqMezAH2xhqUU6UtKMeiVhBaD2Xjd1H7Bh4bsxYH3xu4IsuCpAeXfuxwTTyvmrZLL4BBRBzBytlUAsFcDcELjgG9SiX5yIgnpLviCZm1bZiZJ72ErQtztbfhYJibtJi9GO2/UfuLSxRUAsim08e5CODb+AM9m9DApv7Q4Mc/mXD1SWQOKO7tz32mTwL2XjHxm7LGl+jKQsQdVe4jFpKclmlT9aNQsviGTeHQ7qTNp8CIsAtczPaPw9FVP4slpBPr/R2HH+aiufQhgQtmfyYPkKtAeg==
X-YMail-OSG: .F_hzgEVM1lfrLSM.Eh.M0m39_Umkh74AVLv9n1t9deyP7nNH4NDx3wg1E3vPC8
 gsWU1x_w7wIUOJmOuPywvc1YGfNc38RlyenkyfB71X1_rpq2Tu3N_wnjfQaNkQRT3YZW6_yu3XML
 bUtof0MVe2CzqxeSktpDOwx0pNPz92BiOjCq80GNHtukNWuJlVZ2eKnKVxYb_0AEwCLX.4.tKIWm
 gKkUvOFbfxDAI8v702too7JEAgrWeu04x.sG2174iGNKJkDpZ6ri1BmDD1L2PYuKjEIXei8vgE1F
 zUVcFGlkeePrkKuDnfLtpix6zPEoe400HTJLoPBbJFhtXxCx8CVJ08eyth0qeIgPdcLZj6Bs2Szr
 QXDWatgcMtG6zjvNkBttBxSstHpEUzaoOJWchJIDro7JIj5WxLFczqZyJHUzU8yLO1J7lX6G8Q6e
 YrvuhaCGRf8Br8.SiSVAR7hca1ps93pK15en1ijIxpjKlVXj7.Sxj77DusXaZKQhEomz1A3vO8tb
 27PQgDX.OB6fXhV5x3uwiDla_VhCa16LDYTwIGKGZvxMHdGctfyr9CBcmC5_5osvrb4mY.Znlmr5
 OqSt7DZrT9QI9XER.3tf6vAewh1PyxxHseWIHYXbOVR2nEGMvKXr4U4flq_uEN0QPjvpWPoUNtJF
 6alhR7ch41_z11WQtBRAZJaxhYe0MPBVw3b.dtq2LOdEVXLgSnOCLRHXskxsFj03gB.9unR.7BQC
 Y2B0NJ2_5oic_iVNfPuU.LDYvZw43C5HgfHEyo00zTMCOH53XTlGolVTHP9wbuPOPRAYHkYbRz3o
 rOZmIqStmtC.PZBT4Vbw3dzl099phauRi10z.E33S.1ZnZKrTW_aNaYRZXyraZ5YbJLeaYDHWS6_
 U2nUboEhXc3FzTZw8YH1hsCagOFUXS2K72sbs5E0kiW87XdSVx65yEnlWKZHgn9RKIWxFXW13Ojk
 V1QN5Rvvdzk9eQI_RfMT7dOunPbKTcny5wCcyIet6bhgdap48wM2AjIhXc3C.hKwsw9uhM5OIFkc
 7BECkueF1.LFUrSyq3oE7wUO.9l_if_6VzioQA_mTbKdLMq4VPCHz2WHJAfdy_kFDzJDtGFFQkaU
 3HfH8WDiMlcsmyX4qZbm2wytkp0BYs88orLUWLIeK9gIk6uSFONLwe3AukOqQGoq8MCrEWuctWFQ
 v5PXodgBWtlRqGCFe.HbVW671XRfqjlsFoqPSRIwmxdp09kNKSnoO3dmGOis91_26NDr1E2eyeQ6
 Aa6cg9Fl6ARlfZaR41sj.nx_PHvfK6RHjGMIcy7u681tlzmhkI9YTiUEzamMoO19X3QFc8ooM7mC
 1MvF_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Mon, 18 Nov 2019 15:42:40 +0000
Date:   Mon, 18 Nov 2019 15:42:37 +0000 (UTC)
From:   Mrs Elodie Antoine <elodieantoine423@gmail.com>
Reply-To: elodiem97@yahoo.com
Message-ID: <1416728968.1204110.1574091757931@mail.yahoo.com>
Subject: Greetings From Mrs Elodie,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings From Mrs Elodie,

Calvary Greetings in the name of the LORD Almighty and Our LORD JESUS CHRIST the giver of every good thing. Good day,i know this letter will definitely come to you as a huge surprise, but I implore you to take the time to go through it carefully as the decision you make will go off a long way to determine my future and continued existence. I am Mrs Elodie Antoine
aging widow of 59 years old suffering from long time illness. I have some funds I inherited from my late husband,

The sum of (US$4.5 Million Dollars) and I needed a very honest and God fearing who can withdraw this money then use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR CHARITY WORKS. I found your email address from the internet after honest prayers to the LORD to bring me a helper and i decided to contact you if you may be willing and interested to handle these trust funds in good faith before anything happens to me.
I accept this decision because I do not have any child who will inherit this money after I die. I want your urgent reply to me so that I will give you the deposit receipt which the COMPANY issued to me as next of kin for immediate transfer of the money to your account in your country, to start the good work of God, I want you to use the 15/percent of the total amount to help yourself in doing the project.


I am desperately in keen need of assistance and I have summoned up courage to contact you for this task, you must not fail me and the millions of the poor people in our todays WORLD. This is no stolen money and there are no dangers involved,100% RISK FREE with full legal proof. Please if you would be able to use the funds for the Charity works kindly let me know immediately.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish. I want you to take 15 percent of the total money for your personal use while 85% of the money will go to charity.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish.


kindly respond for further details.

Thanks and God bless you,

Mrs Elodie Antoine
