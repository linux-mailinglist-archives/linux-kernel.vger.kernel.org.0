Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B312712A15D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Dec 2019 13:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfLXMhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Dec 2019 07:37:23 -0500
Received: from sonic317-28.consmr.mail.bf2.yahoo.com ([74.6.129.83]:46323 "EHLO
        sonic317-28.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbfLXMhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577191041; bh=E+ks7AydzaUb4ISZTuxin7s0E6gVmk5020fTLYVYB5E=; h=Date:From:Reply-To:Subject:References:From:Subject; b=emubtj4TxrNdbMzPcOrgauPcikhhyNvJzFOJTx0ThejujqB7CqYUccjV/E/nNZH6Oy/n6M4p7j4AY9SFCbun5e27fgHBUg/y0Lj3/gIsizsJWwx85+UeJhPsxJyRiMP1XpZIhdTc7JS8wEuRVCbnylb36UEsdFyWl0z+Ykr6FWxibfLx6ep3YTalsJZE9RaXwIYy4tChDqwlXA7IQ+0eODdn6FDBTRaeAESJa6qywMZGpQpUshFu/FHp584a7g3pWvfsOX8CalZzaqi3vwVcwS3AkY605X2cpSihlvNmQI0CsRyFvz9G9IzlQPW4EdFjMqnEW9KBsFPeexbNKfg5iQ==
X-YMail-OSG: RIAIcRIVM1mp9LRFSf1R2CQs1NBHNtDwP75KrzU2r9XszKJTWqNB.m2V4TBKyWZ
 TJBv.tpBtw49gnHo4eTixw.aLXQDi6gUXo6gC1RKsA8_IbWheEP2WXcP_4uH7eAJPV8fpxvzFfwh
 nOHufPs6DH.uHw7pftBFZP.pdG7m6hvsWV7tNufq6JIkJYD6kr4ayd2B5kMh7jEVXsVu9nbPoQYB
 HODxf4cdVbBIclP6Hnw6D5qvsJrVo8epR28IZYhVxJen5tuxBzmn7pLLNSgWLRJyR0vA1cjcP6vT
 1zTOYrYnLxX_GH1601ROShjcauPfZE_KJ.7n49LLExIyeqsMSWQtGPt.ph6VZXb23nG5dSxLGwg8
 zDoa_NzH17QOxTlqYrnc9RWj7xCVcC02maxzAfRkVvQtKCN9RPGXNcyII1wBowxBhEyqqH1mSxhO
 Seu4OJd94j3E9FP0.cF_yHiujHTzzlP4IDJOVd_D4AMZwZSJsNCtreUabvmW6cvmNvz1o5MzjP6g
 dsACClVbCZe10xvD11slT4F0MxBRUn1xMSAIaqIklz.xDWqLM.srxICqlWI.ZE7mfNaacOnpgJTG
 6PlV5Y_v6F7Gnh2f.RiDVKE29Rp4ySdo30_xTAUUu37t0jTAHTKWDSb1pm.DP3khGam4ntZ7Z_eI
 csS30t84.lmbcUgenKiNmNFdj4UEv7nucLIeFf9f8TN271WC2KTKydYzb1t5uZ_jajDvqpoV_ubC
 yoJv9hdYisfYjD.NWawvFd2ePxoA9jIbvcx8jNIbZx2kuum1mL_OdLug9qicOOAN4jB_9heyD8L2
 W7Tjz6VeFO6kb_ic2xNTWWwSLNkip86ZS4KctUd5JzqUOo1ss6c2ZxmcHJh99PvB2OL9SvbwJIJZ
 zSIOPex_7I2wLfwRTbGmVPqc_ja1iwZoElBG1vdKBjK2vEVWMJUYa2GDp94b3nwvKtsiDg7Nmfna
 K5i0cXudbGs8mpoEyDf3qdHy6z4VUMZ9CUqpaWt4notjNJcpszVSJMLpT5oUroSUQBdAy5CzgZYH
 fE6cZ4Hd6.6NLRASAu4.H1tM6ieGZCBoFSb9.po3ykJlYzM80.vmfMlEBJkMnUNosI80JV1u8iJh
 JdUpl9P4kLiXWvlk4kJ1_wQwJbsuybwDjfpC8_KzaaPQF1F9Fg59auckC8YHuJOASkYPhrM.UU8K
 lvOZBftaHLfxR9OceuKblPZSSlNWkMXbjU6i8M3Zfwm17r0FpxVZwWNpJyJ05ho7Gx6ZnQqBuj9w
 Ky2uXnVLL5bE2XN92kJZ2KVLlnMZpV2FWane5YOj0PIkkSEx9JhBd.B8WQscI3Bb11.fovgQJEvW
 Ddq0w.gnI_cPyIc.NdOIbR8JIVQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Tue, 24 Dec 2019 12:37:21 +0000
Date:   Tue, 24 Dec 2019 12:37:16 +0000 (UTC)
From:   Aisha Gaddafi <gaddafi661@gmail.com>
Reply-To: gaddafia504@gmail.com
Message-ID: <2062665538.2049439.1577191036197@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2062665538.2049439.1577191036197.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:71.0) Gecko/20100101 Firefox/71.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaddafia504@gmail.com)
