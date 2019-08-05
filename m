Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F2D8162A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2019 11:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfHEJ7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 05:59:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57052 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727259AbfHEJ7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:59:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3CB1FB624;
        Mon,  5 Aug 2019 09:59:17 +0000 (UTC)
Message-ID: <1564998287.4248.5.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in usb_free_coherent
From:   Oliver Neukum <oneukum@suse.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, dtor@chromium.org,
        andreyknvl@google.com, syzkaller-bugs@googlegroups.com,
        robh@kernel.org, srinivas.kandagatla@linaro.org,
        gregkh@linuxfoundation.org, mans@mansr.com,
        mathias.payer@nebelwelt.net, stern@rowland.harvard.edu,
        syzbot+d1fedb1c1fdb07fca507@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Mon, 05 Aug 2019 11:44:47 +0200
In-Reply-To: <8d2b9cb5-d32c-e24c-c973-a3a11a436dc6@arm.com>
References: <0000000000003f86d8058f0bd671@google.com>
         <8d2b9cb5-d32c-e24c-c973-a3a11a436dc6@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 01.08.2019, 11:52 +0100 schrieb Suzuki K Poulose:
> 
> Looks like the yurex_delete() drops the ref count on the dev->udev
> way early in the function and then later tries to see if there
> are any other buffers associated with it worth releasing. So,
> I am guessing moving the usb_put_dev(), after we have finished
> all that might solve the issue ?

Hi,

the fix looks good to me.

	Regards
		Oliver

