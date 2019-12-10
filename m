Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60D118388
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 10:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfLJJ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 04:28:09 -0500
Received: from sonic308-1.consmr.mail.bf2.yahoo.com ([74.6.130.40]:37938 "EHLO
        sonic308-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbfLJJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1575970087; bh=6u3qDl6yXWBH9oVBF6VmNFaXPPfmaUEmS0LDo6+oXlw=; h=Date:From:Reply-To:Subject:From:Subject; b=dhcTzaJXlImAv1d9IOQLOBYVfq+a6/AtxxOp9P/3QkEqj6c+D2grGSMjitMouQ0uvwLDXVlgEAq0FbGsnl4HHtYyyeO81fyAEVSFDVFO722agYsA2s+/9qxFJyRHVBRSV9kV06iCQkD1c5GM69VxnkCbzZ/Y5piCnOFQbhe+32rgUjRmqRJHiNgBwosrFj92b0uzEMZeRqpufh1NsTWbdhrrmqq20lPUiAKOL/XysZTubimvGU4KL4WZrn1cssgPohfsDLNlhvbB8O/tNSpcW/7w9wmAkaZrfpgcKq+mgBhdE6F46FvVgdcdvwEnUlkSdkBbxqzISLxqKdY9IOAS+w==
X-YMail-OSG: OSSOpdoVM1lxPSsJsQuamg8PWxt_nl9kUhSoHmpm8iDHh5ELZSq8LXomBVti4e6
 1o6XN1wKXNCHDX1h84pxd59KhtNN6wwWQjyBJV63jXWi.fVbHSvimvylLSNXI0EXzYT6eNgsJB2G
 7wOuXpAFFWoAUJxMlmfa.uy34YHoFAprNrPkRE3G2Fa4DUO80r4PIgK7IeQnxQYMVxmVd22D5gyv
 q8YhwRfTOl7rvNrAu4W6.BufzucNM9b._2eKU8KgyPQ0ewsod.CxWXTyhWgjBOWieF5WXpbYy9jF
 pDAVuIFJbvq9y2_DJWWn_SkHgbskcz47kTsE0kMO.0DEFWgMYnWvyYFYAZhh7VTfCOcatu6U60aI
 a.tcVQ761gGF8fpF_YbZFoGu2jsyEG5Aw6ops._1cim5hEQrm1ib8H6CVSrZaCVXJvLIvMJS9ORk
 pAxC5ee9zmDgQJoT6s1PEvDdvnNIjY8.l.w.KxFdrf0P.Gqo0KpyeiwRtWlzQj9hbcc_mMq0MSA7
 pR3jyjkc.J4aIk30gFuD3JGpDvf2n6iHK5ture80E8rfC59.ZvOqgJgtyhSePe448KBo3SnOlGjt
 hGBdCqboFpQj1U95qMI2WcrJzXWKHTERTmKY_bqqxT8U5uCYDgSN2bxXXdfQxojeoP20m6Vsm29h
 z4FVszR.tBfVL1OXNLbJKAb_DKp1Ge4bKKvro.tRxVNopc5nNLZts4UuecAs7TPxasZQdKPyB2CV
 1Xz.joUrIFeSprUbX9znsd4HdYIIhNYFjM.iCVaN67nPiBbD6fiLTuL8ks58qk0EwsTatI40MErL
 fCo8ssVWnxyy_8AQ53S15ngZ7XM7EyBfLi0AJsX61HP9OlxjUmg3Mp0DsqnBP9jf18goEs0bWBsg
 P35NreS9Eez11c7nfJ78OTKxPuY_bM2qM2OItUQnhqWQZUK5rQEDw9bfdKuQL8D2oHgbcQxbQYE0
 ar2tIAOX2nb9SaJpXa4qONUB.cTuwCiam7DXdKqlCrY0vWs1n7QJfpfRavZGGnyoYSSKGu28YS4j
 JvTy_hmrNrAgGZoMT9HGaFtLINIiPQvsoyiq7Zwo5503rT6c6Ugl7EPrbUEd.PgnxnN5Qf3L2Pd9
 .11YkxWyDG_hTx90duIqWYn.6QkWXWwCp1zQB3Dwk1vR1t2j_zp7OdgKiivVEpNQ1X.xqZRw7NXB
 FUmB97KCrOJAG7AGMp3Wv00ExVMdsabj3S9Vh8o38GsEkUyfercYXudG4zWYU0K3RLYPDAMt4YCS
 dBqkjCWF2fd7qlyFUGEwvU5zl.ecWhAmA_BKqa5ZntkKLrxpRuPZFUHk48OQ6jF8mwDOO5ay7yqH
 VDZiaUA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Tue, 10 Dec 2019 09:28:07 +0000
Date:   Tue, 10 Dec 2019 09:28:03 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh222@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <2044225484.7405135.1575970083815@mail.yahoo.com>
Subject: I NEED YOUR HELP FOR THIS BUSINESS.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I am Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment and the amount is (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me after success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other .

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa Hugh
