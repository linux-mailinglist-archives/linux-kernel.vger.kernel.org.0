Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E153190883
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 10:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgCXJIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 05:08:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:39006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgCXJIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:08:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EB2D0ACCA;
        Tue, 24 Mar 2020 09:08:50 +0000 (UTC)
Message-ID: <1585040918.7151.6.camel@suse.de>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
From:   Oliver Neukum <oneukum@suse.de>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 Mar 2020 10:08:38 +0100
In-Reply-To: <20200323172932.5s7txy2juhut5qdv@e107158-lin.cambridge.arm.com>
References: <20200323143857.db5zphxhq4hz3hmd@e107158-lin.cambridge.arm.com>
         <1584977769.27949.18.camel@suse.de>
         <20200323172932.5s7txy2juhut5qdv@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 23.03.2020, 17:29 +0000 schrieb Qais Yousef:
> Hi Oliver

Hi,

> First time I use dynamic debugging, hopefully I've done correctly.

I am afraid not.

> 	echo "file drivers/usb/* +p" > /sys/kernel/debug/dynamic_debug/control

Overkill but correct. +mpf would be even better

> 	$REPRODUCE

Good

> 	cat /sys/kernel/debug/dynamic_debug/control | grep usb > usb.debug

No.

/sys/kernel/debug/dynamic_debug/control holds the collection of the
messages that may be triggered, but it does not tell you which messages
are triggered and in which order. The triggered messages end up
in syslog. So you would use 'dmesg'
I am afraid you redid the test correctly and then threw away the
result.
Could you redo it and just attach the output of dmesg?

	Sorry
		Oliver

