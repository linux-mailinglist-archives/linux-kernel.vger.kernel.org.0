Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7343DB39DB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 14:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbfIPMAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 08:00:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:54400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731514AbfIPMAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:00:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 340B9AFF3;
        Mon, 16 Sep 2019 12:00:40 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de>
        <20190910070503.GA31743@lst.de> <mvmzhjcr2d4.fsf@suse.de>
        <alpine.DEB.2.21.9999.1909160456010.7214@viisi.sifive.com>
X-Yow:  I need to discuss BUY-BACK PROVISIONS with at least
 six studio SLEAZEBALLS!!
Date:   Mon, 16 Sep 2019 14:00:39 +0200
In-Reply-To: <alpine.DEB.2.21.9999.1909160456010.7214@viisi.sifive.com> (Paul
        Walmsley's message of "Mon, 16 Sep 2019 04:57:14 -0700 (PDT)")
Message-ID: <mvm7e68fo2g.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 16 2019, Paul Walmsley <paul.walmsley@sifive.com> wrote:

> On Tue, 10 Sep 2019, Andreas Schwab wrote:
>
>> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
>> 
>> > On Tue, Sep 10, 2019 at 08:57:37AM +0200, Andreas Schwab wrote:
>> >> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
>> >> 
>> >> > The sifive serial driver implements earlycon support,
>> >> 
>> >> It should probably be documented in admin-guide/kernel-parameters.txt.
>> >
>> > How so?  Wіth OF and a stdout path you just set earlycon on the
>> > command line without any arguments and it will be found.
>> 
>> Doesn't work for me.
>> 
>> [    0.000000] Malformed early option 'earlycon'
>
> Try:
>
>     earlycon=sifive,0x10010000

That's not what Christoph wants.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
