Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87678142F10
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 16:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgATPz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 10:55:59 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:33765 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:55:59 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 41D2A22FEB;
        Mon, 20 Jan 2020 16:55:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1579535756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ooYTeglPjja9XHWcnDgkHhVKkBwaE2MvC2UUFHOdGc=;
        b=ZKp4wxt5LVptrZx1UYJw57ss+UDp/gXPw9Ot2BVdnGFG+DMs8qCSt72OOdD9/PnY0Husao
        SEPxvfnYj6MECvSiYNF1194r+boPpfbsTmP00jsl6ok4AXgyo5PLShzp1X4Cybz/3CtMdC
        vY5btFfaXoEeQAoC2qxWE3uPTHrsC9s=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Jan 2020 16:55:55 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        richard@nod.at, vigneshr@ti.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH] mtd: spi-nor: Add support for w25qNNjwim
In-Reply-To: <3862353.UOg0IvECEa@localhost.localdomain>
References: <20200103223423.14025-1-michael@walle.cc>
 <8021667.67K7kvUAe6@192.168.0.113>
 <66c1ad8e74fb20a061f35f8b23a925ab@walle.cc>
 <3862353.UOg0IvECEa@localhost.localdomain>
Message-ID: <d3f03e392c060ff4ed4c2ae8a8999d9f@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: /
X-Spam-Status: No, score=-0.10
X-Rspamd-Server: web
X-Spam-Score: -0.10
X-Rspamd-Queue-Id: 41D2A22FEB
X-Spamd-Result: default: False [-0.10 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[];
         NEURAL_HAM(-0.00)[-0.721];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

Am 2020-01-20 12:03, schrieb Tudor.Ambarus@microchip.com:
> On Monday, January 20, 2020 12:24:25 AM EET Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the
>> content is safe
>> 
>> Hi Tudor,
> 
> Hi, Michael,
> 
>> 
>> >> Am 2020-01-13 11:07, schrieb Michael Walle:
>> >> >>> Btw. is renaming the flashes also considered a backwards incomaptible
>> >> >>> change?
>> >> >>
>> >> >> No, we can fix the names.
>> >> >>
>> >> >>> And can there be two flashes with the same name? Because IMHO it
>> >> >>> would
>> >> >>> be
>> >> >>
>> >> >> I would prefer that we don't. Why would you have two different
>> >> >> jedec-ids with
>> >> >> the same name?
>> >> >
>> >> > Because as pointed out in the Winbond example you cannot distiguish
>> >> > between
>> >> > W25Q32DW and W25Q32JWIQ; and in the Macronix example between MX25L8005
>> >> > and
>> >> > MX25L8006E. Thus my reasoning was to show only the common part, ie
>> >> > W25Q32
>> >> > or MX25L80 which should be the same for this particular ID. Like I
>> >> > said, I'd
>> >> > prefer showing an ambiguous name instead of a wrong one. But then you
>> >> > may
>> >> > have different IDs with the same ambiguous name.
>> >>
>> >> Another solution would be to have the device tree provide a hint for
>> >> the
>> >> actual flash chip. There would be multiple entries in the spi_nor_ids
>> >> with the
>> >> same flash id. By default the first one is used (keeping the current
>> >> behaviour). If there is for example
>> >>
>> >>    compatible = "jedec,spi-nor", "w25q32jwq";
>> >>
>> >> the flash_info for the w25q32jwq will be chosen.
>> >
>> > This won't work for plug-able flashes. You will influence the name in
>> > dt to be
>> > chosen as w25q32jwq, and if you change w25q32jwq with w25q32dw you will
>> > end up
>> > with a wrong name for w25q32dw, thus the same problem.
>> 
>> No, because then the device tree is wrong and doesn't fit the 
>> hardware.
>> You'd
>> have to some instance which could change the device tree node, like 
>> the
>> bootloader or some device tree overlay for plugable flashes. We should
>> try to
>> solve the actual problem at hand first..
>> 
>> It is just not possible to autodetect the SPI flash, just because
>> the vendors reuse the same IDs for flashes with different features 
>> (and
>> the
>> SFDP is likely not enough). Therefore, you need to have a hint in some
>> place
>> to use the flash properly.
>> 
>> > If the flashes are identical but differ just in terms of name, we can
>> > rename
>> > the flash to "w25q32jwq (w25q32dw)". I haven't studied the differences
>> > between
>> > these flashes; if you want to fix them, send a patch and I'll try to
>> > help.
>> 
>> It is not only the name, here are two examples which differ in
>> functionality:
>>   (1) mx25l8005 doesn't support dual/quad mode. mx25l8006e supports
>> dual/quad
>>       mode
>>   (2) mx25u3235f doesn't support TB bit, mx25u3232e has a TB bit.
>> 
>> well.. to repeat myself, the mx25l25635_post_bfpt_fixups is a third
> 
> sorry if this exhausted you.

TBH, this is no fun (and I'm doing this on my spare time because I like
open source). I guess our opinions differ waaay too much. I don't
really like band-aid fixes; eg. with vague information "it seems that
the F version adveritses support for Fast Read 4-4-4", what about other
flashes with that idcode and this property. This might break at any time
or with anyone trying support for other flashes with that ID.

That's what I've meant with first come first serve, I'm lucky now that
there was no flash with the same jedec id as the W25Q32JW.

To add the MX25U3232F I could check the JEDEC revision (or the BFPT
length) because it differers from the MX25U3235F. But I don't feel well
doing that. Who says Macronix won't update their description for the
MX25U3235F to the new revision.. FYI the Winbond guys apparently use the
first OTP region to store the JEDEC data, which is clever because they
can update it during production.

>> example.
>> 
> 
> Flash auto-detection is nice and we should preserve it if possible. I 
> would
> prefer having a post bfpt fixup than giving a hint about the flash in 
> the
> compatible.

see above.

> The flashes that you mention are quite old and I don't know if it
> is worth to harm the auto-detection for them. A compromise has to be 
> made.

so you'd drop support for them? because SFDP is never read if there is 
no
DUAL_READ or QUAD_READ flag.

> You can gain traction in your endeavor if you have such a flash and 
> there's
> nothing auto-detectable that differentiates it from some other flash 
> that
> shares the sama jedec-id.
> 
> If you have such a flash and you care about it, send a patch and I'll 
> try to
> help.

Given my reasoning above.. well maybe in the future. The Macronix would 
be
a second source candidate. For now we are using the Winbond flash.

I would rather like to have the flash protection topic and OTP support
sorted out, because that is something we are actually using.

-michael

> 
>> -michael
>> 
>> > Cheers,
>> > ta
>> >
>> >> I know this will conflict with the new rule that there should only be
>> >>
>> >>    compatible = "jedec,spi-nor";
>> >>
>> >> without the actual flash chip. But it seems that it is not always
>> >> possible
>> >> to just use the jedec id to match the correct chip.
>> >>
>> >> Also see for example mx25l25635_post_bfpt_fixups() which tries to
>> >> figure
>> >> out different behaviour by looking at "some" SFDP data. In this case
>> >> we
>> >> might have been lucky, but I fear that this won't work in all cases
>> >> and
>> >> for older flashes it won't work at all.
>> >>
>> >> BTW I do not suggest to add the strings to the the spi_nor_dev_ids[].
>> >>
>> >> I guess that would be a less invasive way to fix different flashes
>> >> with
>> >> same jedec ids.
>> >>
>> >> -michael
