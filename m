Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41EB2198C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 08:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgCaG3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 02:29:16 -0400
Received: from sonic314-21.consmr.mail.sg3.yahoo.com ([106.10.240.145]:33066
        "EHLO sonic314-21.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725809AbgCaG3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 02:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585636149; bh=YdDyVS9QBRPCiN2YYZ/cryZSa6YEXSJJY6ujWZ06LZ8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=ByVTUm69eeF1CJ3uZkZ6iJSnHSYlEO7Wbndh5pIGJleBdCAOOtQ4cncG6GGdKgiBhVDClJGN7uRhj88n6ejGYyELWmoLdNfrxSozQEmTgvNLFKOgF7nCITY45dCNTtKeoENlpnPrqC3+yru1x2wj0Gprof9qRdrdckpWlGebMK1bze1SCvVz55QcB80UekmxeM/+pBbKSS4WSig/9hx1s60JnpruYhI+euB3h3GzjeohcUPAwxZethN6oT1LnPrdw+WeDO2Nl0eTeSbEWy+SvFYKb4jJjePUrQNrbIv6pTHF3TkdvoK9MpQynx0moQ4WEy7zhW7a1L5sMqD7faMR/w==
X-YMail-OSG: swHMVJAVM1kIwwdMpzsINOd3NFK0hCnD39cdYoUGmOmPH.DtekFM15mQGnjEiIl
 1guh0J2wQhFsAf3iNQbgrcgGwRwGuLuvmxGMTCsSFPnJ.uivIEGF5KySfPNdr5Ukb91GQh.EYquU
 HXh1nVsJDZDApsk.uRyQl5rRdUyqYp6qH3QfdZGZqe37HRvZlxZcKmQV_xuW5cGCeyvJWcdGQjXO
 IM97Yd1fPYfD5oRLMBYCV8eDrjfkykOzD0IUg.QyljnKLYeuELgUjkVbRHRxmBWyj9Vh7JqowItQ
 NPPKD9rPrp5EpuBKttttK.TTWT7IuGQuekylhZrBltGC_gUSu.C4UawoW5LVUb1XpzL04nKoGm0d
 9iECf0H1vits07qaEpfNqEBw4qVaZABVQabCAv9haeV1cXXT0cSQHc3eOv6j_8ayXBoTZhqLXuP0
 w6CBDuJk4l1HIl02qifwDzpN12ZhMKOd8ZxKu9bp.P6v.HxLOYZScLBnFfpd.iGVy4Rfovx3hoP.
 RzBcTZSN4IvJuoTfqTW6lhP60YxQHxWfgAduFjhhST5o6T2Qp815ReidxMT1OG6f_PPNb._.gUCh
 TjEBhMx6yhrYERwYS_qAuJafkUFum34o6PbGWRxj5fdwirMjmLwHD3x1fDJozaMbIkA3RZXt.7Ar
 wla3Fi_4OR5KhZk_P9d0maO3H2lJ6eljoWkyhaa_AsPnM3y.zMCP5l6mIVc6x4ThOik3Rt4Kc.Ym
 GUZH7MVMjDqejYrAoaQ3gXvJnqyIrt4dxjv0IsosBGsVtyl7BxlCkrky7MW6kJVU_OLVZUPc4tQ8
 7MVP1qrUUGi0xgLjV1VPlhzkZTAzStEjRmcubnOw8dWnN4XDh2MWbOHALSyKschYe1ArQ3E9W4eT
 ErboVBbQSAJ1wZLkIgtjq5ckpa56uLYEHMKSHJhhlf0HMB9YXA16pp4Z.y67UtkLng1EIaIPr2PY
 uczGhs5kln9jIeYeD99bKMJ8Z7EG2I_UlDINXzm7XjC7obGXj6uVnrzhZfda7eMIuvlIRejvKeLq
 fPldJZ7p434vfSDXKLe0jYcOJpZSkrKLIiz95JS6H2JwrlmZG9UKVtw29oUzLBLYLYDfEur12HqF
 A4XK_j9mqaKRhVpWzMFLpGiLthh4G.2lvbhoDCjF4Htuqg13LvUkr6.K2GMdmUgCUHvac28lamsK
 JVN.JPvKKrlGodj27.i90R3lq1jhI38dG7LmPc.a1KHKHhDddTC9rgJwI61cHvx90NlNJUW1OcxS
 sOALI_zH7QqsHBGGliy2ADKzXZ0S3Dv15L5u2gcqrJ1KVl35oDy.I.PywGQSDrEAcokyyJelXq.r
 4zCFnYDd7udIO8z9zGMFQeg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.sg3.yahoo.com with HTTP; Tue, 31 Mar 2020 06:29:09 +0000
Date:   Tue, 31 Mar 2020 06:29:07 +0000 (UTC)
From:   Mr Moussa Dauda <officefilelee@gmail.com>
Reply-To: mrmoussadaudaa@gmail.com
Message-ID: <465919842.877221.1585636147637@mail.yahoo.com>
Subject: I await your urgent response immediately.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <465919842.877221.1585636147637.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15555 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:74.0) Gecko/20100101 Firefox/74.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Good Friend,

Good Day,

I am Mr. Moussa Dauda, Director In charge of Auditing and accounting department of Bank Of Africa, BOA, I hope that you will not betray or expose this trust and confident that i am about to repose on you for the mutual benefit of our both families.

I need your urgent assistance in transferring the sum of TEN MILLION FIVE HUNDRED THOUSAND UNITED STATES DOLLARS, U$10,500.000.00, immediately to your account anywhere you chose.

This is a very highly secret, i will like you to please keep this proposal as a top secret or delete it if you are not interested, upon receipt of your reply, i will send to you more details about this business deal.

I will also direct you on how this deal will be done without any problem; you must understand that this is 100% free from risk.

Therefore my questions are:

1. Can you handle this project?
2. Can I give you this trust?
If yes, get back to me immediately.

Try and get back to me with this my private email address ( mrmoussadaudaa@gmail.com )

I will be waiting to hear from you immediately.

Regards
Mr. Moussa Dauda.
