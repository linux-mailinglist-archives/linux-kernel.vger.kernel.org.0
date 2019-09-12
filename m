Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5875B0D20
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 12:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731099AbfILKok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 06:44:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:60252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730470AbfILKoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:44:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE546B0B6;
        Thu, 12 Sep 2019 10:44:37 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: /dev/mem and secure boot
Date:   Thu, 12 Sep 2019 12:44:01 +0200
Message-ID: <2263894.GsazvrUjIX@skinner.arch.suse.de>
In-Reply-To: <20190909150957.12abe684@endymion>
References: <20190906130221.0b47a565@endymion> <20190906121510.GA17328@kroah.com> <20190909150957.12abe684@endymion>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 9, 2019 3:09:57 PM CEST Jean Delvare wrote:
> Hi Greg,

...

> > Sure, feel free to not register it at all if the mode is enabled.

> Now I feel sorry that I asked my question upstream when there's nothing
> to be done there. I'll go bother SUSE kernel folks instead, sorry for
> the noise. And thanks for the advice.

I also/still think /dev/mem should vanish in secure boot mode, also upstream.
There may have been strong reasons why it has been restricted to /dev/ioport
which I do not know.

Whatever the exact definition for kernel behaviour in secure boot mode in the
UEFI books is (if there is any), it should close quite some possible doors
for hijacking a machine or read sensible data and if anyhow possible secure
boot mode should head for this feature (IMHO): Get rid of /dev/mem.

Thanks for bringing this up,

    Thomas


