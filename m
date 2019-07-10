Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C678364347
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 10:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfGJIEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 04:04:07 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:33017 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfGJIEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:04:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 07D731838E;
        Wed, 10 Jul 2019 10:04:04 +0200 (CEST)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id HTfl7Eh3_sTc; Wed, 10 Jul 2019 10:04:02 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 7B70B182B2;
        Wed, 10 Jul 2019 10:04:02 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BBD91A067;
        Wed, 10 Jul 2019 10:04:02 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 605171A065;
        Wed, 10 Jul 2019 10:04:02 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Wed, 10 Jul 2019 10:04:02 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 54541D93;
        Wed, 10 Jul 2019 10:04:02 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 4870780231; Wed, 10 Jul 2019 10:04:02 +0200 (CEST)
Date:   Wed, 10 Jul 2019 10:04:02 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: Do not lose last line in kmsg dump
Message-ID: <20190710080402.ab3f4qfnvez6dhtc@axis.com>
References: <20190709081042.31551-1-vincent.whitchurch@axis.com>
 <20190709101230.GA16909@jagdpanzerIV>
 <20190709142939.luqhbd6x6bzdkydr@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709142939.luqhbd6x6bzdkydr@pathway.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 04:29:39PM +0200, Petr Mladek wrote:
> On Tue 2019-07-09 19:12:30, Sergey Senozhatsky wrote:
> > On (07/09/19 10:10), Vincent Whitchurch wrote:
> > > A dump of a 64-byte buffer filled by kmsg_dump_get_buffer(), before this
> > > patch:
> > > 
> > >  00000000: 3c 30 3e 5b 20 20 20 20 36 2e 35 32 32 31 39 37  <0>[    6.522197
> > >  00000010: 5d 20 41 41 41 41 41 41 41 41 41 41 41 41 41 0a  ] AAAAAAAAAAAAA.
> > >  00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >  00000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > > 
> > > After this patch:
> > > 
> > >  00000000: 3c 30 3e 5b 20 20 20 20 36 2e 34 32 37 35 30 32  <0>[    6.427502
> > >  00000010: 5d 20 41 41 41 41 41 41 41 41 41 41 41 41 41 0a  ] AAAAAAAAAAAAA.
> > >  00000020: 3c 30 3e 5b 20 20 20 20 36 2e 34 32 37 37 36 39  <0>[    6.427769
> > >  00000030: 5d 20 42 42 42 42 42 42 42 42 31 32 33 34 35 0a  ] BBBBBBBB12345.
> > 
> > [..]
> > 
> > > @@ -1318,7 +1318,7 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog,
> > >  		}
> > >  
> > >  		if (buf) {
> > > -			if (prefix_len + text_len + 1 >= size - len)
> > > +			if (prefix_len + text_len + 1 > size - len)
> > >  				break;
> > 
> > So with this patch the last byte of the buffer is 0xA. It's a bit
> > uncomfortable that `len', which we return from msg_print_text(),
> > now points one byte beyond the buffer:
> > 
> > 	buf[len++] = '\n';
> > 	return len;
> > 
> > This is not very common. Not sure what usually happens to kmsg_dump
> > buffers, but anyone who'd do a rather innocent
> > 
> > 	kmsg_dump(buf, &len);
> > 	buf[len] = 0x00;
> > 
> > will write to something which is not a kmsg buffer (in some cases).
> 
> I have the same worries.
> 
> On the other hand. The function does not store the trailing '\0'
> into the buffer itself. The callers would need to add it themself.
> It is their responsibility to avoid a buffer overflow.
> 
> I have checked several users and it seems that nobody adds or
> needs the trailing '\0'.
> 
> It is ugly to do not use the entire buffer just because theoretical
> buggy users.

All the callers of kmsg_dump_get_buffer() seem to be fine but these two
users of kmsg_dump_get_line(), which also calls msg_print_text(), have
exactly the code which you and Sergey worry about:

arch/powerpc/xmon/xmon.c
2836:	while (kmsg_dump_get_line_nolock(&dumper, false, buf, sizeof(buf), &len)) {
2837-		buf[len] = '\0';

arch/um/kernel/kmsg_dump.c
29:	while (kmsg_dump_get_line(dumper, true, line, sizeof(line), &len)) {
30-		line[len] = '\0';

I guess we should fix these first and leave this patch as is?
