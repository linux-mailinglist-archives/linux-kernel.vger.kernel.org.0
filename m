Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB3113063
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 18:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfLDRBf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Dec 2019 12:01:35 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:38428 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbfLDRBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:01:35 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-99-sjLWNHPnP_GIhzqPZuPVuA-1; Wed, 04 Dec 2019 17:01:32 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 4 Dec 2019 17:01:32 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 4 Dec 2019 17:01:32 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Running an Ivy Bridge cpu at fixed frequency
Thread-Topic: Running an Ivy Bridge cpu at fixed frequency
Thread-Index: AdWqwtS5CEX1+9oiRRqqz+2UyKDrUw==
Date:   Wed, 4 Dec 2019 17:01:32 +0000
Message-ID: <8eeee0695c664305ba6a56bce42a995f@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: sjLWNHPnP_GIhzqPZuPVuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way to persuade the intel_pstate driver to make an Ivy bridge (i7-3770)
cpu run at a fixed frequency?
It is really difficult to compare code execution times when the cpu clock speed
keeps changing.
I thought I'd managed by setting the 'scaling_max_freq' to 1.7GHz, but even that
doesn't seem to be working now.
It would also be nice to run a little faster than that - but without it 'randomly'
going to 'turbo' frequencies (which it is doing even after I've set no_turbo to 1).

An alternative would be a variable frequency TSC - might give more consistent values.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

