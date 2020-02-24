Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0244716A46A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 11:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgBXK4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 05:56:16 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37307 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgBXK4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:56:16 -0500
Received: by mail-lj1-f194.google.com with SMTP id q23so9575140ljm.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 02:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lDf/2jKoQq0tiwN4yvaRqNKhcMTgJatZlaUy0hnS+Lk=;
        b=Z0+5V/tFSjxEpTM1SXDFW8kXWg2PaZVvBJP3Wc3PDv51I3MdIr1N5gb4uoodRM3x5k
         HKlOM+WU0kEpe5BQp1rG1I8C6v5SSxVVAjw860xE9wbt36bIHqGX57M2Kvj+1gz2puUz
         x7nD21BuKLY8y1WL1eqEPpOYmi8i2jZ4nNmXxrtFSzjG8cesJ5UXHNgc+Lw49QM0wu8k
         auZu99B2wdvZ35CqCbRUqmes6GNvMHWK5qaOCW64BykZ4/xB3NoA2lASnXp2sjRr9zez
         7f0IYeq0T6GDe44E2fKUfgn+R4Hrc78aFCCd2Lp/1j8T0DJcMPgDfjnPcyLzyxE6HTam
         Vg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=lDf/2jKoQq0tiwN4yvaRqNKhcMTgJatZlaUy0hnS+Lk=;
        b=r/f60iEinsUrcLoOJTxXn5E9WOr1SIJBMdqXfhiQrla4+hPdFBoP2BYeBF05FMDe1F
         fnD5G9mzq+Q9r21sPnbXYIRJmVGZ4xtpNizgiY4SQOatarEb/QelEcjJvwhx0ZcY2auf
         jRqZOk7A2rfA8VL4PVYqbW8GjVZ1t8F1J+OV0H9ENlTSqFQ8MHhyIdgf9fAZFdnY/zgy
         k6P6TIVKHM3hvvott3wDNEOoiM7BwbJFxPF22dEcC2otiD8fYjPhzwggduWXrWxnPTUM
         BsibKjHtE6rqUfU2OXfDtyshr4jiEw1L5imf+V9abD2OnYJ4uT6aQj/U3Hu9BO31dSEn
         6l8Q==
X-Gm-Message-State: APjAAAWiUtLKKqqZrknbjB+lelJAK2BetoUOEbUJExmbkPikhgIAhl2b
        9pNdZcVUeKobxzIaKzOk0laj8X93tAxpLUlGdUE=
X-Google-Smtp-Source: APXvYqwdgyE+ZJwY/Jh0qKPqtMy0uMTzGP5tT1B91UE/h/Yvbv2cwQPkaQvYEwmAHfwnmyTIdtgIcq8w0LxZnk34roU=
X-Received: by 2002:a2e:9284:: with SMTP id d4mr29427051ljh.226.1582541774161;
 Mon, 24 Feb 2020 02:56:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a19:5051:0:0:0:0:0 with HTTP; Mon, 24 Feb 2020 02:56:13
 -0800 (PST)
Reply-To: ummel.investments@gmail.com
From:   Abraham Ummel <lordsmithneuberger40@gmail.com>
Date:   Mon, 24 Feb 2020 10:56:13 +0000
Message-ID: <CABMO8_tBocHBHheaQYiUd7r+n-38Qz_Ko5WzCVKuaEEu5=D5Ew@mail.gmail.com>
Subject: =?UTF-8?B?5oqV6LWE6aG555uu?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R29vZCBkYXkNCg0KaSBob3BlIHlvdSByZWNlaXZlZCB0aGUgZW1haWwgaSBzZW50IHRvIHlvdSBl
YXJsaWVyPyBpIGFtIHNlZWtpbmcgZm9yDQphIHBvc3NpYmxlIGludmVzdG1lbnQgcGFydG5lcnNo
aXAgd2l0aCB5b3UgaW4geW91ciBjb3VudHJ5IGFuZCBwZXJoYXBzDQp3aXRoIHlvdXIgYXNzaXN0
YW5jZSB3ZSBjb3VsZCBnZXQgbG93IHRheCByYXRlcw0KSSBhbSBpbnRlcmVzdGVkIGluIHJlYWwg
ZXN0YXRlcywgaG90ZWwgbWFuYWdlbWVudCwgb2lsIGFuZCBnYXMsIGhlYWx0aA0KY2FyZSBvciBh
bnkgb3RoZXIgYnVzaW5lc3MgeW91IGRlZW0gcHJvZml0YWJsZS4NCklmIHlvdSBhcmUgd2lsbGlu
ZyB0byBwYXJ0bmVyIHdpdGggbWUsIGtpbmRseSBpbmRpY2F0ZSB5b3VyIGFjY2VwdGFuY2UNCmZv
ciBtb3JlIGRldGFpbHMuDQpCZXN0IHJlZ2FyZHMNCkFicmFoYW0gVW1tZWwNClp1cmljaCBTd2l0
emVybGFuZA0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09DQrnvo7lpb3nmoTkuIDlpKkNCg0K5oiR5biM5pyb5oKo5pS25Yiw5oiR5LmL5YmN5Y+R6YCB
57uZ5oKo55qE55S15a2Q6YKu5Lu25ZCX77yfIC7miJHmraPlnKjlr7vmsYLkuI7mgqjlnKjmgqjm
iYDlnKjlm73lrrYv5Zyw5Yy655qE5oqV6LWE5LyZ5Ly05YWz57O777yM5Lmf6K645Zyo5oKo55qE
5Y2P5Yqp5LiL77yM5oiR5Lus5Y+v5Lul6I635b6X6L6D5L2O55qE56iO546HDQou5oiR5a+55oi/
5Zyw5Lqn77yM6YWS5bqX566h55CG77yM55+z5rK55ZKM5aSp54S25rCU77yM5Yy755aX5L+d5YGl
5oiW5oKo6K6k5Li65Y+v55uI5Yip55qE5Lu75L2V5YW25LuW5Lia5Yqh5oSf5YW06Laj44CC5aaC
5p6c5oKo5oS/5oSP5LiO5oiR5ZCI5L2c77yM6K+36KGo5piO5oKo55qE5o6l5Y+X5Lul6I635Y+W
5pu05aSa6K+m57uG5L+h5oGvLg0K5pyA5aW955qE56Wd56aPIOS6muS8r+aLiee9lcK35LmM5qKF
5bCU77yIQWJyYWhhbSBVbW1lbO+8iQ0K55Ge5aOr6IuP6buO5LiWDQo=
