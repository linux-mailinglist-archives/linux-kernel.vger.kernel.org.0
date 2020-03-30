Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F4F198321
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgC3SOm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 Mar 2020 14:14:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:22606 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgC3SOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:14:42 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-228-Uzzyp6fHP5iCb0krCcGUIQ-1; Mon, 30 Mar 2020 19:14:38 +0100
X-MC-Unique: Uzzyp6fHP5iCb0krCcGUIQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 30 Mar 2020 19:14:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 30 Mar 2020 19:14:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: ftrace not showing the process names for all processes on syscall
 events
Thread-Topic: ftrace not showing the process names for all processes on
 syscall events
Thread-Index: AdYGnj+cWqFtVCqqTmCXgoqvHM5xrf///P+A///qkvCAAEdbAP//7aKg
Date:   Mon, 30 Mar 2020 18:14:37 +0000
Message-ID: <ffd8aa59d88146fbb5a4cb02ea9b7440@AcuMS.aculab.com>
References: <3cdef49951734e83a14959628233d4f0@AcuMS.aculab.com>
        <20200330110855.437fe854@gandalf.local.home>
        <7dec110c2dc14792ba744419a4eb907e@AcuMS.aculab.com>
 <20200330140736.4b5f1667@gandalf.local.home>
In-Reply-To: <20200330140736.4b5f1667@gandalf.local.home>
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

From: Steven Rostedt
> Sent: 30 March 2020 19:08
> On Mon, 30 Mar 2020 15:34:08 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > Oh, does the 'function_graph' code ignore tail calls?
> 
> Yes and no ;-)  It works by dumb luck. As it was a year after function
> graph tracing was live (some time in 2010 I believe) that someone brought
> up tail calls, and I had to take a look at how it never crashed, and was
> surprised that it "just worked". Here's a summary:

'Dumb luck' seems to be failing me :-)
I'll look more closely tomorrow.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

