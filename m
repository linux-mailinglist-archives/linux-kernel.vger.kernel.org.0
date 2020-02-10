Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 066D4157386
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Feb 2020 12:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJLf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 06:35:26 -0500
Received: from sonic305-1.consmr.mail.bf2.yahoo.com ([74.6.133.40]:35876 "EHLO
        sonic305-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726792AbgBJLf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581334524; bh=iQ/yiqZ2onIU9tXBubbGKHVpMbLcC5j24ZzYARYcFwY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=RG30A0KMAxf80HJlfe7d96RBSP62PYO7bFWbgoZc75nN3caU0ih9tawAYajcX8omsEyi4DniVS3wc+25S/bXu3slQB3LVvvSno9YF8cYLPhPAvAFgMvYr8QKOn8cWfGMKJfFFsaPKIUHx1uOGUqRYgbAGq/x7Htmpmea1PzDc3A+jkXL3owuuc3dgD3wIy1AamwD6YUBeliDmJLJWH+oiZAOgCyzXkdRBvwE55KbcpAncsT4Xb/eQ4/8x48MgjAw8GwQdKOFoFgyc20j+3/Uw03hc6enDGdSSzs5AKBz1GyaIuNl2egc4y8gTTx/6DeThpaOUyz+pCz5dFHaN/bG4Q==
X-YMail-OSG: 4FMMh5UVM1mil.u2zxyTRJzwMqS1esws7waE9kNprSUPYtMGEEISjKNclPLR16h
 qSf0WCfLNcZi.qpIpb_0LZLd_lSdMjHUmLIxf17yAeWG9mXxZJF0ImE3Ff7vgPEVoY376lYNfmEy
 EyUopdaPD7UWLMpNOGZ5Tw2jPNo_mn1VR0V1q.7FmGB48vk6buEQi3.QfAgJJcqzk6kBv8ZuNa_I
 FGZAZydSflBUlS0Nt1u6JqSJb8izn3EgzJ0PL5.._mRY7x_yoFCD6kD4YsjLAOiwXIYQGZ16_7oi
 9LLRF.E3.wqjgULhlhVl_XjUKb0qfszhM3qxI7wVidPUb8QcvGlxlb4FFTTQo6G.39JdFLQ_URpm
 5R4zwvzZIHick7Y4xt6IKV5sKueZDheMlxRpv9d2dRWasvfDTzEPOXMYqpYUe5NfD1NDRqpzAnWd
 YeHY7z8ARrPzdVHg66SVKd3xJjoBkAYICWHd7HHmf9JydMRSRTzcy0MnyeMMPWobuD.6rNAIUck0
 EVP6bX.lJUVc5_pib7967sD23oY4PvpImcyxyKw9SpmyYYerGjLC2vZYccMU.gZlTJt9t_21vOqL
 x_sfla61XsGUOf7a2J315xzg_TTAs5MOtL6UYVvnKtdwsK2oLf.AR0MAsnjxnT9331e4ycyuR6pB
 aJvLRb0LUU_4KhGJtUmSOIaWQntbkzNo6173xNdpccAnZfQVA9uM7gTtvj59V9338t.Pyz4uKn1z
 x8zCRGeG3Y2fp7JaHrqDjPUIdPMhQnaKp.iZsP_KbutZJlOZGoKQaeuHOa7u53p4FA62iGvlTyZA
 HT1J7MHDqTe7BtT4BczG54rQOc4.yoamr0yp.M57_8MhJ5kvhJBkLUqcw_BM5z9DYo15Rdcc452F
 5yPgb9MQ7zPmhc00KyK.tn5XoYLawJIgEUpwtomMxCcB1Rj8p9k6G2M1f6GDcA8zWPnhc1embuXX
 dIOh8s54ik8xpYNLshTnOeCjW9JW0TPC_ab.__vt8cUwzNytA.f766XoFIGoJdv4BrheZ1IIthwK
 6WY6cmTa5qqKf7yalJ5s31obqx1nYzy1IXRFSTV5_KYMTmltO4nA.4KJGAAVUyIORyjpp20a5BMC
 lDRPQj6q.qdkg6cBsgOFsDXdkhKLyBefjhIj.Uupqjtnyx20ntzR_hrvIZw08yzGFtPFwLXU7_q5
 SUxyKda9T4bJqB5Ne3z565t314z7COm3oswvpJGo1FegzzXuw7OQMaD2SItSCu7VTA7sHyJ.Yx8X
 gJshdevz3vRv6_16ohhyYAvKr8vFOIy_cNWJidMEaENYt7lDvcVpBGqzRTRni6Cxo5YMPkc7Ltgl
 zuQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Mon, 10 Feb 2020 11:35:24 +0000
Date:   Mon, 10 Feb 2020 11:35:22 +0000 (UTC)
From:   Aisha Gaddafi <aishagaddafi11119@gmail.com>
Reply-To: aishagaddaf02@gmail.com
Message-ID: <1039336412.534749.1581334522452@mail.yahoo.com>
Subject: Inquiry for Investment.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1039336412.534749.1581334522452.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Inquiry for Investment.

Assalamu Alaikum Wa Rahmatullahi Wa Barakatuh,

Dear Friend,

I came across your e-mail contact prior a private search while in need of your assistance. My name is Aisha Gaddafi a single Mother and a Widow with three Children. I am the only biological Daughter of late Libyan President (Late Colonel Muammar Gaddafi).

I have an investment funds worth Twenty Seven Million Five Hundred Thousand United State Dollar ($27,500,000.00 ) and i need an investment Manager/Partner and because of the asylum status i will authorize you the ownership of the funds, however, I am interested in you for investment project assistance in your country, may be from there, we can build a business relationship in the near future.

I am willing to negotiate investment/business profit sharing ratio with you base on the future investment earning profits.

If you are willing to handle this project kindly reply urgent to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated

Best Regards
Mrs Aisha Gaddafi
