Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1216E151815
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 10:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgBDJq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 04:46:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgBDJq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:46:26 -0500
Received: from localhost (unknown [212.187.182.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE5402166E;
        Tue,  4 Feb 2020 09:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580809585;
        bh=VlRUtSRrLeKtQYvR52+rIA5unH+BH0HRF/MnHJy83kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5PHGApGK7OQ/RMddsZTNIgFSoKnxB9nwQn7TXLjHH+MkD0ucqoOeNcr37GUUzZZ+
         rXwkNkMpjgWmAID/1pZ/hlYqkKIdQ4WILvySL4U7M7q6BkYr+6hOrZ8U7tal15BVQE
         pjf4lmHARICAsPMOWYwHIvGlQzGVlB+8nz169FUI=
Date:   Tue, 4 Feb 2020 09:46:22 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, Jian-Min.Liu@mediatek.com
Subject: Re: [PATCH v1] binder: transaction latency tracking for user build
Message-ID: <20200204094622.GA1087870@kroah.com>
References: <1580807715-26609-1-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580807715-26609-1-git-send-email-Frankie.Chang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 05:15:14PM +0800, Frankie Chang wrote:
> Record start/end timestamp to binder transaction.
> When transaction is completed or transaction is free,
> it would be checked if transaction latency over threshold (2 sec),
> if yes, printing related information for tracing.
> 
> 
> Frankie Chang (1):
>   binder: transaction latency tracking for user build
> 
>  drivers/android/Kconfig           |    8 +++
>  drivers/android/binder.c          |  107 +++++++++++++++++++++++++++++++++++++
>  drivers/android/binder_internal.h |    4 ++
>  3 files changed, 119 insertions(+)

There is no patch here :(
