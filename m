Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4189F2A1B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 10:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbfKGJGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 04:06:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:54070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726800AbfKGJGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:06:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 339D5AE65;
        Thu,  7 Nov 2019 09:06:31 +0000 (UTC)
Message-ID: <1573116629.3024.1.camel@suse.com>
Subject: Re: [PATCH] usb: appledisplay: fix use-after-free in
 bl_get_brightness
From:   Oliver Neukum <oneukum@suse.com>
To:     Phong Tran <tranmanphong@gmail.com>,
        syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com
Cc:     2pi@mok.nu, alex.theissen@me.com, andreyknvl@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 07 Nov 2019 09:50:29 +0100
In-Reply-To: <d6c628d0-71ad-7343-d80e-1b0cd0795242@gmail.com>
References: <00000000000042d60805933945b5@google.com>
         <20191105233652.21033-1-tranmanphong@gmail.com>
         <1573040577.3090.22.camel@suse.com>
         <d6c628d0-71ad-7343-d80e-1b0cd0795242@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 06.11.2019, 21:22 +0700 schrieb Phong Tran:

> compare with message size (2) can be considered.
> 
> if (retval == 2) {
> 	brightness = pdata->msgdata[1];
> } else {
> 	retval = -EMSGSIZE;
> }

If you do it that way, the error reporting will be distorted.
Hence I did it a bit more complexly.

	Regards
		Oliver
