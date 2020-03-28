Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 164FF19690E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 21:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgC1UDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Mar 2020 16:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbgC1UDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 16:03:43 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522A9206E6;
        Sat, 28 Mar 2020 20:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585425822;
        bh=2RE27pBV+J0beJOE//pS//H1FUDSi+8wfa7mLlayF24=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n7unn6Y+WsoRTcvhACJO3Saj8WOgkedFr4D8hFntwXp08pLVToFJhe7xQmOe3ClcF
         AOE8MfqJsKVePsx7MdhWomgS1/s0+cBewzUnvh7PYENmWAk0xFs53tEv9JgXdblBs4
         Z5oWWUMSiZbAgyB21DSQbbM2R0trxLKYRHThFwJc=
Date:   Sat, 28 Mar 2020 13:03:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Ahern <dsahern@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [PATCH] getdelays: Fix netlink attribute length
Message-Id: <20200328130341.a23be12b3a0f4cf0288a0d84@linux-foundation.org>
In-Reply-To: <20200327173111.63922-1-dsahern@kernel.org>
References: <20200327173111.63922-1-dsahern@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 11:31:11 -0600 David Ahern <dsahern@kernel.org> wrote:

> A recent change to the netlink code:
>   6e237d099fac ("netlink: Relax attr validation for fixed length types")
> logs a warning when programs send messages with invalid attributes
> (e.g., wrong length for a u32). Yafang reported this error message
> for tools/accounting/getdelays.c.
> 
> send_cmd() is wrongly adding 1 to the attribute length. As noted in
> include/uapi/linux/netlink.h nla_len should be NLA_HDRLEN + payload
> length, so drop the +1.

Thanks.

> Fixes: 9e06d3f9f6b1 ("per task delay accounting taskstats interface: documentation fix")
> Signed-off-by: David Ahern <dsahern@kernel.org>
> Tested-by: Yafang Shao <laoar.shao@gmail.com>

I'll add Reported-by: as well.

> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Shailabh Nagar <nagar@watson.ibm.com>

Is this worth a cc:stable?


