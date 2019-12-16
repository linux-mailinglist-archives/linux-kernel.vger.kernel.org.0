Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A582A121129
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 18:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLPRJJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Dec 2019 12:09:09 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:27672 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727777AbfLPRGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:06:54 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-234-JuRnfgrMPl6iYDkTywHqlA-1; Mon, 16 Dec 2019 17:06:51 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 16 Dec 2019 17:06:50 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 16 Dec 2019 17:06:50 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     'Tom Zanussi' <zanussi@kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: ftrace histogram sorting broken on BE architecures
Thread-Topic: ftrace histogram sorting broken on BE architecures
Thread-Index: AQHVsSDKonZphcun20Oca4kHPqdeCKe87LwAgAAGU4CAAA+FUA==
Date:   Mon, 16 Dec 2019 17:06:50 +0000
Message-ID: <548eb8ae4b8742e4bf122af98b208925@AcuMS.aculab.com>
References: <20191211123316.GD12147@stackframe.org>
        <20191211103557.7bed6928@gandalf.local.home>
        <20191211110959.2baeb70f@gandalf.local.home>
        <1576178241.3309.2.camel@kernel.org>
        <4805b40c3e1547f8a26eeac6932f6499@AcuMS.aculab.com>
 <20191216110539.2b268d86@gandalf.local.home>
In-Reply-To: <20191216110539.2b268d86@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: JuRnfgrMPl6iYDkTywHqlA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> Sent: 16 December 2019 16:06
> On Mon, 16 Dec 2019 15:47:12 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > > From: Tom Zanussi
> > > Sent: 12 December 2019 19:17
> > > On Wed, 2019-12-11 at 11:09 -0500, Steven Rostedt wrote:
> > > > On Wed, 11 Dec 2019 10:35:57 -0500
> > > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > > > Any thoughts on how to fix this? I'm not sure whether i fully
> > > > > > understand the
> > > > > > ftrace maps... ;-)
> > > > >
> > > > > Your analysis makes sense. I'll take a deeper look at it.
> > > >
> > > > Sven,
> > > >
> > > > Does this patch fix it for you?
> > > >
> > > > Tom,
> > > >
> > > > Correct me if I'm wrong, from what I can tell, all sums and keys are
> > > > u64 unless they are a string. Thus, I believe this patch should not
> > > > have any issues.
> > ...
> > > > --- a/kernel/trace/tracing_map.c
> > > > +++ b/kernel/trace/tracing_map.c
> > > > @@ -148,8 +148,8 @@ static int tracing_map_cmp_atomic64(void *val_a,
> > > > void *val_b)
> > > >  #define DEFINE_TRACING_MAP_CMP_FN(type) 	\
> > > >  static int tracing_map_cmp_##type(void *val_a, void *val_b) \
> > > >  { \
> > > > -	type a = *(type *)val_a; \
> > > > -	type b = *(type *)val_b; \
> > > > +	type a = (type)(*(u64 *)val_a); 	\
> > > > +	type b = (type)(*(u64 *)val_b); 	\
> > > > \
> > > >  	return (a > b) ? 1 : ((a < b) ? -1 : 0); \
> > > >  }
> >
> > That looks so horrid/wrong it can't be right on both BE and LE.
> 
> Well, the original is obviously not right for both BE and LE, but the
> fix is:
> 
> 	type a = (type)(*(u64 *)val_a);
> 
> Which breaks down to:
> 
> 		(u64 *)val_a - make val_a a pointer to a u64 number
> 
> all values were written as u64.
> 
> 	u64 data = (u64)original_val_a
> 
> Where original_val_a could be a byte, short, int, long or long long.

I'd sort of guessed that, but then the pointer type passed to tracing_map_cmp_##type()
will always be 'u64 *' (since the field the address is taken of must be that type).
Then the (u64 *) casts are no longer needed.

Possibly you can just pass the u64 values to:
tracing_map_cmp_##type(type a, type b)
{
	return a > b ? 1 : a < b ? -1 : 0;
}

The high bit masking and sign extension is then implicit in the call.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

