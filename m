Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C77194498
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Mar 2020 17:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCZQum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 12:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCZQul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:50:41 -0400
Received: from linux-8ccs (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0680820719;
        Thu, 26 Mar 2020 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585241441;
        bh=WLCHALPxaf6AbiSaiH7MjlV2bA2FFJyEwY3qfPb2Yps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxPPtcMFKY2aEU36KZDR6E/FCF+DVXVH2JMS8FcuPxM6BbVHaJAVE5G5gBf0zOKl9
         xOJqW4vCklpEHDF6XdlVZcSH1IVmurjIZ+W0NRUcgHKboPEMz2coRBZylVNSXn+tMV
         BEg/h42CT4X0lcPXSHjVJ5OiPS0hwHkmhGqmHkG4=
Date:   Thu, 26 Mar 2020 17:50:37 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Maennich <maennich@google.com>
Subject: Re: modpost Module.symver handling is broken in 5.6.0-rc7
Message-ID: <20200326165036.GA22172@linux-8ccs>
References: <931818529b1d4d13a08d30ddace22733@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <931818529b1d4d13a08d30ddace22733@AcuMS.aculab.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+++ David Laight [26/03/20 16:25 +0000]:
>Something is currently broken in modpost.
>I'm guessing it is down to the recent patch that moved the
>namespace back to the end of the line.
>
>I'm building 2 'out of tree' modules that have a symbol dependency.
>When I build the 2nd module I get ERROR "symbol" undefined message.
>
>If I flip the order of the fields in Module.symver to the older order
>and link with modpost from 5.4.0-rc7 (which I happen to have lurking)
>it all works fine.
>
>Note that I'm using a named namespace, not the default one
>that is the full path of the module.
>
>I'll dig in a little further.

[ Adding more people to CC ]

Hi David,

Could you provide some more details about how I can reproduce the
issue? As I understand it, you have two out-of-tree modules, and one
has a symbol dependency on the second? Pasting the modpost error
messages helps too.

Thanks,

Jessica
