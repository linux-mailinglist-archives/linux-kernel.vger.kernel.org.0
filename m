Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A222A16ABC3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 17:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBXQiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 11:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbgBXQiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:38:08 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8912920637;
        Mon, 24 Feb 2020 16:38:06 +0000 (UTC)
Date:   Mon, 24 Feb 2020 11:38:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yiwei Zhang <zzyiwei@google.com>
Cc:     mingo@redhat.com, Greg KH <gregkh@linuxfoundation.org>,
        elder@kernel.org, federico.vaga@cern.ch, tony.luck@intel.com,
        vilhelm.gray@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        tglx@linutronix.de, yamada.masahiro@socionext.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        Prahlad Kilambi <prahladk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        android-kernel <android-kernel@google.com>
Subject: Re: [PATCH v3] gpu/trace: add gpu memory tracepoints
Message-ID: <20200224113805.134f8b95@gandalf.local.home>
In-Reply-To: <CAKT=dDnt174adfWzSiNfheA5EVL32AG_2RQa0861V2Mjh-f51w@mail.gmail.com>
References: <20200212222922.5dfa9f36@oasis.local.home>
        <20200213042331.157606-1-zzyiwei@google.com>
        <20200213090308.223f3f20@gandalf.local.home>
        <CAKT=dDmB=TX++VeL=-NihDv5L4iBn_48=i7Lsnrkd+4e13QQsQ@mail.gmail.com>
        <CAKT=dDnt174adfWzSiNfheA5EVL32AG_2RQa0861V2Mjh-f51w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2020 22:31:11 -0800
Yiwei Zhang <zzyiwei@google.com> wrote:

> Dear gpu and tracing owners,
> 
> It's been a while and this is just a gentle and friendly re-ping for
> review of this small patch.

I guess the question is what tree should this go through. I usually
only take tracing infrastructure changes and leave topic specific
tracing for those that maintain the topics.

I'm fine with taking this through my tree if I get a bunch of
acked/reviewed by from other maintainers.

-- Steve

