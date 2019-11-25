Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFE6108D44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 12:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfKYLwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 06:52:22 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38010 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfKYLwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:52:21 -0500
Received: by mail-il1-f193.google.com with SMTP id u17so13906602ilq.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 03:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CeeDtpjMokJukuH1miomF5Oz08aqVjt3ots/YpdA6R8=;
        b=LL+d5UjSYKQo7SNtgOxz0ks9vaL1K+hNA5DwJRgFR9ov1HvWut16evvV0/6ztetOuR
         he3t5iPskJEbvBfIb52JkTCKlv5Sp04uM17MGQAjataPJfKt6kWhkz35iJEKMEhEBJxJ
         tKqMa9AMm0ONQuRCDqD/sxzamfPwBjy+xOgiCmhkv9uThCpbqMKhjOiEHGPzDYnWdU8P
         8sm7wGJpa4loJrCqvK1ClOe4hhoHwuNXC9rSs4Ccq8hxoCS0txNpp3rJOVrTa7MFOyOO
         dnKsQu8rhXIF9m/iN5YfRlpDvwlfWCFneurTuvuag0tkjjEQWWT9/Vuix5ORXZQ0JL9Z
         uCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=CeeDtpjMokJukuH1miomF5Oz08aqVjt3ots/YpdA6R8=;
        b=GJVx6+cyqkJ1NAeHfQprD441NjRwtIWK0oWm5jD5DzF+vvH/Bc9xxfAozp/Pp/PLXe
         RhIH+NRAdjZ5Vb0eVKnNg+eAsTUJSXdn8RwIYaTO5ILr+wK3rhv7LiIN2ilvgCS4jCU0
         3VH53IwSLqpAsaGALLFv/TDqk6N+FeYGd1ptuLRwPD+TLSRKthtBTlNbRuUKkZbUuT2r
         Q0YEUm23jOdh2wJR0RoHm4yQbGw1qAKKJYZGC7Z7emh+fF1h/0DFUikNkTfJjTxiBtaz
         IMRgkhg+UAPWSoulX5w/E6uI0PdrnpXhzntOvBM4e0TgUNBjCUlOJMt8UMffqPPmocvi
         oOxg==
X-Gm-Message-State: APjAAAX0zithsXOWbjtps5UcTbtqeF0RMvEX6t48bfwyADJrpdSLQapm
        3opwrPT+d0YZyAIdxE9AXqbBekHzOsuJtozFI+c=
X-Google-Smtp-Source: APXvYqz0DFGpXnvuXshvHVSxedQf2gI4DFhvQAvFtmzUSlS5Ng7EEaItNWEJyGJOiSMyqdv1h6l5VKcdoU3uLV3DxbM=
X-Received: by 2002:a92:ce06:: with SMTP id b6mr30332956ilo.14.1574682740918;
 Mon, 25 Nov 2019 03:52:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:9250:0:0:0:0:0 with HTTP; Mon, 25 Nov 2019 03:52:20
 -0800 (PST)
Reply-To: aakkaavvii@gmail.com
From:   Abraham Morrison <johnego001@gmail.com>
Date:   Mon, 25 Nov 2019 03:52:20 -0800
Message-ID: <CACOK_Jth5C+jaJc78Y7u=cdbC2zm1_8wgFn_04aEsK+azwJSag@mail.gmail.com>
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
