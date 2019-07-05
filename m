Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE6E60A36
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2019 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfGEQYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jul 2019 12:24:49 -0400
Received: from sonic308-18.consmr.mail.ir2.yahoo.com ([77.238.178.146]:41393
        "EHLO sonic308-18.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbfGEQYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562343887; bh=X9W5wP8/8WDivOaQJeQRAKeUf6rX7u/gJLEqfTtXsPM=; h=Date:From:Reply-To:To:Subject:From:Subject; b=okVDsPwfSDtAiv5dcVEk2/i0W/LXFSZrifv7IWsUc1HoBXIUsAn/jQ3WTYueSuvNXdz72L4uay1ytVtD28KLqMit0pUcTrIaCKoOUCm2FOEoPeGbipDsLO6HvBQDagbstVdJk/DJAbdnN3fMrOoNw4JvvzpDV4GMp0FFsX0+2kkBlofYqNhkzGbo0OUc/IFRPV2umspHs29Alj7r5JSdZC2HjjCQL7/32We0rwAyv9STr2gEbnCGjd0lXWMhi8HdWi9aOWvPt4nbs1qJ49BDib5M9FjGQ3F39PcdmmMwslcWQau9wukHZevnpG9W3Y1h6QF8sHyE/WMmhPyhHn1I3g==
X-YMail-OSG: wJH58K0VM1lgQ6NoTMHIui96xhe5lj398UcvfN1TjcMoXBuWmOfXhRXIhUWdFg.
 MUW5MD3Itz9Ka6LobKjGw891sgJX0KloPoPegferPtgaFNbGs5nWbeFRSFhCHdvKUmas0f4YRakR
 ysXGj2o6PSQbD9GELT6TZubhnevfm0V0fVdf6uXrTZ2heKe2GiMk4ddzIGm4FBVamJ11XzyKxn87
 FfXFZK1JSmujN.wNFKLfF_Q2dgkmnmSt8FDG6Jb_syQvj6TcVLJGl4kstkmH2eWZOGfUAbWW03l5
 25_zhx0BtS.wCVIQ6_FVmtxxLCz9dAOQmRfXdhYKmaKD8_Tr5sZxWVQBZ8Xd2RuFbO_9RZXVBSP0
 lbbf5W5N6fds1NPOdFPlMPm7AA6I6Y.8_6Tx.SklrKyzXE_LGz7PGXw8vNvZ9uuqpEeN89o7XBfD
 aBpEantYLWpLt5rsiX1Iz8GtU2xah4evv1PobXfTMfvT6O2dsYcBkmz74FO1S4UeT657N6v_AFp2
 _1QhZjvxIp0ieCiYTVwUZ1aoDsGsDK0OWL7mQewKb724zDKl63t02sTqmlZ0cg7cmDx0ZQM0wk_R
 0BZAmfjVuIwwFiw1CxEA6ODO1AwIE.KhT.Au5nTcnOwBscxJb58nG5C.zrJJTFcGh5PjOYPW_GNr
 257rOk4ioGpUQ54sZmaC2lhKaqXuHk8_OB50aS12Rc63dzpsy1UWXK4AHe0kyvIk68ILXzyrs4Kd
 NqZWKhRWfQfVpQLEuMn7SsJySJdkrTmcv1v__WNA2MuKL72j_3Hygl3Ug5.u2_TtpNxM.gT04Jbg
 KSj0LKen__v.xW0oyslHL1yEURB4sa5irDYjiq0gtp038zH4alhKkrvMk0Pcpa1hQZSIHd22VSQt
 WVrwdaBcChioKbe1sXrVtsEnLdqXxBKAysQP4aAQNu.cHTqFAiR_21XMh_O86GMegq7AfNbQ7yqJ
 ju38G6tT0NwZzomXCpDSUBfKhR8XCd2cUNN5kJaRmgHWYfHFtDfvwopxQVKijQMvriB0tk.lAeha
 PSmNvY8zjXkm.PKum2mQ9ZMgMNgSs9XOHfotapU_OuIXkG1Vx1Ea4mzm3WtlGb5txuM3YLNLNq0J
 SpFOBkeg82LVgOqlJprN0ghOWOpv3ju5zx3_dSp.h633NB2Ys7xsjBtqwszpSmDBg2sdldbkZ6C4
 rXzdoc8Efq1SxEnZ7FnlFRzomshN8xeUDReyulGu7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Fri, 5 Jul 2019 16:24:47 +0000
Date:   Fri, 5 Jul 2019 16:24:42 +0000 (UTC)
From:   "Mr. Rachid Yacouba" <exexexexexexezz@gmail.com>
Reply-To: r.yacouba@hotmail.com
To:     exexexexexexezz@gmail.com
Message-ID: <53300624.4937014.1562343882088@mail.yahoo.com>
Subject: Please for your immediate consent response
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,
My name is Mr. Rachid Yacouba: a banker by profession and I have a proposal for you concerning to a transaction worth the sum of US$10,350,000.00 for you to handle with me and there is a golden opportunity to transfer this abandon fund to your bank account in your country which belongs to our deceased client.

I am inviting you in this transaction where the money can be shared between us at the ratio of 50% for me and 40% for you while 10% will be used to settle for any outstanding expenses during and after the course of the transaction and also help the needy around us so you do not need to be afraid of any negativity because I am with you and I will guide you on how to go about reclaiming the fund from the bank here.

Please kindly get back to me if you are interested for more details.

Best regards,
Mr. Rachid Yacouba
