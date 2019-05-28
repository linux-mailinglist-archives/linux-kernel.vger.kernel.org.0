Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61D42C17A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 10:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfE1IhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 04:37:11 -0400
Received: from sonic312-20.consmr.mail.bf2.yahoo.com ([74.6.128.82]:42225 "EHLO
        sonic312-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbfE1IhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559032629; bh=tPMFdTY+0vCEHEJdls+8ad0RGQoZkRGbQBF0vnIRvYg=; h=Date:From:Reply-To:Subject:References:From:Subject; b=hE6RNa1pAEP8Wz+7orRGbO9okjLovRx55aF152AvzjXp1dBZzs6KiKrBrDtDJlay1rHFmjeRqDwmbqHWY6Y1439jl5Y4d42VJco5TQbvgf35FnowuzDGYRwelkJdVjNgm769BrXNs9lnP1PTEbKVs7gMusi/nZdy1p6qWLvMKcMaNqOHh0ltSCtZjhYIs6/jR+cDdYPZhzgAnQDDjaEydZYz2ZucVDuqL+BFpgB2iKuQpyhgAU+9XoN7a8DyhcvsHyZm4xyPp4TUQ/wb8KMJC3QBiNk/fW8SyDnRiRrGpN04m0ZHi1ru/W6FtTM9REHRruhzJPET4hnhugCp7T8myA==
X-YMail-OSG: W._gMq0VM1m2mgIMUSxtGQXXvbs0qOL7BGw1WywoExvTOl8TKU2eHSrQ9_mcfp3
 Zy95HIuWIrvQdRGU8b7rGYkO8axoLFNHQsSXKzAGQ.5Kr20PORUlcLk36NA1.RzTSyetrXIM84c1
 .AWgGv41uCXYgcdmQye1GQxEm5IBYs6Ztn31yv2RLbBvEtJfQcRc.D8D_PNvwdDjnbLzV3UgrTul
 kCfjr3CZ5Epj64HUywPHcaV7FBk5oehyaw1sJa9GCE73Enk37vyb0PlrzaHc_a8yy2fE6U7cGWVn
 n8Nv1hcssqql_kZF1cVE0UpI8fQEvotteOEDOVJ.HratlJsgeygdN3FLddVNTKtRfekr.RG9EB9i
 9VeGRzzxwwFSlVu2QsgsbZKOTesTFCedNYyWQouxAN50z83QM3uqARz1cIddy5nExjaxsbuTZ24A
 Sm8hbhLOGzVpctaaJHZnsjYzSKtX946uJx9i_qnsDVDGsKEEDVyZHEqO9x0b5arZur3w5ZHqrzvM
 eYom9w8fiN3lcOQ8kOZ6oTlpoldEyxrX0fHmKBIuOFS4mzkhqOGVNhXbFFI8vS4Yc9vuju9JggbL
 zVHoV3gWc05jw_7jugmCYNKhBxXsJuJTDUPGaOhvzPMthS0rhXC_dBICJW4bP9_BncisANA6pMBW
 KlguWxrvt0pgYuSUH7WnO9NQAtqm3.98NKxtoBRtXuTq4Sml0JBWyxegEZ92gvrFLlxgv7GFh2La
 gNM2ESa0iT4nfg5n_Cd5DAAoLnzi6_6rPy5g.sH_bQ2g_8vEZZsoGAACWCn39DB81uxUDNFz2Ag4
 CXDUF.5nUeAhZsUX8ElayL7xHGUUWEsGONzTAlXbReOxqRaKuVmQXtwmRGuU.o1wZCzpVWSLLvjh
 8Vq0yJpZ1f2VSvLCmnLySpBnN.F0wWx6xI8nrVYDome8RuqMbzWOBzY10UQPBqXbjT1LUqYVIups
 pmNdtNVisx0ap6LQlEZqPkWQAjd20LW10abh6vsFyP3yQ7oHlnc4rlT7YC517DeLpdL7p3iOrm93
 wzMYSlkStug6.qGzIihkGZWrLhDwDxjcSSHxuTZiyztu37DEB8oKmL4d8eSt82X_VfYnkEQkH9Bh
 W7ohLGu4zqlhA7QWP56QT.lCjx7DWrUAZtoSWNNilhivB_zrgGVrfkkPd6gtO3cI3zqs32e66mbO
 NNKZZnNaYv19SiFb_y4fLQ3mPciu_dMoYs4TEorH4oNm2RFeMJn3WFkM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Tue, 28 May 2019 08:37:09 +0000
Date:   Tue, 28 May 2019 08:37:06 +0000 (UTC)
From:   DR Rhama David Benson <bensondrrdavid@gmail.com>
Reply-To: DR Rhama David Benson <bdrrhamadavid221@gmail.com>
Message-ID: <2802253.5593824.1559032626895@mail.yahoo.com>
Subject: Please read carefully,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2802253.5593824.1559032626895.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13634 YahooMailBasic Mozilla/5.0 (Windows NT 6.1; rv:67.0) Gecko/20100101 Firefox/67.0
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
