Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDA5F18F2EB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 11:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgCWKgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Mar 2020 06:36:32 -0400
Received: from sonic312-19.consmr.mail.sg3.yahoo.com ([106.10.244.209]:39551
        "EHLO sonic312-19.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727901AbgCWKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584959786; bh=TCEah6dQDVULXjjJd0DMU7TiZ3f8rT/CjPbt58XpL8M=; h=Date:From:Reply-To:Subject:References:From:Subject; b=K3ge/ppjup19uFmP+uQ2dC185TEpc+as+qFrRhttkAcYJ04Wt5lEdo6HHjrthrT6+UbcpgLro9ab36lajQCTPa9ZLH6hIsZuQN6F+Ck1HkjMb2x1AA2KQ6BFsuF7IWkAwmkymfwsT3kLIIknnZzhU6DwCkjwIZ0ZQJyI98UwYvp50mphff7/dPHKq68PIpn12TWJczZ9/XDln6u3abkeF1E2/cNTdqu/vWjs/reWHzKEdRE7YP0l/h5CQMkQPLpwg2J+trmbHnVl/SnMWUVUSlOCFXlR/KroLliTadynRzNhkW5eoKCyYbgRHPpKv2Ltso4q35EIJR2eV5E8Gornlw==
X-YMail-OSG: 2sSkjZAVM1lfFMCaDrDUN3hXopcYNNOLhRuAMeYocq2Zl1rg1ya2pbAYD89UGyv
 cLr68WDDjwI.gDU0TWH_TUobjuAmmbWONJzF6YAReoGTxpN5A2ytfU1wBl9BnoPv1Z3zo_PnRP.K
 IFI2v8Y5DwT7XGCVftl7pfEJsUZqrhMk9lprm.uux2aWdUeGliYdBGfiboErDSmO3D0LFd.TwweH
 Mb6_m7r2YkmaAMGkeiLGVPCcc8G6FzsbJ8YwUixPKf4yg4nRQ3IcPk6bKwhKZquig2TLYoq47H_z
 WDcZHhby00JyDoRIPL5y5WZLpUwOH7VJVkesFWh4XtUp_.G7DC_k2Qq6sUK8qqQm95qyYUMhQSMX
 oTorJdTglVg_eXiVAeTflSxqUB2fgblrfpcw6QSHltCevpYOx9Bl5KremwY.4Ae1WPlZl7wyeQrO
 XDF0X4dZK2X0Pr2oQByR0oktXgSWiKh1dqYRS44.ZiaP._ttHU4t.JOFAC_dt_XIcbZZst_uOZ34
 VlkhtthQSJ_hSMsGFUBgxh_gzpWn7B8y_ulH_NMHNVGqaENqHuyE7OHNMvn10F_igBDv42VMMAdE
 RJmaB1EcIPcwsaswAlRWT2yHWtxK8FsEz9jhEWiJs7Vp62Wzm5k8nLo1O.CZepciVpnoDZ_jF4E2
 ahDA4Bmgjtl8.ow6PN4mLztlGg23NoKAC1fa99HYi2nCUoZzrjw4ME1Bi3F_nVJZTESwUvm1DQQC
 gG00Sk4sxoI4U3yFgTjbrHIB1zcfrxpYdqzD2w2WlG.M.xnUZQNAe7RxFkUQOVykCXO0gE.f3yvt
 bkmA8YnpeLbAkdBlEZVLSBjTIdYJlhHQmHRL.TgoKUcbhWqyLfkwv6s.TEfVF7Qqfefp9d26skP_
 KTrSNxz.LVH70xl26T_JWPwD_nMduPb7X6Mj68JH8_pHssjmiioeHOjrXCa_gglTIX6KWjW1acLn
 U3ZEVgmC1qx84DNsF9x3fG8a9L.yosiUu5izAISLd.8O8jJLqqWNQGWqcmKGTcjH8BnScDWkKlx4
 OcSFk3SiSnzYpOhh8aG6cr18sRqWZYCGPxGJx1dB43Yqjkw5HYIv_LPA4blBoe5TbopWDaTfVy_q
 oFCRvBhITjw_qNRnDlcjQLv0o0Y7qDSwYQ9VFXeJJCJpHIqhmk1CbRkkkoEj1TzIjR9dYEvGS5Pr
 p6q9pT.mTgn4ulS4j45sK.EmBVp2_jiQeYhYmJ4Ze8FQ4NNGd3RFia8xP58YJQXSKYRBz4zb90O6
 6CbjzFBb4XVEBBagUKaiGlvzUwXFMoIsDGXbVOpO7LbzAIQQW80GHiokFmnu8hjBjgblw_11amSZ
 df.kKyt7XG_pSAuDPqN5HTEbaZsrCPQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.sg3.yahoo.com with HTTP; Mon, 23 Mar 2020 10:36:26 +0000
Date:   Mon, 23 Mar 2020 10:36:25 +0000 (UTC)
From:   "Mr. Mohamed Musa" <mrmohamedmusa739@gmail.com>
Reply-To: mohamedmusa1962@gmail.com
Message-ID: <1642261289.388477.1584959785476@mail.yahoo.com>
Subject: REPLY ME IMMEDIATELY
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1642261289.388477.1584959785476.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15518 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Assalamu alaikum

My name is Mr. Mohamed Musa, I am a staff working with the Bank of Africa here in Ouagadougou,Burkina Faso.

I want you to help me in receiving the sum of Twenty Seven Million Two Hundred thousand Dollars ($27,200,000) into your Bank Account. This fund was deposited in the bank here by a foreign customer who died accidentally alongside with his entire family members many years ago.

Nobody had asked for this fund till now please contact me through my private email address: (mohamedmusa1962@gmail.com) for more details.

Mr. Mohamed Musa.
