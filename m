Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA8AC7A804
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 14:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfG3MRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 08:17:42 -0400
Received: from sonic307-1.consmr.mail.bf2.yahoo.com ([74.6.134.40]:34570 "EHLO
        sonic307-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbfG3MRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564489060; bh=VH+ayjkfgFOnVs6Itm99bu+e5MnqUcfnzJeZ6Cvpeko=; h=Date:From:Reply-To:Subject:From:Subject; b=lYwXtktUXQe6ygHwqPM9j7YroGPe9NmCT7drQNRdRt5OOztwRmuBW85OBpldhFd5e6liBUvpP/NDmvMQ9ih7cCOENGV0KSyZf026A06TBA2OWrWPv4oY0J4p3uXCjpCPY6Z4i3YY4zkQKf74LnB/MEC4V4R1YynCbbkGQvh91mwGr3GZyeg7RDhdDBpCdd5FI+98W6USnzb1sOvhNzkcaIuETr6JAjTzD6xE5/cHa1EnVIis+NPED2rBbWheyBDOylUvBshHDiuZmstVgOpJnhUcHXqzcVuKtXDvDU3tIdiIITwfyTfKRxaiP4nwPOndmA6N9MT4jFEPNpAK4Bspyg==
X-YMail-OSG: G4MfpqsVM1kUYNdtMhOZsErLrSLEgq_0ny5AKZ9SYHI3OYvaiTGENn6MHmcYYCc
 OlfnlTQwTcNUebDRjbkT5U5pBkEkjzUlcOzffFVlcedyVGFzTsMpuPpJLKgZemj3l5ipkZjF5NEL
 MWJzYX71diIVdXzFbIn4dgx8gFqOoIYI5eGHemCfekNFQkRoVyOtKAG05I9HdPjn5lSSB8ccz_hG
 yLkaZGW3Ki6AY5d9e1tQa0gSgaapweIHLDgR8hPkZzYa36weM5vmrs0m7Hq9OaFNecHYLW2vnws1
 agq.VFWQ6ZWwNQm5MSgBzRd79jYoxDv1621CmQVKubPGfEnH1wtPtoGy0suRs.Aj_eJT5Do0h9.w
 MCkKIq.Wh1q_IcizN17kaIkI4tht0RmZK3vVkmkIheeaxa9k5PHEcBEsv_7yyhGt5QANxuq3rtop
 0OCNVLQaHN7olsTZocY2vqNL.Db5R5Uwu31BLC7yDwNTVT40bRmWGImujIx3Mg7dHrIAy1_EpEKB
 bP_jV3gU9Lbax3xtymM91dWZR9DR2eQ5lquWUoChqe19HdxK.Ei7bYchs5_XvCwMkEhubV0fgilE
 N2F5z7tNsp.BQFEIKe2lXj93ce3FD6uY1BbRb4tQ6XETSsHptili5IAoPwUrPhmmTUX0UKopY3wd
 cCsy8olV_MhU7bfKBwFuwoIAmp88gp7j4XKeAZqvHNAZeONHatcWvCgERURLhDYxJXLvkrXmazYc
 FYYi1SALX26qzuhFMUaD8mXeBZlBZEcFNvwvJCuhAxiPX3exMoAqfj9snLYDCz4t.t.i0bqqcmef
 AOsIvVSxIVujrf16FzpqP71Ymrc4GHuaAzu2iVwObTLX35Wu5mdeX5cdSbnI4PXMW0LSZxpYIZnK
 5xp8hOmuco7q1kP0b00VG4UXSEBvsNuJpw.nheWKAZUke6fFsAbHCQZAap43RIkJLjOI1iaY5hI1
 F4LLubSIyRojj7keH2DkRDQPPo8s5.tpX4UiHboUWo45WpmRq1G76z14.T7fl.sBi5jcLZ80IZys
 g3kUGOO.c0XYMhVJnPfMXElzrpRPr6Ksrl45zQPjKHwWtZY8TrgLrlNvUWX8_BDxARre7d5r3jvB
 tnFFePz4h20eN.1uoGZH.vO3R4aC5pfAxDBtYfuodQkujDn6wVUAjL3awdc1Hu1_6qxA_EXPIlcp
 CLhHi7Hws3E5m3o4ClkRMYNfQS72nc_iKB2H75wNLPPWYdvpdDKKEO3W_EkF2FM3SiBZH60cG5hC
 TVF5m
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Tue, 30 Jul 2019 12:17:40 +0000
Date:   Tue, 30 Jul 2019 12:17:37 +0000 (UTC)
From:   western union payment department <lukesanfo451@gmail.com>
Reply-To: westerniunion09@gmail.com
Message-ID: <2052179417.1523460.1564489057748@mail.yahoo.com>
Subject: Attention: E-Mail Address Owner,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Website: www.westernunion.com
Address: Plot 1261, Adela Hopewell Street CO / B / REP, Republic of Benin.
Email: uwesternunion75@gmail.com

Attention: E-Mail Address Owner,
Sequel to the meeting held with the Federal Bureau of Investigation, The
International Monetary Fund (IMF) is compensating all the victims and
some email users who your name and email address was found on the list.
However, we have agreed to effect your own payment through Western
Union=C2=AE Money Transfer, $ 5,000 daily until the total amount of your
compensation fund is transferred to you.

BELOW IS THE MTCN AND TRACKING WEBSITE TO ENABLE YOU TRACK YOUR FIRST PROGR=
AMMED APPROVED PAYMENT,

https://www.westernunion.com/global-service/track-transfer
This is your first payment information:

MTCN #: 517 125 6760

Amount Programmed: $ 5,000
Track your first online payment now Money Transfer | Global Money

You are advised to get back to the contact person through the email below
for more information on how to receive your payment.
Contact person :. . SIR. INNOCENT JOHNSON
Email address :. . ( uwesternunion75@gmail.com )
Thanks,
SIR.INNOCENT JOHNSON
Director of Western Union Money Transfer,
Head Office of Benin Republic.
