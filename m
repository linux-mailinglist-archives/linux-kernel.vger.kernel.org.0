Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE5A411E2B6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 12:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLMLV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 06:21:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40465 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfLMLV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 06:21:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so1680390lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 03:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CeeDtpjMokJukuH1miomF5Oz08aqVjt3ots/YpdA6R8=;
        b=gMiBGJcB9iqbcflF31oxl4YrsgOx/RtbASo8D6mXdis3eQEQ74u+Zif93xlWRc6aVj
         i+o7fyYiwd15KekAre3PTL/lAQ26Nimci9kVmCdx6xeUQsRrvPAWj01EAgzbrXOybFGl
         uKq67ZRXh+OLTwIGEKNdbntKVYExxDddIneGe6hKWQAAwp6OUqUXDV2oNCeh2ZnAVqQY
         Z5WimpHVOEg/t+86o9QTrXsDU6VFiEtrG85z4XdrK1Yigg50719WkjYtR2GPnKVjvTz9
         nQts7DUrKxb2tnlIZDXZwG1mRrlP0MAUyKoVK0NRjW65kVes/byI017RbbeBv5YvWovj
         LWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=CeeDtpjMokJukuH1miomF5Oz08aqVjt3ots/YpdA6R8=;
        b=Onbe9Z81qlB74hd4cEXkdHKQ53eix03/f7hPLj+Dc8uO1ftjxd3ZnQOnZcFGYTLAs2
         hwR54MjLO17gZnHT5j5WsYxM5LCLtOwU5TaWJBxuY/V8PZ//7w2U45LM5DWVU5umB30H
         ZtoQWnwiMVEbpSltqCO0Ud7PQfn/Ko2gYGWjNoCq7bweYDSNa1IfTpeyKykZQ3OxCm5e
         kvCwSSAOOJ9yx0zcgL03tzaUN98VSOXFZMQeVM8YfGlwyuBaJ0rk/3hy5+6JMZHIKYok
         R774Cd8WcffPM33OSNioatgNpqT2uvLTTAQRXN9orPw7hTkmaKV0hJOcipMkLYr27PVL
         JpcA==
X-Gm-Message-State: APjAAAU1fDx10KotbAPLnfUgYCXbOMcCiPuqT86X/D4DhkuBoNlPRUM9
        3WQk/3VqYzKvk0lGM0NC8UvPDQjHuhHnTL3ajjE=
X-Google-Smtp-Source: APXvYqx26nhX4S238XftOplVArFsT3VWokcKxNLTan+yp56BzwfnqNeIrAGRoB/mxtIr1OJGVL0cpbfPxs+BUkpiXjo=
X-Received: by 2002:a19:ca59:: with SMTP id h25mr8506555lfj.27.1576236087455;
 Fri, 13 Dec 2019 03:21:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab3:615:0:0:0:0:0 with HTTP; Fri, 13 Dec 2019 03:21:26 -0800 (PST)
Reply-To: aakkaavvii@gmail.com
From:   Abraham Morrison <chamber00000001@gmail.com>
Date:   Fri, 13 Dec 2019 03:21:26 -0800
Message-ID: <CABLDrx5zPeuJZ35-auXw6=oOat9sqomFCucpaHrvhkhvK05Hvw@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBGcmllbmQsDQpJIGFtIEJhcnJpc3RlciBBYnJhaGFtIE1vcnJpc29uLCBEaWQgeW91IHJl
Y2VpdmUgbXkgcHJldmlvdXMgbWVzc2FnZQ0KdG8geW91PyBJIGhhdmUgYW4gaW1wb3J0YW50IGlu
Zm9ybWF0aW9uIGZvciB5b3UgYWJvdXQgeW91ciBpbmhlcml0YW5jZQ0KZnVuZCB3b3J0aCBvZiAo
JDIwLDUwMCwwMDAuMDApIE1pbGxpb24gd2hpY2ggd2FzIGxlZnQgZm9yIHlvdSBieSB5b3VyDQps
YXRlIHJlbGF0aXZlLCBNci4gQ2FybG9zLiBTbyBpZiB5b3UgYXJlIGludGVyZXN0ZWQgZ2V0IGJh
Y2sgdG8gbWUgZm9yDQptb3JlIGRldGFpbHMuDQpUaGFuayB5b3UuDQpCYXJyaXN0ZXIgQWJyYWhh
bSBNb3JyaXNvbi4NCi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uDQrQlNC+0YDQvtCz0L7QuSDQtNGA0YPQsywNCtCvINCR0LDRgNGA0LjR
gdGC0LXRgCDQkNCy0YDQsNCw0Lwg0JzQvtGA0YDQuNGB0L7QvSwg0JLRiyDQv9C+0LvRg9GH0LjQ
u9C4INC80L7QtSDQv9GA0LXQtNGL0LTRg9GJ0LXQtSDRgdC+0L7QsdGJ0LXQvdC40LUg0LTQu9GP
DQrQstCw0YE/INCjINC80LXQvdGPINC10YHRgtGMINC00LvRjyDQstCw0YEg0LLQsNC20L3QsNGP
INC40L3RhNC+0YDQvNCw0YbQuNGPINC+INCy0LDRiNC10Lwg0L3QsNGB0LvQtdC00YHRgtCy0LXQ
vdC90L7QvA0K0YTQvtC90LTQtSDQvdCwINGB0YPQvNC80YMgKDIwIDUwMCAwMDAsMDAg0LTQvtC7
0LvQsNGA0L7QsiDQodCo0JApLCDQutC+0YLQvtGA0YvQuSDQvtGB0YLQsNCy0LjQuyDQstCw0Lwg
0LLQsNGIDQrQv9C+0LrQvtC50L3Ri9C5INGA0L7QtNGB0YLQstC10L3QvdC40LosINC80LjRgdGC
0LXRgCDQmtCw0YDQu9C+0YEuINCi0LDQuiDRh9GC0L4sINC10YHQu9C4INCy0Ysg0LfQsNC40L3R
gtC10YDQtdGB0L7QstCw0L3RiywNCtGB0LLRj9C20LjRgtC10YHRjCDRgdC+INC80L3QvtC5INC0
0LvRjyDQsdC+0LvQtdC1INC/0L7QtNGA0L7QsdC90L7QuSDQuNC90YTQvtGA0LzQsNGG0LjQuC4N
CtCh0L/QsNGB0LjQsdC+Lg0K0JHQsNGA0YDQuNGB0YLQtdGAINCQ0LLRgNCw0LDQvCDQnNC+0YDR
gNC40YHQvtC9Lg0K
