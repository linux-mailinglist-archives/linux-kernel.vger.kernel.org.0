Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A154B1170C1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2019 16:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLIPno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 10:43:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37083 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfLIPno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:43:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so16183744lja.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 07:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1r30tXDHS/FiQz7/MaYgKxfsEhbm2NItznrHdMcxexE=;
        b=JO54mbh5YXQb7bB1AQI5PFRtCYUow6wpxbRJguJhQ4A3gTj4aXvwNX5az5sfVYkpXk
         qs/Vqmc+4j0Yf2o0Oq0uwG2syM4NKPElous9ycZ91j0lzFsNZVTD4kF3v7I9LZQmPruY
         VY2/YogCCd6wqPMzdlE0EFh2yPWRqFHypdOUmw+1FCWAfxkI4HwDJ1OrtX53jyoxssI7
         tvKAvygyyxclmyMBlyxBm4FWsYb+4+yDKsdRwm3b1L+xjbrwuTs4NuISloJzfZP4IPWh
         Zw7MuuBedLfmSCnWPc2RPsgTwBt9HleozSiQAsj4uQLeaHucdJtlXgq6wXSGOIjRtr09
         neHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=1r30tXDHS/FiQz7/MaYgKxfsEhbm2NItznrHdMcxexE=;
        b=pxQKMYhRU4oitsZiajspYHw+b6UzSsh/zHCI7LkktvNV6fydBl1KETjXS9xWgFsqqb
         G3sSV0evDNvmhPFZB6H5K+9/WYQmAmBzysMHlDkKWZwHVKsxoAn4xYvsBXVMgxDoyeKX
         dAJJZLe5pfxRhQwxZfbTOaNK5xmiDmm76Xm+G1HYv01dXTrllL4fwmWthwcMBpaKfFuz
         FvYA0Z6d4CVLUsBO08F/fd/o2EXw+6RVIWtog1Z3jzw7wxNmpU4PctMCkPFtgGDSA29x
         Qz/D642yLjoyo0CZrjZtR+SPDd3OE8chq29ZZ/KlcDSA1vOBqe42Hk5VYoo3+AnJ6Frb
         LNog==
X-Gm-Message-State: APjAAAUvi4jQ6GA/elnOPj2c93bOPy6QS2WYe3JwdClYrPCEiYyajCvz
        dUlrFpY/PB3/5lDK2CdOvr3Zu0q6NZuEXSomCZo=
X-Google-Smtp-Source: APXvYqwcKyDFy+8g313Uh6S0QRrX/bRwN4Cs/HTUL76wcJQdjNk2+p0gjZuUv/Cijsqdrd6z+HHIo3Y8+JtkKAxsKHI=
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr12669412ljj.97.1575906222066;
 Mon, 09 Dec 2019 07:43:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a19:8842:0:0:0:0:0 with HTTP; Mon, 9 Dec 2019 07:43:41 -0800 (PST)
Reply-To: aakkaavvii@gmail.com
From:   Abraham Morrison <ttek3592@gmail.com>
Date:   Mon, 9 Dec 2019 07:43:41 -0800
Message-ID: <CAKGtys_Qg7cMoV233phuqkAfBRVaG5twia6i7D8eUWbMdLezBQ@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsDQrQryDQkdCw0YDRgNC40YHRgtC10YAg0JDQstGA0LDQ
sNC8INCc0L7RgNGA0LjRgdC+0L0sINCS0Ysg0L/QvtC70YPRh9C40LvQuCDQvNC+0LUg0L/RgNC1
0LTRi9C00YPRidC10LUg0YHQvtC+0LHRidC10L3QuNC1INC00LvRjw0K0LLQsNGBPyDQoyDQvNC1
0L3RjyDQtdGB0YLRjCDQtNC70Y8g0LLQsNGBINCy0LDQttC90LDRjyDQuNC90YTQvtGA0LzQsNGG
0LjRjyDQviDQstCw0YjQtdC8INC90LDRgdC70LXQtNGB0YLQstC10L3QvdC+0LwNCtGE0L7QvdC0
0LUg0L3QsCDRgdGD0LzQvNGDICgyMCA1MDAgMDAwLDAwINC00L7Qu9C70LDRgNC+0LIg0KHQqNCQ
KSwg0LrQvtGC0L7RgNGL0Lkg0L7RgdGC0LDQstC40Lsg0LLQsNC8INCy0LDRiA0K0L/QvtC60L7Q
udC90YvQuSDRgNC+0LTRgdGC0LLQtdC90L3QuNC6LCDQvNC40YHRgtC10YAg0JrQsNGA0LvQvtGB
LiDQotCw0Log0YfRgtC+LCDQtdGB0LvQuCDQstGLINC30LDQuNC90YLQtdGA0LXRgdC+0LLQsNC9
0YssDQrRgdCy0Y/QttC40YLQtdGB0Ywg0YHQviDQvNC90L7QuSDQtNC70Y8g0LHQvtC70LXQtSDQ
v9C+0LTRgNC+0LHQvdC+0Lkg0LjQvdGE0L7RgNC80LDRhtC40LguDQrQodC/0LDRgdC40LHQvi4N
CtCR0LDRgNGA0LjRgdGC0LXRgCDQkNCy0YDQsNCw0Lwg0JzQvtGA0YDQuNGB0L7QvS4NCi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLg0KRGVhciBGcmllbmQsDQpJ
IGFtIEJhcnJpc3RlciBBYnJhaGFtIE1vcnJpc29uLCBEaWQgeW91IHJlY2VpdmUgbXkgcHJldmlv
dXMgbWVzc2FnZQ0KdG8geW91PyBJIGhhdmUgYW4gaW1wb3J0YW50IGluZm9ybWF0aW9uIGZvciB5
b3UgYWJvdXQgeW91ciBpbmhlcml0YW5jZQ0KZnVuZCB3b3J0aCBvZiAoJDIwLDUwMCwwMDAuMDAp
IE1pbGxpb24gd2hpY2ggd2FzIGxlZnQgZm9yIHlvdSBieSB5b3VyDQpsYXRlIHJlbGF0aXZlLCBN
ci4gQ2FybG9zLiBTbyBpZiB5b3UgYXJlIGludGVyZXN0ZWQgZ2V0IGJhY2sgdG8gbWUgZm9yDQpt
b3JlIGRldGFpbHMuDQpUaGFuayB5b3UuDQpCYXJyaXN0ZXIgQWJyYWhhbSBNb3JyaXNvbi4NCg==
