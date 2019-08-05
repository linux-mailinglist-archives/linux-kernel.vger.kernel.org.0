Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC9E81830
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 13:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfHELbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 07:31:45 -0400
Received: from sonic316-22.consmr.mail.ne1.yahoo.com ([66.163.187.148]:46588
        "EHLO sonic316-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727357AbfHELbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565004703; bh=hib8+UkIm/dhfHOgSKsCmGffI0PPja04PjM1O047l94=; h=Date:From:Reply-To:Subject:From:Subject; b=aV5l3OawoydZg/RbOnL0jhxyhl5NtUaqyYCm75ued5+TiXW8zp+V3JkzmPkh7iLwwkxYQM2a3Tt4G7gzN9MgLG6DBb8QIGIrH4srl94N5kGfkTokJ0jg4N71yTA5YVTUd2/we58Ceo6twUo0atQ3sTyguCfoGH/jXniXRHk84f2mMbVSQHCmH8JyQOY8ApU//ilsEm+P4jrmhbJmcqc2QbgP2VebuBwC7cPxqiGrGurLTVZFJ3HBilL7L2oMEJ4oBz87fy68k0+7NUIix2ZzKRcYH2dNt5owf5JKE1ckBfEq6ShpIumtV8QC4KYT00DSkq0eXZJucfbQvmCUHfbJMQ==
X-YMail-OSG: hcsRQIQVM1mcDKoQw6OvaB4WiMUfmrc7pwSPw54uyimn.L16XICjQHycXXLSaG5
 EHtPZqf35jdDBWthjkmZq2M7xezwYuxKxWl3HirjLba8fVNDb5hN9thY.LM4vKvsdmvmhR2Ug5ED
 RWK89bY_md66nGr8u6iaL.ycvFEw4APn_N.6T1EIqhRso1C62NI_Q0MrzyTKA59HgdPDiFcpski7
 vgtcwQO7_RKZhGB9pqIiZWKs7vJ1WX_6nSoKhhuNTpPut1If1JAgmuISX4Y_n1CfoYywIjY1tzI9
 9YuP2mkm6msHlBzRuJlk03jUrZggA6vzVGzZbaYi.dC.V2q7fHwjoj.zBcCb9H_Av22ap5Z1KY99
 Aaie.ez_TK9WEi9MjR6XZAygUFx.dHiHURhWZAYtDh0YpAArwmWkFx2XtQv_T.8HbGcuQdO7qios
 ynsdZiOxUACp3FGJm23owRh6kaucGu0AXvhVWmJocu0JHFPd9ljlRVl1z7l2xLi3fkGkHu7ZKgLI
 OqYRgvPDukxGBZ7LpMJIrvG5vOaOg2Y8Tm0fws9QNMOj56Zd.ZLX9_j3RcqH4YHTgf3KyEJ_suTk
 8uyEI8c_dWH63lTQUAW3BWJCdZ229eootHkLWjuEPuaKXeafSsbeDeueRqWrkWv_u7Lf_q4m93gQ
 4SK0QwdAbnpfQ_5GpBEqJFzNDOBJd9jrulw.JwkHHVi3SBCf6jjPFAwYi7vx0OsrXsJ0aDLIya3s
 cdxNTI9HZxKS7d1.FAAve25ZqGoPjxVj9O14HH2OGxvx8OCJ3q7aD0dDyS5m7YZ3ZfxWwUGNLHml
 aL0j2ipIUqgV4Sy9ofV7wupkZAaFQ0xwBtCQo_U0HWPm5Bi6eiRwHZi3R0z0m2GnfBBope2EeNAo
 xBC1mpi.x92f3Am5pyK2mrEO4jzAhrlw0zlAX9jaKMVzhlqrXPCyzm2zl6OptFhfNAW7GGp5L06T
 COYJc9QQDcN2vd7srA5n7ymXjphDxn9fwJcnm0OtQe8hgtrdF5JnVrDQY3Qc8eQt1hine5j5e7aC
 _tko.d22vidTdBV_ylZDabknnVbvC9imtlrjpBIhqbU70eI38puN02YgLbgbNjhUODV9C5ILeyf0
 0O.GiKRtK2QgymwYaksQBZxdm5pDuKKuNv.b8ZOVsn1ZmpLOM_7vg7BLFL0aUsijoYHrOmJjhY8S
 0FhIS.cuha.1pWSNnp9rcSsrrDSb0AB_foqTmwyTIirmJERycA7_1lYNHcpWoYoeZZ6sJAA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Mon, 5 Aug 2019 11:31:43 +0000
Date:   Mon, 5 Aug 2019 11:31:38 +0000 (UTC)
From:   Mrs Elodie Antoine <elodieantoine677@voguemail.de>
Reply-To: elodieantoine76578@yahoo.com
Message-ID: <678461960.1118407.1565004698760@mail.yahoo.com>
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
