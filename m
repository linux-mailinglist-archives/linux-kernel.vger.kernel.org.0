Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6829F5FB11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 17:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfGDPju convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 4 Jul 2019 11:39:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:44730 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727454AbfGDPjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:39:49 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-213-JZyB4AryN_eHsc0v6lTtEQ-1; Thu, 04 Jul 2019 16:39:41 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 4 Jul 2019 16:39:41 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 4 Jul 2019 16:39:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH 0/7] Use spinlock_t instead of struct spinlock
Thread-Topic: [PATCH 0/7] Use spinlock_t instead of struct spinlock
Thread-Index: AQHVMn59sZSDeWtWa0aQMiKqYxhEN6a6mByg
Date:   Thu, 4 Jul 2019 15:39:41 +0000
Message-ID: <4456003dfa654444b8af7b7be9a9c30e@AcuMS.aculab.com>
References: <20190704153803.12739-1-bigeasy@linutronix.de>
In-Reply-To: <20190704153803.12739-1-bigeasy@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: JZyB4AryN_eHsc0v6lTtEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Sebastian Andrzej Siewior
> Sent: 04 July 2019 16:38
> 
> Just a small series to clean up various "struct spinlock" user and make
> them use "spinlock_t" instead.

I thought it was policy to avoid typedefs?
Probably because you can only define them once.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

