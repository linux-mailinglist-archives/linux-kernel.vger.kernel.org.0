Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 703F9A49C7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2019 16:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfIAORi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Sep 2019 10:17:38 -0400
Received: from sonic315-13.consmr.mail.bf2.yahoo.com ([74.6.134.123]:42125
        "EHLO sonic315-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbfIAORi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 10:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567347457; bh=9VufCJ0uz1BZg2XZeYtdin2HH3n3ttYdATbALGknMwA=; h=Date:From:Reply-To:Subject:From:Subject; b=JUq74M+U2iLNMykpAvXwd7q7EBtEhANF/Eo0QysZGzNSjysfwp3mdya5Eflv3ZtVNCMcQDovuVkZG857rC3ZEkBuNLGmKbt8LXRJrb8L0VEQP01PVbcIUt6VHO4wr58kzq5eFKhbeESiVkRBuo/GwqopvbcNBPtcGv+OTln2jV9tn6DvKL+/qWW9wG/m+lXfbzN/wga4D+VBmqQ3C++CMDtZPLxEBF/yIH6gEC9591efrZ9RiMiRrAf6oJvzXZ2BewtDNUMfKEdExEz4s7WTH9TyShgb5XlBmv//rMFQ6MgN8V676/JcuWPtyll4sz2QzssMHc66c59tUcQ+D+ZSdA==
X-YMail-OSG: 0gsfL7EVM1ljyWry_q8tLw4iEk9elTlSA3AWTJDMQK_EsU4NFIIcSNeqRVaQlUP
 9Ze8bOfGH.mJNjoyNJb_rUTsGsZFh57Mt77j1zd9dE5QyWkfTZhAG_K8A45POLdjV9F70jYqze7G
 QUt0YLPR_NswvXeHBF8pRfwg2zh3lAhlYCBCWsZim1sVat8gPulzaTzKbMhqaz9.MH81CLqXMNXl
 l2v64Ck5NfEsppk4Mw0U4Bcy6AuiWvFriXPReQhvClM6aLkq34df55.KtxD0cO9_0RD.vZqigDwZ
 Dzk8wjzrx62ur4svAd4pQWpwWzzIETXVozUP8z4iVPjOS3VDdbgPrjvXBEkgcfdC.Znx5eIDOBCm
 UQt0ZZYxV.8rtqXbqUbbQQ_Ng4avb8AU0aFVf1oDkbVXA2POF5sAufY5aQ27kbnnxRtaB_W67TKO
 6aRmkuc4CKKC_34PNOpma_Gto9s4RU_6ywbkIoiA1_mrecSDGSXcNbtWyn1JJKTlFidS6zJO2RCy
 ZCAOGIbdiJ492I8xNRb5W4EzQlNhJcDLkKWkPZKEu9Bph6DPrsQSJCBq1t3a62Jxz2dE8FKTAsNA
 WuJyVMF2.vN_c1Eghj8_GQDLQVGjGFtnunV1ByyG8lxKQNXpHFTnYBJHks8H.N1pmkbEQ6fE.FSq
 lBkKTZvxk0bXeBOT.BgGEbseybhBiH8lSzjSS8RGb2VGKwWkD8wuSTcEGbRzCz2PEuNM1zJ5x261
 oaDgXMVWD12nSdz2JDgWvi9iYjPRneoBcqe9Q8yzeI5MOCoggZPSwqlFWM7.wuvEO6sNMCXa0vse
 txjFqz1mSgdU.BbFDhMPXprgelHxwKojRJMd5tGBM6EG7bEE94GeGKI9J6V1X1yqscy3dYJe8HK3
 MFuus_v4bhq9Vp.rzvu8Y0U3vba0OEnrDfzBPzisCBJpnJeDLVkdd25TnHkdDUfn7wSwDyEosGwJ
 M2cf239MKpEfu3Gc5xMDZv1Zj11PRQHJ6suqIyrYwQcMK0PATf.vL08W6voycMqc9LutFGx7x.I.
 U.WjZK3W9kES5_fCxLsDcosvD7xt9YdAj8P8r8KeCUas85_FbcM6bj1U.7Yh4apya.rVPSxJdcCA
 CWA.dMEDjHcwoLXUcDzvEnd6IccTDyxs_3PLzOTS8Xxqpr7hXQwmWKcot1KEhYwkkB3S68zPawwq
 1imF141Tp38Cy7P1IGwgl7HuSEXJbM0G.Nxh65l2T_QToKdXqMKjNclXxsJeFOnGk72szqTKtAye
 ThOPHVV26SMkddPp9YTwp5m4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Sun, 1 Sep 2019 14:17:37 +0000
Date:   Sun, 1 Sep 2019 14:17:31 +0000 (UTC)
From:   Mrs Alice Johnson <davidmark6682@gmail.com>
Reply-To: mrsalicejohnson4@gmail.com
Message-ID: <271952071.586821.1567347451845@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I am Mrs Alice Johnson.am sending you this brief letter to solicit your
partnership to transfer $18.5 million US Dollars.I shall send you more
information and procedures when I receive positive response from you.
please send me a message in my Email box (mrsalicejohnson4@gmail.com)
as i wait to hear from you.

Best regard
Mrs Alice Johnson
