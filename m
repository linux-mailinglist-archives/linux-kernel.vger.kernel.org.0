Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA18C15B5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 01:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgBMAkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 19:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgBMAkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:40:31 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7B3B21739;
        Thu, 13 Feb 2020 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581554430;
        bh=cA1gOmp/WG/NJPPQ1nAoYRdKnHntIrtAzRhM5D1qD/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OWQV9mNm+62BA94AOEKL0fsBzam24Reo6ckuX6ztHx8kA2aCauJTiSFUFzU9Ud7DK
         3GDPeaKzIb36FTViI1426Gee8aexHgOCKv3BFh/a0pAQ5TSxleCgCAa7sIzcz3OeZl
         X0JvXAjCSTB5ATKt2IypKFGXEfrTsP8zt1b0Kl8U=
Date:   Wed, 12 Feb 2020 16:40:29 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zzyiwei@google.com
Cc:     rostedt@goodmis.org, mingo@redhat.com, elder@kernel.org,
        federico.vaga@cern.ch, tony.luck@intel.com, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, tglx@linutronix.de,
        yamada.masahiro@socionext.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, prahladk@google.com,
        joelaf@google.com, android-kernel@google.com
Subject: Re: [PATCH v2] Add gpu memory tracepoints
Message-ID: <20200213004029.GA2500609@kroah.com>
References: <20200213003259.128938-1-zzyiwei@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213003259.128938-1-zzyiwei@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 04:32:59PM -0800, zzyiwei@google.com wrote:
> From: Yiwei Zhang <zzyiwei@google.com>
> 
> This change adds the below gpu memory tracepoint:
> gpu_mem/gpu_mem_total: track global or process gpu memory total counters
> 
> Signed-off-by: Yiwei Zhang <zzyiwei@google.com>

If this helps gpu drivers wean themselves off of debugfs, I am all for
it:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for doing this.

greg k-h
