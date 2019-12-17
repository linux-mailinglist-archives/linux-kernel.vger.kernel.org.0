Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE63123017
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 16:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfLQPUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 10:20:44 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:50476 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727809AbfLQPUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:20:43 -0500
Received: from [167.98.27.226] (helo=xylophone)
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1ihEdz-0003vi-6E; Tue, 17 Dec 2019 15:20:15 +0000
Message-ID: <f0e7384f3eb6203eb72b36433b0666150cf560ff.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH 10/24] compat_ioctl: cdrom: handle
 CDROM_LAST_WRITTEN
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org,
        Diego Elio =?ISO-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.com>,
        Hannes Reinecke <hare@suse.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Martin Wilck <mwilck@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Tue, 17 Dec 2019 15:20:14 +0000
In-Reply-To: <20191211204306.1207817-11-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
         <20191211204306.1207817-11-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-12-11 at 21:42 +0100, Arnd Bergmann wrote:
> This is the only ioctl command that does not have a proper
> compat handler. Making the normal implementation do the
> right thing is actually very simply, so just do that by
> using an in_compat_syscall() check to avoid the special
> case in the pkcdvd driver.
[...]

Since this uses blkdev_compat_ptr_ioctl() it needs to be moved after
the following patch.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

