Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54C80132812
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 14:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgAGNto convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Jan 2020 08:49:44 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:49485 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727658AbgAGNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:49:44 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-35-r-ymTIbtO2ia86kj15aT7g-1; Tue, 07 Jan 2020 13:49:41 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 7 Jan 2020 13:49:40 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 7 Jan 2020 13:49:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: ftrace trace_raw_pipe format
Thread-Topic: ftrace trace_raw_pipe format
Thread-Index: AdW0/hn3Ss2VXYeUS7iB4GPS8sdlIgAK/t2AACd1JMAD46PTkA==
Date:   Tue, 7 Jan 2020 13:49:40 +0000
Message-ID: <8b225fdcbe6e4cc7bba302d899e277ae@AcuMS.aculab.com>
References: <e8f9744ddffc4527b222ce72d41c61a1@AcuMS.aculab.com>
 <20191217173403.61f4e2d8@gandalf.local.home>
 <3df0aa9c69ec4d2086b96eb032a1a0df@AcuMS.aculab.com>
In-Reply-To: <3df0aa9c69ec4d2086b96eb032a1a0df@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: r-ymTIbtO2ia86kj15aT7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After reading the code in kbuffer-parse.c I can now get a sequence of trace entries
with their timestamps.

I think there is a bug in the processing (skipping) of KBUFFER_TYPE_TIME_STAMP
in translate_data().
I assume a 64bit timestamp would follow, and 'data' should only be incremented
by 8 (not 12) as there is an increment by 4 earlier.
I'm pretty sure these are never generated - __next_event() doesn't loop.

It is ~impossible to match this parsing code to the generating code because none
of the constants are in a shared header file.

Back to my original problem:

I've a set of trace files that contain 4 4k blocks each.
The 4 blocks are in time order, but I think there is a big time discontinuity
between the first and second blocks.
The second block has both MISSED_EVENTS and MISSED_STORED set.
My suspicion is that the first block (partially filled) is the final block
from the previous trace and its presence is a bug.
So anything processing the trace must completely ignore the first
block (if the second reports MISSED_EVENTS).

The 4th block is also partial - which is what I expect.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

