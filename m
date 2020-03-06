Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3601D17B512
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 04:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCFDoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 22:44:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgCFDoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:44:34 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37EE22072D;
        Fri,  6 Mar 2020 03:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583466272;
        bh=v7Z1JGbpqLPQcQrCE/IcBs7eL2d2FZOkUaA4ZPdqYsc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wUKxwgm1RtXQ6d0jYoA3jluGb/ZYXzEmXe3bIVAdsQUnwu6yHvYR/k5PZRoAaDmX7
         4LMwfanHeIfVZ25XCCcz1FPPZSFbb0iKwNdnpE6SwKFU4pENlgZiiIJQQadoelAkhi
         NT/GLgPeupaNUrL11gBLxnPco6yiRwMuySZx+EMw=
Date:   Thu, 5 Mar 2020 19:44:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm: Correct guards for non_swap_entry()
Message-Id: <20200305194431.7fe10d760d9921d0eff106c1@linux-foundation.org>
In-Reply-To: <20200305130550.22693-1-steven.price@arm.com>
References: <20200305130550.22693-1-steven.price@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Mar 2020 13:05:50 +0000 Steven Price <steven.price@arm.com> wrote:

> If CONFIG_DEVICE_PRIVATE is defined, but neither CONFIG_MEMORY_FAILURE nor
> CONFIG_MIGRATION, then non_swap_entry() will return 0, meaning that the
> condition (non_swap_entry(entry) && is_device_private_entry(entry)) in
> zap_pte_range() will never be true even if the entry is a device private
> one.
> 
> Equally any other code depending on non_swap_entry() will not function
> as expected.

What are the user-visible runtime effects of this change?

Is a cc:stable needed?
