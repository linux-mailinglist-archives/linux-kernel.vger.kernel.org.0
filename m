Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E00ECAE541
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 10:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405252AbfIJISS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 04:18:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:59578 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731155AbfIJISR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:18:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF5CFAE35;
        Tue, 10 Sep 2019 08:18:15 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        paul.walmsley@sifive.com, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial/sifive: select SERIAL_EARLYCON
References: <20190910055923.28384-1-hch@lst.de> <mvm4l1kskny.fsf@suse.de>
        <20190910070503.GA31743@lst.de>
X-Yow:  I'll clean your ROOM!!  I know some GOOD stories, too!!  All about
 ROAD Island's, HUSH Puppies, and how LUKE finds GOLD on his LAND!!
Date:   Tue, 10 Sep 2019 10:18:15 +0200
In-Reply-To: <20190910070503.GA31743@lst.de> (Christoph Hellwig's message of
        "Tue, 10 Sep 2019 09:05:03 +0200")
Message-ID: <mvmzhjcr2d4.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Sep 10, 2019 at 08:57:37AM +0200, Andreas Schwab wrote:
>> On Sep 10 2019, Christoph Hellwig <hch@lst.de> wrote:
>> 
>> > The sifive serial driver implements earlycon support,
>> 
>> It should probably be documented in admin-guide/kernel-parameters.txt.
>
> How so?  Wіth OF and a stdout path you just set earlycon on the
> command line without any arguments and it will be found.

Doesn't work for me.

[    0.000000] Malformed early option 'earlycon'

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
