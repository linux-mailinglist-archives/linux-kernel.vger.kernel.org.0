Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1AF5F3557
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 18:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389783AbfKGREP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 12:04:15 -0500
Received: from sonic308-2.consmr.mail.bf2.yahoo.com ([74.6.130.41]:46692 "EHLO
        sonic308-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728847AbfKGREP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573146253; bh=tnR598H/QqPT1Ph/+p7nVdpgic7bknwMcbeRQcbc5RI=; h=Date:From:Reply-To:Subject:From:Subject; b=DnVEsGs6kQ2HCM2WObi0mI8veOT/PxIs8f1UYdC8vEpyuXulaSRdoy/75YSepbxAXqRqKEmj698Yryf+v6CZEM3O0CzmrBXIiiVh6zLDoSnCmNCxnssHPE3B9WkLnuWI5VoG+DXpeTA8lngl0sK+G/AWAcbHqdbjtMrp52kdECSFh7aZ2TjL8L9j62NsWdLHVXbx6iT3AJFZxYPZDRwEp+C2Zyuvp4ZVGV/xvrJg2fj40kioQlnNRk3cDWFRWOtFpiacs+qI7fh955nPFSnrwI0d11kMgogYfR0FZgsxgjRrmzxjS9Ns3u+oCXkDyNLfL/CLd5BnOAiBUmGQ06C2nw==
X-YMail-OSG: 6zEGP.MVM1kmyWBJE0q22zNJLuoR7fp760Wt4Q5kHqZ4vEGCcbqEzFPib32gbLc
 9tCC3lQTr1pZY2JvDr_vlwdo17fIhh7ZX8lRgMfWYDIL7nXlz2hwuNqegsly.rLtNsDnHTnua870
 rnTe85M0rlMF59CTPSsc.Huc0ot2YYRglyk13oakiylaarpnWSJZVysYU3mRPN8p7Ov1T1Ba7rxD
 oVISEIfUPiX4GnqgGf2PgeMiTCKWyKb0Ad8lDdxOJUbTWpiBCUjSxspET.P8COrJrMIjKjRsf9wL
 pbHaDaZnSKZtG_pUClb9uEm_1gxqVQxGXG2kr9YcXxlyh2EANkW9VBqql7HsfG7.62mwqnCNmRaM
 n0spu_8VT8ucU3lCvXp2y7T8PaSk_O5TybO6AWYekMro8W0F7qSQI7eaeuZUIsku6oxthbLyq_Vq
 EnxnHYeXa2SNglJrqkVfarPToroMOxV1swu2IFRitcqi4279_W8p7D1.6YFXzWV66MehNw4JWGru
 DledJRWxWIu3yU2Lrj4CMYsgW_8VQseVqoITpX5zEKVWkVCxa_Og3g5IHVL54ab3cMEJYn6ILkYZ
 sjt9KNND3mwxxm1on_NWKVIFHDf3w52CXsrnOKwVPW2cuoRMnBjduf.8_ddSgEyFXHZijS2Z1xZa
 mmEUBLxJpE0vmT6IO3WpMmgFxPUHw2XZpMnlE_EGZK7syBG.H64BMX4zlojx4fM0itesWwASSLl1
 .UmiHdZ92PyMsvOdkZpeP_A5y0LXKw0MlZx2A4FPNb_dgPbfntSjk8Yi5VCQpGIutvRB6Ltn3Jkx
 j3W5YFL3sJ1EhxFaTX1iWDJFOPv4XGf9.DgM8rTEsGjjVOq3zi_OMbcvIKjbVxyNLPUzeUb_PRFa
 X2e2ey6Io_L1AtKTMZJyTiitXDbPSa1VglVEIXJ7fxu9dKIP4L1azIJKzyvuFwq_zL0sl07xCZEE
 fQyaGS208dlprCMWGwUd4co7UsnefMIJU3tHD9u.xYh_QNOya1Xo9jD4ALtMzLemXeqcpAQ60oJ4
 zbBxOUB4AMV7VnVGCm8lJZpczVZBV6nZHwbWrwMcabRgOJCuzf8xqvDuv5OkmLofKeOvH0YKejd2
 L2vRSkqnEM27r7apcRNPLET46djQ_nf8ZYqdkJ8drJ9uFBnCDkArX6BiJrUjh.NZn7n6Swctga6B
 0DYEwD.PvVQf8yO8xGHdraDfp1QENKHwMnOJkZeKz.dy0P58oNIlvVjhsJmlCaeWrA.an3Kvou67
 3JzuSQpTUt_p5316WL_U4WjsuSHxw6FHV1bwzRHRLsjOvdAvJ3Kh6tF0XyLOmFFG0zqJdSc6AEw-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Thu, 7 Nov 2019 17:04:13 +0000
Date:   Thu, 7 Nov 2019 17:04:12 +0000 (UTC)
From:   Mrs Elodie Antoine <elodieantoine890@gmail.com>
Reply-To: elodiem97@yahoo.com
Message-ID: <396487668.652204.1573146252671@mail.yahoo.com>
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
