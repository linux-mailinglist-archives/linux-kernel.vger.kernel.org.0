Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE409A7F92
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 11:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfIDJjA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Sep 2019 05:39:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:36177 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726045AbfIDJi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:38:59 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-106-MP-yMEjzODqKT_VQfSISUA-1; Wed, 04 Sep 2019 10:38:55 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 4 Sep 2019 10:38:55 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 4 Sep 2019 10:38:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?iso-8859-2?Q?=27Valentin_Vidi=E6=27?= 
        <vvidic@valentin-vidic.from.hr>, Al Viro <viro@zeniv.linux.org.uk>
CC:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: exfat: cleanup braces for if/else statements
Thread-Topic: [PATCH] staging: exfat: cleanup braces for if/else statements
Thread-Index: AQHVYoMgt2lCAY06IEWAL3uRVSEYfacbQ6fg
Date:   Wed, 4 Sep 2019 09:38:55 +0000
Message-ID: <d14cda319c584db9b8aa35b15b542f89@AcuMS.aculab.com>
References: <20190903164732.14194-1-vvidic@valentin-vidic.from.hr>
 <20190903173249.GL1131@ZenIV.linux.org.uk>
 <20190903181208.GA8469@valentin-vidic.from.hr>
In-Reply-To: <20190903181208.GA8469@valentin-vidic.from.hr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: MP-yMEjzODqKT_VQfSISUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Vidic
> Sent: 03 September 2019 19:12
> On Tue, Sep 03, 2019 at 06:32:49PM +0100, Al Viro wrote:
> > On Tue, Sep 03, 2019 at 06:47:32PM +0200, Valentin Vidic wrote:
> > > +			} else if (uni == 0xFFFF) {
> > >  				skip = TRUE;
> >
> > While we are at it, could you get rid of that 'TRUE' macro?
> 
> Sure, but maybe in a separate patch since TRUE/FALSE has more
> calls than just this.

I bet you can get rid of the 'skip' variable and simplify the code
by using continue/break/return (or maybe goto).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

