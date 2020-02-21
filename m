Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA0B166BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 01:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgBUAkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Feb 2020 19:40:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbgBUAke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:40:34 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C38E207FD;
        Fri, 21 Feb 2020 00:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582245634;
        bh=hZ3dGT7YJqIbKFGjdrNH8loYD4/AxKe4J06eOSLcC6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vuni54K9568CmSjIYiNas2JBby91Xm/1JOEwM+Akreo8FEcnNdjw92J3r4Fgby+jT
         pk1so+82is8MWqD5UAYuxK8geIwlA1LW/FFWhOJ7lJ6iSyVYSX7n9NrgY9EQhl3s+p
         gULzSpzkWR1r5ADD8iZLWgU8yMj0xEGsqFnKxTfI=
Date:   Thu, 20 Feb 2020 16:40:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/page_alloc: increase default min_free_kbytes bound
Message-Id: <20200220164033.8634c2c836c1558daebd81b9@linux-foundation.org>
In-Reply-To: <20200220150103.5183-1-jsavitz@redhat.com>
References: <20200220150103.5183-1-jsavitz@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 10:01:03 -0500 Joel Savitz <jsavitz@redhat.com> wrote:

> 
> Currently, the vm.min_free_kbytes sysctl value is capped at a hardcoded
> 64M in init_per_zone_wmark_min (unless it is overridden by khugepaged
> initialization).
> 
> This value has not been modified since 2005, and enterprise-grade
> systems now frequently have hundreds of GB of RAM and multiple 10, 40,
> or even 100 GB NICs. We have seen page allocation failures on heavily
> loaded systems related to NIC drivers. These issues were resolved by an
> increase to vm.min_free_kbytes.
> 
> This patch increases the hardcoded value by a factor of 4 as a temporary
> solution.

OK, better than nothing I guess.

> Further work to make the calculation of vm.min_free_kbytes more
> consistent throughout the kernel would be desirable.
> 
> As an example of the inconsistency of the current method, this value is
> recalculated by init_per_zone_wmark_min() in the case of memory hotplug
> which will override the value set by set_recommended_min_free_kbytes()
> called during khugepaged initialization even if khugepaged remains
> enabled, however an on/off toggle of khugepaged will then recalculate
> and set the value via set_recommended_min_free_kbytes().
> 

Yup, these hardcoded numbers are lame.
