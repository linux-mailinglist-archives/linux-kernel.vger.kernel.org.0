Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D37BD15B7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 04:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgBMD30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 22:29:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbgBMD30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:29:26 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E70020724;
        Thu, 13 Feb 2020 03:29:24 +0000 (UTC)
Date:   Wed, 12 Feb 2020 22:29:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yiwei Zhang <zzyiwei@google.com>
Cc:     Prahlad Kilambi <prahladk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        android-kernel <android-kernel@google.com>,
        yamada.masahiro@socionext.com, tglx@linutronix.de,
        vilhelm.gray@gmail.com, tony.luck@intel.com, federico.vaga@cern.ch,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        elder@kernel.org, mingo@redhat.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] Add gpu memory tracepoints
Message-ID: <20200212222922.5dfa9f36@oasis.local.home>
In-Reply-To: <CAKT=dDnkfS9buZut8JwBTNO3duRbWX_mL=VpP1rK1yaucaFA8A@mail.gmail.com>
References: <20200213003259.128938-1-zzyiwei@google.com>
        <20200213022020.142379-1-zzyiwei@google.com>
        <CAKT=dDnkfS9buZut8JwBTNO3duRbWX_mL=VpP1rK1yaucaFA8A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 18:24:32 -0800
Yiwei Zhang <zzyiwei@google.com> wrote:

> Hi Steven,
> 
> I'm not sure if my use of "in-reply-to" is correct. I can only find
> the Message-Id of my original email from cmdline. but looks like the
> diff shows up right.

You mean this one?

  https://lore.kernel.org/lkml/20200213022020.142379-1-zzyiwei@google.com/

Looks fine, except I think you meant to make this v3. Also you may have
wanted to add a topic, "gpu/trace: "? to the subject. 

-- Steve
