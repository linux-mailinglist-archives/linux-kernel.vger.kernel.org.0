Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE87E14378A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 08:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUHZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 02:25:18 -0500
Received: from sonic302-1.consmr.mail.bf2.yahoo.com ([74.6.135.40]:39280 "EHLO
        sonic302-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbgAUHZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 02:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579591516; bh=AOGonAn92nStPthnxgXlFu27UaMmeJ9tVgUwqWkJ+Rs=; h=Date:From:Reply-To:Subject:References:From:Subject; b=UFY+wsGGaSpQ7wJvtGAwp1m0Fxfx3XGEl18AqyHY7lc1L96ZVFbpST+bF1nBDeE30Xib2q8AWvykvW2TuERCp0N4jPmegV2x7/dD51tV341f5wcD5w2EqgEZCnj6Kd6bdwtCbt7Nq2p6P1CQxbIohx7/pNyz/ThzpIANbo/ZrSqvyNG4ZZKS68lgggaNVmO6HuKg5vblFqROogu3FNheMappZqfXN6F2cdFMHXua/crJZ/yEegULqs6wW7sLYI3+9CqBuFncQwe5DYmEdTjbwcNqrs1dz0Kd5zXsBBn12RylHd6Z2UUQoLjW8hCIlXgPBYkU0TtP9PEbL0YmVPA71Q==
X-YMail-OSG: ATnMXh4VM1mVW0rGzIkeRgmG9tL8z0lEGdcu3xMf.C1LcECAMAw56zkSjA5GQWa
 YsTyzBi28eTq1Hx1BwM.Fpklun8SYVjLGdq9T9B02ufULXDI7biZjuLoyr1PV69ySWSD7vrW9CPf
 7vk4i_KRPaY8ioFlZktfFD7pfylXPRnikydrPFWXHmnXVjCySmHsS_wtyCYXYm6vFh0NyV_FpAAv
 jCdD52JKyahu_n9rb4GiKA9bOsjiZcq1hdoQru2GRQ7VTVRZXGwJru7WorB663Q3MykpIZsQ8uZf
 NvEq8fH29tDtLcDXZxTenSv.AHaTT5lVWx1J5WSbAb610kLR9Upm6DJF65NWaz7VRQm5Tr9pEHEt
 LXWw_Xo4R_WljTiOr3yqVtkdm03SSyQKotXIvi.weyVOhe0zoBjvIr5A20obO1P.oikY0VnKU9xj
 WI1tIkCBcSzIrRpnsJ3rSPEryGHIfEu40vzB.GXpa6lbxvWP.eAI7INp0O34vkt8zpKxEeD0vHr.
 2tyLRg7aEFvwKUfQ30aGPbkqamjiOavGYyOsM19jCD6JYuXP7d2oS72T1UiXkZy6nJLwDiL1VPP7
 zl6PzjQkAblkQlEt0a2be_5k.4jYG.IO.A_Pgt_fnOGilURK_93EzA7gxat7QysGnjbipKmX5_c8
 gklcJa_q0kE6JajbBvio.6DWkjqkcti98N1OQxfFLK6GeIoGXwmo1n0uL5.ZyBcoXZNNI3B6CBe5
 MnZPrvjpVXAV8Sz3l3L7s2ZSWbe5IVIWbhX_qlB5Yg7zY39DfdcprVNp97wklmhd.fy2yeXDsuTn
 YG7Cz8_Oa3exr2KxDkpSDKP0tehWsn1qs9pVc0MHfkBYFyDNEZgtiyQzUYs240KB7Cn1GyPYjH_x
 pdq5Ez9GHVo3FIxD8yov9D8CssnkMHT4HriNXPNqF6ifvdmJFi0ItQ6P_UyyOPkNxch2m19kIRDn
 ZE00QownbdZHNGJMofRtyw7PaE0Jy1z99H3mmgCBHEB_11ISeFtJv.oY0uYMvn992WC38L0p1aai
 Ji_DMzqkb_6mvNGNnqJPs3PqMIK_Nef731XjNcuZgN7X8aVEL6pt2Tk6IAf_jzHGQUmShrtwF36v
 tW1pxFQpN3V_oAmORQqif3DdD32gkBpMAqQIbuFqXcBmqzAcLMG8urKqf.RfXYs_Ptt9zfwCcY_5
 P2WNbcMfUIlfRgYEFCV7SPNun1QBeJ7JlU_erSkY_s7nN.sgzapl958v4i_tQqeIPPWArx24TSrt
 Kl7EgMCyuRpohcDHvH_I3_JOmz3.r_NhI4UcorJIO1Df4PcnL8RRdjQIEKxb_qfrP9XdVy9iOJm0
 vAXQo3G69_L6RFp8NfCLjOYgXNynO3KSWFQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Tue, 21 Jan 2020 07:25:16 +0000
Date:   Tue, 21 Jan 2020 07:25:13 +0000 (UTC)
From:   "Miss.Amina Ibrahim" <ai262034@gmail.com>
Reply-To: aminaibrahim0007@gmail.com
Message-ID: <267202765.9781067.1579591513342@mail.yahoo.com>
Subject: Please I Need Your Urgent Reply,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <267202765.9781067.1579591513342.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36 OPR/65.0.3467.78
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Name is Miss Amina Ibrahim from Libya, I am 22 years old, I am in
St.Christopher's Parish for refugee in Burkina Faso under United
Nations High commission for Refugee ,I lost my parents in the recent

war in  Libya, right now am in Burkina Faso, please save my life i am
in danger need your help in transferring my inheritance my father left
behind for me in a Bank in Burkina Faso here,i have every document for

the transfer, all i need is a foreigner who will stand as the foreign
partner to my father and beneficiary of the fund. The money deposited
in the Bank is US10.5 MILLION UNITED STATES DOLLAR) I just need this

fund to be transfer to your account so that I will come over to your
country and complete my education as you know that my country have
been in deep crisis due to the war .and I cannot go back there again

because I have nobody again all of my family were killed in the war.
If you are interested to save me and help me receive my inheritance
fund Please get back to me aminaibrahim0007@gmail.com
Miss Amina IBRAHIM.
