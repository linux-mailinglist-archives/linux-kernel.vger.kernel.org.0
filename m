Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3811ED3C6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2019 17:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfKCQAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Nov 2019 11:00:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:53164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727523AbfKCQAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 11:00:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC454B1F7;
        Sun,  3 Nov 2019 16:00:31 +0000 (UTC)
Date:   Sun, 3 Nov 2019 17:00:30 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     flameeyes@flameeyes.com
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: cdrom: make debug logging rely on pr_debug and debugfs only.
Message-ID: <20191103160030.GO1384@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826151640.5036-3-flameeyes@flameeyes.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

can you change cd_dbg to a macro that always prints the device name
using pr_debug instead of removing it?

That way you will get much more useful debug messages. That's also what
many other subsystems do.

Also consider adding some relevant mailinglist to cc. I think the
MAINTAINERS even specifies linux-scsi for cdrom and/or sr.

Thanks

Michal
