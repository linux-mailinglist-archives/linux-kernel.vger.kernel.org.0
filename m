Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51156142C49
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 14:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgATNkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 08:40:05 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56822 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATNkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:40:05 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 16D6214EAD04E;
        Mon, 20 Jan 2020 05:40:03 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:40:02 +0100 (CET)
Message-Id: <20200120.144002.869964951393529700.davem@davemloft.net>
To:     krzk@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ide: ht6560b: Fix cast to pointer from integer of
 different size
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200104143348.27842-1-krzk@kernel.org>
References: <20200104143348.27842-1-krzk@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Jan 2020 05:40:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KRGF0ZTogU2F0LCAg
NCBKYW4gMjAyMCAxNTozMzo0NyArMDEwMA0KDQo+IEludGVnZXIgcGFzc2VkIGFzIHBvaW50ZXIg
dG8gZHJ2ZGF0YSBzaG91bGQgYmUgY2FzdCB0byB1bnNpZ25lZCBsb25nIHRvDQo+IGF2b2lkIHdh
cm5pbmcgKGNvbXBpbGUgdGVzdGluZyBvbiBhbHBoYSBhcmNoaXRlY3R1cmUpOg0KPiANCj4gICAg
IGRyaXZlcnMvaWRlL2h0NjU2MGIuYzogSW4gZnVuY3Rpb24goWh0NjU2MGJfaW5pdF9kZXaiOg0K
PiAgICAgZHJpdmVycy9pZGUvaHQ2NTYwYi5jOjMxODoyNzogd2FybmluZzoNCj4gICAgICAgICBj
YXN0IHRvIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIG9mIGRpZmZlcmVudCBzaXplIFstV2ludC10by1w
b2ludGVyLWNhc3RdDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnprQGtlcm5lbC5vcmc+DQoNCkFwcGxpZWQuDQo=
