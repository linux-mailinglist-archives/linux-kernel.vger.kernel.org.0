Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684393AC26
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2019 23:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfFIV60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jun 2019 17:58:26 -0400
Received: from mtax.cdmx.gob.mx ([187.141.35.197]:12518 "EHLO mtax.cdmx.gob.mx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfFIV60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 17:58:26 -0400
X-NAI-Header: Modified by McAfee Email Gateway (4500)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cdmx.gob.mx; s=72359050-3965-11E6-920A-0192F7A2F08E;
        t=1560117236; h=DKIM-Filter:X-Virus-Scanned:
         Content-Type:MIME-Version:Content-Transfer-Encoding:
         Content-Description:Subject:To:From:Date:Reply-To:
         Message-Id:X-AnalysisOut:X-AnalysisOut:X-AnalysisOut:
         X-AnalysisOut:X-AnalysisOut:X-AnalysisOut:
         X-SAAS-TrackingID:X-NAI-Spam-Flag:X-NAI-Spam-Threshold:
         X-NAI-Spam-Score:X-NAI-Spam-Rules:X-NAI-Spam-Version;
        bh=U0Muiz5ECa3gaTzMJe13Eshf2iywdDpIp+lqwE
        FBq5U=; b=ROno9U4nIC4G+e9dn1GwsR0ZtuqLlGibtUxrA28D
        RkwsXQwrWZS++ksf2/mxfvc8MRuGV3251kCfWGQplzhW2fhIbC
        zGLyKjVdJjvvsIT07BUh0iBn8IT3VT7SqnaYh9oa3Dctb99tyu
        F0679x4I2NQ81vdpLi97YV5dgaT2wk0=
Received: from cdmx.gob.mx (unknown [10.250.108.150]) by mtax.cdmx.gob.mx with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 06a7_b8bf_a7490048_6d3c_47ec_ad8a_23613b33381a;
        Sun, 09 Jun 2019 16:53:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 2DC512E8616;
        Sun,  9 Jun 2019 14:17:02 -0500 (CDT)
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wai8wptn79JV; Sun,  9 Jun 2019 14:17:02 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 42E581E32CE;
        Sun,  9 Jun 2019 11:08:56 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx 42E581E32CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=72359050-3965-11E6-920A-0192F7A2F08E; t=1560096536;
        bh=U0Muiz5ECa3gaTzMJe13Eshf2iywdDpIp+lqwEFBq5U=;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:To:
         From:Date:Reply-To:Message-Id;
        b=NWniCQteXX2de2CZG6jaby0xOgWahRLSFd/+ttRtnp/Xs0Rf2AYVmE2WyF3PdcYlc
         sv7oXEb4IDjN33o8oH9DFEROG4pkRztkW+/IC8xbaqktD72yWFC8VomMB3ZVAgi/yW
         soXYz+ZvfFEYv+QybT0TUio90FdSVfrIjwO6FiZY=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eX0pxY32qPrQ; Sun,  9 Jun 2019 11:08:56 -0500 (CDT)
Received: from [51.38.116.193] (ip193.ip-51-38-116.eu [51.38.116.193])
        by cdmx.gob.mx (Postfix) with ESMTPSA id 682B11FCDEC;
        Sun,  9 Jun 2019 09:52:47 -0500 (CDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?4oKsIDIuMDAwLjAwMCwwMCBFdXJv?=
To:     Recipients <cilpinez@cdmx.gob.mx>
From:   cilpinez@cdmx.gob.mx
Date:   Sun, 09 Jun 2019 07:52:49 -0700
Reply-To: johnwalterlove2010@gmail.com
Message-Id: <20190609145248.682B11FCDEC@cdmx.gob.mx>
X-AnalysisOut: [v=2.2 cv=Fp91xyjq c=1 sm=1 tr=0 p=d_9A9YPZgCEA:10 p=UhPmRW]
X-AnalysisOut: [QW4yN_uUvCwugA:9 p=Ner0o0mvyuUA:10 p=CwrrfTYHidcoWUP_FusY:]
X-AnalysisOut: [22 p=Z3hVr4-9LPz_iBwj1Snb:22 a=T6zFoIZ12MK39YzkfxrL7A==:11]
X-AnalysisOut: [7 a=o6exIZH9ckoXPxROjXgmHg==:17 a=IkcTkHD0fZMA:10 a=x7bEGL]
X-AnalysisOut: [p0ZPQA:10 a=dq6fvYVFJ5YA:10 a=pGLkceISAAAA:8 a=QEXdDO2ut3Y]
X-AnalysisOut: [A:10 a=uXetiwfYVjQA:10]
X-SAAS-TrackingID: 1108dfc5.0.365862668.00-2381.625491339.s12p02m014.mxlogic.net
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 3
X-NAI-Spam-Score: -5000
X-NAI-Spam-Rules: 1 Rules triggered
        WHITELISTED=-5000
X-NAI-Spam-Version: 2.3.0.9418 : core <6564> : inlines <7098> : streams
 <1824022> : uri <2854373>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ich bin Herr Richard Wahl der Mega-Gewinner von $ 533M In Mega Millions Jac=
kpot spende ich an 5 zuf=C3=A4llige Personen, wenn Sie diese E-Mail erhalte=
n, dann wurde Ihre E-Mail nach einem Spinball ausgew=C3=A4hlt. Ich habe den=
 gr=C3=B6=C3=9Ften Teil meines Verm=C3=B6gens auf eine Reihe von Wohlt=C3=
=A4tigkeitsorganisationen und Organisationen verteilt. Ich habe mich freiwi=
llig dazu entschieden, Ihnen den Betrag von =E2=82=AC 2.000.000,00 zu spend=
en eine der ausgew=C3=A4hlten 5, um meine Gewinne zu =C3=BCberpr=C3=BCfen. =
Das ist dein Spendencode: [DF00430342018] Antworten Sie mit dem Spendencode=
 auf diese E-Mail: richardpovertyorg@gmail.com
