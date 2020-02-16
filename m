Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9F016042B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2020 14:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgBPNex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Feb 2020 08:34:53 -0500
Received: from sonic312-20.consmr.mail.bf2.yahoo.com ([74.6.128.82]:33222 "EHLO
        sonic312-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbgBPNex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 08:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581860092; bh=vdONypa+pmkSCxMpJ481zxWsfmYXdIIKq3bhYsM38cE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=MduPeVBG8I+9xcK9wMfqwoEvfnR7OLcOIbEMYPTJ5FDbhyjwqER9Wy+69yMgf6RUYThBotWawA1ecMh7WQs15Sl+1VPpVp8YAs5hRT8h04ggP4/Vv+Nobjr4IVBd/09dF1IZKrYzOGNmukTYKy+bU5x/gCNA6GtkpLoyZEZDtUZp372Z9D4jl0MnH2Y3ncSN/TMBc28/C/4N0/dw+KxKmP9gG8hskGgt8QvzY5gpQqgzdIr0zoU0c9EfbupIhQgKkWygvIrRSJbwUGsaxtqIJB9Dz3qVHLBmCp/65eMXzSSRbpGlKRVnqmXhlJHmzeIvGkLUkZ6n2Lid6ntS/xtbGg==
X-YMail-OSG: 7L63JCQVM1kF6LXK42pQKvWONiNli17hblxGjMYQr7ZyicmG1JKC7Y_LZQCqZWH
 3KqPBskzLkU5Eito4QqM1O4Rqq8rmGnOIxUrlULkCK2lUrEemJ8B3ohshYnXZtJokTDTux2Jyi88
 QxaMwmLAn.AIKUIOO3.Z3iXdiAsRL8cHywSvXMYQdZdm1cvTQNCgY4TgIH.8QC0X6zHVd9hTN8R6
 TlyTlYMHK4fBRd_afN80Dx2HplgvgB82DKjpwsn6vaXd4mI_MABKUGZc88rllWsShGTbwdpyACpm
 lTYv7zZfHHvtWjGyGSIdBtwrCQqSp_n1pt0lS3iTnk.2iRzIHybyJrR1Xy0ht2JXN.l_KVZTZYMl
 6cbhqHffGazCL4ydBHtXbEViKxoajCz0nInPHzrMOWPOnYQAcIdpcxqR4QdFRRCqvi7p.2zhA1eh
 oc0PQjvOFBtes8Gvt9Y9d7GNrmyhDcy8gOMeNiDNwkTSnxk4relZMoSbFXxkNL8Y5eJOEpqdWW0D
 sg_XZDOId6yA1nEoLSwaPjgzLVlVsECt8MQBmyZnck5Ab6mmK51fBAJbAS79cuum_2kLrT8Ikvac
 jid6E5VJliLhsbuazFiWBS1zU2YRlPYZ5ryaFYduXypxFy9niNOt3q6jyEyT4zFwMmeWu0C.blOu
 2bsuq.yNRdQeOume8VT.cWctij7GQOL7kg5TLnht7lsVapLKKCwDni2sj_4xCeWUKShfpq2zYu7Z
 HlBv2JfFz6t3p.trRgIDRj5YwLa1dQzGHCJsQsa6V89MiWPYX89PUqwN7F9NxCCEpbmio.lcWrGQ
 4swrbNUqcthFa23KogWs.YzszDLWmVGJ2uBa1MVedQy87QjSH0nOGtYGD3BG.cWAUg0RBw.V7fc4
 lH9jlM43kxR_0ZUQ4_tQYT6zrswVIHZZTVD_QlZS_OdcCz4kLbTdLYirZ03QqI1w2S5Brhj1nwcJ
 zpJQFH53bEqu892G_SGr.39gSMKc_qxOs65I2HXhqsSXVwQg_9Qivi.zkCqqHy0qhnF5RlVOIlHD
 mQyG77W9Al.v4TJFfrfMiw8.4Wa24MAuoNqtJn0dB89w.km5vfZB2DhZbBhpPNACBjHQqZNCsY.a
 ubcZncC9Kri.Zl.S.gMhI0eL9qVtKwd1pZTTcNSFiGcJyAztvDgk.xtrSPP1ptBmkG43lGJdt0cX
 2NL75GHqlCGUCym5PBvnv0DQPTgIg5rGxKKtvw1PHZSR2290vCngxjJiRPHFQA1ksLUfm1_l2CA5
 Br44r2IMIDz2InSJWieK_eEB2r_ZMaVvFTT_sKhB9Dk_LjtPaxhnKEhzcVEkzra1VcN2UDBn7PGi
 iWgRI04r6ihg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Sun, 16 Feb 2020 13:34:52 +0000
Date:   Sun, 16 Feb 2020 13:34:49 +0000 (UTC)
From:   Mrs Elodie Antoine <mrselodieantoine@gmail.com>
Reply-To: antoinm93@yahoo.com
Message-ID: <893729943.2618502.1581860089951@mail.yahoo.com>
Subject: Greetings From Mrs Elodie,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <893729943.2618502.1581860089951.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:72.0) Gecko/20100101 Firefox/72.0
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
