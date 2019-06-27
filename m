Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B97457F06
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 11:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfF0JMo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jun 2019 05:12:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:35616 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfF0JMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:12:44 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-7-UfpZyM_bND6y_efQ6g2k2A-1;
 Thu, 27 Jun 2019 10:12:40 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 27 Jun 2019 10:12:40 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 27 Jun 2019 10:12:40 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 00/10] x86/CPU and x86/resctrl: Support pseudo-lock
 regions spanning L2 and L3 cache
Thread-Topic: [PATCH 00/10] x86/CPU and x86/resctrl: Support pseudo-lock
 regions spanning L2 and L3 cache
Thread-Index: AQHVLEe9xpx8VVsweUuywxr187msuKavNmNg
Date:   Thu, 27 Jun 2019 09:12:40 +0000
Message-ID: <41cd71514a9042abaaef909d816e2522@AcuMS.aculab.com>
References: <cover.1561569068.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1561569068.git.reinette.chatre@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: UfpZyM_bND6y_efQ6g2k2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre
> Sent: 26 June 2019 18:49
> 
> Cache pseudo-locking involves preloading a region of physical memory into a
> reserved portion of cache that no task or CPU can subsequently fill into and
> from that point on will only serve cache hits. At this time it is only
> possible to create cache pseudo-locked regions in either L2 or L3 cache,
> supporting systems that support either L2 Cache Allocation Technology (CAT)
> or L3 CAT because CAT is the mechanism used to manage reservations of cache
> portions.

While this is a 'nice' hardware feature for some kinds of embedded systems
I don't see how it can be sensibly used inside a Linux kernel.
There are an awful lot of places where things can go horribly wrong.
I can imagine:
- Multiple requests to lock regions that end up trying to use the same
  set-associative cache lines leaving none for normal operation.
- Excessive cache line bouncing because fewer lines are available.
- The effect of cache invalidate requests for the locked addresses.
- I suspect the Linux kernel can do full cache invalidates at certain times.

You've not given a use case.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

