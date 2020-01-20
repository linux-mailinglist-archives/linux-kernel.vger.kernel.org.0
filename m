Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1316142C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 14:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgATNkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 08:40:12 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56830 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:40:12 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1213014EAD059;
        Mon, 20 Jan 2020 05:40:10 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:40:09 +0100 (CET)
Message-Id: <20200120.144009.421264290635214433.davem@davemloft.net>
To:     krzk@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ide: qd65xx: Fix cast to pointer from integer of
 different size
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200104143348.27842-2-krzk@kernel.org>
References: <20200104143348.27842-1-krzk@kernel.org>
        <20200104143348.27842-2-krzk@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Jan 2020 05:40:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KRGF0ZTogU2F0LCAg
NCBKYW4gMjAyMCAxNTozMzo0OCArMDEwMA0KDQo+IEludGVnZXIgcGFzc2VkIGFzIHBvaW50ZXIg
dG8gZHJ2ZGF0YSBzaG91bGQgYmUgY2FzdCB0byB1bnNpZ25lZCBsb25nIHRvDQo+IGF2b2lkIHdh
cm5pbmcgKGNvbXBpbGUgdGVzdGluZyBvbiBhbHBoYSBhcmNoaXRlY3R1cmUpOg0KPiANCj4gICAg
IGRyaXZlcnMvaWRlL3FkNjV4eC5jOiBJbiBmdW5jdGlvbiChcWQ2NTgwX2luaXRfZGV2ojoNCj4g
ICAgIGRyaXZlcnMvaWRlL3FkNjV4eC5jOjMxMjoyNzogd2FybmluZzoNCj4gICAgICAgICBjYXN0
IHRvIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIG9mIGRpZmZlcmVudCBzaXplIFstV2ludC10by1wb2lu
dGVyLWNhc3RdDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnpr
QGtlcm5lbC5vcmc+DQoNCkFwcGxpZWQuDQo=
