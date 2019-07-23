Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE4371BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 17:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbfGWPld convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Jul 2019 11:41:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:34687 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbfGWPlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:41:32 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-187-32j5YcqrN5ShbLouelXgfQ-1; Tue, 23 Jul 2019 16:41:28 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 23 Jul 2019 16:41:27 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 23 Jul 2019 16:41:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>, Stephen Kitt <steve@sk2.org>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>,
        "jannh@google.com" <jannh@google.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
Thread-Topic: [PATCH 1/2] string: Add stracpy and stracpy_pad mechanisms
Thread-Index: AQHVQSOiPIn99bSetkamp+/6YQTlwKbYVhaA
Date:   Tue, 23 Jul 2019 15:41:27 +0000
Message-ID: <5ffdbf4f87054b47a2daf23a6afabecf@AcuMS.aculab.com>
References: <cover.1563841972.git.joe@perches.com>
 <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
 <eec901c6-ca51-89e4-1887-1ccab0288bee@rasmusvillemoes.dk>
In-Reply-To: <eec901c6-ca51-89e4-1887-1ccab0288bee@rasmusvillemoes.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 32j5YcqrN5ShbLouelXgfQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes
> Sent: 23 July 2019 07:56
...
> > +/**
> > + * stracpy - Copy a C-string into an array of char
> > + * @to: Where to copy the string, must be an array of char and not a pointer
> > + * @from: String to copy, may be a pointer or const char array
> > + *
> > + * Helper for strscpy.
> > + * Copies a maximum of sizeof(@to) bytes of @from with %NUL termination.
> > + *
> > + * Returns:
> > + * * The number of characters copied (not including the trailing %NUL)
> > + * * -E2BIG if @to is a zero size array.
> 
> Well, yes, but more importantly and generally: -E2BIG if the copy
> including %NUL didn't fit. [The zero size array thing could be made into
> a build bug for these stra* variants if one thinks that might actually
> occur in real code.]

Probably better is to return the size of the destination if the copy didn't fit
(zero if the buffer is zero length).
This allows code to do repeated:
	offset += str*cpy(buf + offset, src, sizeof buf - offset);
and do a final check for overflow after all the copies.

The same is true for a snprintf()like function

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

