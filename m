Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31EE81766D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 23:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCBWZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 17:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgCBWZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:25:04 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B93FB21775;
        Mon,  2 Mar 2020 22:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583187904;
        bh=SVYiFvX92VuCsAsK08u1bS2yUwPnhkO1YCCCd/qjESc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nbNlVyzdc1wWnE6hQv9qUhiKjyavbJQtJRzgZTSYoP4S72CXP5SXVuwGFdckih7f7
         6POXFe3rMwNkpXFyE/ygkfTZoExlmIl6QbPmfc9og3csYI7bvzMoRqfuhmQvmEUsFn
         yO4VqpGzM2IYOmhaN+HAeOgrI0uavAF6W2UagrJg=
Date:   Mon, 2 Mar 2020 23:25:01 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 02/24] x86/entry/64: Avoid pointless code when
 CONTEXT_TRACKING=n
Message-ID: <20200302222500.GA25705@lenoir>
References: <20200225221606.511535280@linutronix.de>
 <20200225222648.395059616@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225222648.395059616@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:16:08PM +0100, Thomas Gleixner wrote:
> GAS cannot optimize out the test and conditional jump when context tracking
> is disabled and CALL_enter_from_user_mode is an empty macro.
> 
> Wrap it in #ifdeffery. Will go away once all this is moved to C.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Frederic Weisbecker <frederic@kernel.org>
