Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC4CCCA3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 22:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfJEUNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 16:13:25 -0400
Received: from box5.frro.utn.edu.ar ([190.114.196.235]:56867 "EHLO
        box5.frro.utn.edu.ar" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbfJEUNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 16:13:25 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Oct 2019 16:13:24 EDT
Received: from mailgw.frro.utn.edu.ar (unknown [192.168.2.166])
        by vmsmtpbox.frro.utn.edu.ar (UTNFRRO-SMTPBOX) with ESMTP id DB104187CB1;
        Sat,  5 Oct 2019 17:03:22 -0300 (-03)
Received: from mailgw.frro.utn.edu.ar (localhost.localdomain [127.0.0.1])
        by mailgw.frro.utn.edu.ar (Proxmox) with ESMTP id 7C3C8C3253;
        Sat,  5 Oct 2019 14:36:29 -0300 (-03)
Received: from mailkp.frro.utn.edu.ar (mailkp.rosario.frro.utn.edu.ar [192.168.2.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw.frro.utn.edu.ar (Proxmox) with ESMTPS id 41E45C2CB6;
        Sat,  5 Oct 2019 14:36:29 -0300 (-03)
Received: from mailkp.rosario.frro.utn.edu.ar (localhost [127.0.0.1])
        by mailkp.frro.utn.edu.ar (Postfix) with ESMTP id 1D7ED13F602;
        Sat,  5 Oct 2019 14:36:29 -0300 (-03)
Received: from mail.frro.utn.edu.ar (mail.rosario.frro.utn.edu.ar [192.168.2.80])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailkp.frro.utn.edu.ar (Postfix) with ESMTPS;
        Sat,  5 Oct 2019 14:36:15 -0300 (-03)
Received: from mail.frro.utn.edu.ar (localhost.localdomain [127.0.0.1])
        by mail.frro.utn.edu.ar (Postfix) with ESMTPS id 8EF575AC1B1F;
        Sat,  5 Oct 2019 14:35:31 -0300 (-03)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.frro.utn.edu.ar (Postfix) with ESMTP id 384515AC1B27;
        Sat,  5 Oct 2019 14:35:31 -0300 (-03)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.frro.utn.edu.ar 384515AC1B27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=frro.utn.edu.ar;
        s=D1B3C804-DBC2-11E5-9AE9-6CE59837ACFB; t=1570296931;
        bh=EKfuU2VoaGOpO4gxXYISI2jG7O/zk7idIpVHWsX+U4E=;
        h=Date:From:Reply-To:Message-ID:Subject:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=j7qh0pIEDFkHuNoY6w3V+BNt8PnwgZwXcUtZti2dRNbm8IFv7wADnQY27Z857nDzG
         ZWwywnTcJi2sLYyQQpIGDO/d/sWlalcy0iAhTAUNqUWJy7HLuhC2nGbnUGvHE8yeyY
         RuHl2w+e4JBXCy02mQ08aHDk/nnCHgFKnYEC5Fis=
X-Virus-Scanned: amavisd-new at frro.utn.edu.ar
Received: from mail.frro.utn.edu.ar ([127.0.0.1])
        by localhost (mail.frro.utn.edu.ar [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 505D54EicJ-E; Sat,  5 Oct 2019 14:35:30 -0300 (-03)
Received: from mail.frro.utn.edu.ar (localhost.localdomain [127.0.0.1])
        by mail.frro.utn.edu.ar (Postfix) with ESMTP id 0772D5AC1B1C;
        Sat,  5 Oct 2019 14:35:29 -0300 (-03)
Date:   Sat, 5 Oct 2019 14:35:29 -0300 (ART)
From:   Mavis <jit2019@frro.utn.edu.ar>
Reply-To: Mavis <maviswan081@gmail.com>
Message-ID: <1851965486.552340.1570296928960.JavaMail.zimbra@frro.utn.edu.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.6.0_GA_1200 (zclient/8.6.0_GA_1200)
Thread-Topic: spende
Thread-Index: 4M2baOzXyXyJYcmwnI68IyBg4nbRBA==
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: skipped, AntiSpam
X-KSMG-AntiSpam-Lua-Profiles: 145938 [Oct 05 2019]
X-KSMG-AntiSpam-Version: 5.8.14.0
X-KSMG-AntiSpam-Envelope-From: jit2019@frro.utn.edu.ar
X-KSMG-AntiSpam-Rate: 100
X-KSMG-AntiSpam-Status: spam
X-KSMG-AntiSpam-Method: content [recent terms]
X-KSMG-AntiSpam-Info: LuaCore: 322 322 12bd9d8a79e5b8cdc1268aad0f12f907506dc6bb, {Tracking_content_type, plain}, {Prob_reply_not_match_from}, {Content: Spam}, frro.utn.edu.ar:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mail.frro.utn.edu.ar:7.1.1;gmail.com:7.1.1;127.0.0.199:7.1.2;Money.cnn.com:7.1.1
X-MS-Exchange-Organization-SCL: 9
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2019/10/05 16:35:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.12, bases: 2019/10/05 14:16:00 #14111339
X-KSMG-AntiVirus-Status: Clean, skipped
Subject: [Spam]spende
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Lieber Freund,
Ich bin Frau Mavis Wanczyk, B=C3=BCrgerin von Massachusetts, Vereinigte Sta=
aten von Amerika, die Mega-Gewinnerin des Powerball-Jackpots in H=C3=B6he v=
on 758,7 Millionen US-Dollar. Ich spende an 5 zuf=C3=A4llige Personen. Wenn=
 Sie diese E-Mail erhalten, wird Ihre E-Mail zu einer von mir verteilten Ku=
gel wenig von meinem Verm=C3=B6gen an eine Reihe von Wohlt=C3=A4tigkeitsorg=
anisationen und Organisationen. Ich habe mich freiwillig entschlossen, den =
Betrag von 5.800.000,00 =E2=82=AC an Sie als einen der ausgew=C3=A4hlten 5 =
zu spenden, um meine Gewinne zu =C3=BCberpr=C3=BCfen. Weitere Informationen=
 finden Sie auf meiner YouTube-Seite unten.
HIER: http://Money.cnn.com/2017/08/23/News/Powerball-700-Million-Jackpot/In=
dex.html
Dies ist Ihr Spendencode: [MW530342019]
Antworte auf diese E-Mail mit dem DONOR CODE:maviswan081@gmail.com
Ich hoffe, Sie und Ihre Familie gl=C3=BCcklich zu machen.Gr=C3=BC=C3=9Fe Fr=
au Mavis Wanczyk

