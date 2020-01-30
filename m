Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D18C14D921
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jan 2020 11:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgA3KhO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Jan 2020 05:37:14 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:37040 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726893AbgA3KhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:37:14 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-177-BUQPPyd0Pc2k7YXNfMyzWA-1; Thu, 30 Jan 2020 10:37:08 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 30 Jan 2020 10:37:07 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 30 Jan 2020 10:37:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Greg KH' <gregkh@linuxfoundation.org>,
        'Eric Biggers' <ebiggers@kernel.org>
CC:     'Tetsuo Handa' <penguin-kernel@i-love.sakura.ne.jp>,
        "'gustavo@embeddedor.com'" <gustavo@embeddedor.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hpet: Fix struct_size() in kzalloc()
Thread-Topic: [PATCH] hpet: Fix struct_size() in kzalloc()
Thread-Index: AQHV1zIWYxQa+FO7zkqmoqcRV+KmjagC+3VQgAAHKIA=
Date:   Thu, 30 Jan 2020 10:37:07 +0000
Message-ID: <69fae096f556414c96a71747f49d1e08@AcuMS.aculab.com>
References: <202001300450.00U4ocvS083098@www262.sakura.ne.jp>
 <20200130052645.GA833@sol.localdomain> <20200130055650.GA623220@kroah.com>
 <b04253f40d9e49e597af925599bd4964@AcuMS.aculab.com>
In-Reply-To: <b04253f40d9e49e597af925599bd4964@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: BUQPPyd0Pc2k7YXNfMyzWA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ...
> > > > -	hpetp = kzalloc(struct_size(hpetp, hp_dev, hdp->hd_nirqs - 1),
> > > > +	hpetp = kzalloc(struct_size(hpetp, hp_dev, hdp->hd_nirqs),
> > > >  			GFP_KERNEL);
> > > >
> > > >  	if (!hpetp)
> > > > --
> > >
> > > Yep, "char: hpet: Use flexible-array member" started causing random boot
> > > failures on mainline for me.  Tetsuo beat me to sending the fix.
> > >
> > > Only thing I'll add is that GFP_KERNEL can now fit on the previous line.
> >
> > Gustavo already sent a fix for this, I didn't realize it was causing
> > boot problems, I'll forward it on to Linus soon.
> 
> grep -r --include '*.c' 'struct_size.*- 1'
> gives 4 other matches.
> I bet they all have the same bug.
> There might be others that simple pattern doesn't find.

kvm_main.c is ok - although why it reallocates 1 entry smaller on
    delete is any bodies guess.
megaraid_sas_fusion.c is broken, header has seq[1]
   (and lots of __packed).
iavf_virtchnl.c is broken, header has list[1].
ice_sched.c is broken, header has generic[1].

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

