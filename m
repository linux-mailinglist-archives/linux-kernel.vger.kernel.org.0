Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEB043B60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 17:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfFMP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 11:28:31 -0400
Received: from sonic302-2.consmr.mail.bf2.yahoo.com ([74.6.135.41]:45825 "EHLO
        sonic302-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728935AbfFMLa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560425425; bh=M+2BQM2x3GSy/dmtDG0o07y3ZYWK28QOQCLRz1DcS2Q=; h=Date:From:Reply-To:Subject:References:From:Subject; b=mUZQO9wBzaPRbIIhxUQRmh6eLT2VU+vOg22XjArIwTuJ07AFc3gMpyNJenNQN00zW+ltZLfSSR8NAbX6wxfGA74LVzLROmS1EnWmzZ3OZnFzMC54Ug7Cj2V1uRCCCE808zMsRFXP6frHrpgWpKaMMJF6St2kGvrwsxfX5mzpIFRsqMXs8EUcRyXAApJWTgGe0KElljleE3r32oMbC13qg/avJLOAeDQIf/hqQHq2TpsoUkE4hPoL7An8A/v8wepyeAQwXyXDWmguBtNTJ+k6iCDAl8It9KkUCc/zPL987evHkHVCnNhB9/5AMScqNpdloUBHuMYqKfLMmGlieRVEVQ==
X-YMail-OSG: kCAF9iUVM1nhH_QHfv7Y_AvOrcVUkr0ClfwcllKn9L0sxfGhq5qB3PKAxO82Jnj
 Er43QqmyRBvzqbdHLxX4vAz8ijtDSFUg1pcBG18jbn44VwmWY9BeveqfPmUl6bcFWG2nAo.Z.vUy
 4twcZv0wPjAO6LlmDClzG2NMjTh6suaiw.CjBmL9FbDUhpat_uHwxq.uIOC7PqcjfOHjemm5zquE
 SbysU4P5hsDzkwlx_ayHpJ6lAY6z75nFUolJ3ZUZttz.yVl.6JOjbUqiqUBUHu2UIqRD6mXOPtK1
 lknUz6iWfJkTFZI9IcPYFzEr_m6VI_NaHBNE6UFq0e9oiKSnw1794gHSpE7bKZ3T.Q4zUCJpZIF.
 xWk_j0wdKZUsooAdk68G74V59vVOoZNFeyy9o6W.gzeVY.l8FCUX_iLwspZwVRPPtq.919WorHUu
 NCPDgPA2_zNaMB5P4cNuEmynRfNSJWIMdmhD5UiJXGS77HOVs7H1QccIpJb0dHrah1nO3w8Fh_LH
 0TZTasI3h9X95y_9Rf2bdI.Z.ixY2bWaNyNaJIwmCWtSx.RSZxZflBoOU4XaJmH9eQFtjHHzFq1e
 LpLK5ExsEeZaaCjbbK_zL4AHSDYsrF1eViWsee2moeBjEKAQjiwRzjAcokx3zyOHx2.iNepgp3uu
 KQHelgrcDUQX7kdf1n2KAAI7_T0uVju41cVo_vT_k4BDCzQ4fC.o4_NKu3K7BHW6hBOdpdjheRWk
 Zzm_bjEb4MKkTSB2xXJ2SKRISxAwBLy6qZHTk2W0vv2nvoyzANPTCYv4r.pQr1Dl5sQgzhNa_0MU
 Opek4zkyynPt.xwOuhFG0Rao.UB_bSjYurZM_U5PRdhRTPw8aLOYp8HqmwYPjGH4xnk0fZh9JY6X
 vdFTMB57Kk3JCPGX2tRJAkfmwimrHXEm.UEFiA3_nPDeTLzIGN2y0VS0PWOdZ3ZP10QR7TvrfVwL
 83vTnP2qrqE_gk2vTbEF5fQpBuAAHScjKllCZXCVH5eCWS.AA0rBnA9y9iEaxgmQuxynWC0oZe7g
 AoeQLesb2XKVRvXg01RxwHUpZP7QFIhN8wVGebjOZBtrv.7dD2UjsMyNSgl7IFONaaQWcSGDpiiC
 JypkTy_vu_5YVnEOvqqXZ2oy_78Jg557kyMAkSPIabWVEQgizCKUtZDxSKiybEmGKDmQf0XEiUDM
 lO4yRkfHMfJP3ScD_bEXtyzaoCxoeWZS0Jr1_MU3Z8z611C105QA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Thu, 13 Jun 2019 11:30:25 +0000
Date:   Thu, 13 Jun 2019 11:30:21 +0000 (UTC)
From:   Aisha Gaddafi <aishag637@gmail.com>
Reply-To: Aisha Gaddafi <gaisha983@gmail.com>
Message-ID: <507712907.595920.1560425421058@mail.yahoo.com>
Subject: Hello My Beloved One, i need your assistance
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <507712907.595920.1560425421058.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13837 YahooMailBasic Mozilla/5.0 (Windows NT 6.1; rv:67.0) Gecko/20100101 Firefox/67.0
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
