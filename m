Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEB3B413D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 21:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbfIPTkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 15:40:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:44852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728209AbfIPTkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:40:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4FD96AF6B;
        Mon, 16 Sep 2019 19:40:12 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
References: <20190916064253.GA24654@lst.de>
        <mhng-671404fb-c86e-444a-86fb-b1ba027b1c36@palmer-si-x1c4>
X-Yow:  Okay..  I'm going home to write the ``I HATE RUBIK's CUBE
 HANDBOOK FOR DEAD CAT LOVERS''..
Date:   Mon, 16 Sep 2019 21:40:10 +0200
In-Reply-To: <mhng-671404fb-c86e-444a-86fb-b1ba027b1c36@palmer-si-x1c4>
        (Palmer Dabbelt's message of "Mon, 16 Sep 2019 09:12:09 -0700 (PDT)")
Message-ID: <87ftkwdo85.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 16 2019, Palmer Dabbelt <palmer@sifive.com> wrote:

> On Sun, 15 Sep 2019 23:42:53 PDT (-0700), Christoph Hellwig wrote:
>> On Fri, Sep 13, 2019 at 01:40:27PM -0700, Palmer Dabbelt wrote:
>>> OpenEmbedded passes "earlycon=sbi", which I can find in the doumentation.
>>> I can't find anything about just "earlycon".  I've sent a patch adding sbi
>>> to the list of earlycon arguments.
>>
>> earlycon without arguments is documented, although just for ARM64.
>> I can send a patch to update it to properly cover all DT platforms
>> in addition.
>
> Thanks.  I've kind of lost track of the thread, but assuming that does the
> "automatically pick an earlycon" stuff then that's probably what we should
> be using in the distros.

Except that it doesn't work.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
