Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B240196D40
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Mar 2020 14:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgC2MVv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 29 Mar 2020 08:21:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:33084 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728044AbgC2MVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 08:21:51 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-135-E2d1cB3MNcKiBN6SYycyaw-1; Sun, 29 Mar 2020 13:21:47 +0100
X-MC-Unique: E2d1cB3MNcKiBN6SYycyaw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 29 Mar 2020 13:21:47 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 29 Mar 2020 13:21:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'George Spelvin' <lkml@SDF.ORG>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Subject: RE: [RFC PATCH v1 00/52] Audit kernel random number use
Thread-Topic: [RFC PATCH v1 00/52] Audit kernel random number use
Thread-Index: AQHWBS7wHKwkXcotX0GE2ObBbkw++6hffddg
Date:   Sun, 29 Mar 2020 12:21:46 +0000
Message-ID: <98bd30f23b374ccbb61dd46125dc9669@AcuMS.aculab.com>
References: <202003281643.02SGhPmY017434@sdf.org>
 <CAPcyv4iagZy5m3FpMrQqyOi=_uCzqh5MjbW+J_xiHU1Z1BmF=g@mail.gmail.com>
 <20200328182817.GE5859@SDF.ORG>
In-Reply-To: <20200328182817.GE5859@SDF.ORG>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Spelvin
> Sent: 28 March 2020 18:28
...
> 20..23: Changes to the prandom_u32() generator itself.  Including
>     switching to a stronger & faster PRNG.

Does this remove the code that used 'xor' to combine the output
of (about) 5 LFSR?
Or is that somewhere else?
I didn't spot it in the patches - so it might already have gone.

Using xor was particularly stupid.
The whole generator was then linear and trivially reversable.
Just using addition would have made it much stronger.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

