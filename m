Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E880F749F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 14:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKKNSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 08:18:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:45086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbfKKNSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:18:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05DF4B595;
        Mon, 11 Nov 2019 13:18:23 +0000 (UTC)
Date:   Mon, 11 Nov 2019 14:18:17 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: cdrom: make debug logging rely on pr_debug and debugfs only.
Message-ID: <20191111131817.GA2770@kitsune.suse.cz>
References: <20190826151640.5036-3-flameeyes@flameeyes.com>
 <20191103160030.GO1384@kitsune.suse.cz>
 <CAHcsgXRtWAt0mEQoW2rn1v6yYZ8ZKygKVetk4mnm_o+pwgwcVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHcsgXRtWAt0mEQoW2rn1v6yYZ8ZKygKVetk4mnm_o+pwgwcVw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 12:21:38PM +0000, Diego Elio Pettenò wrote:
> On Sun, Nov 3, 2019 at 4:00 PM Michal Suchánek <msuchanek@suse.de> wrote:
> > can you change cd_dbg to a macro that always prints the device name
> > using pr_debug instead of removing it?
> 
> I can try doing that (need to figure out how, of course.)
> 
> Should I split the change that removes the debug parameter /
> ERRORLOGMASK parts? To be honest those are the parts that appear more
> of a duplication than the macro itself, so it might make sense to
> remove the custom debug selection, and then add the device name on top
> of that?

I wrote a patch that does just that because I am debugging an issue with
cdrom and I need to know which device the messages relate to.

Maybe you can drop this part entirely to not get conflicts.

Thanks

Michal
