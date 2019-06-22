Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA9D4F48E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 10:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFVI6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 04:58:17 -0400
Received: from sonic315-15.consmr.mail.bf2.yahoo.com ([74.6.134.125]:39146
        "EHLO sonic315-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726276AbfFVI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 04:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561193895; bh=tPMFdTY+0vCEHEJdls+8ad0RGQoZkRGbQBF0vnIRvYg=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Fa2sDulrveNhVX5ZvPAs2LBenvSUPihMfmoxsCSL/jAKdE6cKi3vat9qUfzIblQe7T3Kdep0Fd/2UGnnZ6ZHIA94FF1wZPLg/0PXk4VJ+ANO+zRKLc3AeNFb0iaBJMFEEO/XBLMh6tCav976l7FeFy/dR+lM4s8o9g4KNCkyL37+HkNWkhR1zCBK0unGt/XsTgBnMFayJ0H0HHmGQdJgewGkPSg8mveCcsh5P0NCmnC0BTl03h+4G4GlqbVONI0O+tw/FLz1IxObx/wQoXn8zsa3vVElbA6XpFm2L2Bzysr0Pvhi6iIi7gtvGIzQXcak0dReKidPGPxlWmyXJwBrWw==
X-YMail-OSG: BAotZdwVM1m9qEhWVEek5aegVFAibZda1EMsJh1OzZ6G6XqOXmDDA01PG9pM0oj
 j1HYPoh4yf5M5uNlnx9CoCdZ.dViiI.OLKoIPQ3mUMw8tkxrEX7.HbhgdxQcG_PGAz_M2SM0BhH3
 a9pUIcGNWZP34sphUNPgDwPkAsQKixgom5BtzCNOMwfUJzFqfDtmDQGE9zmo7YLtZDPTXuy6Y5CA
 AcLS6dVX0EZXWBN8QTbqvWA40QU_Bv2b829pPmBbT.BP7a9Vb6DkwnykAkid23D2jV_3VVUKFAta
 Nwqp25voFLNCtsj8bQ75xoyMTEoYkp8nIT8YyA9bBP3LmnOK6lucjPre0JV_ltdYkNpEc3b_Pp.s
 317gFAZkZjuqTku.cTIXnLYuHdUvkNRhdb9M_2VbUnjP.W8JDFfkRKpZeh4F4j2UvDEexUt151yV
 F7XB9Xudu_X69DSZYYLZQq3YSgG_4zlx4sF16jJHxXl6PI4D_vFDNZMCyywDrsXcamp_RPinaqGy
 U8lDZ_gruVLq.AceP6M3CEmHBXgknJCRfgrvya54zQWjzrUIIalIPLZ.v1UfhSIYEBBkZ7uq7uw4
 ei0BEWIioaWkP1ieXE82lffWsRWYAJHBEFV25RVaZ85lQ9Km8WeerVCAap1D885Lv4EmI02ppW7E
 ZRxHMUf27WO9BON4Ito2lT_7WSx1Ewc0ehp4Ko74zLHlqVyP8qqwNrFeyEd3ZCblEVj7vkaBhnZM
 eNGphX8yDex39qFit0OW7X0ouScGmwjM10lO8kUdo2a.NQgbw0n_trO0o4WdNYMU6r2u9n6jIV_l
 UxBsAp1lT_NY0Lzb5MhL3JLDIdxB9kF_7.A16z5RPnZ0Tn4A2OzvlSw8qjvGSQVTdteO8vnux8Zh
 L_MVG3iYPHrm0SOTTcPMWVjUKA_ROqBk0GLSY8UDT_s6_3Bw3ibm3t1m17pNrTv1f3eiEeFLZDVc
 Q3o.HeAK4h_XMnFmCE54_mo7rM_0j4TDx3effEXPnaKU3gukWp0EV6x21gnr01lDc0NwbMRBQJAS
 AUyOqaL_0KRwFOaSzMG2wTKyeyhARLfOsIl4WWb0o8_NHN1ynY.82W8pqrj9ZYroK11dSypxt00v
 lgu3OUO.ksIv2xtNkwOSN3ITwq97qxvXeeqCIIAVaqviXcEXPyTZrvYPb9W5BFpuv3T4StBEmhIs
 4FVNgFuFlnwMhWk79DLbeyw02SNkLHJAToanzmFhh.5j2oNNzwGvpeL8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Sat, 22 Jun 2019 08:58:15 +0000
Date:   Sat, 22 Jun 2019 08:58:12 +0000 (UTC)
From:   DR Rhama David Benson <bensondrrdavid@gmail.com>
Reply-To: DR Rhama David Benson <bdrrhamadavid221@gmail.com>
Message-ID: <450288071.230098.1561193892986@mail.yahoo.com>
Subject: Please read carefully,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <450288071.230098.1561193892986.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13837 YahooMailBasic Mozilla/5.0 (Windows NT 6.1; rv:67.0) Gecko/20100101 Firefox/67.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



From: Dr Rhama David Benson,
Please read carefully,

This message might meet you in utmost surprise. However, it's just my
urgent need for foreign partner that made me to contact you for this
transaction. I got your contact from yahoo tourist search while I was
searching for a foreign partner. I am assured of your capability and
reliability to champion this business opportunity when I prayed about
you.

I am a banker by profession in Burkina-Faso, West Africa and currently
holding the post of manager in account and auditing department in our
bank. I have the opportunity of transferring the left over funds ($
5.5 Million Dollars) belonging to our deceased customer who died along
with his entire family in a plane crash

Hence; I am inviting you for a business deal where this money can be
shared between us in the ratio of 60/40 if you agree to my business
proposal. Further details of the transfer will be forwarded to you as
soon as I receive your return mail as soon as you receive this letter.

Please indicate your willingness by sending the below information for
more clarification and easy communication.
For more details, Contact me for more details.

(1) YOUR FULL NAME...............................
(2) YOUR AGE AND SEX............................
(3) YOUR CONTACT ADDRESS..................
(4) YOUR PRIVATE PHONE N0..........
(5) FAX NUMBER..............
(6) YOUR COUNTRY OF ORIGIN..................
(7) YOUR OCCUPATION.........................

Trusting to hear from you immediately.
Thanks & Best Regards,
 Dr Rhama David Benson.
